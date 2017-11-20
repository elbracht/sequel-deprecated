import SwiftTheme
import UIKit

class CustomTextField: UITextField {
    public let placeholderLabel = UILabel()
    public let imageView = UIImageView()

    private var image = UIImage()
    private var clearImage = UIImage()

    public var leftOffset = 16 as CGFloat
    public var rightOffset = 16 as CGFloat
    public var leftInnerOffset = 8 as CGFloat
    public var rightInnerOffset = 8 as CGFloat

    override init(frame: CGRect) {
        super.init(frame: frame)

        initImageView()
        initPlaceholderLabel()
        initClearButton()

        self.addTarget(self, action: #selector(searchTextFieldEditingChanged), for: .editingChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }

    private func initImageView() {
        self.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(leftOffset)
            make.bottom.equalTo(self)
        }
    }

    private func initPlaceholderLabel() {
        self.addSubview(placeholderLabel)

        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(imageView.snp.right).offset(leftInnerOffset)
            make.bottom.equalTo(self)
        }
    }

    private func initClearButton() {
        self.clearButtonMode = .whileEditing
    }
}

/**
Set CustomTextField properties
*/
extension CustomTextField {
    func setPlaceholderText(_ text: String) {
        placeholderLabel.text = text
    }

    func setFont(_ font: UIFont) {
        self.font = font
        placeholderLabel.font = font
    }

    func setImage(_ image: UIImage) {
        self.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.image = image.withRenderingMode(.alwaysTemplate)
    }

    func setClearImage(_ image: UIImage, colors: ThemeColorPicker) {
        self.clearImage = image
        if let clearButton = self.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.imageView?.theme_tintColor = colors
        }
    }

    func setBackgroundColors(_ colors: ThemeColorPicker) {
        self.theme_backgroundColor = colors
    }

    func setTextColors(_ colors: ThemeColorPicker) {
        self.theme_textColor = colors
    }

    func setPlaceholderColors(_ colors: ThemeColorPicker) {
        placeholderLabel.theme_textColor = colors
        imageView.theme_tintColor = colors
    }

    func setTintColors(_ colors: ThemeColorPicker) {
        self.theme_tintColor = colors
    }

    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func setOffset(left: CGFloat, right: CGFloat, leftInner: CGFloat, rightInner: CGFloat) {
        leftOffset = left
        rightOffset = right
        leftInnerOffset = leftInner
        rightInnerOffset = rightInner

        imageView.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(leftOffset)
        }

        placeholderLabel.snp.updateConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(leftInnerOffset)
        }
    }
}

/**
TextField event to disable placeholder and highlight image
*/
extension CustomTextField {
    @objc public func searchTextFieldEditingChanged() {
        UIView.animate(withDuration: 0.1) {
            if self.hasText {
                self.placeholderLabel.alpha = 0
                self.imageView.theme_tintColor = self.theme_textColor
            } else {
                self.placeholderLabel.alpha = 1
                self.imageView.theme_tintColor = self.placeholderLabel.theme_textColor
            }
        }
    }
}

/**
TextField offsets
*/
extension CustomTextField {
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let left = leftOffset + leftInnerOffset + image.size.width
        let right = rightOffset + rightInnerOffset + clearImage.size.width
        let offset = UIEdgeInsets(top: 1, left: left, bottom: 0, right: right - 8)
        return UIEdgeInsetsInsetRect(bounds, offset)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let left = leftOffset + leftInnerOffset + image.size.width
        let right = rightOffset + rightInnerOffset + clearImage.size.width
        let offset = UIEdgeInsets(top: 1, left: left, bottom: 0, right: right - 8)
        return UIEdgeInsetsInsetRect(bounds, offset)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let right = rightOffset + clearImage.size.width
        return CGRect(x: self.frame.width - right, y: 0, width: clearImage.size.height, height: self.frame.height)
    }
}
