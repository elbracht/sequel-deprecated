import XCTest
@testable import SeasonOne

class ViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithCoder() {
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
        let viewController = ViewController(coder: archiver)
        
        XCTAssertNil(viewController)
    }
}

