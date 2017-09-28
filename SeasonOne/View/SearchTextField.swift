//
//  SearchTextField.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit
import SnapKit

class SearchTextField: UITextField {

    private let backgroundView = UIView()
    private let placeholderLabel = UILabel()
    private let imageView = UIImageView()
    
    override func draw(_ rect: CGRect) {
        initBackground()
        initImage()
        initPlaceholder()
        initKeyboard()
        initClearButton()
        
        self.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    func initBackground() {
        backgroundView.isUserInteractionEnabled = false
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.12)
        backgroundView.layer.cornerRadius = 8.0;
        backgroundView.layer.masksToBounds = true
        self.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }
    
    func initImage() {
        if let image = UIImage(named: "search") {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.black.withAlphaComponent(0.54)
            imageView.contentMode = .center
            self.addSubview(imageView)
            
            imageView.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(self).offset(0)
                make.top.equalTo(self).offset(0)
                make.bottom.equalTo(self).offset(0)
                make.width.equalTo(32)
            }
        }
    }
    
    func initPlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textAlignment = .left
        placeholderLabel.textColor = UIColor.black.withAlphaComponent(0.38)
        placeholderLabel.font = self.font
        self.addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(imageView.snp.right).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
    
    func initKeyboard() {
        self.keyboardType = .alphabet
        self.keyboardAppearance = .light
        self.autocorrectionType = .no
        self.autocapitalizationType = .sentences
        self.returnKeyType = .search
    }
    
    func initClearButton() {
        self.clearButtonMode = .always
        
        let clearButton = self.value(forKey: "_clearButton") as! UIButton
        let clearButtonImage = UIImage(named: "clear")?.alpha(0.38)
        clearButton.setImage(clearButtonImage, for: .normal)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: 32, dy: 1)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: 32, dy: 1)
    }
    
    @objc func textFieldEditingChanged(sender: UITextField!) {
        UIView.animate(withDuration: 0.1) {
            if sender.text!.isEmpty {
                self.placeholderLabel.alpha = 1
            } else {
                self.placeholderLabel.alpha = 0
            }
        }
    }
}
