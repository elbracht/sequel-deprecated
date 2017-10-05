import XCTest
@testable import SeasonOne

class IconTextFieldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        let iconTextField = IconTextField(frame: CGRect())
        iconTextField.padding = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        iconTextField.font = UIFont(name: "Arial", size: 15)
        iconTextField.icon = UIImage(named: "search")
        iconTextField.iconColor = UIColor.black
        iconTextField.iconPadding = 16
        iconTextField.placeholder = "Search"
        iconTextField.placeholderColor = UIColor.black
        iconTextField.clearButtonImage = UIImage(named: "clear")
        iconTextField.clearButtonColor = UIColor.black
        iconTextField.clearButtonPadding = 16
        
        XCTAssertNotNil(iconTextField)
    }
    
    func testInitWithCoder() {
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
        let iconTextField = IconTextField(coder: archiver)
        
        XCTAssertNil(iconTextField)
    }
}
