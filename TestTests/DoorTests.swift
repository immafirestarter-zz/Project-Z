//
//  Door.swift
//  Test
//
//  Created by Unai Motriko on 23/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import XCTest
@testable import Test


class TestDoor: XCTestCase {
    
    let door:Door = Door()
    
    override func setUp() {
        super.setUp()
        door.name = "Door"
        door.setUpDoor()
        
    }
    override func tearDown() {
        super.tearDown()
    }
    
    
    
    
    func testsetUpDoor(){
        XCTAssertEqual(door.name, "Door")
        XCTAssertEqual(door.goesWhere, "Door")
    }
    
    func testsetUpDoor2(){
        XCTAssertEqual(door.physicsBody?.collisionBitMask, 0)
    }
    
    func testsetUpDoor3(){
        XCTAssertEqual(door.physicsBody?.contactTestBitMask, 1)
    }
    
    func testsetUpDoor4(){
        XCTAssertEqual(door.physicsBody?.categoryBitMask, 2)
    }
    
    func testsetUpDoor5(){
        XCTAssertEqual(door.physicsBody?.isDynamic, true)
    }
    
    func testsetUpDoor6(){
        XCTAssertEqual(door.physicsBody?.affectedByGravity, false)
    }
    
    func testsetUpDoo7(){
        XCTAssertEqual(door.physicsBody?.allowsRotation, false)
    }
    
}
