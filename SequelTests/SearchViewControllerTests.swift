import XCTest
@testable import Sequel

class SearchViewControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFetchSeries() {
        let expected = expectation(description: "Should load series with search query")

        let searchViewController = SearchViewController()
        searchViewController.fetchSeries(searchQuery: "Game of Thrones", page: 1) {
            let series = searchViewController.series

            XCTAssertEqual(series.count, 1)
            XCTAssertNotNil(series[0].name)
            XCTAssertNotNil(series[0].posterPath)
            expected.fulfill()
        }

        wait(for: [expected], timeout: 1)
    }
}
