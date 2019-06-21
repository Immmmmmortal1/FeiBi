//
//  GameScene.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/8.
//  Copyright © 2019 GM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    let npcName = "ballonNode"
    let moveFeiBiao = "moveFBNode"
    let npcNameD = "npcNameD"

    var FBNode :SKSpriteNode!
    var trailNode : SKNode!
    
    
    //:创建物理体标识
    let FeiBiao :UInt32 = 0x1 << 0
    let qiqiu :UInt32 = 0x1 << 1
    let qiqiuDeath :UInt32 = 0x1 << 2

    //:移动速度
    var balloonSpeed = CGFloat(1)
    //:击杀个数
    var  killNum     = CGFloat(0)
    //:最大速度
    var  FBspeed     = CGFloat(20)
    
    
    
    
    //w 1024  h 1535
    override func didMove(to view: SKView) {
        
        //:设置物理场
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        
        

        createBack()
        
        createMoveActioForBalloon()
        createFB()
        
        //:添加粒子效果
        trailNode = SKNode()
        trailNode.zPosition = 0
        //trailNode.name = "trail"
        addChild(trailNode)
    }
    func createBack()  {
        
        let backNode = SKSpriteNode(texture: SKTexture(imageNamed: "tianye"), size: CGSize(width: view!.frame.width, height:view!.frame.height ))
        backNode.anchorPoint = CGPoint(x: 0, y: 0)
        backNode.zPosition  = -1;
        backNode.position = CGPoint(x: 0, y: 0)
        addChild(backNode)

        
    }
    //创建移动的气球 屏幕外面
    func createMoveBalloon() {
        let ballonNode = SKSpriteNode(texture: SKTexture(imageNamed: "balloon"), size: CGSize(width: 120, height: 120))
        ballonNode.zPosition  = 1;
        ballonNode.name = npcName
        //:保证创建的气球在屏幕外面
        ballonNode.position = CGPoint(x: view!.frame.width + ballonNode.size.width/2, y:280)
        addChild(ballonNode)
        //:创建气球的物理实体 SKPhysicsBody(texture: ballonNode.texture!, size: ballonNode.size)
        ballonNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30), center: CGPoint(x: 0, y: 30))
        ballonNode.physicsBody?.isDynamic = true
        ballonNode.physicsBody?.categoryBitMask    =  qiqiu
//        ballonNode.physicsBody?.contactTestBitMask =  FeiBiao
    }
    func createMoveDeathBalloon() {
        let ballonNode = SKSpriteNode(texture: SKTexture(imageNamed: "death"), size: CGSize(width: 100, height: 150))
        ballonNode.zPosition  = 1;
        ballonNode.name = npcNameD
        //:保证创建的气球在屏幕外面
        ballonNode.position = CGPoint(x: view!.frame.width + ballonNode.size.width/2, y:280)
        addChild(ballonNode)
        //:创建气球的物理实体 SKPhysicsBody(texture: ballonNode.texture!, size: ballonNode.size)
        ballonNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30), center: CGPoint(x: 0, y: 30))
        ballonNode.physicsBody?.isDynamic = true
        ballonNode.physicsBody?.categoryBitMask    =  qiqiuDeath
