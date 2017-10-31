import XCTest
@testable import SeasonOne

class HumanizeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFileSize() {
        let b = Humanize.fileSize(bytes: 5)
        XCTAssertEqual(b, "5 B")

        let kb = Humanize.fileSize(bytes: 5000)
        XCTAssertEqual(kb, "4.88 kB")

        let mb = Humanize.fileSize(bytes: 5000000)
        XCTAssertEqual(mb, "4.77 MB")

        let gb = Humanize.fileSize(bytes: 5000000000)
        XCTAssertEqual(gb, "4.66 GB")

        let tb = Humanize.fileSize(bytes: 5000000000000)
        XCTAssertEqual(tb, "4.55 TB")
    }
}
