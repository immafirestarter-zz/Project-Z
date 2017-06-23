//
//  GameScene.swift
//  Test
//
//  Created by Sami on 21/06/2017.
//  Copyright © 2017 Sami. All rights reserved.
//
import SpriteKit
import GameplayKit

enum BodyType:UInt32 {
    case player = 1
    case door = 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var thePlayer:Player = Player()
    var theEnemy = Enemy()
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
    
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
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
        
        for node in self.children {
            if let theDoor:Door = node as? Door {
                theDoor.setUpDoor()
            }
        }
        theEnemy.position = CGPoint(x: 10, y: 0)
        self.addChild(theEnemy)
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if ( contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.door.rawValue) {
            if let theDoor = contact.bodyB.node as? Door {
                loadAnotherLevel (levelName: theDoor.goesWhere)
            }
            
        } else if ( contact.bodyA.categoryBitMask == BodyType.door.rawValue && contact.bodyB.categoryBitMask == BodyType.player.rawValue) {
            if let theDoor = contact.bodyA.node as? Door {
                loadAnotherLevel (levelName: theDoor.goesWhere)
            }
        }
        
    }
    
    
    func loadAnotherLevel( levelName:String) {
        if let scene = GameScene(fileNamed: levelName) {
            self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.1))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let buttonJump = childNode(withName: "button") as! SKSpriteNode
        let buttonLeft = childNode(withName: "leftButton") as! SKSpriteNode
        let buttonRight = childNode(withName: "rightButton") as! SKSpriteNode
        let velocityCheck: CGFloat = -20.0
        
        if movingRight == true && buttonJump.contains(touchlocation){
            thePlayer.jumpDirectionally(directionForce: 200)
            
        } else if movingLeft == true && buttonJump.contains(touchlocation){
            thePlayer.jumpDirectionally(directionForce: -200)
            
        } else if buttonJump.contains(touchlocation) && (thePlayer.physicsBody?.velocity.dy)! >= velocityCheck  {
            thePlayer.jump()
            
        } else if buttonRight.contains(touchlocation){
            directionHandling = 1
            isTouching = true
            movingRight = true
            xVelocity = 200
            
        } else if buttonLeft.contains(touchlocation){
            directionHandling = -1
            isTouching = true
            movingLeft = true
            xVelocity = -200
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        thePlayer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -100))
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
        
                      
        if theCamera.position.y > -150 {
                
        theCamera.position = CGPoint(x: thePlayer.position.x ,y: thePlayer.position.y)
        button.position = CGPoint(x: thePlayer.position.x + 260 ,y: thePlayer.position.y)
        leftButton.position = CGPoint(x: thePlayer.position.x - 280 ,y: thePlayer.position.y)
        rightButton.position = CGPoint(x: thePlayer.position.x - 220 ,y: thePlayer.position.y)
        }
      
        if (thePlayer.position.y < -200){
            thePlayer.isDead = true
        }
        

        if thePlayer.isDead {
            restartLevel()
        }
        
        thePlayer.xScale = fabs(thePlayer.xScale)*directionHandling
        
        if isTouching && movingRight && !thePlayer .hasActions(){
            thePlayer.walk(moveVelocity:xVelocity)
            
        } else if isTouching && movingLeft && !thePlayer .hasActions(){
            thePlayer.walk(moveVelocity:xVelocity)
            
        } else if !isTouching {
            thePlayer.setUpIdle()
        }
    }
    

    func restartLevel(){
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs

                
                sceneNode.scaleMode = .aspectFill
                
                if let view = self.view as! SKView? {
                    let transition = SKTransition.fade(withDuration: 1.0)
                    view.presentScene(sceneNode, transition: transition)
                    
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
}



