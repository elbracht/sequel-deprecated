import SnapKit
import SwiftTheme
import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {

    struct Style {
        let backgroundColor: String
        let statusBarStyle: UIStatusBarStyle

        static let light = Style(
            backgroundColor: Color.light.background,
            statusBarStyle: .default
        )
    }

    struct Measure {
        static let scrollIndicatorOffset = 8 as CGFloat
        static let searchTriggerPosition = 250 as CGFloat
    }

    var searchView: SearchView!
    var scrollIndicatorImageView: ScrollIndicatorImageView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        initView()
        initSearchView()
        initScrollIndicator()

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPanGesture))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Init */
    func initView() {
        self.view.theme_backgroundColor = [Style.light.backgroundColor]
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: Style.light.statusBarStyle)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }

    func initSearchView() {
        searchView = SearchView()
        searchView.searchTextField.delegate = self
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(SearchView.Measure.height + SearchView.Measure.offset.top)
        }
    }

    func initScrollIndicator() {
        scrollIndicatorImageView = ScrollIndicatorImageView(frame: CGRect())
        self.view.addSubview(scrollIndicatorImageView)

        scrollIndicatorImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchView.snp.bottom).offset(Measure.scrollIndicatorOffset)
            make.centerX.equalTo(self.view)
        }
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SearchTransition(transitionMode: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SearchTransition(transitionMode: .dismiss)
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let searchViewController = SearchViewController()
        searchViewController.transitioningDelegate = self
        present(searchViewController, animated: true)
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
            make.top.equalTo(searchView.snp.bottom).offset(Measure.scrollIndicatorOffset + (offset * 1.5))
        }

        if yTranslation > Measure.searchTriggerPosition {
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

                if yTranslation > Measure.searchTriggerPosition {
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
                make.top.equalTo(self.searchView.snp.bottom).offset(Measure.scrollIndicatorOffset)
            }

            self.view.layoutIfNeeded()
        }, completion: { (success) in
            completion(success)
        })
    }
}
