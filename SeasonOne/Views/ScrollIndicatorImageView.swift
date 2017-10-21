import UIKit

class ScrollIndicatorImageView: UIImageView {

    let style = Style.light

    struct Style {
        let color: UIColor
        let highlightColor: UIColor

        static let light = Style(
            color: Color.light.blackDisabled,
            highlightColor: Color.light.accent
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.image = UIImage(named: "arrow_down")?.withRenderingMode(.alwaysTemplate)
        self.tintColor = style.color
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
            self.tintColor = self.style.color
        }
    }

    func animateHightlight() {
        UIView.animate(withDuration: 0.1) {
            self.tintColor = self.style.highlightColor
        }
    }
}
