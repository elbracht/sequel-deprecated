import SwiftTheme
import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerDismiss()
}

class SettingsViewController: UIViewController {

    struct Style {
        let backgroundColor: String
        let statusBarStyle: UIStatusBarStyle

        static let light = Style(
            backgroundColor: Color.light.background,
            statusBarStyle: .lightContent
        )
    }

    weak var delegate: SettingsViewControllerDelegate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /* Init */
    func initView() {
        self.view.theme_backgroundColor = [Style.light.backgroundColor]
        let statusBarStylePicker = ThemeStatusBarStylePicker(styles: Style.light.statusBarStyle)
        UIApplication.shared.theme_setStatusBarStyle(statusBarStylePicker, animated: true)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        delegate?.settingsViewControllerDismiss()
    }
}
