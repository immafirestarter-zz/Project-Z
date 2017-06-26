//
//  Bullet.swift
//  Test
//
//  Created by Ahmed Shehab on 26/06/2017.
//  Copyright © 2017 Sami. All rights reserved.


import Foundation
import SpriteKit

class Projectile {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let projectileTexture = SKTexture(imageNamed: "bomb")
        super.init(texture: enemyTexture, color: UIColor.clear, size: projectileTexture.size())
        self.physicsBody = SKPhysicsBody(texture: projectileTexture, size: projectileTexture.size())
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        
        
        self.physicsBody?.categoryBitMask = BodyType.projectile.rawValue
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = BodyType.enemy.rawValue
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawnProjectile(){
        let projectile: Projectile = Projectile()
        
    }
    
}

