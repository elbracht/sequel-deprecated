//
//  SearchTransition.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

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
    
    func present(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if let searchViewController = transitionContext.viewController(forKey: .to) as? SearchController {
            if let viewController = transitionContext.viewController(forKey: .from) as? ViewController {
                containerView.addSubview(searchViewController.view)
                searchViewController.view.alpha = 0
                searchViewController.searchIconTextField.becomeFirstResponder()
                
                UIView.animate(withDuration: 0.2, animations: {
                    viewController.searchIconTextField.snp.updateConstraints { (make) -> Void in
                        make.right.equalTo(viewController.cancelButton.snp.left).offset(-8)
                    }
                    
                    viewController.cancelButton.snp.updateConstraints { (make) -> Void in
                        make.right.equalTo(viewController.view).offset(-16)
                    }
                    
                    viewController.view.layoutIfNeeded()
                }, completion: { (success) in
                    searchViewController.view.alpha = 1
                    transitionContext.completeTransition(success)
                    
                    viewController.searchIconTextField.snp.updateConstraints { (make) -> Void in
                        make.right.equalTo(viewController.cancelButton.snp.left).offset(-16)
                    }
                    
                    viewController.cancelButton.snp.updateConstraints { (make) -> Void in
                        make.right.equalTo(viewController.view).offset(viewController.cancelButton.intrinsicContentSize.width)
                    }
                })
            }
        }
    }
    
    func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        if let searchViewController = transitionContext.viewController(forKey: .from) as? SearchController {
            searchViewController.searchIconTextField.endEditing(true)
            
            UIView.animate(withDuration: 0.2, animations: {
                searchViewController.searchIconTextField.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(searchViewController.cancelButton.snp.left).offset(-16)
                }
                
                searchViewController.cancelButton.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(searchViewController.view).offset(searchViewController.cancelButton.intrinsicContentSize.width)
                }
                
                searchViewController.view.layoutIfNeeded()
            }, completion: { (success) in
                searchViewController.view.removeFromSuperview()
                transitionContext.completeTransition(success)
                
                searchViewController.searchIconTextField.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(searchViewController.cancelButton.snp.left).offset(-8)
                }
                
                searchViewController.cancelButton.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(searchViewController.view).offset(-16)
                }
            })
        }
    }
}
