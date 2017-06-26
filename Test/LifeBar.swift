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
    
    
    func setUp() {
        let objectSize = CGSize(width: self.texture!.size().width / 2, height: self.texture!.size().height / 2)
        self.size = objectSize
    }
    
    func updateBar(lifeWidth: CGFloat) {
        let newRatio = lifeWidth / 100
        let objectSize = CGSize(width: self.texture!.size().width / 2  * newRatio, height: self.texture!.size().height / 2)
        self.size = objectSize
    }
}
