import UIKit

class SettingsAboutTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initTitle()
        initBackButton()
        initDoneButton()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    /* Init */
    func initView() {
        self.view.theme_backgroundColor = [Color.light.background]
    }

    func initTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "About"
        titleLabel.theme_textColor = [Color.light.blackSecondary]
        titleLabel.font = Font.title
        self.navigationItem.titleView = titleLabel
    }

    func initBackButton() {
        let backButton = ExtendedButton()
        backButton.setTitle("Back", font: Font.body!)
        backButton.setImage("back")
        backButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        backButton.addTarget(self, action: #selector(backButtonTouchUpInside), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    func initDoneButton() {
        let doneButton = ExtendedButton()
        doneButton.setTitle("Done", font: Font.body!)
        doneButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        doneButton.addTarget(self, action: #selector(doneButtonTouchUpInside), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }

    /* Buttons */
    @objc func backButtonTouchUpInside(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func doneButtonTouchUpInside(sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }

    /* TableView */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
