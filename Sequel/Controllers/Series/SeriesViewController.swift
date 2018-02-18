import Alamofire
import Kingfisher
import SnapKit
import SwiftTheme
import SwiftyJSON

class SeriesViewController: UIViewController {
    private var series: Series!

    public var seriesView: SeriesView!

    private var closeButtonColor: ThemeColorPicker?
    private var closeButtonBlurStyle: UIBlurEffectStyle?

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
            if let overview = self.series.overview {
                self.seriesView.overviewLabel.text = overview
            }

            if let episodeRunTime = self.series.episodeRunTime {
                self.seriesView.runTimeLabel.text = "\(episodeRunTime) minutes"
            }

            if let firstAirDate = self.series.firstAirDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                self.seriesView.airDateLabel.text = dateFormatter.string(from: firstAirDate)
            }

            if let voteAverage = self.series.voteAverage {
                self.seriesView.voteLabel.text = String(describing: voteAverage)
            }

            if let url = URL(string: "https://image.tmdb.org/t/p/w780\(self.series.posterPath)") {
                self.seriesView.imageView.kf.setImage(with: url, placeholder: self.seriesView.imageView.image, options: nil, progressBlock: nil, completionHandler: nil)
            }

            self.seriesView.layoutIfNeeded()
        }
    }

    private func setupCloseButton() {
        if let url = URL(string: "https://image.tmdb.org/t/p/w342\(series.posterPath)") {
            KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, _, _, _ in
                if image != nil {
                    if image!.isDark {
                        self.closeButtonColor = [Color.Black.primary.hexString(true)]
                        self.closeButtonBlurStyle = .extraLight
                    } else {
                        self.closeButtonColor = [Color.White.secondary.hexString(true)]
                        self.closeButtonBlurStyle = .dark
                    }

                    self.seriesView.closeButton.setColor(colors: self.closeButtonColor!)
                    self.seriesView.closeButton.setBlurEffect(style: self.closeButtonBlurStyle!)
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
 Parallax scrolling effect and update close button color
 */
extension SeriesViewController: UIScrollViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        parallaxScroll(offsetY: offsetY)
        updateCloseButton(offsetY: offsetY)
    }

    private func parallaxScroll(offsetY: CGFloat) {
        if offsetY < 0 {
            seriesView.headerView.transform = CGAffineTransform(translationX: 0, y: offsetY)

            seriesView.keyFiguresView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            seriesView.keyFiguresInnerView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 12)

            seriesView.contentView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            seriesView.contentInnerView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 6)

            seriesView.headerView.snp.updateConstraints { (make) in
                make.height.equalTo(SeriesViewMeasure.imageHeight - offsetY / 3)
            }

            seriesView.imageView.snp.updateConstraints { (make) in
                make.width.equalTo(UIScreen.main.bounds.width - offsetY / 6)
            }

            seriesView.contentView.snp.updateConstraints { (make) in
                make.bottom.equalTo(seriesView.scrollView).offset(-offsetY / 3)
            }
        }
    }

    private func updateCloseButton(offsetY: CGFloat) {
        let headerOffset = seriesView.headerView.frame.size.height
        let buttonOffset = seriesView.closeButton.frame.size.height / 2 + seriesView.closeButton.frame.origin.y
        if offsetY > 0 {
            if offsetY > headerOffset - buttonOffset {
                UIView.animate(withDuration: 0.2, animations: {
                    self.seriesView.closeButton.setColor(colors: [Color.White.secondary.hexString(true)])
                    self.seriesView.closeButton.setBlurEffect(style: .dark)
                })
            } else {
                if closeButtonColor != nil && closeButtonBlurStyle != nil {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.seriesView.closeButton.setColor(colors: self.closeButtonColor!)
                        self.seriesView.closeButton.setBlurEffect(style: self.closeButtonBlurStyle!)
                    })
                }
            }
        }
    }
}

/**
 Fetch and parse data
 */
extension SeriesViewController {
    private func fetchSeries(id: Int, completion: @escaping () -> Void) {
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

    private func parseSeries(json: JSON) {
        series.overview = json["overview"].string
        series.voteAverage = json["vote_average"].float
        series.voteCount = json["vote_count"].int

        if let episodeRunTimes = json["episode_run_time"].arrayObject as? [Int] {
            if episodeRunTimes.count > 0 {
                series.episodeRunTime = episodeRunTimes.reduce(0, +) / episodeRunTimes.count
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!

        if let firstAirDate = json["first_air_date"].string {
            series.firstAirDate = dateFormatter.date(from: firstAirDate)
        }

        if let lastAirDate = json["last_air_date"].string {
            series.lastAirDate = dateFormatter.date(from: lastAirDate)
        }

        if let homepage = json["homepage"].string {
            if let url = URL(string: homepage) {
                series.homepage = url
            }
        }
    }
}
