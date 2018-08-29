import XCTest
@testable import Sequel

class HumanizeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFileSize() {
        let sizeB = Humanize.fileSize(bytes: 5)
        XCTAssertEqual(sizeB, "5 B")

        let sizeKB = Humanize.fileSize(bytes: 5000)
        XCTAssertEqual(sizeKB, "4.88 kB")

        let sizeMB = Humanize.fileSize(bytes: 5000000)
        XCTAssertEqual(sizeMB, "4.77 MB")

        let sizeGB = Humanize.fileSize(bytes: 5000000000)
        XCTAssertEqual(sizeGB, "4.66 GB")

        let sizeTB = Humanize.fileSize(bytes: 5000000000000)
        XCTAssertEqual(sizeTB, "4.55 TB")
    }
}
