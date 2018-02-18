import SnapKit
import SwiftTheme
import UIKit

struct SearchViewMeasure {
    static let searchHeaderHeight = 64 as CGFloat
    static let searchInputOffsetTop = 12 as CGFloat
    static let searchCollectionViewOffset = UIEdgeInsets(top: 76.0, left: 16.0, bottom: 16.0, right: 16.0)
    static let searchItemOffset = 12 as CGFloat
    static let searchItemPerRow = 2 as CGFloat
    static let searchItemRatioWidth = 2 as CGFloat
    static let searchItemRatioHeight = 3 as CGFloat
}

class SearchView: UIView {
    public var searchHeaderView: UIVisualEffectView!
    public var searchInputView: SearchInputView!
    public var searchCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initSearchCollectionView()
        initSearchHeader()
        initSearchInputView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        self.theme_backgroundColor = [Color.Background.light.hexString(true)]
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
        searchInputView.showCancelButton()
        self.addSubview(searchInputView)

        searchInputView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(UIApplication.shared.statusBarFrame.height + SearchViewMeasure.searchInputOffsetTop)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(SearchInputViewMeasure.height)
        }
    }

    private func initSearchCollectionView() {
        searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        searchCollectionView.contentInset = SearchViewMeasure.searchCollectionViewOffset
        searchCollectionView.scrollIndicatorInsets.top = SearchViewMeasure.searchCollectionViewOffset.top
        searchCollectionView.scrollIndicatorInsets.bottom = SearchViewMeasure.searchCollectionViewOffset.bottom
        searchCollectionView.backgroundColor = UIColor.clear
        searchCollectionView.keyboardDismissMode = .onDrag
        self.addSubview(searchCollectionView)

        searchCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
        }
    }
}
