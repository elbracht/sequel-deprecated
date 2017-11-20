import XCTest

class SearchUITests: XCTestCase {

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
        app.textFields["SearchTextField"].tap()
        app.buttons["SearchCancelButton"].tap()
    }

    func testInputTextAndClear() {
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        searchTextField.typeText("Test")
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Search\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
