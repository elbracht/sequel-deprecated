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
        cancelButton.titleLabel?.font = Fonts.body
        cancelButton.tintColor = Colors.accent
        cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstants.searchPadding.top)
            make.right.equalTo(self.view).offset(-SearchConstants.searchPadding.right)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(SearchConstants.searchHeight)
        }
        
        searchIconTextField.placeholder = "Search"
        searchIconTextField.font = Fonts.body
        searchIconTextField.icon = UIImage(named: "search")
        searchIconTextField.tintColor = Colors.accent
        searchIconTextField.clearButtonImage = UIImage(named: "clear")?.alpha(0.38)
        searchIconTextField.cornerRadius = SearchConstants.searchHeight / 2
        searchIconTextField.keyboardType = .alphabet
        searchIconTextField.keyboardAppearance = .light
        searchIconTextField.autocorrectionType = .no
        searchIconTextField.autocapitalizationType = .sentences
        searchIconTextField.returnKeyType = .search
        self.view.addSubview(searchIconTextField)
        
        searchIconTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstants.searchPadding.top)
            make.left.equalTo(self.view).offset(SearchConstants.searchPadding.left)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchConstants.cancelButtonPadding)
            make.height.equalTo(SearchConstants.searchHeight)
        }
    }
    
    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        searchIconTextField.endEditing(true)
        self.dismiss(animated: true)
    }
}
