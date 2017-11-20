import SwiftTheme

protocol SettingsNavigationControllerDelegate: class {
    func settingsNavigationControllerDismiss()
}

class SettingsNavigationController: UINavigationController {
    weak var dismissDelegate: SettingsNavigationControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let settingsTableViewController = SettingsViewController(style: .grouped)
        self.viewControllers = [settingsTableViewController]
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)

        if self.isBeingDismissed {
            dismissDelegate?.settingsNavigationControllerDismiss()
        }
    }
}
