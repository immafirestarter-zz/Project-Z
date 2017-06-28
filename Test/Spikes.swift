//
//  Spikes.swift
//  Test
//
//  Created by Unai Motriko on 27/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Spikes:SKSpriteNode {
    
    func setUp() {
        
        let objectSize = CGSize(width: self.texture!.size().width * 0.5, height: self.texture!.size().height * 0.5)
        let body:SKPhysicsBody = SKPhysicsBody(texture: self.texture!, size: objectSize)
        
        self.physicsBody = body
        
        body.affectedByGravity = false
        body.isDynamic = false
        body.allowsRotation = false
        
        body.collisionBitMask = 0
        body.categoryBitMask = BodyType.spikes.rawValue
        body.contactTestBitMask = BodyType.player.rawValue
    }
    
}
