//
//  StartScene.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/8.
//  Copyright © 2019 GM. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene,SKPhysicsContactDelegate {
    
    /*
     四个忍者一个接着一个显示
     
     飞镖乱飞
     
     */
    
    //:
    var Number :String!
    
 
    //:创建 1-4 的忍者 node
    var node1 :SKSpriteNode!
    var node2 :SKSpriteNode!
    var node3 :SKSpriteNode!
    var node4 :SKSpriteNode!
    var nodeEnter :SKSpriteNode!
    
    
    let placeNodeSize = CGSize(width: 100, height: 100)
    
    
    
    
    
    override func didMove(to view: SKView) {
        

        
        createBack()
        createNode1()
        createNode2()
        createNode3()
        createNode4()
        creahideANDshOW()
        
        createEnterNode()
        
        if Number != nil {
            numberLabel.position = CGPoint(x: view.frame.width/2, y: nodeEnter.position.y - 150)

            addChild(numberLabel)
        }
    }
    func createBack()  {
        let backNode = SKSpriteNode(texture: SKTexture(imageNamed: "startBack.jpg"),size: view!.bounds.size)
        
        backNode.anchorPoint = CGPoint(x: 0, y: 0)
        backNode.position = CGPoint(x: 0, y: 0)
        backNode.zPosition = -1
        addChild(backNode)
        
    }
    func createNode1() {
        node1 = SKSpriteNode(texture: SKTexture(imageNamed: "renzhe1"), size: placeNodeSize)
        node1.anchorPoint = CGPoint(x: 0, y: 0)
        node1.position = CGPoint(x:0, y:0)
        addChild(node1)
    }
    func createNode2() {
        node2 = SKSpriteNode(texture: SKTexture(imageNamed: "renzhe2"), size: placeNodeSize)
        node2.anchorPoint = CGPoint(x: 0, y: 0)
        node2.position = CGPoint(x: view!.frame.width - node2.size.width, y:0)
        node2.run(SKAction.hide())
        addChild(node2)
    }
    func createNode3() {
        node3 = SKSpriteNode(texture: SKTexture(imageNamed: "renzhe3"), size: placeNodeSize)
        node3.anchorPoint = CGPoint(x: 0, y: 0)
        node3.position = CGPoint(x: view!.frame.width - node2.size.width, y:view!.frame.height - node2.size.height)
        node3.run(SKAction.hide())
        addChild(node3)
    }
    func createNode4() {
        
        node4 = SKSpriteNode(texture: SKTexture(imageNamed: "renzhe4"), size: placeNodeSize)
        node4.anchorPoint = CGPoint(x: 0, y: 0)
        node4.position = CGPoint(x: 0, y:view!.frame.height - node2.size.height)
        node4.run(SKAction.hide())

        addChild(node4)
    }
    //:隐藏动作
    func creahideANDshOW()  {
        let waitNode1 = SKAction.wait(forDuration: 4)
        let hideNode1 = SKAction.hide()
        node1.run(SKAction.sequence([waitNode1,hideNode1])){
            self.node2.run(SKAction.unhide())
            self.createNode2Hide()
        }
    }
    func createNode2Hide()  {
        let waitNode2 = SKAction.wait(forDuration: 4)
        let hideNode2 = SKAction.hide()
        node2.run(SKAction.sequence([waitNode2,hideNode2])){
            self.node3.run(SKAction.unhide())
            self.createNode3Hide()
        }
    }
    func createNode3Hide()  {
        let waitNode3 = SKAction.wait(forDuration: 4)
        let hideNode3 = SKAction.hide()
        node3.run(SKAction.sequence([waitNode3,hideNode3])){
            self.node4.run(SKAction.unhide())
            self.createNode4Hide()
        }
    }
    func createNode4Hide()  {
        let waitNode4 = SKAction.wait(forDuration: 4)
        let hideNode4 = SKAction.hide()
        node4.run(SKAction.sequence([waitNode4,hideNode4])){
            self.node1.run(SKAction.unhide())
            self.creahideANDshOW()
        }
    }

    //:创建飞镖
    func createFB(postionNode:CGPoint)  {
        
        let nodeFB1 = SKSpriteNode(texture: SKTexture(imageNamed: "biao"), size: CGSize(width: 30, height: 30))
        nodeFB1.position = postionNode
        addChild(nodeFB1)
        
        self.creaMoveAction(moveNode: nodeFB1)

    }
    func createFB2(postionNode:CGPoint){
    let nodeFB2 = SKSpriteNode(texture: SKTexture(imageNamed: "biao"), size: CGSize(width: 30, height: 30))
    nodeFB2.position = postionNode
    addChild(nodeFB2)
    self.creaMoveAction2(moveNode: nodeFB2)

    }
    func createFB3(postionNode:CGPoint)  {

        let nodeFB3 = SKSpriteNode(texture: SKTexture(imageNamed: "biao"), size: CGSize(width: 30, height: 30))
        nodeFB3.position = postionNode
        addChild(nodeFB3)
        self.creaMoveAction3(moveNode: nodeFB3)
    }
    
    func createFB4(postionNode:CGPoint)  {
        
        let nodeFB4 = SKSpriteNode(texture: SKTexture(imageNamed: "biao"), size: CGSize(width: 30, height: 30))
        nodeFB4.position = postionNode
        addChild(nodeFB4)
        self.creaMoveAction4(moveNode: nodeFB4)
    }
    //:动作
    func creaMoveAction(moveNode:SKSpriteNode)  {
        let moveAcrion = SKAction.move(by: CGVector(dx: view!.frame.width, dy: -view!.frame.height), duration: 1)
        moveNode.run(moveAcrion){
            moveNode.removeFromParent()
        }
    }
    
    func creaMoveAction2(moveNode:SKSpriteNode)  {
        let moveAcrion = SKAction.move(by: CGVector(dx: view!.frame.width, dy: view!.frame.width), duration: 1)
        moveNode.run(moveAcrion){
            moveNode.removeFromParent()
        }
    }
    func creaMoveAction3(moveNode:SKSpriteNode)  {
        let moveAcrion = SKAction.move(by: CGVector(dx: -view!.frame.width, dy: view!.frame.height), duration: 1)
        moveNode.run(moveAcrion){
            moveNode.removeFromParent()
        }
    }
    func creaMoveAction4(moveNode:SKSpriteNode)  {
        
        let moveAcrion = SKAction.move(by: CGVector(dx: -view!.frame.width, dy: -view!.frame.width), duration: 1)
        moveNode.run(moveAcrion){
            moveNode.removeFromParent()
        }
    }
    //:进入 node
    func createEnterNode()  {
        nodeEnter = SKSpriteNode(texture: SKTexture(imageNamed: "biao"),size: CGSize(width: 100, height: 100))
        nodeEnter.position = CGPoint(x: view!.frame.width/2, y: view!.frame.height/2)
        addChild(nodeEnter)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        guard let touch = touches.first else {
            return
        }
        
        let tapLocation = touch.location(in: self)
        
        self.createFB(postionNode: tapLocation)
        self.createFB2(postionNode: tapLocation)
        self.createFB3(postionNode: tapLocation)
        self.createFB4(postionNode: tapLocation)
        
        if nodeEnter.contains(tapLocation) {
            let scene = GameScene(size: view!.bounds.size)
            self.view!.presentScene(scene)
        }

    }
    
    lazy var numberLabel:SKLabelNode = {
        let OverLable = SKLabelNode(fontNamed: "Chalkduster")
        OverLable.text = "得分:\(Number ?? "0")"
        
        return OverLable
    }()
    
    override func update(_ currentTime: TimeInterval) {
     
        
    }
}
/*
 笔记:
 
 1.SKAction.repeatForever(<#T##action: SKAction##SKAction#>) 一直在执行 不会 执行完  所以也就不会 执行 complete
 
 */
