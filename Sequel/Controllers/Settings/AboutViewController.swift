import DeckTransition

class AboutViewController: UITableViewController {
    private weak var deckTransitionDelegate: DeckTransitioningDelegate!
    private var lastScrollOffset: CGFloat = 0
    private var initialModalOffset: CGFloat = 0

    public var aboutView: AboutView!

    override func viewDidLoad() {
        super.viewDidLoad()

        aboutView = AboutView(navigationItem: self.navigationItem, tableView: self.tableView)
        aboutView.backButton.addTarget(self, action: #selector(backButtonTouchUpInside), for: .touchUpInside)
        aboutView.doneButton.addTarget(self, action: #selector(doneButtonTouchUpInside), for: .touchUpInside)
        self.tableView.tableHeaderView = aboutView.tableHeaderView

        if let navigationController = self.navigationController {
            initialModalOffset = navigationController.view.frame.origin.y

            if let delegate = navigationController.transitioningDelegate as? DeckTransitioningDelegate {
                deckTransitionDelegate = delegate
            }

            if navigationController.interactivePopGestureRecognizer != nil {
                navigationController.interactivePopGestureRecognizer!.delegate = self
                navigationController.interactivePopGestureRecognizer!.addTarget(self, action: #selector(handlePopGesture))
            }
        }
    }
}

/**
BackButton event to pop AboutViewController
*/
extension AboutViewController {
    @objc func backButtonTouchUpInside(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

/**
DoneButton event to dismiss AboutViewController
*/
extension AboutViewController {
    @objc func doneButtonTouchUpInside(sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
}

/**
Layout and data source of AboutViewTable
*/
extension AboutViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return aboutView.sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return aboutView.sections[section].name
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.theme_textColor = [Color.light.blackSecondary]
            header.textLabel?.font = Font.caption
            header.textLabel?.text = aboutView.sections[section].name
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutView.sections[section].cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aboutView.sections[indexPath.section].cells[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.isSelected = false
        }

        if indexPath.section == 0 && indexPath.row == 0 {
            websiteCellTouchUpInside()
        }

        if indexPath.section == 0 && indexPath.row == 1 {
            twitterCellTouchUpInside()
        }

        if indexPath.section == 0 && indexPath.row == 2 {
            githubCellTouchUpInside()
        }
    }
}

/**
Events of AboutViewTable
*/
extension AboutViewController {
    func websiteCellTouchUpInside() {
        if let url = URL(string: Config.Developer.website) {
            UIApplication.shared.openURL(url)
        }
    }

    func twitterCellTouchUpInside() {
        if let url = URL(string: Config.Developer.twitter) {
            UIApplication.shared.openURL(url)
        }
    }

    func githubCellTouchUpInside() {
        if let url = URL(string: Config.Developer.github) {
            UIApplication.shared.openURL(url)
        }
    }
}

/**
 Fix scrolling for DeckTransition
 */
extension AboutViewController {
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

/**
Fix navigation pop animation
*/
extension AboutViewController: UIGestureRecognizerDelegate {
    @objc func handlePopGesture(sender: UIGestureRecognizer) {
        if sender.state == .began {
            deckTransitionDelegate.isDismissEnabled = false
        } else if sender.state == .ended {
            deckTransitionDelegate.isDismissEnabled = true
        }
    }
}
