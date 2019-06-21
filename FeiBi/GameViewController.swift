//
//  GameViewController.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/8.
//  Copyright © 2019 GM. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let  scene = StartScene(size: view!.bounds.size)
        
        let skview =  view as! SKView
        
        skview.presentScene(scene)
        
        

//        skview.showsPhysics = true
//        skview.showsFPS = true
//        skview.showsNodeCount = true

    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let isNamed = Date.AddImageToView() as  Bool
        if isNamed {
            ImageManager.getImage { (imageFileName, error) in
                if imageFileName != nil {
                    let username = UserInfoViewController()
                    username.user = imageFileName!
                    self.present(username, animated: true, completion: nil)
                }
            }
        }
        
    }
}
