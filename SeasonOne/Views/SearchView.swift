import UIKit

class SearchView: UIView {

    struct Measure {
        static let height = 36 as CGFloat
        static let offset = UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16)
        static let cancelButtonOffset = 8 as CGFloat
    }

    var cancelButton: UIButton!
    var searchTextField: SearchTextField!

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
            make.top.equalTo(self).offset(Measure.offset.top)
            make.left.equalTo(self).offset(Measure.offset.left)
            make.right.equalTo(cancelButton.snp.left).offset(-Measure.offset.right)
            make.height.equalTo(Measure.height)
        }
    }

    func initCancelButton() {
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = Font.body
        cancelButton.tintColor = Color.accent
        self.addSubview(cancelButton)

        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(Measure.offset.top)
            make.right.equalTo(self).offset(cancelButton.intrinsicContentSize.width)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
            make.height.equalTo(Measure.height)
        }
    }

    /* Animation */
    func swipeLeft() {
        searchTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(cancelButton.snp.left).offset(-Measure.cancelButtonOffset)
        }

        cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-Measure.offset.right)
        }

        self.layoutIfNeeded()
    }

    func swipeRight() {
        searchTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(cancelButton.snp.left).offset(-Measure.offset.right)
        }

        cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(self).offset(cancelButton.intrinsicContentSize.width)
        }

        self.layoutIfNeeded()
    }

    func animateSwipeLeft(completion: @escaping (_ success: Bool) -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            self.swipeLeft()
        }, completion: { (success) in
            completion(success)
        })
    }

    func animateSwipeRight(completion: @escaping (_ success: Bool) -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            self.swipeRight()
        }, completion: { (success) in
            completion(success)
        })
    }
}
