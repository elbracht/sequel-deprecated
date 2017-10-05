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
        
        if let toController = transitionContext.viewController(forKey: .to) as? SearchController {
            if let fromController = transitionContext.viewController(forKey: .from) as? ViewController {
                containerView.addSubview(toController.view)
                
                toController.view.alpha = 0
                toController.searchView.searchTextField.becomeFirstResponder()
                toController.searchView.swipeLeft()
                
                fromController.searchView.animateSwipe(.left, completion: { (success) in
                    transitionContext.completeTransition(success)
                    
                    toController.view.alpha = 1
                    fromController.searchView.swipeRight()
                })
            }
        }
    }
    
    func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        if let fromController = transitionContext.viewController(forKey: .from) as? SearchController {
            fromController.searchView.searchTextField.endEditing(true)
            
            fromController.searchView.animateSwipe(.right, completion: { (success) in
                transitionContext.completeTransition(success)
                
                fromController.view.removeFromSuperview()
                fromController.searchView.swipeLeft()
            })
        }
    }
}
