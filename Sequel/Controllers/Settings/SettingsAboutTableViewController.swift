import UIKit

class SettingsAboutTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    struct Measure {
        static let headerHeight = 244 as CGFloat
        static let headerImageSize = 100 as CGFloat
        static let headerImageOffset = 32 as CGFloat
        static let headerTitleHeight = 42 as CGFloat
        static let headerTitleOffset = 16 as CGFloat
        static let headerVersionHeight = 14 as CGFloat
        static let headerVersionOffset = 0 as CGFloat
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        initTitle()
        initBackButton()
        initDoneButton()
        initHeaderView()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    /* Init */
    func initTableView() {
        self.tableView.theme_backgroundColor = [Color.light.background]
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

    func initHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: Measure.headerHeight))

        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon_Preview")
        headerView.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView).offset(Measure.headerImageOffset)
            make.width.equalTo(Measure.headerImageSize)
            make.height.equalTo(Measure.headerImageSize)
            make.centerX.equalTo(headerView)
        }

        let titleLabel = UILabel()
        if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            titleLabel.text = bundleName
            titleLabel.font = Font.display
            titleLabel.theme_textColor = [Color.light.blackPrimary]
            titleLabel.textAlignment = .center
        }
        headerView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(Measure.headerTitleOffset)
            make.left.equalTo(headerView)
            make.right.equalTo(headerView)
            make.height.equalTo(Measure.headerTitleHeight)
        }

        let versionLabel = UILabel()
        if let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionLabel.text = "Version \(bundleVersion)"
            versionLabel.font = Font.small
            versionLabel.theme_textColor = [Color.light.blackSecondary]
            versionLabel.textAlignment = .center
        }
        headerView.addSubview(versionLabel)

        versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Measure.headerVersionOffset)
            make.left.equalTo(headerView)
            make.right.equalTo(headerView)
            make.height.equalTo(Measure.headerVersionHeight)
        }

        self.tableView.tableHeaderView = headerView
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
