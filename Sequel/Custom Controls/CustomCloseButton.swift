import SwiftTheme
import UIKit

class CustomCloseButton: UIButton {
    private let size = 28
    private let offset = 8

    private var blur: UIVisualEffectView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.frame = CGRect(x: 0, y: 0, width: size + 2 * offset, height: size + 2 * offset)
        initImage()
        initBlur(size: size, offset: offset)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func initImage() {
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.setImage(image, for: .highlighted)
        self.imageView?.tintColor = UIColor.black
    }

    func initBlur(size: Int, offset: Int) {
        blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.frame = CGRect(x: offset, y: offset, width: size, height: size)
        blur.layer.cornerRadius = CGFloat(size / 2)
        blur.clipsToBounds = true
        blur.isUserInteractionEnabled = false
        self.insertSubview(blur, at: 0)
    }
}

/**
Set CustomButton properties
*/
extension CustomCloseButton {
    func setColor(colors: ThemeColorPicker) {
        self.imageView?.theme_tintColor = colors
    }

    func setBlurEffect(style: UIBlurEffectStyle) {
        blur.effect = UIBlurEffect(style: style)
    }
}
