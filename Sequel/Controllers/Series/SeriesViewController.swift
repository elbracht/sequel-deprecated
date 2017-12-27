import Kingfisher
import SnapKit

class SeriesViewController: UIViewController {
    public var seriesView: SeriesView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        seriesView = SeriesView()
        self.view.addSubview(seriesView)

        seriesView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(series: Series) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w342\(series.posterPath)") {
            seriesView.imageView.kf.setImage(with: url)
        }
    }
}
