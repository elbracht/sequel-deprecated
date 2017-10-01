//
//  SearchControllerTests.swift
//  SeasonOneTests
//
//  Created by Alexander Elbracht on 01.10.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

import XCTest
@testable import SeasonOne

class SearchControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithCoder() {
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
        let searchController = SearchController(coder: archiver)
        
        XCTAssertNil(searchController)
    }
}

