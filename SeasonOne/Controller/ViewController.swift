//
//  ViewController.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    
    let searchIconTextField = IconTextField(icon: UIImage(named: "search")!)
    let cancelButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPanGesture))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initSearchBar() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = UIColor(hue: 1.00, saturation: 0.61, brightness: 0.88, alpha: 1.00)
        self.view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstants.padding.top)
            make.right.equalTo(self.view).offset(cancelButton.intrinsicContentSize.width)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(SearchConstants.height)
        }
        
        searchIconTextField.placeholder = "Search"
        searchIconTextField.tintColor = UIColor(hue: 1.00, saturation: 0.61, brightness: 0.88, alpha: 1.00)
        searchIconTextField.delegate = self
        self.view.addSubview(searchIconTextField)
        
        searchIconTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstants.padding.top)
            make.left.equalTo(self.view).offset(SearchConstants.padding.left)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchConstants.padding.right)
            make.height.equalTo(SearchConstants.height)
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
            self.searchIconTextField.backgroundColor = UIColor.black.withAlphaComponent(0.12)
            self.searchIconTextField.iconColor = UIColor.black.withAlphaComponent(0.54)
            self.searchIconTextField.placeholderColor = UIColor.black.withAlphaComponent(0.38)
        }
    }
    
    func searchIconTextFieldActive() {
        UIView.animate(withDuration: 0.1) {
            self.searchIconTextField.backgroundColor = UIColor(hue: 1.00, saturation: 0.61, brightness: 0.88, alpha: 1.00)
            self.searchIconTextField.iconColor = UIColor.white
            self.searchIconTextField.placeholderColor = UIColor.white
        }
    }
    
    func searchIconTextFieldRubberBand(becomeFirstResponder: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
            self.searchIconTextField.snp.updateConstraints { (make) -> Void in
                make.top.equalTo(self.view).offset(SearchConstants.padding.top)
            }
            self.view.layoutIfNeeded()
        }, completion: { (success) in
            if (becomeFirstResponder) {
                self.searchIconTextField.becomeFirstResponder()
            }
        })
    }
    
    @objc func detectPanGesture(sender: UIPanGestureRecognizer) {
        let yTranslation = sender.translation(in: self.view).y
        
        searchIconTextField.snp.updateConstraints { (make) -> Void in
            let offset = SearchConstants.padding.top + (yTranslation / 10)
            make.top.equalTo(self.view).offset(offset)
        }
        
        if (yTranslation > SearchConstants.triggerPosition) {
            searchIconTextFieldActive()
        } else {
            searchIconTextFieldDefault()
        }
        
        if (sender.state == UIGestureRecognizerState.ended) {
            searchIconTextFieldDefault()
            if (yTranslation > SearchConstants.triggerPosition) {
                searchIconTextFieldRubberBand(becomeFirstResponder: true)
            } else {
                searchIconTextFieldRubberBand(becomeFirstResponder: false)
            }
            
        }
    }
}

