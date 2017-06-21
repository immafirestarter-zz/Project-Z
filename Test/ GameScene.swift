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
    
    let jump = SKAction.moveBy(x: 0, y: 100, duration: 0.2)
    let moveRight = SKAction.moveBy(x: 3, y: 0, duration: 0.1)
    let moveLeft = SKAction.moveBy(x: -3, y: 0, duration: 0.1)
    let jumpTexture = SKAction.setTexture(SKTexture(imageNamed: "zombie_jump"))
    let standTexture = SKAction.setTexture(SKTexture(imageNamed: "zombie_stand"))
    var jumpAction = SKAction()
    let halfStep = SKAction.setTexture(SKTexture(imageNamed: "zombie_walk1"))
    let fullStep = SKAction.setTexture(SKTexture(imageNamed: "zombie_walk2"))
    var walkAction = SKAction()
    var isTouching = false
    var movingRight = false
    var movingLeft = false
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        print("ive moved here")
        jumpAction = SKAction.sequence([jumpTexture, jump, standTexture])
        walkAction = SKAction.sequence([halfStep, fullStep])
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        //        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let buttonJump = childNode(withName: "button") as! SKSpriteNode
        let player = childNode(withName: "zombie") as! SKSpriteNode
        let buttonLeft = childNode(withName: "leftButton") as! SKSpriteNode
        let buttonRight = childNode(withName: "rightButton") as! SKSpriteNode

        if buttonJump.contains(touchlocation) && player.physicsBody?.velocity.dy == 0 {
            print("ive been touched")
            print(player.physicsBody?.velocity.dy)
            player.run(jumpAction)
                    } else if buttonRight.contains(touchlocation){
                    print("right")
                        isTouching = true
                        movingRight = true
                    } else if buttonLeft.contains(touchlocation){
                    print("left")
                        isTouching = true
                        movingLeft = true
                    }
        }
        
            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                isTouching = false
                movingRight = false
                movingLeft = false
            }
        
    
            override func update(_ currentTime: TimeInterval) {
                let player = childNode(withName: "zombie") as! SKSpriteNode
                if isTouching && movingRight{
                    player.run(moveRight)
                    player.run(walkAction)
                    
                } else if isTouching && movingLeft{
                    player.run(moveLeft)
                }
    }

}
