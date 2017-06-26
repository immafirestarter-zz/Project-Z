//
//  Projectie.swift
//  Test
//
//  Created by Ahmed Shehab on 26/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        let someTexture = SKTexture(imageNamed: "bomb")
        
        super.init(texture: someTexture, color: UIColor.clear, size: someTexture.size())
        
        self.physicsBody = SKPhysicsBody(texture: someTexture, size: someTexture.size())
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        
        
        self.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
        self.physicsBody?.collisionBitMask = 2
        self.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func spawnProjectile(player: Player) {
        let newProjectile: Projectile = Projectile()
        newProjectile.position = player.position
        self.shootProjectile(projectile: newProjectile)
    }
    
    func shootProjectile(projectile: Projectile) {
        projectile.physicsBody?.applyImpulse(CGVector(dx: 500, dy: 0))
    }
}
