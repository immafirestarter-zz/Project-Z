//
//  Background.swift
//  Test
//
//  Created by Sami on 28/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    
    // 0 = no movement, 1 = player speed
    var movementMultiplier = CGFloat(0)
    var jumpAdjustment = CGFloat(0)
    let backgroundSize = CGSize(width: 2300, height:1500)
    var textureAtlas = SKTextureAtlas(named: "Backgrounds")
    
    func spawn(parentNode:SKNode, imageName:String, zPosition:CGFloat, movementMultiplier:CGFloat) {
        
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint(x: 0,y: -400)
        self.zPosition = zPosition
        self.movementMultiplier = movementMultiplier
        parentNode.addChild(self)
        let texture = textureAtlas.textureNamed(imageName)
        
        for i in -1...1 {
            let BGNode = SKSpriteNode(texture: texture)
            BGNode.size = backgroundSize
            BGNode.anchorPoint = CGPoint.zero
            BGNode.position = CGPoint(x: i * Int(backgroundSize.width), y: 0)
            self.addChild(BGNode)
        }
    }
    
    func updateBG(playerProgress:CGFloat) {
        let adjustedPosition = jumpAdjustment + playerProgress * (1 - movementMultiplier)
        
        if playerProgress - adjustedPosition > backgroundSize.width {
            jumpAdjustment += backgroundSize.width
        }
        self.position.x = adjustedPosition
    }
}

