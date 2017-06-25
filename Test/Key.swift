//
//  Key.swift
//  Test
//
//  Created by Unai Motriko on 25/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Key:SKSpriteNode {
    
    
    func setUpKey() {
        
        let body:SKPhysicsBody = SKPhysicsBody()
        
        self.physicsBody = body
        
        body.affectedByGravity = false
        body.isDynamic = false
        body.allowsRotation = false
        
        body.collisionBitMask = 0
        body.categoryBitMask = BodyType.key.rawValue
        body.contactTestBitMask = BodyType.player.rawValue
    
    }
}
