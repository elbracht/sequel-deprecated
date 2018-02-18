import SnapKit
import SwiftTheme
import UIKit

struct SearchCollectiobViewCellMeasure {
    static let cornerRadius = 4 as CGFloat
    static let titleViewHeight = 54
    static let nameLabelHeight = 16
    static let nameLabelOffset = UIEdgeInsets(top: 12, left: 8, bottom: 0, right: 8)
    static let captionLabelHeight = 14
    static let captionLabelOffset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
}

class SearchCollectionViewCell: UICollectionViewCell {
    public var imageView: UIImageView!
    public var titleView: UIView!
    public var blurEffectView: UIVisualEffectView!
    public var nameLabel: UILabel!
    public var captionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initImageView()
        initTitleView()
        initBlurEffectView()
        initNameLabel()
        initCaptionLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        self.theme_backgroundColor = [Color.Black.divider.hexString(true)]

        self.contentView.layer.cornerRadius = SearchCollectiobViewCellMeasure.cornerRadius
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = Shadow.depth1.color
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = Shadow.depth1.offset
        self.layer.shadowRadius = Shadow.depth1.radius
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: SearchCollectiobViewCellMeasure.cornerRadius).cgPath
        self.layer.cornerRadius = SearchCollectiobViewCellMeasure.cornerRadius
        self.layer.masksToBounds = false
    }

    private func initImageView() {
        imageView = UIImageView()
        imageView.alpha = 0
        self.contentView.addSubview(imageView)

        imageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView)
        }
    }

    private func initTitleView() {
        titleView = UIView()
        self.contentView.addSubview(titleView)

        titleView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.height.equalTo(SearchCollectiobViewCellMeasure.titleViewHeight)
        }
    }

    private func initBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0
        titleView.addSubview(blurEffectView)

        blurEffectView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(titleView)
        }
    }

    private func initNameLabel() {
        nameLabel = UILabel()
        nameLabel.theme_textColor = [Color.White.primary.hexString(true)]
        nameLabel.font = Font.caption
        nameLabel.textAlignment = .center
        titleView.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleView).offset(SearchCollectiobViewCellMeasure.nameLabelOffset.top)
            make.left.equalTo(titleView).offset(SearchCollectiobViewCellMeasure.nameLabelOffset.left)
            make.right.equalTo(titleView).offset(-SearchCollectiobViewCellMeasure.nameLabelOffset.right)
            make.height.equalTo(SearchCollectiobViewCellMeasure.nameLabelHeight)
        }
    }

    private func initCaptionLabel() {
        captionLabel = UILabel()
        captionLabel.theme_textColor = [Color.White.primary.hexString(true)]
        captionLabel.font = Font.small
        captionLabel.textAlignment = .center
        titleView.addSubview(captionLabel)

        captionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(titleView).offset(SearchCollectiobViewCellMeasure.captionLabelOffset.left)
            make.right.equalTo(titleView).offset(-SearchCollectiobViewCellMeasure.captionLabelOffset.right)
            make.height.equalTo(SearchCollectiobViewCellMeasure.captionLabelHeight)
        }
    }

    public func showCell() {
        if self.imageView.alpha == 0 && self.blurEffectView.alpha == 0 {
            self.layer.shadowOpacity = Shadow.depth1.opacity
            self.imageView.alpha = 1
            self.blurEffectView.alpha = 1
        }
    }
}
