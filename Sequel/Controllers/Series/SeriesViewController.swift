import Alamofire
import Kingfisher
import SnapKit
import SwiftyJSON

class SeriesViewController: UIViewController {
    private var series: Series!

    public var seriesView: SeriesView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        seriesView = SeriesView()
        seriesView.scrollView.alwaysBounceVertical = true
        seriesView.scrollView.delegate = self
        seriesView.closeButton.addTarget(self, action: #selector(closeButtonTouchUpInside), for: .touchUpInside)
        self.view.addSubview(seriesView)

        seriesView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(series: Series) {
        self.series = series

        setupCloseButton()
        setupCurrentValues()
        setupMissingValues()
    }

    private func setupCurrentValues() {
        self.seriesView.nameLabel.text = series.name
        if let url = URL(string: "https://image.tmdb.org/t/p/w342\(series.posterPath)") {
            self.seriesView.imageView.kf.setImage(with: url)
        }
    }

    private func setupMissingValues() {
        fetchSeries(id: series.id) {
            self.seriesView.overviewLabel.text = self.series.overview
            if let url = URL(string: "https://image.tmdb.org/t/p/w780\(self.series.posterPath)") {
                self.seriesView.imageView.kf.setImage(with: url, placeholder: self.seriesView.imageView.image, options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }

    private func setupCloseButton() {
        if let url = URL(string: "https://image.tmdb.org/t/p/w342\(series.posterPath)") {
            KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, _, _, _ in
                if image != nil {
                    if image!.isDark {
                        self.seriesView.closeButton.setColor(colors: [Color.light.blackPrimary])
                        self.seriesView.closeButton.setBlurEffect(style: .extraLight)
                    } else {
                        self.seriesView.closeButton.setColor(colors: [Color.light.whiteSecondary])
                        self.seriesView.closeButton.setBlurEffect(style: .dark)
                    }
                }
            })
        }
    }
}

/**
 CloseButton event to dismiss SeriesViewController
 */
extension SeriesViewController {
    @objc private func closeButtonTouchUpInside() {
        UIApplication.shared.isStatusBarHidden = false
        self.dismiss(animated: true)
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
        if let overview = json["overview"].string {
            series.overview = overview
        }
    }
}
