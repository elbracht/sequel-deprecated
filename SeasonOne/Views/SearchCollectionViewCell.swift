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

    var imageView: UIImageView!
    var titleView: UIView!
    var blurEffectView: UIVisualEffectView!
    var nameLabel: UILabel!
    var captionLabel: UILabel!
    var progressView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true

        initView()
        initImageView()
        initTitleView()
        initBlurEffectView()
        initNameLabel()
        initCaptionLabel()
        initProgressView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Init */
    func initView() {
        self.theme_backgroundColor = [Style.light.backgroundColor]
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
            make.height.equalTo(48)
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
            make.top.equalTo(titleView).offset(8)
            make.left.equalTo(titleView).offset(4)
            make.right.equalTo(titleView).offset(-4)
            make.height.equalTo(16)
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
            make.left.equalTo(titleView).offset(4)
            make.right.equalTo(titleView).offset(-4)
            make.height.equalTo(14)
        }
    }

    func initProgressView() {
        progressView = UIView()
        progressView.theme_backgroundColor = [Style.light.textColor]

        titleView.addSubview(progressView)

        progressView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleView)
            make.bottom.equalTo(titleView)
            make.right.equalTo(titleView).offset(-contentView.frame.size.width)
            make.height.equalTo(4)
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
                self.imageView.alpha = 1
                self.blurEffectView.alpha = 1
            }
        }
    }

    func animateProgress(value: CGFloat, max: CGFloat) {
        let offset = (max != 0) ? (contentView.frame.size.width / max) * (max - value) : contentView.frame.size.width

        UIView.animate(withDuration: 0.2) {
            self.progressView.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.titleView).offset(-offset)
            }

            self.titleView.layoutIfNeeded()
        }
    }
}