//        ballonNode.physicsBody?.contactTestBitMask =  FeiBiao
    }
    
    func createMoveActioForBalloon() {
        //:一秒创建一个
        let waitActio = SKAction.wait(forDuration: 2)
        //:创建气球
        let createAction = SKAction.run {
            print("只是多少:\(Int(self.killNum) % 8)")
            if Int(self.killNum) % 4 == 1{
                self.createMoveDeathBalloon()
                self.killNum += 1
            }else{
                self.createMoveBalloon()
            }

        }
        run(SKAction.repeatForever(SKAction.sequence([waitActio,createAction])))
    }
    
   
    
    
    //:创建飞镖
    func createFB()  {
        FBNode = SKSpriteNode(texture: SKTexture(imageNamed: "biao2"), size: CGSize(width: 60, height: 60))
        
        FBNode.position   = CGPoint(x: view!.frame.width/2, y: FBNode.size.height/2)
        addChild(FBNode)
        createRotationAction(playNode: FBNode)
    }
    //:创建旋转动作
    func createRotationAction(playNode:SKSpriteNode)  {
        //SKAction.rotate(toAngle: CGFloat(Double.pi ), duration: 1)
        let rorateLeftAction = SKAction.rotate(byAngle: -CGFloat(Double.pi / 4), duration: 0.1)
        
       
        playNode.run(SKAction.repeatForever(rorateLeftAction))

    }
    //:点击动作
    
    func createMoveFeibiao()  {
        
        //:创建移动的飞镖
        let moveFBNode = SKSpriteNode(texture: SKTexture(imageNamed: "biao"), size: CGSize(width: 30, height: 30))
        moveFBNode.position =  CGPoint(x: view!.frame.width/2, y: FBNode.size.height/2)
        moveFBNode.name = moveFeiBiao
      

        addChild(moveFBNode)
        //:创建物理实体
        moveFBNode.physicsBody = SKPhysicsBody(texture: moveFBNode.texture!, size: moveFBNode.size)

        moveFBNode.physicsBody?.isDynamic = true

        moveFBNode.physicsBody?.categoryBitMask    = FeiBiao
        moveFBNode.physicsBody?.contactTestBitMask = qiqiu | qiqiuDeath
   

        let emitterNode = SKEmitterNode(fileNamed: "ShootTrailBlue")! // particles文件夹存放粒子效果
        emitterNode.targetNode = trailNode  // 设置粒子效果的目标为trailNode => 跟随新建的trailNode
        moveFBNode.addChild(emitterNode)    // 在子弹节点Node加上粒子效果;
//        :创建移动动作
       
        if killNum <= 5 {
            FBspeed = 1.5
        }else if killNum < 15 && killNum > 5 {
            FBspeed = 1
        }else{
           FBspeed = 0.5
        }
        let rotateAction = SKAction.rotate(byAngle: -CGFloat(Double.pi / 4), duration: 0.01)
        let moveAction = SKAction.move(to: CGPoint(x: view!.frame.width/2, y: view!.frame.height + moveFBNode.size.height/2), duration: TimeInterval(FBspeed))
        
        

        moveFBNode.run(SKAction.repeatForever(rotateAction))
        moveFBNode.run(moveAction){
            moveFBNode.removeAllChildren()
            moveFBNode.removeFromParent()

        }

        
        
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)

        if FBNode .contains(touchLocation){
            self.createMoveFeibiao()
        }

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        

        /*这样写 是有判断作用的  不能直接 获取node
         例如:
         nodeA = contact.bodyA.node! as SKSpritNode  这样写会有时为空  就会崩溃
         
         */
        let bodyA:SKPhysicsBody
        let bodyB:SKPhysicsBody
        
       
        
        
        
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyA = contact.bodyA
            bodyB = contact.bodyB
        }else{
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        if contact.bodyA.categoryBitMask == qiqiuDeath || contact.bodyB.categoryBitMask == qiqiuDeath {
            
//            let overScene = StartScene(size: view?.bounds.size)
//            overScene.Number = String.init(format:"%.0f",self.killNum)
//            view!.presentScene(overScene)
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(0.5))
            let loseScene = StartScene(size: self.size)
            loseScene.size = self.size
            loseScene.scaleMode = .aspectFill
            loseScene.Number = String.init(format:"%.0f",self.killNum)
            self.view?.presentScene(loseScene, transition: reveal)
            return;
        }
        let explosion = SKEmitterNode(fileNamed: "CollectNormal")!
        explosion.position = bodyA.node!.position
        self.addChild(explosion)
        explosion.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.run {
                explosion.removeFromParent()
            }]))
        
        let coinAction = SKAction.playSoundFileNamed("explosion", waitForCompletion: false)
        run(coinAction)
        
        bodyA.node?.removeAllChildren()
        bodyA.node?.removeFromParent()
        bodyB.node?.removeAllChildren()
        bodyB.node?.removeFromParent()
        
        killNum += 1
    }
  
    
    //:移动气球
    func moveBalloon()  {
       
        
        if killNum <= 5 {
            balloonSpeed = 1
        }else if killNum < 15 && killNum > 5 {
            balloonSpeed = 4
        }else{
            balloonSpeed = 6
        }
        
        for npcNode in children where npcNode.name == npcName {
            if let ballNode = npcNode as? SKSpriteNode{
                ballNode.position = CGPoint(x: ballNode.position.x - balloonSpeed, y: ballNode.position.y)
                
                if ballNode.position.x < -ballNode.size.width/2 {
                    ballNode.removeFromParent()
                }
            }
        }
        for npcNode in children where npcNode.name == npcNameD {
            if let ballNode = npcNode as? SKSpriteNode{
                ballNode.position = CGPoint(x: ballNode.position.x - balloonSpeed, y: ballNode.position.y)
                
                if ballNode.position.x < -ballNode.size.width/2 {
                    ballNode.removeFromParent()
                }
            }
        }
        
        
 
        
    }
    override func update(_ currentTime: TimeInterval) {
        
        moveBalloon()
    }
}
