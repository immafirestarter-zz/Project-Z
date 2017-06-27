//
//  Ground.swift
//  Test
//
//  Created by Ahmed Shehab on 27/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        let texture = SKTexture()
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody()
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0

        
        
        self.physicsBody?.categoryBitMask = BodyType.ground.rawValue
        self.physicsBody?.collisionBitMask = 1 | 2
        self.physicsBody?.contactTestBitMask = BodyType.player.rawValue | BodyType.enemy.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
