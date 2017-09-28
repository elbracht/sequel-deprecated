//
//  SearchTextField.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    private let backgroundLayer = CALayer()
    private let placeholderLabel = UILabel()
    private let imageView = UIImageView()
    
    override func draw(_ rect: CGRect) {
        initBackground()
        initPlaceholder()
        initImage()
        initKeyboard()
        initClearButton()
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    func initBackground() {
        backgroundLayer.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
        backgroundLayer.backgroundColor = UIColor.black.withAlphaComponent(0.12).cgColor
        backgroundLayer.cornerRadius = 8.0;
        backgroundLayer.masksToBounds = true
        self.layer.addSublayer(backgroundLayer)
    }
    
    func initPlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textAlignment = .left
        placeholderLabel.textColor = UIColor.black.withAlphaComponent(0.38)
        placeholderLabel.font = self.font
        placeholderLabel.frame = bounds.offsetBy(dx: 32, dy: 0)
        
        self.addSubview(placeholderLabel)
    }
    
    func initImage() {
        if let image = UIImage(named: "search") {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.black.withAlphaComponent(0.54)
            imageView.contentMode = .center
            imageView.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: 32, height: bounds.size.height)
            
            self.addSubview(imageView)
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
    
    func animatePlaceholder() {
        UIView.animate(withDuration: 0.1, animations: {
//            if self.text!.isEmpty {
//                self.placeholderLabel.alpha = 1
//            } else {
//                self.placeholderLabel.alpha = 0
//            }
        })
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: 32, dy: 1)
    }
    
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc func textFieldDidChange() {
        animatePlaceholder()
    }
}
