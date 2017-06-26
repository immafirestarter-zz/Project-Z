//
//  LifeBar.swift
//  Test
//
//  Created by Unai Motriko on 26/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class LifeBar: SKSpriteNode {
    
    var objectSize:CGSize?
    var imageTexture:SKTexture?
    
    func setUp(playerPosition: CGFloat, cameraPosition: CGFloat) {
        let imageTexture = SKTexture(imageNamed: "hpBar")
        var objectSize = CGSize(width: imageTexture.size().width, height: imageTexture.size().height)
        let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture, size: objectSize)
        self.position = CGPoint(x: playerPosition  - 280, y: cameraPosition + 50)
        
    }
    
    
    func updateBar(lifeWidth: CGFloat) {
        var newRatio = lifeWidth / 100
        var objectSize = CGSize(width: self.texture!.size().width * newRatio, height: self.texture!.size().height)
        
    }
    
}
