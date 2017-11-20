import UIKit

extension CustomTextField {
    public func setPlaceholderAlignment(_ alignment: NSTextAlignment) {
        if alignment == .center {
            centerPlaceholder()
        } else {
            resetPlaceholder()
        }
    }

    private func centerPlaceholder() {
        self.layoutIfNeeded()

        let textFieldWidth = self.frame.width / 2
        let searchImageViewWidth = imageView.frame.width
        let placeholderLabelWidth = placeholderLabel.intrinsicContentSize.width
        let contentWidth = (searchImageViewWidth + leftInnerOffset + placeholderLabelWidth) / 2
        let offset = textFieldWidth - contentWidth

        imageView.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(offset)
        }
    }

    private func resetPlaceholder() {
        imageView.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(leftOffset)
        }
    }
}
