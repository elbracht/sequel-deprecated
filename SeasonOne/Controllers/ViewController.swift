import UIKit
import SnapKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {

    var style: Style!

    struct Style {
        let backgroundColor: UIColor
        let statusBarStyle: UIStatusBarStyle

        static let light = Style(
            backgroundColor: Color.light.background,
            statusBarStyle: .default
        )
    }

    let scrollIndicatorOffset: CGFloat = 8
    let searchTriggerPosition: CGFloat = 250

    var searchView: SearchView!
    var scrollIndicatorImageView: ScrollIndicatorImageView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        initSearchView()
        initScrollIndicator()

        updateStyle(style: .light)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPanGesture))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Init */
    func initSearchView() {
        searchView = SearchView()
        searchView.searchTextField.delegate = self
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(searchView.height + searchView.insets.top)
        }
    }

    func initScrollIndicator() {
        scrollIndicatorImageView = ScrollIndicatorImageView(frame: CGRect())
        self.view.addSubview(scrollIndicatorImageView)

        scrollIndicatorImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchView.snp.bottom).offset(scrollIndicatorOffset)
            make.centerX.equalTo(self.view)
        }
    }

    /* Updates */
    func updateStyle(style: Style) {
        self.style = style

        updateBackgroundColor(style.backgroundColor, statusBarStyle: style.statusBarStyle)
    }

    func updateBackgroundColor(_ color: UIColor, statusBarStyle: UIStatusBarStyle) {
        self.view.backgroundColor = color
        UIApplication.shared.statusBarStyle = statusBarStyle
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SearchTransition(transitionMode: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SearchTransition(transitionMode: .dismiss)
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let searchController = SearchController()
        searchController.transitioningDelegate = self
        present(searchController, animated: true)
        return false
    }

    @objc func detectPanGesture(sender: UIPanGestureRecognizer) {
        let yTranslation = sender.translation(in: self.view).y
        let offset = yTranslation / 10

        scrollIndicatorImageView.animateFadeIn()

        searchView.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(offset)
        }

        scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(searchView.snp.bottom).offset(scrollIndicatorOffset + (offset * 1.5))
        }

        if yTranslation > searchTriggerPosition {
            searchView.searchTextField.animateTextFieldHightlight()
            scrollIndicatorImageView.animateHightlight()
        } else {
            searchView.searchTextField.animateTextFieldDefault()
            scrollIndicatorImageView.animateDefault()
        }

        if sender.state == UIGestureRecognizerState.ended {
            searchView.searchTextField.animateTextFieldDefault()
            scrollIndicatorImageView.animateDefault()

            animateRubberBand(completion: { _ in
                self.scrollIndicatorImageView.animateFadeOut()

                if yTranslation > self.searchTriggerPosition {
                    self.searchView.searchTextField.becomeFirstResponder()
                }
            })
        }
    }

    /* Animation */
    func animateRubberBand(completion: @escaping (_ success: Bool) -> Void) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
            self.searchView.snp.updateConstraints { (make) -> Void in
                make.top.equalTo(self.view)
            }

            self.scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
                make.top.equalTo(self.searchView.snp.bottom).offset(self.scrollIndicatorOffset)
            }

            self.view.layoutIfNeeded()
        }, completion: { (success) in
            completion(success)
        })
    }
}
