import SwiftTheme
import UIKit

class ScrollIndicatorImageView: UIImageView {

    struct Style {
        let color: String
        let highlightColor: String

        static let light = Style(
            color: Color.light.blackDisabled,
            highlightColor: Color.light.accent
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.image = UIImage(named: "arrow_down")?.withRenderingMode(.alwaysTemplate)
        self.theme_tintColor = [Style.light.color]
        self.alpha = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Animation */
    func animateFadeIn() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }

    func animateFadeOut() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        }
    }

    func animateDefault() {
        UIView.animate(withDuration: 0.1) {
            self.theme_tintColor = [Style.light.color]
        }
    }

    func animateHightlight() {
        UIView.animate(withDuration: 0.1) {
            self.theme_tintColor = [Style.light.highlightColor]
        }
    }
}
