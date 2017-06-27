//
//  Ground.swift
//  Test
//
//  Created by Ahmed Shehab on 27/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode {
    

    func setUpGround() {
        let objectSize = CGSize(width: self.texture!.size().width * 0.4, height: self.texture!.size().height * 0.4)
        let body:SKPhysicsBody = SKPhysicsBody(texture: self.texture!, size: objectSize)
        self.physicsBody = body
        body.isDynamic = true
        body.affectedByGravity = false
        body.allowsRotation = false
        body.restitution = 0
        body.categoryBitMask = BodyType.ground.rawValue
        body.collisionBitMask = 1
        body.contactTestBitMask = BodyType.player.rawValue
        body.usesPreciseCollisionDetection = true
    }
    
    
}
