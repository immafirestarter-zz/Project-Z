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
    
    func setUpPlayer() {
        
        let imageTexture = SKTexture(imageNamed: "zombie_stand")
        
        let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture,
                                               size: imageTexture.size())
        
        self.physicsBody = body
        
        
        body.affectedByGravity = true
        body.allowsRotation = false
        
        self.xScale = 1
        
//        setUpJump()
        setUpRunRight()
        setUpRunLeft()
    
  
        
    }
    
//    func setUpJump() {
//        let atlas = SKTextureAtlas(named:"Jump")
//        var array = [String]()
//        
//        for i in (0...2) {
//            let nameString = String(format:"jump%i", i)
//            array.append(nameString)
//        }
//        for(var)
//    }
    
    func setUpRunRight() {
        let atlas = SKTextureAtlas(named: "Walk")
        var atlasTextures = [SKTexture]()
        let texture1:SKTexture = atlas.textureNamed("zombie_walk1")
        let texture2:SKTexture = atlas.textureNamed("zombie_walk2")
        atlasTextures.append(texture1)
        atlasTextures.append(texture2)
        
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1/10, resize:true,
                                              restore:false)
        walkAction = SKAction.repeatForever(atlasAnimation)
        
        
    }
    
    func setUpRunLeft() {
        
    }
}
