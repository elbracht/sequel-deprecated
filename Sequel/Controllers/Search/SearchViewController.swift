import Alamofire
import Kingfisher
import SwiftyJSON

class SearchViewController: UIViewController {
    private var series = [Series]()
    private var searchText = ""
    private var searchPage = 1
    private var searchTotalPage = 1

    public var searchView: SearchView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchView = SearchView()
        searchView.searchCollectionView.delegate = self
        searchView.searchCollectionView.dataSource = self
        searchView.searchInputView.cancelButton.addTarget(self, action: #selector(searchCancelButtonTouchUpInside), for: .touchUpInside)
        searchView.searchInputView.textField.addTarget(self, action: #selector(searchTextFieldEditingDidEndOnExit), for: .editingDidEndOnExit)

        self.view.addSubview(searchView)

        searchView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

/**
SearchCancelButton to dismiss SearchViewController
*/
extension SearchViewController {
    @objc private func searchCancelButtonTouchUpInside() {
        if searchView.searchInputView.textField.hasText {
            searchView.searchInputView.textField.text = nil
            searchView.searchInputView.textField.searchTextFieldEditingChanged()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.dismiss(animated: true)
            }
        } else {
            self.dismiss(animated: true)
        }
    }
}

/**
SearchTextField event to load data
*/
extension SearchViewController {
    @objc private func searchTextFieldEditingDidEndOnExit(sender: CustomTextField) {
        if let text = sender.text {
            if !text.isEmpty {
                series.removeAll()
                searchView.searchCollectionView.reloadData()

                searchText = text
                searchPage = 1

                fetchSeries(searchQuery: searchText, page: searchPage) {
                    self.searchPage += 1
                    self.searchView.searchCollectionView.reloadData()
                }
            }
        }
    }
}

/**
Layout and data source of SearchCollectionView
*/
extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnSpaceInside = (SearchViewMeasure.searchItemPerRow - 1) * SearchViewMeasure.searchItemOffset
        let columnSpace = columnSpaceInside + SearchViewMeasure.searchCollectionViewOffset.left + SearchViewMeasure.searchCollectionViewOffset.right
        let availableWidth = searchView.searchCollectionView.frame.width - columnSpace
        let widthPerItem = (availableWidth / SearchViewMeasure.searchItemPerRow)
        let heightPerItem = widthPerItem / SearchViewMeasure.searchItemRatioWidth * SearchViewMeasure.searchItemRatioHeight

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SearchViewMeasure.searchItemOffset
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell {
            let currentSeries = series[indexPath.row]

            cell.nameLabel.text = currentSeries.name
            cell.captionLabel.text = "New"

            if let url = URL(string: "https://image.tmdb.org/t/p/w342\(currentSeries.posterPath)") {
                cell.imageView.kf.setImage(with: url, completionHandler: { (_, _, _, _) in
                    UIView.animate(withDuration: 0.2) {
                        cell.showCell()
                    }
                })
            }

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
                    self.searchView.searchCollectionView.reloadData()
                }
            }
        }
    }
}

/**
Fetch and parse data
*/
extension SearchViewController {
    func fetchSeries(searchQuery: String, page: Int, completion: @escaping () -> Void) {
        let apiKey = ProcessInfo.processInfo.environment["TMDB_API_KEY"]
        let url = "https://api.themoviedb.org/3/search/tv"
        let parameters: Parameters = [
            "api_key": apiKey != nil ? apiKey! : "",
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
