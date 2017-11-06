import XCTest

class SettingsUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testOpenAndClose() {
        app.buttons["Settigns"].tap()
        app.navigationBars["Settings"].buttons["Done"].tap()
    }

    func testOpenAndSwipeToClose() {
        app.buttons["Settigns"].tap()
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        start.press(forDuration: 0, thenDragTo: end)
    }

    func testClearCache() {
        app.buttons["Settigns"].tap()

        let removeCacheStaticText = app.tables.staticTexts["Remove Cache"]
        removeCacheStaticText.tap()
        app.sheets.buttons["Cancel"].tap()

        removeCacheStaticText.tap()
        app.sheets.buttons["Remove"].tap()
    }

    func testAboutAndBack() {
        app.buttons["Settigns"].tap()
        app.tables.staticTexts["About"].tap()
        app.navigationBars["About"].buttons["Back"].tap()
    }

    func testAboutAndSwipeToBack() {
        app.buttons["Settigns"].tap()
        app.tables.staticTexts["About"].tap()
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.5))
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.8, dy: 0.5))
        start.press(forDuration: 0, thenDragTo: end)
    }

    func testAboutWebsite() {
        app.buttons["Settigns"].tap()
        app.tables.staticTexts["About"].tap()
        app.tables.staticTexts["Website"].tap()
    }

    func testAboutTwitter() {
        app.buttons["Settigns"].tap()
        app.tables.staticTexts["About"].tap()
        app.tables.staticTexts["Twitter"].tap()
    }

    func testAboutGitHub() {
        app.buttons["Settigns"].tap()
        app.tables.staticTexts["About"].tap()
        app.tables.staticTexts["GitHub"].tap()
    }

    func testFeedback() {
        app.buttons["Settigns"].tap()
        app.tables.staticTexts["Feedback"].tap()
        app.navigationBars["Sequel Feedback"].buttons["Cancel"].tap()
        app.sheets.buttons["Delete Draft"].tap()
    }

    func testRate() {
        app.buttons["Settigns"].tap()
        app.tables.staticTexts["Rate"].tap()
        app.otherElements["Rating"].tap()
        app.staticTexts["Cancel"].tap()
    }
}
