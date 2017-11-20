import SnapKit
import SwiftTheme
import UIKit

struct MainViewMeasure {
    static let settingsButtonHeight = 40 as CGFloat
    static let settingsButtonOffset = 8 as CGFloat
}

class MainView: UIView {
    public var searchHeaderView: UIVisualEffectView!
    public var searchInputView: SearchInputView!
    public var settingsButton: CustomButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initSearchHeader()
        initSearchInputView()
        initSettingsButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        self.theme_backgroundColor = [Color.light.background]
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: .default)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }

    private func initSearchHeader() {
        searchHeaderView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        self.addSubview(searchHeaderView)

        searchHeaderView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(UIApplication.shared.statusBarFrame.height + SearchViewMeasure.searchHeaderHeight)
        }
    }

    private func initSearchInputView() {
        searchInputView = SearchInputView()
        searchInputView.hideCancelButton()
        self.addSubview(searchInputView)

        searchInputView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(UIApplication.shared.statusBarFrame.height + SearchViewMeasure.searchInputOffsetTop)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(SearchInputViewMeasure.height)
        }
    }

    func initSettingsButton() {
        settingsButton = CustomButton()
        settingsButton.setTitle("Settigns", font: Font.body!)
        settingsButton.setImage("settings")
        settingsButton.setColors(colors: [Color.light.blackSecondary], highlightColors: [Color.light.blackPrimary])
        self.addSubview(settingsButton)

        settingsButton.snp.makeConstraints { (make) in
            make.top.equalTo(searchHeaderView.snp.bottom).offset(MainViewMeasure.settingsButtonOffset)
            make.centerX.equalTo(self)
            make.height.equalTo(MainViewMeasure.settingsButtonHeight)
        }
    }
}
