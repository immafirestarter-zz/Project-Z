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
        
        let someTexture = SKTexture(imageNamed: "knife")
        
        super.init(texture: someTexture, color: UIColor.clear, size: someTexture.size())
        
        self.physicsBody = SKPhysicsBody(texture: someTexture, size: someTexture.size())
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        
        
        self.physicsBody?.categoryBitMask = BodyType.projectile.rawValue
        self.physicsBody?.collisionBitMask = BodyType.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.enemy.rawValue
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func spawnProjectile(player: Player, parent: GameScene) {
        let newProjectile: Projectile = Projectile()
        newProjectile.position = player.position
        parent.addChild(newProjectile)
        if player.xScale > 0 {
        self.shootProjectile(projectile: newProjectile, direction: 100.0)
        } else {
        self.shootProjectile(projectile: newProjectile, direction: -100.0)
        }
        
    }
    
    class func shootProjectile(projectile: Projectile, direction: CGFloat) {
        
        
        projectile.physicsBody?.applyImpulse(CGVector(dx: direction, dy: 0))
    }
}
