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
    let moveRight = SKAction.moveBy(x: 3, y: 0, duration: 0.1)
    let moveLeft = SKAction.moveBy(x: -3, y: 0, duration: 0.1)
    let jumpTexture = SKAction.setTexture(SKTexture(imageNamed: "zombie_jump"))
    let standTexture = SKAction.setTexture(SKTexture(imageNamed: "zombie_stand"))
    let halfStep = SKAction.setTexture(SKTexture(imageNamed: "zombie_walk1"))
    let fullStep = SKAction.setTexture(SKTexture(imageNamed: "zombie_walk2"))
    var jumpAction = SKAction()
    var walkAction = SKAction()
    var walkForever = SKAction()
    var isTouching = false
    var movingRight = false
    var movingLeft = false
    var animatedWalkRight = SKAction()
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        if (self.childNode(withName: "Player") != nil){
            thePlayer = self.childNode(withName: "Player") as! Player
            thePlayer.setUpPlayer()
        }
        jumpAction = SKAction.sequence([jumpTexture, jump, standTexture])
        walkAction = SKAction.sequence([halfStep, fullStep, moveRight])
        walkForever = SKAction.repeatForever(walkAction)
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

        if buttonJump.contains(touchlocation) {
            print("ive been touched")
            print(thePlayer.physicsBody?.velocity.dy)
            thePlayer.run(jumpAction)
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
                if (self.childNode(withName: "Player") != nil){
                    thePlayer = self.childNode(withName: "Player") as! Player

                
                }
                if isTouching && movingRight{
                    thePlayer.run(walkForever)
                    
                    
                    
                } else if isTouching && movingLeft{
                    thePlayer.run(moveLeft)
                }
    }

}


