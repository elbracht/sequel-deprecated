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
        app.textFields["Search"].tap()
        app.buttons["Cancel"].tap()
    }
    
    func testInputTextAndClear() {
        let searchTextField = app.textFields["Search"]
        searchTextField.tap()
        searchTextField.typeText("Test")
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Search\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSwipeDown() {
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.3))
        start.press(forDuration: 0, thenDragTo: end)
    }
    
    func testActiveSwipeDown() {
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        start.press(forDuration: 0, thenDragTo: end)
    }
}
