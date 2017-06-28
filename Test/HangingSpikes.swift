//
//  HangingSpikes.swift
//  Test
//
//  Created by Unai Motriko on 28/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class HangingSpikes:SKSpriteNode {
    
    var hit = false
    
    func setUp() {
        
        let objectSize = CGSize(width: self.texture!.size().width * 0.4, height: self.texture!.size().height * 0.4)
        let body:SKPhysicsBody = SKPhysicsBody(texture: self.texture!, size: objectSize)
        
        self.physicsBody = body
        
        body.affectedByGravity = false
        body.isDynamic = false
        body.allowsRotation = false
        
        body.collisionBitMask = 0
        body.categoryBitMask = BodyType.hangingSpikes.rawValue
        body.contactTestBitMask = BodyType.player.rawValue
    }

    
}
