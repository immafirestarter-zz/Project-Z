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
    var attacking = false
    var atlas:SKTextureAtlas?
    static let enemyHitCategory = 1
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let enemyTexture = SKTexture(imageNamed: "soldier_stand")
        super.init(texture: enemyTexture, color: UIColor.clear, size: enemyTexture.size())
        self.physicsBody = SKPhysicsBody(texture: enemyTexture, size: enemyTexture.size())
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        
        
        self.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
    
        self.physicsBody?.collisionBitMask = 1
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
    
    func setUpEnemyWalk() {
        atlas = SKTextureAtlas(named: "Walk")
        var atlasTextures = [SKTexture]()
        let texture1:SKTexture = atlas!.textureNamed("soldier_walk1")
        let texture2:SKTexture = atlas!.textureNamed("soldier_walk2")
        atlasTextures.append(texture1)
        atlasTextures.append(texture2)
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1/15)
        self.run(atlasAnimation)
    }
    
    func enemyWalk(){
        self.physicsBody?.velocity = CGVector(dx: -80, dy: 0)
        setUpEnemyWalk()
    }
    
    func attack(){
        let kickTexture = SKAction.setTexture(SKTexture(imageNamed: "soldier_kick"))
        let standTexture = SKAction.setTexture(SKTexture(imageNamed: "soldier_stand"))
        let megaAttack = SKAction.sequence([kickTexture, standTexture])
        self.run(megaAttack)
    }
    
    
    
}
