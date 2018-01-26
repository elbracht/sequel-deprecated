import Alamofire
import Kingfisher
import SnapKit
import SwiftyJSON

class SeriesViewController: UIViewController {
    private var series: Series?

    public var seriesView: SeriesView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        seriesView = SeriesView()
        seriesView.delegate = self
        self.view.addSubview(seriesView)

        seriesView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(series: Series) {
        fetchSeries(id: series.id) {
            if let currentSeries = self.series {
                self.seriesView.nameLabel.text = currentSeries.name
                self.seriesView.overviewLabel.text = currentSeries.overview
                if let url = URL(string: "https://image.tmdb.org/t/p/w780\(currentSeries.posterPath)") {
                    self.seriesView.imageView.kf.setImage(with: url)
                }
            }
        }
    }
}

/**
 Parallax scrolling effect
 */
extension SeriesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            seriesView.headerView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            seriesView.contentView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            seriesView.overviewLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY / 2)
            seriesView.nameLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY / 2)

            seriesView.headerView.snp.updateConstraints({ (make) in
                make.height.equalTo(SeriesViewMeasure.imageHeight - offsetY / 3)
            })

            seriesView.imageView.snp.updateConstraints({ (make) in
                make.left.equalTo(seriesView.headerView).offset(offsetY / 8)
                make.right.equalTo(seriesView.headerView).offset(-offsetY / 8)
            })
        }
    }
}

/**
 Fetch and parse data
 */
extension SeriesViewController {
    func fetchSeries(id: Int, completion: @escaping () -> Void) {
        let url = "https://api.themoviedb.org/3/tv/\(id)"
        let parameters: Parameters = [
            "api_key": Credentials.TMDb.apiKey
        ]

        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            if let json = response.result.value {
                self.parseSeries(json: JSON(json))
                completion()
            }
        }
    }

    func parseSeries(json: JSON) {
        let id = json["id"].int
        let name = json["name"].string
        let overview = json["overview"].string
        let posterPath = json["poster_path"].string

        if id != nil && name != nil && overview != nil && posterPath != nil {
            series = Series(id: id!, name: name!, overview: overview!, posterPath: posterPath!)
        }
    }
}
