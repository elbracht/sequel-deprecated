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
    
    let searchIconTextField = IconTextField(icon: UIImage(named: "search")!)
    let cancelButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
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
            make.top.equalTo(self.view).offset(SearchConstants.padding.top)
            make.right.equalTo(self.view).offset(-SearchConstants.padding.right)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(SearchConstants.height)
        }
        
        searchIconTextField.placeholder = "Search"
        searchIconTextField.tintColor = UIColor(hue: 1.00, saturation: 0.61, brightness: 0.88, alpha: 1.00)
        searchIconTextField.clearButtonImage = UIImage(named: "clear")?.alpha(0.38)
        searchIconTextField.keyboardType = .alphabet
        searchIconTextField.keyboardAppearance = .light
        searchIconTextField.autocorrectionType = .no
        searchIconTextField.autocapitalizationType = .sentences
        searchIconTextField.returnKeyType = .search
        self.view.addSubview(searchIconTextField)
        
        searchIconTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(SearchConstants.padding.top)
            make.left.equalTo(self.view).offset(SearchConstants.padding.left)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchConstants.buttonPadding)
            make.height.equalTo(SearchConstants.height)
        }
    }
    
    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        searchIconTextField.endEditing(true)
        self.dismiss(animated: true)
    }
}
