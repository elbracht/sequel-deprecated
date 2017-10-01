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
    
    let searchIconTextField = IconTextField(frame: CGRect())
    let cancelButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
    }
    
    func initSearchBar() {
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
        
        searchIconTextField.placeholder = "Search"
        searchIconTextField.font = FontConstant.body
        searchIconTextField.icon = UIImage(named: "search")
        searchIconTextField.tintColor = ColorConstant.accent
        searchIconTextField.clearButtonImage = UIImage(named: "clear")?.alpha(0.38)
        searchIconTextField.cornerRadius = SearchConstant.searchHeight / 2
        searchIconTextField.keyboardType = .alphabet
        searchIconTextField.keyboardAppearance = .light
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
