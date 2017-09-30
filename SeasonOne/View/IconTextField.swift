//
//  SearchTextField.swift
//  SeasonOne
//
//  Created by Alexander Elbracht on 28.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import UIKit
import SnapKit

class IconTextField: UITextField {
    
    private let iconImageView = UIImageView()
    private let placeholderLabel = UILabel()
    
    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    public var iconColor: UIColor? {
        didSet {
            iconImageView.tintColor = iconColor
        }
    }
    
    override var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    public var placeholderColor: UIColor? {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    public var clearButtonImage: UIImage? {
        didSet {
            let clearButton = self.value(forKey: "_clearButton") as! UIButton
            clearButton.setImage(clearButtonImage, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBackground()
        initIcon()
        initPlaceholder()
        initClearButton()
        
        self.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // init(coder:) has not been implemented
        return nil
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    func initBackground() {
        self.layer.backgroundColor = UIColor.black.withAlphaComponent(0.12).cgColor
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = true
    }
    
    func initIcon() {
        iconImageView.tintColor = UIColor.black.withAlphaComponent(0.54)
        iconImageView.contentMode = .center
        self.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(32)
        }
    }
    
    func initPlaceholder() {
        placeholderLabel.textColor = UIColor.black.withAlphaComponent(0.38)
        placeholderLabel.textAlignment = .left
        placeholderLabel.font = self.font
        self.addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageView.snp.right).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
    
    func initClearButton() {
        self.clearButtonMode = .always
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 24)
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 24)
        return UIEdgeInsetsInsetRect(bounds, padding)
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
