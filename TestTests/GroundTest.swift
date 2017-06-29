//
//  GroundTest.swift
//  Test
//
//  Created by Unai Motriko on 28/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import XCTest
import SpriteKit

@testable import Test


class GroundTest: XCTestCase {
    
    let ground:Ground = Ground()
    
    override func setUp() {
        super.setUp()
        ground.setUpGround()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGroundSetUp() {
        print(ground.physicsBody?.contactTestBitMask)
        XCTAssertEqual(ground.physicsBody?.categoryBitMask, BodyType.ground.rawValue)
        XCTAssertEqual(ground.physicsBody?.collisionBitMask , BodyType.player.rawValue)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
