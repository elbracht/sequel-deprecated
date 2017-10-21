import UIKit

class SearchTextField: UITextField {

    let style = Style.light

    struct Style {
        let backgroundColor: UIColor
        let textColor: UIColor
        let imageColor: UIColor
        let tintColor: UIColor
        let clearButtonColor: UIColor
        let placeholderColor: UIColor
        let highlightBackgroundColor: UIColor
        let highlightColor: UIColor

        static let light = Style(
            backgroundColor: Color.light.blackDivider,
            textColor: Color.light.blackPrimary,
            imageColor: Color.light.blackPrimary,
            tintColor: Color.light.accent,
            clearButtonColor: Color.light.blackDisabled,
            placeholderColor: Color.light.blackDisabled,
            highlightBackgroundColor: Color.light.accent,
            highlightColor: Color.light.whitePrimary
        )
    }

    let insetLeft: CGFloat = 16
    let insetLeftInner: CGFloat = 8
    let insetRight: CGFloat = 16
    let insetRightInner: CGFloat = 0

    let searchImageView = UIImageView()
    let searchImage = UIImage(named: "search")!
    let clearImage = UIImage(named: "clear")!

    let placeholderText = "Search"

    override init(frame: CGRect) {
        super.init(frame: frame)

        initImage()

        updateCornerRadius(self.frame.height / 2)
        updateFont(Font.body)
        updateBackgroundColor(style.backgroundColor)
        updateTextColor(style.textColor)
        updateTintColor(style.tintColor)
        updateImageColor(style.placeholderColor)
        updateClearImageColor(style.clearButtonColor)
        updatePlaceholderColor(style.placeholderColor)
        updateKeyboard()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        super.updateConstraints()

        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                updateCornerRadius(constraint.constant / 2)
            }
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let left = insetLeft + insetLeftInner + searchImage.size.width
        let right = insetRight + insetRightInner + clearImage.size.width
        let insets = UIEdgeInsets(top: 1, left: left, bottom: 0, right: right)
        return UIEdgeInsetsInsetRect(bounds, insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let left = insetLeft + insetLeftInner + searchImage.size.width
        let right = insetRight + insetRightInner + clearImage.size.width
        let insets = UIEdgeInsets(top: 1, left: left, bottom: 0, right: right)
        return UIEdgeInsetsInsetRect(bounds, insets)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let superLeftViewRect = super.leftViewRect(forBounds: bounds)
        return superLeftViewRect.offsetBy(dx: insetLeft, dy: 0)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let textFieldEndPosition = (bounds.width / 2) - (clearImage.size.width / 2)
        let inset = textFieldEndPosition - insetRight
        return bounds.offsetBy(dx: inset, dy: 0)
    }

    /* Init */
    func initImage() {
        searchImageView.frame = CGRect(x: 0, y: 0, width: searchImage.size.width, height: searchImage.size.height)
        searchImageView.image = searchImage.withRenderingMode(.alwaysTemplate)
        self.leftView = searchImageView
        self.leftViewMode = .always
    }

    /* Updates */
    func updateCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func updateFont(_ font: UIFont?) {
        self.font = font
    }

    func updateBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }

    func updateTextColor(_ color: UIColor) {
        self.textColor = color
    }

    func updateTintColor(_ color: UIColor) {
        self.tintColor = color
    }

    func updateImageColor(_ color: UIColor) {
        searchImageView.tintColor = color
    }

    func updateClearImageColor(_ color: UIColor) {
        if let clearButton = self.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(clearImage.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.imageView?.tintColor = color
        }

        self.clearButtonMode = .always
    }

    func updatePlaceholderColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor: color])
    }

    func updateKeyboard() {
        self.keyboardType = .alphabet
        self.keyboardAppearance = .dark
        self.autocorrectionType = .no
        self.autocapitalizationType = .sentences
        self.returnKeyType = .search
    }

    /* Animation */
    func animateTextFieldDefault() {
        UIView.animate(withDuration: 0.1) {
            self.updateBackgroundColor(self.style.backgroundColor)
            self.updateImageColor(self.style.placeholderColor)
            self.updatePlaceholderColor(self.style.placeholderColor)
        }
    }

    func animateTextFieldHightlight() {
        UIView.animate(withDuration: 0.1) {
            self.updateBackgroundColor(self.style.highlightBackgroundColor)
            self.updateImageColor(self.style.highlightColor)
            self.updatePlaceholderColor(self.style.highlightColor)
        }
    }

    func animateImageDefault() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor(self.style.imageColor)
        }
    }

    func animateImageHighlight() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor(self.style.highlightColor)
        }
    }

    func animateImagePlaceholder() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor(self.style.placeholderColor)
        }
    }
}
