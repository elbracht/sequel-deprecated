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

        if let toController = transitionContext.viewController(forKey: .to) as? SearchViewController {
            if let fromController = transitionContext.viewController(forKey: .from) as? MainViewController {
                containerView.addSubview(toController.view)

                toController.view.alpha = 0
                toController.startEditingSearchTextField()

                fromController.animateSearchSwipe(completion: { (success) in
                    transitionContext.completeTransition(success)

                    toController.view.alpha = 1
                    fromController.resetSearchSwipe()
                })
            }
        }
    }

    func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        if let fromController = transitionContext.viewController(forKey: .from) as? SearchViewController {
            fromController.endEditingSearchTextField()

            fromController.animateSearchSwipe(completion: { (success) in
                transitionContext.completeTransition(success)

                fromController.view.removeFromSuperview()
                fromController.resetSearchSwipe()
            })
        }
    }
}
