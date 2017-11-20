import SnapKit
import SwiftTheme
import UIKit

struct AboutViewSection {
    let name: String
    let cells: [UITableViewCell]
}

struct AboutViewMeasure {
    static let headerHeight = 224 as CGFloat
    static let headerImageSize = 100 as CGFloat
    static let headerImageOffset = 32 as CGFloat
    static let headerTitleHeight = 42 as CGFloat
    static let headerTitleOffset = 16 as CGFloat
    static let headerVersionHeight = 14 as CGFloat
    static let headerVersionOffset = 0 as CGFloat
}

class AboutView: NSObject {
    public var sections = [AboutViewSection]()

    public var navigationItem: UINavigationItem!
    public var titleLabel: UILabel!
    public var backButton: CustomButton!
    public var doneButton: CustomButton!
    public var tableView: UITableView!
    public var tableHeaderView: UIView!

    init(navigationItem: UINavigationItem, tableView: UITableView) {
        super.init()

        self.navigationItem = navigationItem
        self.tableView = tableView

        initTitle()
        initBackButton()
        initDoneButton()
        initTableView()
        initTableViewHeader()
        initDeveloperSection()
    }

    func initTitle() {
        titleLabel = UILabel()
        titleLabel.text = "About"
        titleLabel.theme_textColor = [Color.light.blackSecondary]
        titleLabel.font = Font.title
        navigationItem.titleView = titleLabel
    }

    func initBackButton() {
        backButton = CustomButton()
        backButton.setTitle("Back", font: Font.body!)
        backButton.setImage("back")
        backButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    func initDoneButton() {
        doneButton = CustomButton()
        doneButton.setTitle("Done", font: Font.body!)
        doneButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }

    func initTableView() {
        tableView.theme_backgroundColor = [Color.light.background]
    }

    func initTableViewHeader() {
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: AboutViewMeasure.headerHeight))

        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon_Preview")
        tableHeaderView.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(tableHeaderView).offset(AboutViewMeasure.headerImageOffset)
            make.width.equalTo(AboutViewMeasure.headerImageSize)
            make.height.equalTo(AboutViewMeasure.headerImageSize)
            make.centerX.equalTo(tableHeaderView)
        }

        let titleLabel = UILabel()
        if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            titleLabel.text = bundleName
            titleLabel.font = Font.display
            titleLabel.theme_textColor = [Color.light.blackPrimary]
            titleLabel.textAlignment = .center
        }
        tableHeaderView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(AboutViewMeasure.headerTitleOffset)
            make.left.equalTo(tableHeaderView)
            make.right.equalTo(tableHeaderView)
            make.height.equalTo(AboutViewMeasure.headerTitleHeight)
        }

        let versionLabel = UILabel()
        if let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionLabel.text = "Version \(bundleVersion)"
            versionLabel.font = Font.small
            versionLabel.theme_textColor = [Color.light.blackSecondary]
            versionLabel.textAlignment = .center
        }
        tableHeaderView.addSubview(versionLabel)

        versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(AboutViewMeasure.headerVersionOffset)
            make.left.equalTo(tableHeaderView)
            make.right.equalTo(tableHeaderView)
            make.height.equalTo(AboutViewMeasure.headerVersionHeight)
        }
    }

    func initDeveloperSection() {
        var developerCells = [UITableViewCell]()

        let websiteCell = UITableViewCell()
        websiteCell.textLabel?.text = "Website"
        websiteCell.imageView?.image = UIImage(named: "website")
        developerCells.append(websiteCell)

        let twitterCell = UITableViewCell()
        twitterCell.textLabel?.text = "Twitter"
        twitterCell.imageView?.image = UIImage(named: "twitter")
        developerCells.append(twitterCell)

        let githubCell = UITableViewCell()
        githubCell.textLabel?.text = "GitHub"
        githubCell.imageView?.image = UIImage(named: "github")
        developerCells.append(githubCell)

        sections.append(AboutViewSection(name: "Developed by \(Config.Developer.name)", cells: developerCells))
    }
}
