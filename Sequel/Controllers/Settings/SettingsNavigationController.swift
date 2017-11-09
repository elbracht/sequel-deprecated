import SwiftTheme
import UIKit

protocol SettingsNavigationControllerDelegate: class {
    func settingsNavigationControllerDismiss()
}

class SettingsNavigationController: UINavigationController {

    struct Style {
        let backgroundColor: String

        static let light = Style(
            backgroundColor: Color.light.background
        )
    }

    weak var dismissDelegate: SettingsNavigationControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()

        let settingsTableViewController = SettingsTableViewController(style: .grouped)
        self.viewControllers = [settingsTableViewController]
    }

    /* Init */
    func initView() {
        self.view.theme_backgroundColor = [Style.light.backgroundColor]
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)

        if self.isBeingDismissed {
            dismissDelegate?.settingsNavigationControllerDismiss()
        }
    }
}
