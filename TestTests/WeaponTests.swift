//
//  WeaponTests.swift
//  Test
//
//  Created by Nigel Said on 26/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import SpriteKit
import XCTest
@testable import Test

class TestWeapon: XCTestCase {
    
    let weapon = Weapon(texture: SKTexture(imageNamed: "bomb"))
    
    override func setUp() {
        super.setUp()
        weapon.setUpWeapon()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAffectedByGravity() {
        XCTAssertEqual(weapon.physicsBody?.affectedByGravity, false)
    }
    
    func testIsDynamic() {
        XCTAssertEqual(weapon.physicsBody?.isDynamic, false)
    }
    
    func testRotates() {
        XCTAssertEqual(weapon.physicsBody?.allowsRotation, false)
    }
    
    func testCollisionBitMask(){
        XCTAssertEqual(weapon.physicsBody?.collisionBitMask, 0)
    }
    
    func testCategoryBitMask(){
        XCTAssertEqual(weapon.physicsBody?.categoryBitMask, BodyType.weapon.rawValue)
    }
    
    func testContactTestBitMask(){
        XCTAssertEqual(weapon.physicsBody?.contactTestBitMask, BodyType.player.rawValue)
    }
    
    func testPickedUp() {
        XCTAssertEqual(weapon.pickedUp, false)
    }
    
    
    func testPerformanceExample() {
        self.measure {}
    }
}

