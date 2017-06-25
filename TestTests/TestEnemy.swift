//
//  TestEnemy.swift
//  Test
//
//  Created by Unai Motriko on 25/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import XCTest
@testable import Test

class TestEnemy: XCTestCase {
    let enemy:Enemy = Enemy()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertEqual(enemy.physicsBody?.isDynamic, true, "the enemy is dynamic")
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
}
