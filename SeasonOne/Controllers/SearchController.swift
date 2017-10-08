import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class SearchController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SeriesDelegate {

    let reuseIdentifier = "SearchCollectionViewCell"

    let margin = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    let itemMargin: CGFloat = 10
    let itemPerRow: CGFloat = 2
    let itemRatioWidth: CGFloat = 2
    let itemRatioHeight: CGFloat = 3

    var series = [Series]()

    var searchView: SearchView!
    var searchCollectionView: UICollectionView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        searchView = SearchView()
        searchView.cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidBegin), for: .editingDidBegin)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidEnd), for: .editingDidEnd)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        searchView.searchTextField.delegate = self
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(searchView.height + searchView.insets.top)
        }

        searchCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        searchCollectionView.backgroundColor = Color.primary
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        self.view.addSubview(searchCollectionView)

        searchCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchView.snp.bottom).offset(16)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(self.view.snp.bottom)
            make.right.equalTo(self.view.snp.right)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* UIButton */
    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        self.dismiss(animated: true)
    }

    /* UITextField */
    @objc func searchTextFieldEditingDidBegin(sender: SearchTextField!) {
        sender.animateImageHighlightEnabled()
    }

    @objc func searchTextFieldEditingDidEnd(sender: SearchTextField!) {
        if let text = sender.text {
            if text.isEmpty {
                sender.animateImageHighlightDisabled()
            }
        }
    }

    @objc func searchTextFieldEditingDidEndOnExit(sender: SearchTextField!) {
        if let text = sender.text {
            if !text.isEmpty {
                fetchSeries(searchQuery: text) {
                    self.searchCollectionView.reloadData()
                }
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if !text.isEmpty {
                return true
            }
        }

        return false
    }

    /* UICollectionView */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SearchCollectionViewCell {
            let currentSeries = series[indexPath.row]

            cell.updateNameText(currentSeries.name)
            cell.updateCaptionText("New")
            cell.updateImage(UIImage())

            if let image = currentSeries.image {
                cell.updateImage(image)
                cell.animateFadeIn()
            }

            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnSpaceInside = (itemPerRow - 1) * itemMargin
        let columnSpace = columnSpaceInside + margin.left + margin.right
        let availableWidth = searchCollectionView.frame.width - columnSpace
        let widthPerItem = (availableWidth / itemPerRow)
        let heightPerItem = widthPerItem / itemRatioWidth * itemRatioHeight

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return margin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemMargin
    }

    /* Data */
    func seriesDataAvailable(_ object: Series) {
        if let index = series.index(where: { $0 === object }) {
            let indexPath = IndexPath(row: index, section: 0)
            DispatchQueue.main.async {
                self.searchCollectionView.reloadItems(at: [indexPath])
            }
        }
    }

    /* Helper */
    func fetchSeries(searchQuery: String, completion: @escaping () -> Void) {
        let url = "https://api.themoviedb.org/3/search/tv"
        let parameters: Parameters = [ "api_key": TMDb.apiKey, "query": searchQuery ]

        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            if let json = response.result.value {
                self.parseSeries(json: JSON(json))
                completion()
            }
        }
    }

    func parseSeries(json: JSON) {
        series.removeAll()

        json["results"].forEach({ (_, subJson) in
            let name = subJson["name"].string
            let posterPath = subJson["poster_path"].string

            if name != nil && posterPath != nil {
                let seriesObject = Series(name: name!, posterPath: posterPath!)
                seriesObject.delegate = self
                seriesObject.load()
                series.append(seriesObject)

            }
        })
    }
}
