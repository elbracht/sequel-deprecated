//
//  ViewController.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let searchTextField = SearchTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initSearchBar() {
        searchTextField.placeholder = "Search"
        searchTextField.tintColor = UIColor(hue: 1.00, saturation: 0.61, brightness: 0.88, alpha: 1.00)
        searchTextField.delegate = self
        self.view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(50)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(self.view).offset(-16)
            make.height.equalTo(36)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        present(SearchController(), animated: false)
        return false
    }
}

