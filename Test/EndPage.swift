//
//  EndPage.swift
//  Test
//
//  Created by Sami on 25/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EndPage: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var endButton:SKSpriteNode = SKSpriteNode()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let buttonEnd = childNode(withName: "end") as! SKSpriteNode
        if buttonEnd.contains(touchlocation){
            loadAnotherLevel (levelName: "GameScene")
        }
    }
    
    func loadAnotherLevel( levelName:String) {
        if let scene = EndPage(fileNamed: levelName) {
            self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 2))
        }
    }
}
