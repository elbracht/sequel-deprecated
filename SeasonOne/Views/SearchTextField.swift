import UIKit

class SearchTextField: UITextField {
    let insetLeft: CGFloat = 16
    let insetLeftInner: CGFloat = 8
    let insetRight: CGFloat = 16
    let insetRightInner: CGFloat = 0
    
    let searchImageView = UIImageView()
    let searchImage = UIImage(named: "search")!
    let clearImage = UIImage(named: "clear")!
    
    let placeholderText = "Search"
    
    let defaultBackgroundColor = ColorConstant.black.withAlphaComponent(0.38)
    let defaultTextColor = ColorConstant.white
    let defaultTintColor = ColorConstant.accent
    let defaultImageColor = ColorConstant.white.withAlphaComponent(0.54)
    let defaultClearButtonColor = ColorConstant.white.withAlphaComponent(0.54)
    let defaultPlaceholderColor = ColorConstant.white.withAlphaComponent(0.54)
    
    let highlightBackgroundColor = ColorConstant.accent
    let highlightImageColor = ColorConstant.white
    let highlightPlaceholderColor = ColorConstant.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initImage()
        
        updateCornerRadius(self.frame.height / 2)
        updateFont(FontConstant.body!)
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
    
    override func updateConstraints() {
        super.updateConstraints()
        
        self.constraints.forEach { (constraint) in
            if (constraint.firstAttribute == .height) {
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
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = true
    }
    
    func updateFont(_ font: UIFont) {
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
        let clearButton = self.value(forKey: "_clearButton") as! UIButton
        clearButton.setImage(clearImage.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.imageView?.tintColor = color
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
}
