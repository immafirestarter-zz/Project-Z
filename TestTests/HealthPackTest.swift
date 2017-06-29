//
//  HealthPack.swift
//  Test
//
//  Created by Unai Motriko on 28/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import XCTest
@testable import Test

class TestHealthPack: XCTestCase {
    
    var healthPack:HealthPack = HealthPack()
    
    
    
    override func setUp() {
        super.setUp()
            }

    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertFalse(healthPack.pickedUp)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
