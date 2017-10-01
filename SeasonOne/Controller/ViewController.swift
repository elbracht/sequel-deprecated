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
    
    let searchIconTextField = IconTextField(frame: CGRect())
    let cancelButton = UIButton(type: .system)
    let scrollIndicatorImageView = UIImageView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initCancelButton()
        initSearchIconTextField()
        initScrollIndicatorImageView()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPanGesture))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // init(coder:) has not been implemented
        return nil
    }
    
    func initCancelButton() {
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
    
    func initSearchIconTextField() {
        searchIconTextField.textColor = ColorConstant.white
        searchIconTextField.tintColor = ColorConstant.accent
        searchIconTextField.font = FontConstant.body
        searchIconTextField.placeholder = "Search"
        searchIconTextField.icon = UIImage(named: "search")
        searchIconTextField.cornerRadius = SearchConstant.searchHeight / 2
        searchIconTextField.delegate = self
        self.view.addSubview(searchIconTextField)
        
        searchIconTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            make.left.equalTo(self.view).offset(SearchConstant.searchPadding.left)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchConstant.searchPadding.right)
            make.height.equalTo(SearchConstant.searchHeight)
        }
    }
    
    func initScrollIndicatorImageView() {
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
    
    func searchIconTextFieldDefault() {
        UIView.animate(withDuration: 0.1) {
            self.searchIconTextField.backgroundColor = ColorConstant.white.withAlphaComponent(0.12)
            self.searchIconTextField.iconColor = ColorConstant.white.withAlphaComponent(0.54)
            self.searchIconTextField.placeholderColor = ColorConstant.white.withAlphaComponent(0.54)
        }
    }
    
    func searchIconTextFieldActive() {
        UIView.animate(withDuration: 0.1) {
            self.searchIconTextField.backgroundColor = ColorConstant.accent
            self.searchIconTextField.iconColor = ColorConstant.white
            self.searchIconTextField.placeholderColor = ColorConstant.white
        }
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
            self.searchIconTextField.snp.updateConstraints { (make) -> Void in
                make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            }
            
            self.scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
                let offset = SearchConstant.searchPadding.top + SearchConstant.searchHeight + SearchConstant.scrollIndicatorPadding
                make.top.equalTo(self.view).offset(offset)
            }
            
            self.view.layoutIfNeeded()
        }, completion: { (success) in
            if (becomeFirstResponder) {
                self.searchIconTextField.becomeFirstResponder()
            }
        })
    }
    
    @objc func detectPanGesture(sender: UIPanGestureRecognizer) {
        let scrollSpeedSlow: CGFloat = 10
        let scrollSpeedFast: CGFloat = 6
        let yTranslation = sender.translation(in: self.view).y
        
        scrollIndicatorImageViewFadeIn()
        
        searchIconTextField.snp.updateConstraints { (make) -> Void in
            let offset = SearchConstant.searchPadding.top + (yTranslation / scrollSpeedSlow)
            make.top.equalTo(self.view).offset(offset)
        }
        
        scrollIndicatorImageView.snp.updateConstraints { (make) -> Void in
            let offset = SearchConstant.searchPadding.top + SearchConstant.searchHeight + SearchConstant.scrollIndicatorPadding + (yTranslation / scrollSpeedFast)
            make.top.equalTo(self.view).offset(offset)
        }
        
        if (yTranslation > SearchConstant.searchTriggerPosition) {
            searchIconTextFieldActive()
            scrollIndicatorImageViewActive()
        } else {
            searchIconTextFieldDefault()
            scrollIndicatorImageViewDefault()
        }
        
        if (sender.state == UIGestureRecognizerState.ended) {
            searchIconTextFieldDefault()
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

