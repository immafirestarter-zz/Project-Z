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
    let jumpTexture = SKAction.setTexture(SKTexture(imageNamed: "zombie_jump"))
    let standTexture = SKAction.setTexture(SKTexture(imageNamed: "zombie_stand"))
    var jumpAction = SKAction()
    let halfStep = SKAction.setTexture(SKTexture(imageNamed: "zombie_walk1"))
    let fullStep = SKAction.setTexture(SKTexture(imageNamed: "zombie_walk2"))
    var isTouching = false
    var movingRight = false
    var movingLeft = false
    var xVelocity: CGFloat = 0
    var directionHandling: CGFloat = 1
    let textureArray = SKAction.animate(with: [
        SKTexture(imageNamed: "zombie_walk1"),
        SKTexture(imageNamed: "zombie_walk2")
        ], timePerFrame: 0.03)
    
    
    
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        print("ive moved here")
        jumpAction = SKAction.sequence([jumpTexture, jump, standTexture])
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let buttonJump = childNode(withName: "button") as! SKSpriteNode
        let player = childNode(withName: "zombie") as! SKSpriteNode
        let buttonLeft = childNode(withName: "leftButton") as! SKSpriteNode
        let buttonRight = childNode(withName: "rightButton") as! SKSpriteNode

        if buttonJump.contains(touchlocation) && player.physicsBody?.velocity.dy == 0 {
            player.run(jumpAction)
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
                xVelocity = 0
            }
        
    
            override func update(_ currentTime: TimeInterval) {
                let player = childNode(withName: "zombie") as! SKSpriteNode
                player.xScale = fabs(player.xScale) * directionHandling
                let rate: CGFloat = 0.5
                let playerVelocity = player.physicsBody?.velocity.dx
                let relativeVelocity: CGVector = CGVector(dx:xVelocity - playerVelocity!, dy: 0)
                
                if isTouching && movingRight && !player .hasActions() {
                    player.physicsBody?.velocity = CGVector(dx: playerVelocity! + relativeVelocity.dx*rate, dy: 0)
                    player.run(textureArray)
               
                } else if isTouching && movingLeft && !player .hasActions() {
                     player.physicsBody?.velocity = CGVector(dx: playerVelocity! + relativeVelocity.dx*rate, dy: 0)
                    player.run(textureArray)
                }
    }

}
