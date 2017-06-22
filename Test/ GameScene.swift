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
    
    var thePlayer:Player = Player()

    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    

    
    let jump = SKAction.moveBy(x: 0, y: 100, duration: 0.2)
    let jumpTexture = SKAction.setTexture(SKTexture(imageNamed: "zombie_jump"))
    var jumpAction = SKAction()

    var isTouching = false
    var movingRight = false
    var movingLeft = false
    var xVelocity: CGFloat = 0
    var directionHandling: CGFloat = 1
    
//    override func sceneDidLoad() {
//        
//    }
    
    override func didMove(to view: SKView) {
        if (self.childNode(withName: "Player") != nil){
            thePlayer = self.childNode(withName: "Player") as! Player
            thePlayer.setUpPlayer()
        }

        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.childNode(withName: "Player") != nil){
            thePlayer = self.childNode(withName: "Player") as! Player
        }

        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let buttonJump = childNode(withName: "button") as! SKSpriteNode
        let buttonLeft = childNode(withName: "leftButton") as! SKSpriteNode
        let buttonRight = childNode(withName: "rightButton") as! SKSpriteNode

        if buttonJump.contains(touchlocation) && thePlayer.physicsBody?.velocity.dy == 0 {
            thePlayer.run(jumpAction)
                    } else if buttonRight.contains(touchlocation){
                    print("right")
                        directionHandling = 1
                        isTouching = true
                        movingRight = true
                        xVelocity = 200
            
                    } else if buttonLeft.contains(touchlocation){
                    print("left")
                        directionHandling = -1
                        isTouching = true
                        movingLeft = true
                        xVelocity = -200
                    }
        }
        
            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                isTouching = false
                movingRight = false
                movingLeft = false
                thePlayer.stopMoving()
            }
        
    
            override func update(_ currentTime: TimeInterval) {
                thePlayer.xScale = fabs(thePlayer.xScale)*directionHandling
                
                if isTouching && movingRight && !thePlayer .hasActions(){
                    thePlayer.walk(moveVelocity:200)
                    
                } else if isTouching && movingLeft && !thePlayer .hasActions(){
                    thePlayer.walk(moveVelocity:-200)
                    
                } else if !isTouching {
                   thePlayer.setUpIdle()
                }
    }

}


