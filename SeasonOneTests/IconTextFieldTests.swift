//
//  IconTextFieldTests.swift
//  SeasonOneTests
//
//  Created by Alexander Elbracht on 30.09.17.
//  Copyright © 2017 Alexander Elbracht. All rights reserved.
//

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
        iconTextField.icon = UIImage(named: "search")
        iconTextField.iconColor = UIColor.black
        iconTextField.placeholder = "Search"
        iconTextField.placeholderColor = UIColor.black
        iconTextField.clearButtonImage = UIImage(named: "clear")
        
        XCTAssertNotNil(iconTextField)
    }
    
    func testInitWithCoder() {
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
        let iconTextField = IconTextField(coder: archiver)
        
        XCTAssertNil(iconTextField)
    }
}
