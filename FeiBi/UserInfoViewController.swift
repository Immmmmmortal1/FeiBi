//
//  UserInfoViewController.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/12.
//  Copyright © 2019 GM. All rights reserved.
//

import UIKit
import WebKit
class UserInfoViewController: UIViewController {

    var user = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = WKWebView.init(frame: view.bounds)
        
        view.addSubview(imageView)
        
        let imageUrl  = URL.init(string: user)
        
        let imageResource = URLRequest.init(url: imageUrl!)
        
        imageView.load(imageResource)
        
    }
    

   
    

}
