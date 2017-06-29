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
        enemy.setUpEnemyWalk()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEnemyInit() {
        XCTAssertEqual(enemy.health, 100)
        XCTAssertFalse(enemy.hasHit)
        XCTAssertFalse(enemy.attacking)
        XCTAssertEqual(enemy.physicsBody?.isDynamic, true)
        XCTAssertEqual(enemy.physicsBody?.affectedByGravity, true)
        XCTAssertEqual(enemy.physicsBody?.allowsRotation, false)
        XCTAssertEqual(enemy.physicsBody?.restitution, 0)
        XCTAssertEqual(enemy.physicsBody?.categoryBitMask, BodyType.enemy.rawValue )
        XCTAssertEqual(enemy.physicsBody?.collisionBitMask, BodyType.player.rawValue | BodyType.projectile.rawValue | BodyType.ground.rawValue )
        XCTAssertEqual(enemy.physicsBody?.contactTestBitMask , BodyType.player.rawValue | BodyType.projectile.rawValue | BodyType.ground.rawValue )
        XCTAssertEqual(enemy.physicsBody?.usesPreciseCollisionDetection, true )
    }
    
    func testEnenmySetUpWalk() {
        XCTAssertEqual(enemy.atlasTextures.texture1, atlas!.textureNamed("ghost1-1"))
        
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
}
