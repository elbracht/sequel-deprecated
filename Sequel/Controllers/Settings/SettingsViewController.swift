import Kingfisher
import MessageUI
import StoreKit

class SettingsViewController: UITableViewController {
    private var lastScrollOffset: CGFloat = 0
    private var initialModalOffset: CGFloat = 0

    public var settingsView: SettingsView!

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsView = SettingsView(navigationItem: self.navigationItem, tableView: self.tableView)
        settingsView.doneButton.addTarget(self, action: #selector(doneButtonTouchUpInside), for: .touchUpInside)

        // Display cache size
        ImageCache.default.calculateDiskCacheSize { (size) in
            let cacheSizeCell = self.settingsView.sections[0].cells[0] as UITableViewCell
            cacheSizeCell.detailTextLabel?.text = Humanize.fileSize(bytes: Int(size))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if let navigationController = self.navigationController {
            initialModalOffset = navigationController.view.frame.origin.y
        }
    }
}

/**
DoneButton event to dismiss SettingsViewController
*/
extension SettingsViewController {
    @objc private func doneButtonTouchUpInside(sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
}

/**
Layout and data source of SettingsViewTable
*/
extension SettingsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsView.sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsView.sections[section].name
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.theme_textColor = [Color.Black.secondary.hexString(true)]
            header.textLabel?.font = Font.caption
            header.textLabel?.text = settingsView.sections[section].name
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsView.sections[section].cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsView.sections[indexPath.section].cells[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.isSelected = false
        }

        if indexPath.section == 0 && indexPath.row == 1 {
            clearCacheCellTouchUpInside()
        }

        if indexPath.section == 1 && indexPath.row == 0 {
            aboutCellTouchUpInside()
        }

        if indexPath.section == 1 && indexPath.row == 1 {
            feedbackCellTouchUpInside()
        }

        if indexPath.section == 1 && indexPath.row == 2 {
            rateCellTouchUpInside()
        }
    }
}

/**
Events of SettingsViewTable
*/
extension SettingsViewController {
    func clearCacheCellTouchUpInside() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to remove the cache?", preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "Remove", style: .destructive) { (_) in
            ImageCache.default.clearDiskCache()
            ImageCache.default.calculateDiskCacheSize { (size) in
                let cacheSizeCell = self.settingsView.sections[0].cells[0] as UITableViewCell
                cacheSizeCell.detailTextLabel?.text = Humanize.fileSize(bytes: Int(size))
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func aboutCellTouchUpInside() {
        let aboutViewController = AboutViewController(style: .grouped)
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }

    func feedbackCellTouchUpInside() {
        if MFMailComposeViewController.canSendMail() {
            let feedbackViewController = FeedbackViewController(nibName: nil, bundle: nil)
            self.present(feedbackViewController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Could not send feedback", message: "Your device could not send mails. Please check your mail configuration and try again.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }

    func rateCellTouchUpInside() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/\(Config.App.identifier)") {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

/**
Fix scrolling for DeckTransition
*/
extension SettingsViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let navigationController = self.navigationController {
            let navigationBarHeight = navigationController.navigationBar.frame.size.height
            let currentModalOffset = navigationController.view.frame.origin.y
            let currentModalScope = 4 as CGFloat

            if lastScrollOffset > scrollView.contentOffset.y {
                // Scroll down
                if scrollView.contentOffset.y <= -navigationBarHeight {
                    scrollView.contentOffset = CGPoint(x: 0, y: -navigationBarHeight)
                }
            } else {
                // Scroll up
                if initialModalOffset < currentModalOffset - currentModalScope {
                    scrollView.contentOffset = CGPoint(x: 0, y: -navigationBarHeight)
                }
            }
        }

        self.lastScrollOffset = scrollView.contentOffset.y
    }
}
