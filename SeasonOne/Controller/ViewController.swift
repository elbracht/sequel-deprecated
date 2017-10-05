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
    
    var searchView: SearchView!
    var scrollIndicatorImageView: UIImageView!
    
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
        
        scrollIndicatorImageView = UIImageView()
        scrollIndicatorImageView.image = UIImage(named: "arrow_down")?.withRenderingMode(.alwaysTemplate)
        scrollIndicatorImageView.tintColor = ColorConstant.white.withAlphaComponent(0.12)
        scrollIndicatorImageView.alpha = 0
        self.view.addSubview(scrollIndicatorImageView)
        
        scrollIndicatorImageView.snp.makeConstraints { (make) -> Void in
            let offset = SearchConstant.searchPadding.top + SearchConstant.searchHeight + SearchConstant.scrollIndicatorPadding
            make.top.equalTo(self.view).offset(offset)
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
    
    func scrollIndicatorImageViewDefault() {
        UIView.animate(withDuration: 0.1) {
            self.scrollIndicatorImageView.tintColor = ColorConstant.white.withAlphaComponent(0.12)
        }
    }
    
    func scrollIndicatorImageViewActive() {
        UIView.animate(withDuration: 0.1) {
            self.scrollIndicatorImageView.tintColor = ColorConstant.accent
        }
    }
    
    func scrollIndicatorImageViewFadeIn() {
        UIView.animate(withDuration: 0.2) {
            self.scrollIndicatorImageView.alpha = 1
        }
    }
    
    func scrollIndicatorImageViewFadeOut() {
        UIView.animate(withDuration: 0.2) {
            self.scrollIndicatorImageView.alpha = 0
        }
    }
    
    func searchRubberBand(becomeFirstResponder: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
            self.searchView.snp.updateConstraints { (make) -> Void in
                make.top.equalTo(self.view)
            }

            self.scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
                let offset = SearchConstant.searchPadding.top + SearchConstant.searchHeight + SearchConstant.scrollIndicatorPadding
                make.top.equalTo(self.view).offset(offset)
            }

            self.view.layoutIfNeeded()
        }, completion: { (success) in
            if (becomeFirstResponder) {
                self.searchView.searchTextField.becomeFirstResponder()
            }
        })
    }

    @objc func detectPanGesture(sender: UIPanGestureRecognizer) {
        let scrollSpeedSlow: CGFloat = 10
        let scrollSpeedFast: CGFloat = 6
        let yTranslation = sender.translation(in: self.view).y

        scrollIndicatorImageViewFadeIn()

        searchView.snp.updateConstraints { (make) -> Void in
            let offset = yTranslation / scrollSpeedSlow
            make.top.equalTo(self.view).offset(offset)
        }

        scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
            let offset = SearchConstant.searchPadding.top + SearchConstant.searchHeight + SearchConstant.scrollIndicatorPadding + (yTranslation / scrollSpeedFast)
            make.top.equalTo(self.view).offset(offset)
        }

        if (yTranslation > SearchConstant.searchTriggerPosition) {
            searchView.searchTextField.animateTextFieldHightlight(.enabled)
            scrollIndicatorImageViewActive()
        } else {
            searchView.searchTextField.animateTextFieldHightlight(.disabled)
            scrollIndicatorImageViewDefault()
        }

        if (sender.state == UIGestureRecognizerState.ended) {
            searchView.searchTextField.animateTextFieldHightlight(.disabled)
            scrollIndicatorImageViewDefault()
            scrollIndicatorImageViewFadeOut()

            if (yTranslation > SearchConstant.searchTriggerPosition) {
                searchRubberBand(becomeFirstResponder: true)
            } else {
                searchRubberBand(becomeFirstResponder: false)
            }

        }
    }
}

