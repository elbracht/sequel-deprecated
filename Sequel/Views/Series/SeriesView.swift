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
    public var contentView: UIView!
    public var nameLabel: UILabel!
    public var overviewLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initScrollView()
        initHeaderView()
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

    private func initContentView() {
        nameLabel = UILabel()
        nameLabel.font = Font.headline2
        nameLabel.theme_textColor = [Color.light.blackPrimary]
        nameLabel.numberOfLines = 0

        overviewLabel = UILabel()
        overviewLabel.font = Font.body
        overviewLabel.theme_textColor = [Color.light.blackPrimary]
        overviewLabel.numberOfLines = 0

        contentView = UIView()
        contentView.addSubview(nameLabel)
        contentView.addSubview(overviewLabel)

        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(SeriesViewMeasure.imageHeight)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }

        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
            make.bottom.equalTo(contentView).offset(-32)
        }
    }
}
