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
    
    var hit = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
       
        let projectileTexture = SKTexture(imageNamed: "knife")
        let projectileSize = CGSize(width: projectileTexture.size().width * 0.5, height: projectileTexture.size().height)
        
        super.init(texture: projectileTexture, color: UIColor.clear, size: projectileSize)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: max(projectileTexture.size().width / 4, projectileTexture.size().height / 4))
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
        self.shootProjectile(projectile: newProjectile, direction: 35.0)
        } else {
        newProjectile.xScale = fabs(newProjectile.xScale) * -1
        self.shootProjectile(projectile: newProjectile, direction: -35.0)
        }
        
    }
    
    class func shootProjectile(projectile: Projectile, direction: CGFloat) {
        
        
        projectile.physicsBody?.applyImpulse(CGVector(dx: direction, dy: 0))
    }
}
