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
    var hasHit = false
    static let enemyHitCategory = 1
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let enemyTexture = SKTexture(imageNamed: "soldier_stand")
        super.init(texture: enemyTexture, color: UIColor.clear, size: enemyTexture.size())
        self.physicsBody = SKPhysicsBody(texture: enemyTexture, size: enemyTexture.size())
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        
        
        self.physicsBody?.categoryBitMask = UInt32(Enemy.enemyHitCategory)
        
        self.physicsBody?.collisionBitMask = BodyType.player.rawValue
        
        self.physicsBody?.contactTestBitMask = BodyType.player.rawValue

        self.physicsBody?.usesPreciseCollisionDetection = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func delayHit(){
        hasHit = true
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.hasHit = false
        }
    }
}
