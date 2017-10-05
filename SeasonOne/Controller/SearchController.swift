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
    
    var cancelButton: UIButton!
    var searchTextField: SearchTextField!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initCancelButton()
        initSearchTextField()
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
        cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            make.right.equalTo(self.view).offset(-SearchConstant.searchPadding.right)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(SearchConstant.searchHeight)
        }
    }
    
    func initSearchTextField() {
        searchTextField = SearchTextField()
        searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidBegin), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidEnd), for: .editingDidEnd)
        self.view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            make.left.equalTo(self.view).offset(SearchConstant.searchPadding.left)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchConstant.cancelButtonPadding)
            make.height.equalTo(SearchConstant.searchHeight)
        }
    }
    
    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        searchTextField.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @objc func searchTextFieldEditingDidBegin(sender: SearchTextField!) {
        sender.animateImageColor(state: .end)
    }
    
    @objc func searchTextFieldEditingDidEnd(sender: SearchTextField!) {
        sender.animateImageColor(state: .start)
    }
}
