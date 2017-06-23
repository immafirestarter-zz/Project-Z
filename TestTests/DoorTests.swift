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
    

    
    override func setUp() {
        super.setUp()
        
    }
    override func tearDown() {
        super.tearDown()
    }
    
    

    
    func testsetUpDoor(){
        let door:Door = Door()
        door.name = "Door"
        door.setUpDoor()
        XCTAssertEqual(door.name, "Door")
        XCTAssertEqual(door.goesWhere, "Door")
    }
    
    func testsetUpDoor2(){
        let door:Door = Door()
        door.name = "Door"
        door.setUpDoor()
        XCTAssertEqual(door.physicsBody?.collisionBitMask, 0)

    }
    
    func testsetUpDoor3(){
        let door:Door = Door()
        door.name = "Door"
        door.setUpDoor()
        XCTAssertEqual(door.physicsBody?.contactTestBitMask, 1)
    }
    
    func testsetUpDoor4(){
        let door:Door = Door()
        door.name = "Door"
        door.setUpDoor()
        XCTAssertEqual(door.physicsBody?.categoryBitMask, 2)
    }

    func testsetUpDoor5(){
        let door:Door = Door()
        door.name = "Door"
        door.setUpDoor()
        XCTAssertEqual(door.physicsBody?.isDynamic, true)
    }

    func testsetUpDoor6(){
        let door:Door = Door()
        door.name = "Door"
        door.setUpDoor()
        XCTAssertEqual(door.physicsBody?.affectedByGravity, false)
    }
    
    func testsetUpDoo7(){
        let door:Door = Door()
        door.name = "Door"
        door.setUpDoor()
        XCTAssertEqual(door.physicsBody?.allowsRotation, false)
    }

    


    
}
