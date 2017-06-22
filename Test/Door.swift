//
//  Door.swift
//  Test
//
//  Created by Sami on 22/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Door: SKSpriteNode {
    
    var goesWhere:String = ""
    
    func setUpDoor() {
        
        goesWhere = self.name!
        
        self.physicsBody?.categoryBitMask = BodyType.door.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BodyType.player.rawValue
    }
    
}
