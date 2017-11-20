import DeckTransition
import SnapKit
import SwiftTheme

class MainViewController: UIViewController {
    public var mainView: MainView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView = MainView()
        mainView.searchInputView.textField.delegate = self
        mainView.settingsButton.addTarget(self, action: #selector(settingsButtonTouchUpInside), for: .touchUpInside)
        self.view.addSubview(mainView)

        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        mainView.searchInputView.textField.setPlaceholderAlignment(.center)
    }
}

/**
SearchTextField event present SearchViewController
*/
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.accessibilityIdentifier == "SearchTextField" {
            let searchViewController = SearchViewController(nibName: nil, bundle: nil)
            searchViewController.transitioningDelegate = self
            present(searchViewController, animated: true)
            return false
        }

        return true
    }
}

/**
SettingsButton event to present SettingsViewController
*/
extension MainViewController {
    @objc func settingsButtonTouchUpInside() {
        let settingsNavigationController = SettingsNavigationController()
        let deckTransitionDelegate = DeckTransitioningDelegate()
        settingsNavigationController.dismissDelegate = self
        settingsNavigationController.transitioningDelegate = deckTransitionDelegate
        settingsNavigationController.modalPresentationStyle = .custom
        present(settingsNavigationController, animated: true, completion: nil)
    }
}

/**
Present and dismiss SearchViewController
*/
extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MainToSearchTransition(transitionMode: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MainToSearchTransition(transitionMode: .dismiss)
    }
}

/**
Dismiss SettingsViewController
*/
extension MainViewController: SettingsNavigationControllerDelegate {
    func settingsNavigationControllerDismiss() {
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: .default)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }
}
