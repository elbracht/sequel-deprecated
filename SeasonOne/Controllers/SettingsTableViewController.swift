import UIKit

class SettingsTableViewController: UITableViewController {

    let reuseIdentifier = "SettingsTableViewCell"

    var data = [[Settings]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initTitle()
        initDoneButton()

        loadSettings()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    /* Init */
    func initTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.theme_textColor = [Color.light.blackSecondary]
        titleLabel.font = Font.title
        self.navigationItem.titleView = titleLabel
    }

    func initDoneButton() {
        let doneButton = UIBarButtonItem()
        doneButton.title = "Done"
        doneButton.target = self
        doneButton.action = #selector(doneButtonTouchUpInside)
        self.navigationItem.rightBarButtonItem = doneButton
    }

    /* DoneButton */
    @objc func doneButtonTouchUpInside(sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        cell.imageView?.image = data[indexPath.section][indexPath.row].image
        cell.textLabel?.text = data[indexPath.section][indexPath.row].text

        return cell
    }

    /* Helper */
    func loadSettings() {
        var settings = [Settings]()
        settings.append(Settings(text: "Notifications", image: UIImage(named: "settings")!))
        settings.append(Settings(text: "Badge", image: UIImage(named: "settings")!))
        settings.append(Settings(text: "Storage", image: UIImage(named: "settings")!))
        settings.append(Settings(text: "Appearance", image: UIImage(named: "settings")!))
        settings.append(Settings(text: "Stats", image: UIImage(named: "settings")!))
        data.append(settings)

        var informations = [Settings]()
        informations.append(Settings(text: "Imprint", image: UIImage(named: "settings")!))
        data.append(informations)
    }
}
