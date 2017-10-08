import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {

    let defaultBackgroundColor = Color.black.withAlphaComponent(0.38)
    let defaultColor = Color.white

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
    func initImageView() {
        imageView = UIImageView()
        imageView.backgroundColor = defaultBackgroundColor
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
        nameLabel.textColor = defaultColor
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
        captionLabel.textColor = defaultColor
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
        progressView.backgroundColor = defaultColor

        titleView.addSubview(progressView)

        progressView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleView)
            make.bottom.equalTo(titleView)
            make.right.equalTo(titleView).offset(-contentView.frame.size.width)
            make.height.equalTo(4)
        }
    }

    /* Update */
    func updateImage(_ image: UIImage) {
        imageView.image = image
    }

    func updateBlurAlpha(_ alpha: CGFloat) {
        blurEffectView.alpha = alpha
    }

    func updateNameText(_ text: String, color: UIColor?) {
        nameLabel.text = text
        nameLabel.textColor = color
    }

    func updateCaptionText(_ text: String, color: UIColor?) {
        captionLabel.text = text
        captionLabel.textColor = color
    }

    func updateProgress(value: CGFloat, max: CGFloat, color: UIColor?) {
        progressView.backgroundColor = color

        progressView.snp.updateConstraints { (make) -> Void in
            let offsetRight = (max != 0) ? (self.contentView.frame.size.width / max) * (max - value) : 0

            make.left.equalTo(titleView)
            make.bottom.equalTo(titleView)
            make.right.equalTo(titleView).offset(-offsetRight)
            make.height.equalTo(4)
        }
    }
}
