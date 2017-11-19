import UIKit

class MainToSearchTransition: NSObject, UIViewControllerAnimatedTransitioning {

    enum TransitionMode: Int {
        case present, dismiss
    }

    var transitionMode: TransitionMode

    init(transitionMode: TransitionMode) {
        self.transitionMode = transitionMode
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionMode == .present {
            present(transitionContext: transitionContext)
        } else if transitionMode == .dismiss {
            dismiss(transitionContext: transitionContext)
        } else {
            transitionContext.completeTransition(false)
        }
    }

    func present(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if let searchViewController = transitionContext.viewController(forKey: .to) as? SearchViewController {
            if let mainViewController = transitionContext.viewController(forKey: .from) as? MainViewController {
                containerView.addSubview(searchViewController.view)

                searchViewController.searchView.alpha = 0
                searchViewController.searchView.searchInputView.textField.becomeFirstResponder()

                UIView.animate(withDuration: 0.2, animations: {
                    mainViewController.mainView.searchInputView.showCancelButton()
                    mainViewController.mainView.layoutIfNeeded()
                }, completion: { (success) in
                    transitionContext.completeTransition(success)
                    searchViewController.searchView.alpha = 1
                    mainViewController.mainView.searchInputView.hideCancelButton()
                })
            }
        }
    }

    func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        if let searchViewController = transitionContext.viewController(forKey: .from) as? SearchViewController {
            searchViewController.searchView.searchInputView.textField.endEditing(true)

            UIView.animate(withDuration: 0.2, animations: {
                searchViewController.searchView.searchInputView.hideCancelButton()
                searchViewController.searchView.layoutIfNeeded()
            }, completion: { (success) in
                transitionContext.completeTransition(success)
                searchViewController.view.removeFromSuperview()
                searchViewController.searchView.searchInputView.showCancelButton()
            })
        }
    }
}
