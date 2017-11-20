import SwiftTheme
import UIKit

class CustomButton: UIButton {
    private var colors: ThemeColorPicker!
    private var highlightColors: ThemeColorPicker!
    private var image: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchUpOutside), for: .touchUpOutside)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

/**
Set CustomButton properties
*/
extension CustomButton {
    public func setTitle(_ title: String, font: UIFont) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
    }

    public func setImage(_ imageName: String) {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.setImage(image, for: .highlighted)
    }

    public func setColors(colors: ThemeColorPicker, highlightColors: ThemeColorPicker) {
        self.colors = colors
        self.highlightColors = highlightColors
        updateColor(colors)
    }
}

/**
Update CustomButton color properties
*/
extension CustomButton {
    private func updateColor(_ colors: ThemeColorPicker) {
        self.theme_setTitleColor(colors, forState: .normal)
        self.theme_setTitleColor(colors, forState: .highlighted)
        self.imageView?.theme_tintColor = colors
    }
}

/**
CustomButton events to highlight touch
*/
extension CustomButton {
    @objc private func buttonTouchDown(sender: CustomButton!) {
        UIView.animate(withDuration: 0.1) {
            self.updateColor(self.highlightColors)
        }
    }

    @objc private func buttonTouchUpInside(sender: CustomButton!) {
        UIView.animate(withDuration: 0.1) {
            self.updateColor(self.colors)
        }
    }

    @objc private func buttonTouchUpOutside(sender: CustomButton!) {
        UIView.animate(withDuration: 0.1) {
            self.updateColor(self.colors)
        }
    }
}
