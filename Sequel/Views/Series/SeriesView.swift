import SnapKit
import SwiftTheme
import UIKit

class SeriesView: UIView {
    public var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        self.theme_backgroundColor = [Color.light.background]
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: .default)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }

    private func initImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(320)
        }
    }
}
