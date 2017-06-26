//
//  Player.swift
//  Test
//
//  Created by Unai Motriko on 21/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    
    var health = 100
    static let enemyHitCategory = 1
    
    var jumpAction:SKAction?
    var walkAction:SKAction?
    var atlas:SKTextureAtlas?
    var textureIdle:SKAction?
    var xVelocity:CGFloat = 0
    
    var isDead = false
    
    var hasKey = false
    var hasWeapon = false
    var weaponCount:Int = 0
    
    func setUpPlayer() {
        
        
        let imageTexture = SKTexture(imageNamed: "zombie_stand")
        
        let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture,
                                               size: imageTexture.size())
        self.physicsBody = body
        
        body.isDynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        body.restitution = 0
        body.categoryBitMask = BodyType.player.rawValue
        body.collisionBitMask = 1
        body.contactTestBitMask = BodyType.door.rawValue | BodyType.enemy.rawValue
    }
    
    func setUpWalk() {
        atlas = SKTextureAtlas(named: "Walk")
        var atlasTextures = [SKTexture]()
        let texture1:SKTexture = atlas!.textureNamed("zombie_walk1")
        let texture2:SKTexture = atlas!.textureNamed("zombie_walk2")
        atlasTextures.append(texture1)
        atlasTextures.append(texture2)
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1/10)
        self.run(atlasAnimation)
    }
    
    func setUpIdle() {
        let zombieTexture = SKTexture(imageNamed: "zombie_stand")
        textureIdle = SKAction.setTexture(zombieTexture)
        self.run(textureIdle!)
    }
    
    func jump() {
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 450))
    }
    
    
    func walk(force: CGFloat) {
        self.physicsBody?.applyForce(CGVector(dx: force, dy: 0.0))
        
    }
    
    func statusCheck(){
        if (self.position.y < -200 || self.health <= 0){
            self.isDead = true
        }
        
        if (self.weaponCount == 0){
            self.hasWeapon = false
        }
    }
}
