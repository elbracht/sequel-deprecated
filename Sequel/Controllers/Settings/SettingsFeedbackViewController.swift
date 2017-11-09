import MessageUI
import SwiftTheme
import UIKit

class SettingsFeedbackViewController: MFMailComposeViewController, MFMailComposeViewControllerDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func initView() {
        self.mailComposeDelegate = self
        self.modalPresentationStyle = .custom

        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] {
                if let developer = dictionary["Developer"] as? [String: Any] {
                    let name = developer["Name"] as? String
                    let mail = developer["Mail"] as? String

                    if name != nil && mail != nil {
                        self.setToRecipients(["\(name!) <\(mail!)>"])
                    }
                }
            }
        }

        if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            self.setSubject("\(bundleName) Feedback")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            UIApplication.shared.statusBarStyle = .default
        })
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        UIApplication.shared.statusBarStyle = .lightContent
        controller.dismiss(animated: true, completion: nil)
    }
}
