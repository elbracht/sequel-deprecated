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
    
    public var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) {
        didSet {
            updatePlaceholder()
        }
    }
    
    override var font: UIFont? {
        didSet {
            updatePlaceholder()
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            updateBackground()
        }
    }
    
    override var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    public var placeholderColor: UIColor = UIColor.black.withAlphaComponent(0.54) {
        didSet {
            updatePlaceholder()
        }
    }
    
    public var icon: UIImage? {
        didSet {
            updateIcon()
            updatePlaceholder()
        }
    }
    
    public var iconPadding: CGFloat = 8 {
        didSet {
            updateIcon()
            updatePlaceholder()
        }
    }

    public var iconColor: UIColor = UIColor.black.withAlphaComponent(0.54) {
        didSet {
            updateIcon()
        }
    }
    
    public var clearButtonImage: UIImage? {
        didSet {
            updateClearButton()
        }
    }
    
    public var clearButtonPadding: CGFloat = 8 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.12)
        self.clearButtonMode = .always
        self.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // init(coder:) has not been implemented
        return nil
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    func updateBackground() {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = true
    }
    
    func updateIcon() {
        if let icon = icon {
            iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = iconColor
            iconImageView.contentMode = .center
            self.addSubview(iconImageView)
            
            iconImageView.snp.updateConstraints { (make) -> Void in
                make.left.equalTo(self).offset(padding.left)
                make.top.equalTo(self).offset(padding.top)
                make.bottom.equalTo(self).offset(padding.bottom)
                make.width.equalTo(icon.size.width)
            }
        }
    }
    
    func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = font
        self.addSubview(placeholderLabel)
        
        placeholderLabel.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(self).offset(padding.top)
            make.left.equalTo(self).offset(getPaddingLeft())
            make.bottom.equalTo(self).offset(padding.bottom)
            make.right.equalTo(self).offset(getPaddingRight())
        }
    }
    
    func updateClearButton() {
        let clearButton = self.value(forKey: "_clearButton") as! UIButton
        clearButton.setImage(clearButtonImage, for: .normal)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, getPaddingForRect())
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, getPaddingForRect())
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let image = (clearButtonImage != nil) ? clearButtonImage : UIImage(named: "clear")
        let paddingRight = (bounds.width / 2) - (image!.size.width / 2) - padding.right
        return bounds.offsetBy(dx: paddingRight, dy: 0)
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
    
    func getPaddingForRect() -> UIEdgeInsets {
        return UIEdgeInsets(top: self.padding.top + 1, left: getPaddingLeft(), bottom: self.padding.bottom, right: getPaddingRight())
    }
    
    func getPaddingLeft() -> CGFloat {
        if let icon = icon {
            return icon.size.width + iconPadding + padding.left
        }
        
        return padding.left
    }
    
    func getPaddingRight() -> CGFloat {
        if (self.clearButtonMode != .never) {
            let image = (clearButtonImage != nil) ? clearButtonImage : UIImage(named: "clear")
            return (image!.size.width / 2) + clearButtonPadding + padding.right
        }
        
        return padding.right
    }
}
