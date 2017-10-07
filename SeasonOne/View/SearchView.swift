import UIKit

class SearchView: UIView {
    var cancelButton: UIButton!
    var searchTextField: SearchTextField!
    
    let height: CGFloat = 36
    let insets = UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16)
    let insetsInner: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initCancelButton()
        initSearchTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /* Init */
    func initSearchTextField() {
        searchTextField = SearchTextField()
        self.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(insets.top)
            make.left.equalTo(self).offset(insets.left)
            make.right.equalTo(cancelButton.snp.left).offset(-insets.right)
            make.height.equalTo(height)
        }
    }
    
    func initCancelButton() {
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = FontConstant.body
        cancelButton.tintColor = ColorConstant.accent
        self.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(insets.top)
            make.right.equalTo(self).offset(cancelButton.intrinsicContentSize.width)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(height)
        }
    }
    
    /* Animation */
    func swipeLeft() {
        searchTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(cancelButton.snp.left).offset(-insetsInner)
        }
        
        cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-insets.right)
        }
        
        self.layoutIfNeeded()
    }
    
    func swipeRight() {
        searchTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(cancelButton.snp.left).offset(-insets.right)
        }
        
        cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(self).offset(cancelButton.intrinsicContentSize.width)
        }
        
        self.layoutIfNeeded()
    }
    
    func animateSwipeLeft(completion: @escaping (_ success: Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.swipeLeft()
        }, completion: { (success) in
            completion(success)
        })
    }
    
    func animateSwipeRight(completion: @escaping (_ success: Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.swipeRight()
        }, completion: { (success) in
            completion(success)
        })
    }
}
