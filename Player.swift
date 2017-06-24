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
    
    struct Constants {
        static let minimumJumpForce:CGFloat = 15.0
        static let maximumJumpForce:CGFloat = 30.0
    }
    
    
    func setUpPlayer() {
        
        
        let imageTexture = SKTexture(imageNamed: "zombie_stand")
        
        let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture,
                                               size: imageTexture.size())
        self.physicsBody = body
        
        body.isDynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        body.restitution = 0.1
        body.categoryBitMask = BodyType.player.rawValue
        body.collisionBitMask = UInt32(Player.enemyHitCategory)
        body.contactTestBitMask = BodyType.door.rawValue | UInt32(Player.enemyHitCategory)
        
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
    
//    func jump() {
//        let jump1 = SKTexture(imageNamed: "jump1")
//        let jump2 = SKTexture(imageNamed: "jump2")
//        let jump1Anime = SKAction.setTexture(jump1)
//        let jump2Anime = SKAction.setTexture(jump2)
//        let jumpAction = SKAction.sequence([jump1Anime, jump2Anime])
//        self.run(jumpAction)
//        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 600))
//    }
    
    func jump(force: CGFloat) {
        self.physicsBody?.applyForce(CGVector(0, force))
    }
    
    func jumpDirectionally(directionForce: CGFloat){
        self.physicsBody?.applyImpulse(CGVector(dx: directionForce, dy: 600))
    }
    
    func walk(moveVelocity: CGFloat) {
        let rate: CGFloat = 0.5
        self.xVelocity = moveVelocity
        let playerVelocity = self.physicsBody?.velocity.dx
        let relativeVelocity:CGVector = CGVector(dx: self.xVelocity - playerVelocity!, dy: 0)
        self.physicsBody?.velocity = CGVector(dx: playerVelocity! + relativeVelocity.dx * rate, dy: 0)
        setUpWalk()
    }
    func stopMoving(){
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
}
