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
    
    var cancelButton: UIButton!
    var searchTextField: SearchTextField!
    var scrollIndicatorImageView: UIImageView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initCancelButton()
        initSearchTextField()
        initScrollIndicatorImageView()

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPanGesture))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // init(coder:) has not been implemented
        return nil
    }
    
    func initCancelButton() {
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = FontConstant.body
        cancelButton.tintColor = ColorConstant.accent
        self.view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            make.right.equalTo(self.view).offset(cancelButton.intrinsicContentSize.width)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(SearchConstant.searchHeight)
        }
    }
    
    func initSearchTextField() {
        searchTextField = SearchTextField()
        searchTextField.delegate = self
        self.view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            make.left.equalTo(self.view).offset(SearchConstant.searchPadding.left)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchConstant.searchPadding.right)
            make.height.equalTo(SearchConstant.searchHeight)
        }
    }
    
    func initScrollIndicatorImageView() {
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
            self.searchTextField.snp.updateConstraints { (make) -> Void in
                make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            }
            
            self.scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
                let offset = SearchConstant.searchPadding.top + SearchConstant.searchHeight + SearchConstant.scrollIndicatorPadding
                make.top.equalTo(self.view).offset(offset)
            }
            
            self.view.layoutIfNeeded()
        }, completion: { (success) in
            if (becomeFirstResponder) {
                self.searchTextField.becomeFirstResponder()
            }
        })
    }
    
    @objc func detectPanGesture(sender: UIPanGestureRecognizer) {
        let scrollSpeedSlow: CGFloat = 10
        let scrollSpeedFast: CGFloat = 6
        let yTranslation = sender.translation(in: self.view).y
        
        scrollIndicatorImageViewFadeIn()
        
        searchTextField.snp.updateConstraints { (make) -> Void in
            let offset = SearchConstant.searchPadding.top + (yTranslation / scrollSpeedSlow)
            make.top.equalTo(self.view).offset(offset)
        }
        
        scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
            let offset = SearchConstant.searchPadding.top + SearchConstant.searchHeight + SearchConstant.scrollIndicatorPadding + (yTranslation / scrollSpeedFast)
            make.top.equalTo(self.view).offset(offset)
        }
        
        if (yTranslation > SearchConstant.searchTriggerPosition) {
            searchTextField.animateHightlight(state: .end)
            scrollIndicatorImageViewActive()
        } else {
            searchTextField.animateHightlight(state: .start)
            scrollIndicatorImageViewDefault()
        }
        
        if (sender.state == UIGestureRecognizerState.ended) {
            searchTextField.animateHightlight(state: .start)
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

