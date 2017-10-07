//
//  ViewController.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    
    let scrollIndicatorOffset: CGFloat = 8
    
    var searchView: SearchView!
    var scrollIndicatorImageView: ScrollIndicatorImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        searchView = SearchView()
        searchView.searchTextField.delegate = self
        self.view.addSubview(searchView)
        
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(searchView.height + searchView.insets.top)
        }
        
        scrollIndicatorImageView = ScrollIndicatorImageView(frame: CGRect())
        self.view.addSubview(scrollIndicatorImageView)
        
        scrollIndicatorImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchView.snp.bottom).offset(scrollIndicatorOffset)
            make.centerX.equalTo(self.view)
        }
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPanGesture))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            make.top.equalTo(searchView.snp.bottom).offset(offset * 1.5)
        }

        if (yTranslation > SearchConstant.searchTriggerPosition) {
            searchView.searchTextField.animateTextFieldHightlightEnabled()
            scrollIndicatorImageView.animateHightlightEnabled()
        } else {
            searchView.searchTextField.animateTextFieldHightlightDisabled()
            scrollIndicatorImageView.animateHightlightDisabled()
        }

        if (sender.state == UIGestureRecognizerState.ended) {
            searchView.searchTextField.animateTextFieldHightlightDisabled()
            scrollIndicatorImageView.animateHightlightDisabled()
            scrollIndicatorImageView.animateFadeOut()

            animateRubberBand(completion: { (success) in
                if (yTranslation > SearchConstant.searchTriggerPosition) {
                    self.searchView.searchTextField.becomeFirstResponder()
                }
            })
        }
    }
    
    /* Animation */
    func animateRubberBand(completion: @escaping (_ success: Bool) -> ()) {
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

