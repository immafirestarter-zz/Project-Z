//
//  GameScene.swift
//  Test
//
//  Created by Sami on 21/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let jump = SKAction.moveBy(x: 0, y: 50, duration: 0.2)
    let fallBack = SKAction.moveBy(x: 0, y: -50, duration: 0.2)
    let moveRight = SKAction.moveBy(x: 3, y: 0, duration: 0.1)
    let moveLeft = SKAction.moveBy(x: -3, y: 0, duration: 0.1)
    let jumpTexture = SKAction.setTexture(SKTexture(imageNamed: "Spaceship"))
    let standTexture = SKAction.setTexture(SKTexture(imageNamed: "Spaceship"))
    var jumpAction = SKAction()
    var isTouching = false
    var movingRight = false
    var movingLeft = false
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        print("ive moved here")
        jumpAction = SKAction.sequence([jump, jumpTexture, fallBack, standTexture])
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let buttonJump = childNode(withName: "button") as! SKSpriteNode
//        
//        let buttonLeft = childNode(withName: "leftButton") as! SKSpriteNode
//        let buttonRight = childNode(withName: "rightButton") as! SKSpriteNode
//        let player = childNode(withName: "Spaceship") as! SKSpriteNode
//        
        if buttonJump.contains(touchlocation){
            print("ive been touched")
                        let player = childNode(withName: "Spaceship") as! SKSpriteNode
                        player.run(jumpAction)
//        } else if buttonRight.contains(touchlocation){
//            isTouching = true
//            movingRight = true
//        } else if buttonLeft.contains(touchlocation){
//            isTouching = true
//            movingLeft = true
//        }
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isTouching = false
//        movingRight = false
//        movingLeft = false
//    }
//    
    
//    override func update(_ currentTime: TimeInterval) {
//        let player = childNode(withName: "Spaceship") as! SKSpriteNode
//        if isTouching && movingRight{
//            player.run(moveRight)
//        } else if isTouching && movingLeft{
//            player.run(moveLeft)
//        }
    }
}
