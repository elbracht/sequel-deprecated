import SwiftTheme
import UIKit

protocol SettingsNavigationControllerDelegate: class {
    func settingsNavigationControllerDismiss()
}

class SettingsNavigationController: UINavigationController {

    struct Style {
        let backgroundColor: String
        let statusBarStyle: UIStatusBarStyle

        static let light = Style(
            backgroundColor: Color.light.background,
            statusBarStyle: .lightContent
        )
    }

    weak var dismissDelegate: SettingsNavigationControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()

        let settingsTableViewController = SettingsTableViewController()
        self.viewControllers = [settingsTableViewController]
    }

    /* Init */
    func initView() {
        self.view.theme_backgroundColor = [Style.light.backgroundColor]
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: Style.light.statusBarStyle)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        dismissDelegate?.settingsNavigationControllerDismiss()
    }
}
