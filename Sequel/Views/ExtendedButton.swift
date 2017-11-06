import SwiftTheme
import UIKit

class ExtendedButton: UIButton {

    private var colors: ThemeColorPicker!
    private var highlightColors: ThemeColorPicker!
    private var image: String?

    /* Init */
    override init(frame: CGRect) {
        super.init(frame: frame)

        setTitle("Hello World!", font: Font.body!)
        setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])

        self.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchCancel), for: .touchCancel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Set */
    func setTitle(_ title: String, font: UIFont) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
    }

    func setImage(_ imageName: String) {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.setImage(image, for: .highlighted)
    }

    func setColors(colors: ThemeColorPicker, highlightColors: ThemeColorPicker) {
        self.colors = colors
        self.highlightColors = highlightColors
        updateColor(colors)
    }

    /* Update */
    func updateColor(_ colors: ThemeColorPicker) {
        self.theme_setTitleColor(colors, forState: .normal)
        self.theme_setTitleColor(colors, forState: .highlighted)
        self.imageView?.theme_tintColor = colors
    }

    /* Animation */
    func animateDefault() {
        UIView.animate(withDuration: 0.1) {
            self.updateColor(self.colors)
        }
    }

    func animateHighlight() {
        UIView.animate(withDuration: 0.1) {
            self.updateColor(self.highlightColors)
        }
    }

    /* Events */
    @objc func buttonTouchDown(sender: ExtendedButton!) {
        animateHighlight()
    }

    @objc func buttonTouchUpInside(sender: ExtendedButton!) {
        animateDefault()
    }

    @objc func buttonTouchCancel(sender: ExtendedButton!) {
        animateDefault()
    }
}
