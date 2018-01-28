import SnapKit
import SwiftTheme
import UIKit

struct SeriesViewMeasure {
    static let imageHeight = 360 as CGFloat
}

class SeriesView: UIView {
    public var closeButton: CustomCloseButton!

    public var scrollView: UIScrollView!

    public var headerView: UIView!
    public var imageView: UIImageView!

    public var keyFiguresView: UIView!
    public var keyFiguresInnerView: UIView!
    public var runTimeView: UIView!
    public var runTimeImageView: UIImageView!
    public var runTimeLabel: UILabel!
    public var airDateView: UIView!
    public var airDateImageView: UIImageView!
    public var airDateLabel: UILabel!
    public var voteView: UIView!
    public var voteImageView: UIImageView!
    public var voteLabel: UILabel!

    public var contentView: UIView!
    public var contentInnerView: UIView!
    public var nameLabel: UILabel!
    public var overviewLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initScrollView()
        initHeaderView()
        initKeyFiguresView()
        initContentView()
        initCloseButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        self.theme_backgroundColor = [Color.light.background]
        UIApplication.shared.isStatusBarHidden = true
    }

    private func initCloseButton() {
        closeButton = CustomCloseButton()
        closeButton.setColor(colors: [Color.light.blackPrimary])
        closeButton.setBlurEffect(style: .extraLight)
        self.addSubview(closeButton)

        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.width.equalTo(closeButton.frame.size.width)
            make.height.equalTo(closeButton.frame.size.height)
        }
    }

    private func initScrollView() {
        scrollView = UIScrollView()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }

        self.addSubview(scrollView)

        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

    private func initHeaderView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill

        headerView = UIView()
        headerView.clipsToBounds = true
        headerView.addSubview(imageView)

        scrollView.addSubview(headerView)

        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(SeriesViewMeasure.imageHeight)
        }

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.width * 1.5)
            make.centerX.equalTo(headerView)
        }
    }

    private func initKeyFiguresView() {
        initRunTimeView()
        initAirDateView()
        initVoteView()

        keyFiguresInnerView = UIView()
        keyFiguresInnerView.addSubview(runTimeView)
        keyFiguresInnerView.addSubview(airDateView)
        keyFiguresInnerView.addSubview(voteView)

        keyFiguresView = UIView()
        keyFiguresView.addSubview(keyFiguresInnerView)

        scrollView.addSubview(keyFiguresView)

        initRunTimeConstraints()
        initAirDateConstraints()
        initVoteConstraints()

        keyFiguresInnerView.snp.makeConstraints { (make) in
            make.top.equalTo(keyFiguresView).offset(24)
            make.bottom.equalTo(keyFiguresView)
            make.centerX.equalTo(keyFiguresView)
        }

        keyFiguresView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }

    private func initRunTimeView() {
        runTimeImageView = UIImageView()
        runTimeImageView.image = UIImage(named: "clock")?.withRenderingMode(.alwaysTemplate)
        runTimeImageView.theme_tintColor = [Color.light.blackSecondary]

        runTimeLabel = UILabel()
        runTimeLabel.text = "–"
        runTimeLabel.font = Font.caption
        runTimeLabel.theme_textColor = [Color.light.blackSecondary]

        runTimeView = UIView()
        runTimeView.addSubview(runTimeImageView)
        runTimeView.addSubview(runTimeLabel)
    }

    private func initRunTimeConstraints() {
        runTimeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(runTimeView)
            make.bottom.equalTo(runTimeView)
            make.left.equalTo(runTimeView)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }

        runTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(runTimeView)
            make.bottom.equalTo(runTimeView)
            make.left.equalTo(runTimeImageView.snp.right).offset(4)
            make.right.equalTo(runTimeView)
            make.height.equalTo(16)
        }

        runTimeView.snp.makeConstraints { (make) in
            make.top.equalTo(keyFiguresInnerView)
            make.bottom.equalTo(keyFiguresInnerView)
            make.left.equalTo(keyFiguresInnerView)
        }
    }

    private func initAirDateView() {
        airDateImageView = UIImageView()
        airDateImageView.image = UIImage(named: "calendar")?.withRenderingMode(.alwaysTemplate)
        airDateImageView.theme_tintColor = [Color.light.blackSecondary]

        airDateLabel = UILabel()
        airDateLabel.text = "–"
        airDateLabel.font = Font.caption
        airDateLabel.theme_textColor = [Color.light.blackSecondary]

        airDateView = UIView()
        airDateView.addSubview(airDateImageView)
        airDateView.addSubview(airDateLabel)
    }

    private func initAirDateConstraints() {
        airDateImageView.snp.makeConstraints { (make) in
            make.top.equalTo(airDateView)
            make.bottom.equalTo(airDateView)
            make.left.equalTo(airDateView)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }

        airDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(airDateView)
            make.bottom.equalTo(airDateView)
            make.left.equalTo(airDateImageView.snp.right).offset(4)
            make.right.equalTo(airDateView)
            make.height.equalTo(16)
        }

        airDateView.snp.makeConstraints { (make) in
            make.top.equalTo(keyFiguresInnerView)
            make.bottom.equalTo(keyFiguresInnerView)
            make.left.equalTo(runTimeView.snp.right).offset(16)
        }
    }

    private func initVoteView() {
        voteImageView = UIImageView()
        voteImageView.image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        voteImageView.theme_tintColor = [Color.light.blackSecondary]

        voteLabel = UILabel()
        voteLabel.text = "–"
        voteLabel.font = Font.caption
        voteLabel.theme_textColor = [Color.light.blackSecondary]

        voteView = UIView()
        voteView.addSubview(voteImageView)
        voteView.addSubview(voteLabel)
    }

    private func initVoteConstraints() {
        voteImageView.snp.makeConstraints { (make) in
            make.top.equalTo(voteView)
            make.bottom.equalTo(voteView)
            make.left.equalTo(voteView)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }

        voteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(voteView)
            make.bottom.equalTo(voteView)
            make.left.equalTo(voteImageView.snp.right).offset(4)
            make.right.equalTo(voteView)
            make.height.equalTo(16)
        }

        voteView.snp.makeConstraints { (make) in
            make.top.equalTo(keyFiguresInnerView)
            make.bottom.equalTo(keyFiguresInnerView)
            make.left.equalTo(airDateView.snp.right).offset(16)
            make.right.equalTo(keyFiguresInnerView)
        }
    }

    private func initContentView() {
        nameLabel = UILabel()
        nameLabel.font = Font.headline2
        nameLabel.theme_textColor = [Color.light.blackPrimary]
        nameLabel.numberOfLines = 0

        overviewLabel = UILabel()
        overviewLabel.font = Font.body
        overviewLabel.theme_textColor = [Color.light.blackPrimary]
        overviewLabel.numberOfLines = 0

        contentInnerView = UIView()
        contentInnerView.addSubview(nameLabel)
        contentInnerView.addSubview(overviewLabel)

        contentView = UIView()
        contentView.addSubview(contentInnerView)

        scrollView.addSubview(contentView)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentInnerView)
            make.left.equalTo(contentInnerView)
            make.right.equalTo(contentInnerView)
        }

        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentInnerView)
            make.left.equalTo(contentInnerView)
            make.right.equalTo(contentInnerView)
        }

        contentInnerView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(keyFiguresView.snp.bottom)
            make.bottom.equalTo(scrollView)
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
}
