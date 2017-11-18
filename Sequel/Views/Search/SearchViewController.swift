import Alamofire
import SnapKit
import SwiftTheme
import SwiftyJSON
import UIKit

class SearchViewController: UIViewController {

    struct Measure {
        static let searchViewOffset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 0, right: 16.0)
        static let searchViewHeight = 40 as CGFloat
        static let searchCancelButtonOffset = 8 as CGFloat
    }

    private var searchView: UIView!
    private var searchTextField: CustomTextField!
    private var searchCancelButton: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initSearchView()
    }

    func initView() {
        self.view.theme_backgroundColor = [Color.light.background]
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: .default)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }

    private func initSearchView() {
        searchView = UIView()
        initSearchCancelButton()
        initSearchTextField()
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(Measure.searchViewOffset.top)
            } else {
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                make.top.equalTo(self.view).offset(statusBarHeight + Measure.searchViewOffset.top)
            }

            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(Measure.searchViewHeight)
        }
    }

    func initSearchTextField() {
        searchTextField = CustomTextField()
        searchTextField.setPlaceholderText("Search series by name")
        searchTextField.setFont(Font.body!)
        searchTextField.setImage(UIImage(named: "search")!)
        searchTextField.setClearImage(UIImage(named: "clear")!, colors: [Color.light.blackDisabled])
        searchTextField.setBackgroundColors([Color.light.blackDivider])
        searchTextField.setTextColors([Color.light.blackPrimary])
        searchTextField.setPlaceholderColors([Color.light.blackDisabled])
        searchTextField.setCornerRadius(Measure.searchViewHeight / 2)
        searchView.addSubview(searchTextField)

        searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(searchView)
            make.bottom.equalTo(searchView)
            make.left.equalTo(searchView).offset(Measure.searchViewOffset.left)
            make.right.equalTo(searchCancelButton.snp.left).offset(-Measure.searchCancelButtonOffset)
        }
    }

    func initSearchCancelButton() {
        searchCancelButton = CustomButton()
        searchCancelButton.addTarget(self, action: #selector(searchCancelButtonTouchUpInside), for: .touchUpInside)
        searchCancelButton.setTitle("Cancel", font: Font.body!)
        searchCancelButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        searchView.addSubview(searchCancelButton)

        searchCancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchView)
            make.bottom.equalTo(searchView)
            make.right.equalTo(searchView).offset(-Measure.searchViewOffset.right)
            make.width.equalTo(searchCancelButton.intrinsicContentSize.width)
        }
    }

    func startEditingSearchTextField() {
        searchTextField.becomeFirstResponder()
    }

    func endEditingSearchTextField() {
        searchTextField.endEditing(true)
    }

    func animateSearchSwipe(completion: @escaping (_ success: Bool) -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            self.searchTextField.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.searchCancelButton.snp.left).offset(-Measure.searchViewOffset.right)
            }

            self.searchCancelButton.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.searchView).offset(self.searchCancelButton.intrinsicContentSize.width)
            }

            self.view.layoutIfNeeded()
        }, completion: { (success) in
            completion(success)
        })
    }

    func resetSearchSwipe() {
        searchTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(searchCancelButton.snp.left).offset(-Measure.searchCancelButtonOffset)
        }

        searchCancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(searchView).offset(-Measure.searchViewOffset.right)
        }
    }
}

extension SearchViewController {
    @objc private func searchCancelButtonTouchUpInside() {
        if searchTextField.hasText {
            searchTextField.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.dismiss(animated: true)
            }
        } else {
            self.dismiss(animated: true)
        }
    }
}
