import SnapKit
import SwiftTheme
import UIKit

struct SeriesViewMeasure {
    static let imageHeight = 360 as CGFloat
}

class SeriesView: UIScrollView {
    public var headerView: UIView!
    public var imageView: UIImageView!
    public var contentView: UIView!
    public var nameLabel: UILabel!
    public var overviewLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initHeaderView()
        initContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        self.theme_backgroundColor = [Color.light.background]
        UIApplication.shared.isStatusBarHidden = true

        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }

    private func initHeaderView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill

        headerView = UIView()
        headerView.clipsToBounds = true
        headerView.addSubview(imageView)

        self.addSubview(headerView)

        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(SeriesViewMeasure.imageHeight)
        }

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView)
            make.left.equalTo(headerView)
            make.right.equalTo(headerView)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.width * 1.5)
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

        self.addSubview(contentView)

        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(SeriesViewMeasure.imageHeight)
            make.bottom.equalTo(self)
            make.width.equalTo(self)
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
