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
    var searchIconTextField: IconTextField!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initCancelButton()
        initSearchIconTextField()
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
    
    func initSearchIconTextField() {
        searchIconTextField = IconTextField(frame: CGRect())
        searchIconTextField.textColor = ColorConstant.white
        searchIconTextField.tintColor = ColorConstant.accent
        searchIconTextField.iconColor = ColorConstant.white
        searchIconTextField.font = FontConstant.body
        searchIconTextField.placeholder = "Search"
        searchIconTextField.icon = UIImage(named: "search")
        searchIconTextField.clearButtonImage = UIImage(named: "clear")
        searchIconTextField.cornerRadius = SearchConstant.searchHeight / 2
        searchIconTextField.keyboardType = .alphabet
        searchIconTextField.keyboardAppearance = .dark
        searchIconTextField.autocorrectionType = .no
        searchIconTextField.autocapitalizationType = .sentences
        searchIconTextField.returnKeyType = .search
        self.view.addSubview(searchIconTextField)
        
        searchIconTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstant.searchPadding.top)
            make.left.equalTo(self.view).offset(SearchConstant.searchPadding.left)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchConstant.cancelButtonPadding)
            make.height.equalTo(SearchConstant.searchHeight)
        }
    }
    
    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        searchIconTextField.endEditing(true)
        self.dismiss(animated: true)
    }
}
