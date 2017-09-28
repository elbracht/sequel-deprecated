//
//  ViewController.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchControllerButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initSearchControllerButton() {
        let searchControllerButton = UIButton(type: .system)
        searchControllerButton.frame = CGRect(x: 16, y: 50, width: 120, height: 50)
        searchControllerButton.setTitle("SearchController", for: .normal)
        searchControllerButton.addTarget(self, action: #selector(searchControllerButtonTouchUpInside), for: .touchUpInside)
        
        self.view.addSubview(searchControllerButton)
    }
    
    @objc func searchControllerButtonTouchUpInside(sender: UIButton!) {
        self.navigationController!.pushViewController(SearchController(), animated: false)
    }
}

