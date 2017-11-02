import Kingfisher
import SnapKit
import SwiftTheme
import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    struct Style {
        let backgroundColor: String
        let textColor: String

        static let light = Style(
            backgroundColor: Color.light.blackDivider,
            textColor: Color.light.whitePrimary
        )
    }

    struct Measure {
        static let cornerRadius = 8 as CGFloat
        static let titleViewHeight = 54
        static let nameLabelHeight = 16
        static let nameLabelOffset = UIEdgeInsets(top: 12, left: 8, bottom: 0, right: 8)
        static let captionLabelHeight = 14
        static let captionLabelOffset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    var imageView: UIImageView!
    var titleView: UIView!
    var blurEffectView: UIVisualEffectView!
    var nameLabel: UILabel!
    var captionLabel: UILabel!
    var progressView: UIView!

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

    /* Init */
    func initView() {
        self.theme_backgroundColor = [Style.light.backgroundColor]

        self.contentView.layer.cornerRadius = 4
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = Shadow.small.color
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = Shadow.small.offset
        self.layer.shadowRadius = Shadow.small.radius
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = false
    }

    func initImageView() {
        imageView = UIImageView()
        imageView.alpha = 0

        self.contentView.addSubview(imageView)

        imageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView)
        }
    }

    func initTitleView() {
        titleView = UIView()

        self.contentView.addSubview(titleView)

        titleView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.height.equalTo(Measure.titleViewHeight)
        }
    }

    func initBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0

        titleView.addSubview(blurEffectView)

        blurEffectView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(titleView)
        }
    }

    func initNameLabel() {
        nameLabel = UILabel()
        nameLabel.theme_textColor = [Style.light.textColor]
        nameLabel.font = Font.caption
        nameLabel.textAlignment = .center

        titleView.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleView).offset(Measure.nameLabelOffset.top)
            make.left.equalTo(titleView).offset(Measure.nameLabelOffset.left)
            make.right.equalTo(titleView).offset(-Measure.nameLabelOffset.right)
            make.height.equalTo(Measure.nameLabelHeight)
        }
    }

    func initCaptionLabel() {
        captionLabel = UILabel()
        captionLabel.theme_textColor = [Style.light.textColor]
        captionLabel.font = Font.small
        captionLabel.textAlignment = .center

        titleView.addSubview(captionLabel)

        captionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(titleView).offset(Measure.captionLabelOffset.left)
            make.right.equalTo(titleView).offset(-Measure.captionLabelOffset.right)
            make.height.equalTo(Measure.captionLabelHeight)
        }
    }

    func updateImage(url: String) {
        if let url = URL(string: url) {
            imageView.kf.setImage(with: url, completionHandler: { (_, _, _, _) in
                self.animateFadeIn()
            })
        }
    }

    func updateNameText(_ text: String) {
        nameLabel.text = text
    }

    func updateCaptionText(_ text: String) {
        captionLabel.text = text
    }

    /* Animation */
    func animateFadeIn() {
        if self.imageView.alpha == 0 && self.blurEffectView.alpha == 0 {
            UIView.animate(withDuration: 0.2) {
                self.layer.shadowOpacity = Shadow.small.opacity
                self.imageView.alpha = 1
                self.blurEffectView.alpha = 1
            }
        }
    }
}
