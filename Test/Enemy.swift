//
//  Enemy.swift
//  Test
//
//  Created by Ahmed Shehab on 23/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    
    var health = 100
    static let enemyHitCategory = 1
    static let playerHitCategory = 2
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let enemyTexture = SKTexture(imageNamed: "soldier_stand")
        super.init(texture: enemyTexture, color: UIColor.clear, size: enemyTexture.size())
        self.physicsBody = SKPhysicsBody(texture: enemyTexture, size: enemyTexture.size())
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        
        
        self.physicsBody?.categoryBitMask = UInt32(Enemy.enemyHitCategory)
        
        self.physicsBody?.collisionBitMask = UInt32(Enemy.playerHitCategory)
        
        self.physicsBody?.contactTestBitMask = UInt32(Enemy.playerHitCategory)

        self.physicsBody?.usesPreciseCollisionDetection = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
