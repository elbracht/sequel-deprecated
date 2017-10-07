import UIKit

class ScrollIndicatorImageView: UIImageView {

    let defaultBackgroundColor = Color.white.withAlphaComponent(0.38)
    let highlightBackgroundColor = Color.accent

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.image = UIImage(named: "arrow_down")?.withRenderingMode(.alwaysTemplate)
        self.tintColor = defaultBackgroundColor
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

    func animateHightlightDisabled() {
        UIView.animate(withDuration: 0.1) {
            self.tintColor = self.defaultBackgroundColor
        }
    }

    func animateHightlightEnabled() {
        UIView.animate(withDuration: 0.1) {
            self.tintColor = self.highlightBackgroundColor
        }
    }
}
