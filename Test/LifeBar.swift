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
    
        let objectSize = CGSize(width: self.texture!.size().width, height: self.texture!.size().height)
        self.size = objectSize
        
    }
    
    
    func updateBar(lifeWidth: CGFloat) {
        var newRatio = lifeWidth / 100
        var objectSize = CGSize(width: self.texture!.size().width * newRatio, height: self.texture!.size().height)
        self.size = objectSize
        
    }
    
}
