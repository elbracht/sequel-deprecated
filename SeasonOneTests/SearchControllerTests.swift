import XCTest
@testable import SeasonOne

class SearchControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFetchSeries() {
        let expected = expectation(description: "Should load series with search query")

        let searchController = SearchController()
        searchController.fetchSeries(searchQuery: "Game of Thrones") {
            let series = searchController.series

            XCTAssertEqual(series.count, 1)
            XCTAssertNotNil(series[0].name)
            XCTAssertNotNil(series[0].posterPath)
            expected.fulfill()
        }

        wait(for: [expected], timeout: 1)
    }
}
