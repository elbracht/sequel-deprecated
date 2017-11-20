import MessageUI

class FeedbackViewController: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.mailComposeDelegate = self
        self.modalPresentationStyle = .custom
        self.setToRecipients(["\(Config.Developer.name) <\(Config.Developer.mail)>"])

        if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            self.setSubject("\(bundleName) Feedback")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
