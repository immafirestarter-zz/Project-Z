//
//  Ground.swift
//  Test
//
//  Created by Ahmed Shehab on 27/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Ground:SKSpriteNode {
    
    func setUpGround(){
        
        self.physicsBody?.categoryBitMask = BodyType.ground.rawValue
        self.physicsBody?.collisionBitMask = BodyType.player.rawValue | BodyType.ground.rawValue | BodyType.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.player.rawValue | BodyType.enemy.rawValue
        
    }
    
}
