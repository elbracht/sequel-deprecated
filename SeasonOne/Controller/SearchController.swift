//
//  SearchController.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit
import SnapKit

class SearchController: UIViewController {

    let searchTextField = SearchTextField()
    let cancelButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            self.searchTextField.becomeFirstResponder()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initSearchBar() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = UIColor(hue: 1.00, saturation: 0.61, brightness: 0.88, alpha: 1.00)
        cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(50)
            make.right.equalTo(self.view).offset(cancelButton.intrinsicContentSize.width)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(36)
        }
        
        searchTextField.placeholder = "Search"
        searchTextField.tintColor = UIColor(hue: 1.00, saturation: 0.61, brightness: 0.88, alpha: 1.00)
        searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidBegin), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidEnd), for: .editingDidEnd)
        self.view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(50)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(cancelButton.snp.left).offset(-16)
            make.height.equalTo(36)
        }
    }
    
    @objc func searchTextFieldEditingDidBegin(sender: UITextField!) {
        UIView.animate(withDuration: 0.2) {
            self.searchTextField.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.cancelButton.snp.left).offset(-8)
            }
            
            self.cancelButton.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.view).offset(-16)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func searchTextFieldEditingDidEnd(sender: UITextField!) {
        UIView.animate(withDuration: 0.2) {
            self.searchTextField.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.cancelButton.snp.left).offset(-16)
            }
            
            self.cancelButton.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.view).offset(self.cancelButton.intrinsicContentSize.width)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        searchTextField.endEditing(false)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
            self.dismiss(animated: false)
        })
    }
}
