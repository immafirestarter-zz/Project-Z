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
    case key = 4
    case enemy = 8
    case weapon = 16
    case projectile = 32
    case healthPack = 64
    case ground = 128
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    static let enemyHitCategory = 1
    var force:CGFloat = 16.0
    var thePlayer:Player = Player()
    var theKey:Key = Key()
    var theWeapon:Weapon = Weapon()
    var enemies = [Enemy]()
    var theLifeBar:LifeBar = LifeBar()
    var theHealthPack:HealthPack = HealthPack()
    var button:SKSpriteNode = SKSpriteNode()
    var shootButton: SKSpriteNode = SKSpriteNode()
    var leftButton:SKSpriteNode = SKSpriteNode()
    var rightButton:SKSpriteNode = SKSpriteNode()
    var theCamera:SKCameraNode = SKCameraNode()
    var playerJump = false

    var knife_count:SKLabelNode = SKLabelNode()

//    var theGround:Ground = Ground()
    
    
    
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
    var backgroundMusic: SKAudioNode!
    
    
    
    
    override func didMove(to view: SKView) {
        
        audio()
        
        
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
        
        if (self.childNode(withName: "shootButton") != nil){
            shootButton = self.childNode(withName: "shootButton") as! SKSpriteNode
        }
        
        if (self.childNode(withName: "leftButton") != nil){
            leftButton = self.childNode(withName: "leftButton") as! SKSpriteNode
        }
        
        if (self.childNode(withName: "rightButton") != nil){
            rightButton = self.childNode(withName: "rightButton") as! SKSpriteNode
        }
        
        if (self.childNode(withName: "Key") != nil) {
            theKey = self.childNode(withName: "Key") as! Key
            theKey.setUpKey()
        }
        if (self.childNode(withName: "lifeBar") != nil) {
            theLifeBar = self.childNode(withName: "lifeBar") as! LifeBar
            theLifeBar.setUp()
        }
        
        if (self.childNode(withName: "health")) != nil {
            theHealthPack = self.childNode(withName: "health") as! HealthPack
            theHealthPack.setUp()
        }
        
        if (self.childNode(withName: "Weapon") != nil) {
            theWeapon = self.childNode(withName: "Weapon") as! Weapon
            theWeapon.setUpWeapon()
        }
        
        if (self.childNode(withName: "Weapon2") != nil) {
            theWeapon = self.childNode(withName: "Weapon2") as! Weapon
            theWeapon.setUpWeapon()
        }
        

        if (self.childNode(withName: "knife_count") != nil) {
            knife_count = self.childNode(withName: "knife_count") as! SKLabelNode
        }
        
        

        
        for node in self.children {
            if let theDoor:Door = node as? Door {
                theDoor.setUpDoor()
            }
            if let theGround:Ground = node as? Ground {
                theGround.setUpGround()
            }
        }
        
        let wait = SKAction.wait(forDuration: 10)
        let spawn = SKAction.run {
            let theEnemy:Enemy = Enemy()
            theEnemy.xScale = fabs(theEnemy.xScale) * -1
            theEnemy.position = CGPoint(x: 300, y: 10)
            self.addChild(theEnemy)
            self.enemies.append(theEnemy)
            print(self.enemies.count)
            print(theEnemy.health)
        }
        let constantSpawn = SKAction.sequence([spawn, wait])
        self.run(SKAction.repeatForever(constantSpawn))
        
        
    }
    
    func audio() {
        let audioNode = SKAudioNode(fileNamed: "oshi.mp3")
        audioNode.autoplayLooped = false
        self.addChild(audioNode)
        let playAction = SKAction.play()
        audioNode.run(playAction)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let xPushedByEnemy = 100
        let yPushedByEnemy = 200
        
        if ( contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.door.rawValue && thePlayer.hasKey) {
            if let theDoor = contact.bodyB.node as? Door {
                loadAnotherLevel (levelName: theDoor.goesWhere)
            }
            
        } else if ( contact.bodyA.categoryBitMask == BodyType.door.rawValue && contact.bodyB.categoryBitMask == BodyType.player.rawValue && thePlayer.hasKey)  {
            if let theDoor = contact.bodyA.node as? Door {
                loadAnotherLevel (levelName: theDoor.goesWhere)
            }
            
        }
        
        if (contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.enemy.rawValue){
            
            if let theBody = contact.bodyB.node as? Enemy {
                theBody.attacking = true
                thePlayer.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
                if thePlayer.position.y > (theBody.position.y + theBody.size.height/2) {
                    thePlayer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: yPushedByEnemy))
                    theBody.health = 0
                } else {
                    
                    if thePlayer.position.x > theBody.position.x {
                        thePlayer.physicsBody?.applyImpulse(CGVector(dx: xPushedByEnemy, dy:yPushedByEnemy))
                    } else if thePlayer.position.x < theBody.position.x {
                        thePlayer.physicsBody?.applyImpulse(CGVector(dx: -xPushedByEnemy, dy:yPushedByEnemy))
                    }
                    theBody.attacking = false
                    
                    if (theBody.hasHit == false) {
                        thePlayer.health -= 25
                        theBody.delayHit()
                        print(thePlayer.health)
                        theLifeBar.updateBar(lifeWidth: CGFloat(thePlayer.health))
                    }
                }
            }
        } else if (contact.bodyA.categoryBitMask == BodyType.enemy.rawValue && contact.bodyB.categoryBitMask == BodyType.player.rawValue){
            
            if let theBody = contact.bodyA.node as? Enemy {
                theBody.attacking = true
                thePlayer.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
                if thePlayer.position.y > (theBody.position.y + theBody.size.height/2) {
                    thePlayer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: yPushedByEnemy))
                    theBody.health = 0
                } else {
                    
                    if thePlayer.position.x > theBody.position.x {
                        thePlayer.physicsBody?.applyImpulse(CGVector(dx: xPushedByEnemy, dy:yPushedByEnemy))
                    } else if thePlayer.position.x < theBody.position.x {
                        thePlayer.physicsBody?.applyImpulse(CGVector(dx: -xPushedByEnemy, dy:yPushedByEnemy))
                    }
                    theBody.attacking = false
                    if (theBody.hasHit == false) {
                        thePlayer.health -= 25
                        theBody.delayHit()
                        print(thePlayer.health)
                        theLifeBar.updateBar(lifeWidth: CGFloat(thePlayer.health))
                    }
                }
            }
        }
        
        if ( contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.healthPack.rawValue) {
            if (thePlayer.health < 100) {
                thePlayer.health += 25
                theHealthPack.removeFromParent()
                theLifeBar.updateBar(lifeWidth: CGFloat(thePlayer.health))
            }
        }
        
        if ( contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.key.rawValue) {
            thePlayer.hasKey = true
            print(thePlayer.hasKey)
            run(SKAction.playSoundFileNamed("key1.wav", waitForCompletion: false))
        }
        
        if ( contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.weapon.rawValue) {
            run(SKAction.playSoundFileNamed("bombpick.wav", waitForCompletion: false))
            if let theWeapon = contact.bodyB.node as? Weapon {
                if theWeapon.pickedUp == false {
                    theWeapon.pickedUp = true
                    theWeapon.removeFromParent()
                    thePlayer.hasWeapon = true
                    thePlayer.weaponCount += 3
                }
            }
        }
        
        if ( contact.bodyA.categoryBitMask == BodyType.ground.rawValue && contact.bodyB.categoryBitMask == BodyType.player.rawValue) {
            playerJump = false
            print("im colliding with the floor")
            
        } else if ( contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.ground.rawValue) {
            playerJump = false
            print("im colliding with the ground")
        }
        
        
        
        if ( contact.bodyB.categoryBitMask == BodyType.projectile.rawValue) {
            if let theProjectile = contact.bodyB.node as? Projectile, let theEnemy = contact.bodyA.node as? Enemy {
                if theProjectile.hit == false {
                    theEnemy.health -= 100
                    theProjectile.hit = true
                    theProjectile.removeFromParent()
                }
            } else if ( contact.bodyA.categoryBitMask == BodyType.projectile.rawValue){
                if let theEnemy = contact.bodyB.node as? Enemy, let theProjectile = contact.bodyA.node as? Projectile {
                    if theProjectile.hit == false {
                        theEnemy.health -= 100
                        theProjectile.hit = true
                        theProjectile.removeFromParent()
                    }
                }
            }
        }
    }
    
    
    func loadAnotherLevel( levelName:String) {
        if let scene = GameScene(fileNamed: levelName) {
            self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.1))
            
        }
    }
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let buttonJump = childNode(withName: "button") as! SKSpriteNode
        let buttonLeft = childNode(withName: "leftButton") as! SKSpriteNode
        let buttonRight = childNode(withName: "rightButton") as! SKSpriteNode
        
        if buttonJump.contains(touchlocation) && thePlayer.physicsBody?.velocity.dy == 0.0  {
            playerJump = true
            thePlayer.jump()
            
        } else if buttonRight.contains(touchlocation) {
            directionHandling = 1
            isTouching = true
            movingRight = true
            xVelocity = 5555
            
        } else if buttonLeft.contains(touchlocation){
            directionHandling = -1
            isTouching = true
            movingLeft = true
            xVelocity = -5555
        
        } else if shootButton.contains(touchlocation){
            if thePlayer.hasWeapon {
                thePlayer.weaponCount -= 1
                Projectile.spawnProjectile(player: thePlayer, parent: self )
                print("im shooting stuff")
                print(thePlayer.xScale)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = false
        movingRight = false
        movingLeft = false
        xVelocity = 0
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        knife_count.text = String(thePlayer.weaponCount)
        
        for (index, enemy) in enemies.enumerated() {
            if enemy.position.y < -100 {
                enemy.removeFromParent()
                enemies.remove(at: index)
            } else if !enemy .hasActions() && enemy.attacking == false{
                enemy.enemyWalk()
            } else if enemy.attacking == true && !enemy .hasActions() {
                enemy.attack()
            } else if enemy.health <= 0 {
                enemy.removeFromParent()
                enemies.remove(at: index)
            }
        }
        
        if theCamera.position.y > -150 {
            
            theCamera.position = CGPoint(x: thePlayer.position.x ,y: thePlayer.position.y)
            button.position = CGPoint(x: thePlayer.position.x + 260 ,y: thePlayer.position.y)
            shootButton.position = CGPoint(x: thePlayer.position.x + 180 ,y: theCamera.position.y)
            leftButton.position = CGPoint(x: thePlayer.position.x - 280 ,y: thePlayer.position.y)
            rightButton.position = CGPoint(x: thePlayer.position.x - 220 ,y: thePlayer.position.y)
            theLifeBar.position = CGPoint(x: thePlayer.position.x - 320 ,y: theCamera.position.y + 150)
            knife_count.position = CGPoint(x: thePlayer.position.x - 130 ,y: theCamera.position.y + 145)
            
        }
        
        if playerJump == false {
            thePlayer.setUpIdle()
        }
    
        thePlayer.statusCheck()
        if thePlayer.isDead {
            restartLevel()
        }
        
        if thePlayer.hasKey {
            theKey.removeFromParent()
        }
        
        thePlayer.xScale = fabs(thePlayer.xScale)*directionHandling
        
        if isTouching && movingRight && !thePlayer .hasActions(){
            thePlayer.walk(force: xVelocity)
         
        } else if isTouching && movingLeft && !thePlayer .hasActions(){
            thePlayer.walk(force: xVelocity)
            
        }
    }
    
    
    func restartLevel() {
        loadAnotherLevel (levelName: "EndPage")
        
    }
}



