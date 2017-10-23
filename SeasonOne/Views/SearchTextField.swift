import UIKit

class SearchTextField: UITextField {

    struct Measure {
        static let offset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let imageOffset = 8 as CGFloat
        static let clearButtonOffset = 0 as CGFloat
    }

    let searchImageView = UIImageView()
    let searchImage = UIImage(named: "search")!
    let clearImage = UIImage(named: "clear")!

    let placeholderText = "Search"

    let defaultBackgroundColor = Color.black.withAlphaComponent(0.38)
    let defaultTextColor = Color.white
    let defaultTintColor = Color.accent
    let defaultImageColor = Color.white.withAlphaComponent(0.54)
    let defaultClearButtonColor = Color.white.withAlphaComponent(0.54)
    let defaultPlaceholderColor = Color.white.withAlphaComponent(0.54)

    let highlightBackgroundColor = Color.accent
    let highlightImageColor = Color.white
    let highlightPlaceholderColor = Color.white

    override init(frame: CGRect) {
        super.init(frame: frame)

        initImage()

        updateCornerRadius(self.frame.height / 2)
        updateFont(Font.body)
        updateBackgroundColor(defaultBackgroundColor)
        updateTextColor(defaultTextColor)
        updateTintColor(defaultTintColor)
        updateImageColor(defaultImageColor)
        updateClearImageColor(defaultClearButtonColor)
        updatePlaceholderColor(defaultPlaceholderColor)
        updateKeyboard()
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
    func animateTextFieldHightlightDisabled() {
        UIView.animate(withDuration: 0.1) {
            self.updateBackgroundColor(self.defaultBackgroundColor)
            self.updateImageColor(self.defaultImageColor)
            self.updatePlaceholderColor(self.defaultPlaceholderColor)
        }
    }

    func animateTextFieldHightlightEnabled() {
        UIView.animate(withDuration: 0.1) {
            self.updateBackgroundColor(self.highlightBackgroundColor)
            self.updateImageColor(self.highlightImageColor)
            self.updatePlaceholderColor(self.highlightPlaceholderColor)
        }
    }

    func animateImageHighlightDisabled() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor(self.defaultImageColor)
        }
    }

    func animateImageHighlightEnabled() {
        UIView.animate(withDuration: 0.1) {
            self.updateImageColor(self.highlightImageColor)
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
