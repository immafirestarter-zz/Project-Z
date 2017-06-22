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
    var button:SKSpriteNode = SKSpriteNode()
    var leftButton:SKSpriteNode = SKSpriteNode()
    var rightButton:SKSpriteNode = SKSpriteNode()
    var theCamera:SKCameraNode = SKCameraNode()
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
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
        if (self.childNode(withName: "TheCamera") != nil){
            theCamera = self.childNode(withName: "TheCamera") as! SKCameraNode
            self.camera = theCamera
            
            
        }
        if (self.childNode(withName: "button") != nil){
            button = self.childNode(withName: "button") as! SKSpriteNode
            
        }
        if (self.childNode(withName: "leftButton") != nil){
            leftButton = self.childNode(withName: "leftButton") as! SKSpriteNode
            
        }
        if (self.childNode(withName: "rightButton") != nil){
            rightButton = self.childNode(withName: "rightButton") as! SKSpriteNode
            
        }
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
            print("im supposed to be jumping")
            thePlayer.jump()
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
                theCamera.position = CGPoint(x: thePlayer.position.x ,y: theCamera.position.y)
                button.position = CGPoint(x: thePlayer.position.x + 260 ,y: theCamera.position.y)
                leftButton.position = CGPoint(x: thePlayer.position.x - 280 ,y: theCamera.position.y)
                rightButton.position = CGPoint(x: thePlayer.position.x - 220 ,y: theCamera.position.y)
                
                thePlayer.xScale = fabs(thePlayer.xScale)*directionHandling
                
                if isTouching && movingRight && !thePlayer .hasActions(){
                    thePlayer.walk(moveVelocity:xVelocity)
                    
                } else if isTouching && movingLeft && !thePlayer .hasActions(){
                    thePlayer.walk(moveVelocity:xVelocity)
                    
                } else if !isTouching {
                   thePlayer.setUpIdle()
                }
       }

}


