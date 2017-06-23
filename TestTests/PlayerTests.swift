//
//  Player.swift
//  Test
//
//  Created by Ahmed Shehab on 23/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import XCTest
@testable import Test


class TestPlayer: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlayerSetUp() {
        let player = Player()
        player.setUpPlayer()
        XCTAssert(player.physicsBody?.isDynamic == true, "player body is not dynamic")
        XCTAssert(player.physicsBody?.affectedByGravity == true, "player body is not affected by gravity")
        XCTAssert(player.physicsBody?.restitution == 0, "player body is not affected by gravity")
    }
    
    func testPlayerMovment() {
        let player = Player()
        player.setUpPlayer()
        XCTAssert(player.physicsBody?.velocity.dx == 0, "player is moving in the begining")
        player.walk(moveVelocity: 200)
        XCTAssert(player.physicsBody?.velocity.dx == 100, "player is not moving")
        player.stopMoving()
        XCTAssert(player.physicsBody?.velocity.dx == 0, "player is still moving")
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
