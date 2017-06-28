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
        
        goesWhere = "EndGame"
        let imageTexture = SKTexture(imageNamed: "door")
        let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture,
                                               size: imageTexture.size())
        self.physicsBody = body
        
        body.isDynamic = true
        body.affectedByGravity = false
        body.allowsRotation = false
        
        body.categoryBitMask = BodyType.door.rawValue
        body.collisionBitMask = 0
        body.contactTestBitMask = BodyType.player.rawValue
        
    }
    
}
