import SwiftTheme
import UIKit

class SearchTextField: UITextField {

    struct Style {
        let backgroundColor: String
        let textColor: String
        let imageColor: String
        let tintColor: String
        let clearButtonColor: String
        let placeholderColor: String
        let highlightBackgroundColor: String
        let highlightColor: String
        let keyboardAppearance: UIKeyboardAppearance

        static let light = Style(
            backgroundColor: Color.light.blackDivider,
            textColor: Color.light.blackPrimary,
            imageColor: Color.light.blackPrimary,
            tintColor: Color.light.accent,
            clearButtonColor: Color.light.blackDisabled,
            placeholderColor: Color.light.blackDisabled,
            highlightBackgroundColor: Color.light.accent,
            highlightColor: Color.light.whitePrimary,
            keyboardAppearance: .light
        )
    }

    struct Measure {
        static let offset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let imageOffset = 8 as CGFloat
        static let clearButtonOffset = 0 as CGFloat
    }

    let searchImageView = UIImageView()
    let searchImage = UIImage(named: "search")!
    let clearImage = UIImage(named: "clear")!

    let placeholderText = "Search"

    override init(frame: CGRect) {
        super.init(frame: frame)

        initImage()
        initKeyboard()

        updateCornerRadius(self.frame.height / 2)
        updateFont(Font.body)
        updateBackgroundColor([Style.light.backgroundColor])
        updateTextColor([Style.light.textColor])
        updateTintColor([Style.light.tintColor])
        updateImageColor([Style.light.placeholderColor])
        updateClearImageColor([Style.light.clearButtonColor])
        updatePlaceholderColor([Style.light.placeholderColor])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Init */
    func initImage() {
        searchImageView.frame = CGRect(x: 0, y: 0, width: searchImage.size.width, height: searchImage.size.height)
        searchImageView.image = searchImage.withRenderingMode(.alwaysTemplate)
        self.leftView = searchImageView
        self.leftViewMode = .always
    }

    func initKeyboard() {
        self.theme_keyboardAppearance = [Style.light.keyboardAppearance]
        self.keyboardType = .alphabet
        self.autocorrectionType = .no
        self.autocapitalizationType = .sentences
        self.returnKeyType = .search
    }

    /* Updates */
    func updateCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func updateFont(_ font: UIFont?) {
        self.font = font
    }

    func updateBackgroundColor(_ colors: ThemeColorPicker) {
        self.theme_backgroundColor = colors
    }

    func updateTextColor(_ colors: ThemeColorPicker) {
        self.theme_textColor = colors
    }

    func updateTintColor(_ colors: ThemeColorPicker) {
        self.theme_tintColor = colors
    }

    func updateImageColor(_ colors: ThemeColorPicker) {
        searchImageView.theme_tintColor = colors
    }

    func updateClearImageColor(_ colors: ThemeColorPicker) {
        if let clearButton = self.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(clearImage.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.imageView?.theme_tintColor = colors
        }

        self.clearButtonMode = .always
    }

    func updatePlaceholderColor(_ colors: ThemeColorPicker) {
        if let color = colors.value() as? UIColor {
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor: color])
        }
    }

    /* Animation */
    func animateTextFieldDefault() {
        UIView.animate(withDuration: 0.1) {
            self.updateBackgroundColor([Style.light.backgroundColor])
            self.updateImageColor([Style.light.placeholderColor])
            self.updatePlaceholderColor([Style.light.placeholderColor])
        }
    }

    func animateTextFieldHightlight() {
        UIView.animate(withDuration: 0.1) {
            self.updateBackgroundColor([Style.light.highlightBackgroundColor])
            self.updateImageColor([Style.light.highlightColor])
            self.updatePlaceholderColor([Style.light.highlightColor])
        }
    }

    func animateImageDefault() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor([Style.light.imageColor])
        }
    }

    func animateImageHighlight() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor([Style.light.highlightColor])
        }
    }

    func animateImagePlaceholder() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor([Style.light.placeholderColor])
        }
    }

    /* Overrides */
    override func updateConstraints() {
        super.updateConstraints()

        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                updateCornerRadius(constraint.constant / 2)
            }
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let leftOffset = Measure.offset.left + Measure.imageOffset + searchImage.size.width
        let rightOffset = Measure.offset.right + Measure.clearButtonOffset + clearImage.size.width
        let offset = UIEdgeInsets(top: 1, left: leftOffset, bottom: 0, right: rightOffset)
        return UIEdgeInsetsInsetRect(bounds, offset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let leftOffset = Measure.offset.left + Measure.imageOffset + searchImage.size.width
        let rightOffset = Measure.offset.right + Measure.clearButtonOffset + clearImage.size.width
        let offset = UIEdgeInsets(top: 1, left: leftOffset, bottom: 0, right: rightOffset)
        return UIEdgeInsetsInsetRect(bounds, offset)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let superLeftViewRect = super.leftViewRect(forBounds: bounds)
        return superLeftViewRect.offsetBy(dx: Measure.offset.left, dy: 0)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let textFieldEndPosition = (bounds.width / 2) - (clearImage.size.width / 2)
        let offset = textFieldEndPosition - Measure.offset.right
        return bounds.offsetBy(dx: offset, dy: 0)
    }
}
