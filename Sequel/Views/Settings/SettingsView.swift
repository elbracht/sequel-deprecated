import SnapKit
import SwiftTheme
import UIKit

struct SettingsViewSection {
    let name: String
    let cells: [UITableViewCell]
}

class SettingsView: NSObject {
    public var sections = [SettingsViewSection]()

    public var navigationItem: UINavigationItem!
    public var tableView: UITableView!
    public var titleLabel: UILabel!
    public var doneButton: CustomButton!

    init(navigationItem: UINavigationItem, tableView: UITableView) {
        super.init()

        self.navigationItem = navigationItem
        self.tableView = tableView

        initStatusBar()
        initTitle()
        initDoneButton()
        initTableView()
        initStorageSection()
        initOtherSection()
    }

    private func initStatusBar() {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    private func initTitle() {
        titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.theme_textColor = [Color.light.blackSecondary]
        titleLabel.font = Font.title
        navigationItem.titleView = titleLabel
    }

    private func initDoneButton() {
        doneButton = CustomButton()
        doneButton.setTitle("Done", font: Font.body!)
        doneButton.setColors(colors: [Color.light.accentNormal], highlightColors: [Color.light.accentHighlighted])
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }

    private func initTableView() {
        tableView.theme_backgroundColor = [Color.light.background]
    }

    private func initStorageSection() {
        var storageCells = [UITableViewCell]()

        let cacheSizeCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cacheSizeCell.textLabel?.text = "Cache Size"
        cacheSizeCell.textLabel?.theme_textColor = [Color.light.blackPrimary]
        cacheSizeCell.textLabel?.font = Font.body
        cacheSizeCell.detailTextLabel?.theme_textColor = [Color.light.blackSecondary]
        cacheSizeCell.detailTextLabel?.font = Font.body
        cacheSizeCell.selectionStyle = .none
        storageCells.append(cacheSizeCell)

        let clearCacheCell = UITableViewCell()
        clearCacheCell.textLabel?.text = "Remove Cache"
        clearCacheCell.textLabel?.theme_textColor = [Color.light.accentNormal]
        clearCacheCell.textLabel?.font = Font.body
        storageCells.append(clearCacheCell)

        sections.append(SettingsViewSection(name: "Storage", cells: storageCells))
    }

    private func initOtherSection() {
        var otherCells = [UITableViewCell]()

        let aboutCell = UITableViewCell()
        aboutCell.textLabel?.text = "About"
        aboutCell.textLabel?.theme_textColor = [Color.light.blackPrimary]
        aboutCell.textLabel?.font = Font.body
        aboutCell.accessoryType = .disclosureIndicator
        otherCells.append(aboutCell)

        let feedbackCell = UITableViewCell()
        feedbackCell.textLabel?.text = "Feedback"
        feedbackCell.textLabel?.theme_textColor = [Color.light.blackPrimary]
        feedbackCell.textLabel?.font = Font.body
        feedbackCell.accessoryType = .disclosureIndicator
        otherCells.append(feedbackCell)

        let rateCell = UITableViewCell()
        rateCell.textLabel?.text = "Rate"
        rateCell.textLabel?.theme_textColor = [Color.light.blackPrimary]
        rateCell.textLabel?.font = Font.body
        rateCell.accessoryType = .disclosureIndicator
        otherCells.append(rateCell)

        sections.append(SettingsViewSection(name: "Other", cells: otherCells))
    }
}
