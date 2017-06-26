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
        
        
        self.physicsBody?.categoryBitMask = BodyType.projectile.rawValue
        self.physicsBody?.collisionBitMask = 8
        self.physicsBody?.contactTestBitMask = BodyType.enemy.rawValue
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawnProjectile(player: Player, parent: GameScene) {
        let newProjectile: Projectile = Projectile()
        newProjectile.position = CGPoint(x: player.position.x+50, y: player.position.y)
        parent.addChild(newProjectile)
        self.shootProjectile(projectile: newProjectile)
    }
    
    func shootProjectile(projectile: Projectile) {
        projectile.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 0))
    }
}
