import DeckTransition
import SnapKit
import SwiftTheme
import UIKit

class MainViewController: UIViewController {

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

    private func initView() {
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
        searchTextField.delegate = self
        searchTextField.accessibilityIdentifier = "SearchTextField"
        searchTextField.setPlaceholderText("Search series by name")
        searchTextField.setFont(Font.body!)
        searchTextField.setImage(UIImage(named: "search")!)
        searchTextField.setBackgroundColors([Color.light.blackDivider])
        searchTextField.setPlaceholderColors([Color.light.blackDisabled])
        searchTextField.setCornerRadius(Measure.searchViewHeight / 2)
        searchView.addSubview(searchTextField)

        searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(searchView)
            make.bottom.equalTo(searchView)
            make.left.equalTo(searchView).offset(Measure.searchViewOffset.left)
            make.right.equalTo(searchCancelButton.snp.left).offset(-Measure.searchViewOffset.right)
        }
    }

    func initSearchCancelButton() {
        searchCancelButton = CustomButton()
        searchCancelButton.setTitle("Cancel", font: Font.body!)
        searchCancelButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        searchView.addSubview(searchCancelButton)

        searchCancelButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchView)
            make.bottom.equalTo(searchView)
            make.right.equalTo(searchView).offset(searchCancelButton.intrinsicContentSize.width)
            make.width.equalTo(searchCancelButton.intrinsicContentSize.width)
        }
    }

    func animateSearchSwipe(completion: @escaping (_ success: Bool) -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            self.searchTextField.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.searchCancelButton.snp.left).offset(-Measure.searchCancelButtonOffset)
            }

            self.searchCancelButton.snp.updateConstraints { (make) -> Void in
                make.right.equalTo(self.searchView).offset(-Measure.searchViewOffset.right)
            }

            self.view.layoutIfNeeded()
        }, completion: { (success) in
            completion(success)
        })
    }

    func resetSearchSwipe() {
        searchTextField.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(searchCancelButton.snp.left).offset(-Measure.searchViewOffset.right)
        }

        searchCancelButton.snp.updateConstraints { (make) -> Void in
            make.right.equalTo(searchView).offset(searchCancelButton.intrinsicContentSize.width)
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.accessibilityIdentifier == "SearchTextField" {
            let searchViewController = SearchViewController()
            searchViewController.transitioningDelegate = self
            present(searchViewController, animated: true)
            return false
        }

        return true
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MainToSearchTransition(transitionMode: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MainToSearchTransition(transitionMode: .dismiss)
    }
}

extension MainViewController: SettingsNavigationControllerDelegate {
    func settingsNavigationControllerDismiss() {
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: .default)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }
}
