//
//  Key.swift
//  Test
//
//  Created by Unai Motriko on 25/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import XCTest
@testable import Test

class TestKey: XCTestCase {
    
    let key:Key = Key()
    
    override func setUp() {
        super.setUp()
        key.setUpKey()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAffectedByGravity() {
        
        XCTAssertEqual(key.physicsBody?.affectedByGravity, false)

    }
    
    func testIsDynamic() {
        
        XCTAssertEqual(key.physicsBody?.isDynamic, false)
        
    }
    
    func testRotates() {
        
        XCTAssertEqual(key.physicsBody?.allowsRotation, false)
    
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
