import Alamofire
import SnapKit
import SwiftTheme
import SwiftyJSON
import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    struct Style {
        let backgroundColor: String
        let statusBarStyle: UIStatusBarStyle

        static let light = Style(
            backgroundColor: Color.light.background,
            statusBarStyle: .default
        )
    }

    struct Measure {
        static let searchCollectionViewOffset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        static let searchItemOffset = 12 as CGFloat
        static let searchItemPerRow = 2 as CGFloat
        static let searchItemRatioWidth = 2 as CGFloat
        static let searchItemRatioHeight = 3 as CGFloat
    }

    let reuseIdentifier = "SearchCollectionViewCell"

    var series = [Series]()

    var searchText = ""
    var searchPage = 1
    var searchTotalPage = 1

    var searchView: SearchView!
    var searchCollectionView: UICollectionView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        initView()
        initSearchView()
        initSearchCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Init */
    func initView() {
        self.view.theme_backgroundColor = [Style.light.backgroundColor]
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: Style.light.statusBarStyle)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }

    func initSearchView() {
        searchView = SearchView()
        searchView.cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingChanged), for: .editingChanged)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        searchView.searchTextField.delegate = self
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(SearchView.Measure.height + SearchView.Measure.offset.top)

            if #available(iOS 11, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(self.view)
            }
        }
    }

    func initSearchCollectionView() {
        searchCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        searchCollectionView.backgroundColor = UIColor.clear
        searchCollectionView.keyboardDismissMode = .onDrag
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

    /* UIButton */
    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        if searchView.searchTextField.hasText {
            searchView.searchTextField.text = ""
            searchView.searchTextField.animatePlaceholderFadeIn()
            searchView.searchTextField.animateImagePlaceholder()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.dismiss(animated: true)
            }
        } else {
            self.dismiss(animated: true)
        }
    }

    /* UITextField */
    @objc func searchTextFieldEditingChanged(sender: SearchTextField!) {
        if sender.hasText {
            sender.animatePlaceholderFadeOut()
            sender.animateImageDefault()
        } else {
            sender.animatePlaceholderFadeIn()
            sender.animateImagePlaceholder()
        }
    }

    @objc func searchTextFieldEditingDidEndOnExit(sender: SearchTextField!) {
        if let text = sender.text {
            if !text.isEmpty {
                series.removeAll()
                searchCollectionView.reloadData()
                searchCollectionView.contentOffset = .zero

                searchText = text
                searchPage = 1

                fetchSeries(searchQuery: searchText, page: searchPage) {
                    self.searchPage += 1
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

            let url = "https://image.tmdb.org/t/p/w342\(currentSeries.posterPath)"
            cell.updateImage(url: url)

            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = series.count - 1
        if indexPath.row == lastElement {
            if searchPage <= searchTotalPage {
                fetchSeries(searchQuery: searchText, page: searchPage) {
                    self.searchPage += 1
                    self.searchCollectionView.reloadData()
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnSpaceInside = (Measure.searchItemPerRow - 1) * Measure.searchItemOffset
        let columnSpace = columnSpaceInside + Measure.searchCollectionViewOffset.left + Measure.searchCollectionViewOffset.right
        let availableWidth = searchCollectionView.frame.width - columnSpace
        let widthPerItem = (availableWidth / Measure.searchItemPerRow)
        let heightPerItem = widthPerItem / Measure.searchItemRatioWidth * Measure.searchItemRatioHeight

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Measure.searchCollectionViewOffset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Measure.searchItemOffset
    }

    /* Helper */
    func fetchSeries(searchQuery: String, page: Int, completion: @escaping () -> Void) {
        let url = "https://api.themoviedb.org/3/search/tv"
        let parameters: Parameters = [
            "api_key": TMDb.apiKey,
            "query": searchQuery,
            "page": page
        ]

        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            if let json = response.result.value {
                self.parseSeries(json: JSON(json))
                completion()
            }
        }
    }

    func parseSeries(json: JSON) {
        if let totalPage = json["total_pages"].int {
            searchTotalPage = totalPage
        }

        json["results"].forEach({ (_, subJson) in
            let name = subJson["name"].string
            let posterPath = subJson["poster_path"].string

            if name != nil && posterPath != nil {
                let seriesObject = Series(name: name!, posterPath: posterPath!)
                series.append(seriesObject)
            }
        })
    }
}
