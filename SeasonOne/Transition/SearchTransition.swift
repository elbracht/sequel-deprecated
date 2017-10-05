import UIKit

class SearchTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
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
    
    func searchSwipeLeft(controller: ViewController) {
        controller.searchIconTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.cancelButton.snp.left).offset(-8)
        }
        
        controller.cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.view).offset(-16)
        }
        
        controller.searchIconTextField.iconColor = ColorConstant.white
        
        controller.view.layoutIfNeeded()
    }
    
    func searchSwipeLeftReset(controller: ViewController) {
        controller.searchIconTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.cancelButton.snp.left).offset(-16)
        }
        
        controller.cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.view).offset(controller.cancelButton.intrinsicContentSize.width)
        }
        
        controller.searchIconTextField.iconColor = ColorConstant.white.withAlphaComponent(0.54)
        
        controller.view.layoutIfNeeded()
    }
    
    func searchSwipeRight(controller: SearchController) {
        controller.searchIconTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.cancelButton.snp.left).offset(-16)
        }
        
        controller.cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.view).offset(controller.cancelButton.intrinsicContentSize.width)
        }
        
        controller.searchIconTextField.iconColor = ColorConstant.white.withAlphaComponent(0.54)
        
        controller.view.layoutIfNeeded()
    }
    
    func searchSwipeRightReset(controller: SearchController) {
        controller.searchIconTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.cancelButton.snp.left).offset(-8)
        }
        
        controller.cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(controller.view).offset(-16)
        }
        
        controller.searchIconTextField.iconColor = ColorConstant.white
        
        controller.view.layoutIfNeeded()
    }
    
    func present(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if let toController = transitionContext.viewController(forKey: .to) as? SearchController {
            if let fromController = transitionContext.viewController(forKey: .from) as? ViewController {
                containerView.addSubview(toController.view)
                
                toController.view.alpha = 0
                toController.searchIconTextField.becomeFirstResponder()
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.searchSwipeLeft(controller: fromController)
                }, completion: { (success) in
                    toController.view.alpha = 1
                    transitionContext.completeTransition(success)
                    self.searchSwipeLeftReset(controller: fromController)
                })
            }
        }
    }
    
    func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        if let searchViewController = transitionContext.viewController(forKey: .from) as? SearchController {
            searchViewController.searchIconTextField.endEditing(true)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.searchSwipeRight(controller: searchViewController)
            }, completion: { (success) in
                searchViewController.view.removeFromSuperview()
                transitionContext.completeTransition(success)
                self.searchSwipeRightReset(controller: searchViewController)
            })
        }
    }
}
