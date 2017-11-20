import SnapKit
import SwiftTheme
import UIKit

struct SearchInputViewMeasure {
    static let offsetLeft = 16 as CGFloat
    static let offsetRight = 16 as CGFloat
    static let height = 40 as CGFloat
    static let cancelButtonOffset = 8 as CGFloat
}

class SearchInputView: UIView {
    public var textField: CustomTextField!
    public var cancelButton: CustomButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initSearchCancelButton()
        initSearchTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initSearchTextField() {
        textField = CustomTextField()
        textField.accessibilityIdentifier = "SearchTextField"
        textField.setPlaceholderText("Search series by name")
        textField.setFont(Font.body!)
        textField.setImage(UIImage(named: "search")!)
        textField.setClearImage(UIImage(named: "clear")!, colors: [Color.light.blackDisabled])
        textField.setBackgroundColors([Color.light.blackDivider])
        textField.setTextColors([Color.light.blackPrimary])
        textField.setPlaceholderColors([Color.light.blackDisabled])
        textField.setCornerRadius(SearchInputViewMeasure.height / 2)

        textField.theme_keyboardAppearance = [.light]
        textField.keyboardType = .alphabet
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.returnKeyType = .search

        self.addSubview(textField)

        textField.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(SearchInputViewMeasure.offsetLeft)
            make.right.equalTo(cancelButton.snp.left).offset(-SearchInputViewMeasure.offsetRight)
        }
    }

    private func initSearchCancelButton() {
        cancelButton = CustomButton()
        cancelButton.accessibilityIdentifier = "SearchCancelButton"
        cancelButton.setTitle("Cancel", font: Font.body!)
        cancelButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        self.addSubview(cancelButton)

        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self).offset(cancelButton.intrinsicContentSize.width)
            make.width.equalTo(cancelButton.intrinsicContentSize.width)
        }
    }

    public func showCancelButton() {
        textField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(cancelButton.snp.left).offset(-SearchInputViewMeasure.cancelButtonOffset)
        }

        cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-SearchInputViewMeasure.offsetRight)
        }

        self.layoutIfNeeded()
    }

    public func hideCancelButton() {
        textField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(cancelButton.snp.left).offset(-SearchInputViewMeasure.offsetRight)
        }

        cancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(self).offset(cancelButton.intrinsicContentSize.width)
        }

        self.layoutIfNeeded()
    }
}
