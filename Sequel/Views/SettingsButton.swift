import SwiftTheme
import UIKit

class SettingsButton: UIButton {

    struct Style {
        let color: String
        let highlightColor: String

        static let light = Style(
            color: Color.light.blackSecondary,
            highlightColor: Color.light.blackPrimary
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()

        updateColor([Style.light.color])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Init */
    func initView() {
        self.setTitle("Settings", for: .normal)
        self.titleLabel?.font = Font.body

        if let settingsImage = UIImage(named: "settings") {
            self.setImage(settingsImage.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    /* Update */
    func updateColor(_ colors: ThemeColorPicker) {
        self.theme_setTitleColor(colors, forState: .normal)
        self.imageView?.theme_tintColor = colors
    }

    /* Animation */
    func animateDefault() {
        UIView.animate(withDuration: 0.1) {
            self.updateColor([Style.light.color])
        }
    }

    func animateHighlight() {
        UIView.animate(withDuration: 0.1) {
            self.updateColor([Style.light.highlightColor])
        }
    }
}
