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
    
    var jumpAction:SKAction?
    var walkAction:SKAction?
    var atlas:SKTextureAtlas?
    var xVelocity:CGFloat = 0
    

    func setUpPlayer() {
        
        
        
        let imageTexture = SKTexture(imageNamed: "zombie_stand")
        
        let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture,
                                               size: imageTexture.size())
        
        self.physicsBody = body
        body.affectedByGravity = true
        body.allowsRotation = false
        body.isDynamic = true
        
//        setUpJump()
        setUpWalk()
    
  
        
    }
    
//    func setUpJump() {
//        atlas = SKTextureAtlas(named:"Jump")
//        var array = [String]()
//        
//        for i in (0...2) {
//            let nameString = String(format:"jump%i", i)
//            array.append(nameString)
//        }
    

//    }
    
    func setUpWalk() {
        atlas = SKTextureAtlas(named: "Walk")
        var atlasTextures = [SKTexture]()
        let texture1:SKTexture = atlas!.textureNamed("zombie_walk1")
        let texture2:SKTexture = atlas!.textureNamed("zombie_walk2")
        atlasTextures.append(texture1)
        atlasTextures.append(texture2)
        
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1/10)
        walkAction = SKAction.repeatForever(atlasAnimation)
        
        
        
        
    }
    
    func walk(moveVelocity: CGFloat) {
        let rate: CGFloat = 0.5
        self.xVelocity = moveVelocity
        let playerVelocity = self.physicsBody?.velocity.dx
        let relativeVelocity:CGVector = CGVector(dx: self.xVelocity - playerVelocity!, dy: 0)
        self.physicsBody?.velocity = CGVector(dx: playerVelocity! + relativeVelocity.dx * rate, dy: 0)
        self.run(walkAction!)
    }
    func stopMoving(){
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
    }

}
