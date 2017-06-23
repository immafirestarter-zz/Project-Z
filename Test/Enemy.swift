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
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let enemyTexture = SKTexture(imageNamed: "soldier_stand")
        self.texture = enemyTexture
        self.physicsBody = SKPhysicsBody()
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = 0
        self.physicsBody?.contactTestBitMask = 1
        super.init(texture: enemyTexture, color: red, size: enemyTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
