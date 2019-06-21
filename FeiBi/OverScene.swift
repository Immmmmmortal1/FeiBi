//
//  OverScene.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/11.
//  Copyright © 2019 GM. All rights reserved.
//

import SpriteKit
import GameplayKit

class OverScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        createEnterNode()
    }
    
    //:进入 node
    func createEnterNode()  {
       let backNode = SKSpriteNode(texture: SKTexture(imageNamed: "startBack.jpg"),size: CGSize(width: 100, height: 100))
        backNode.position = CGPoint(x: view!.frame.width/2, y: view!.frame.height/2)
        addChild(backNode)
    }
}
