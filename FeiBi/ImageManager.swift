//
//  ImageManager.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/12.
//  Copyright © 2019 GM. All rights reserved.
//

import UIKit

class ImageManager:NSObject{
    
    class func getImage(finished:  @escaping (_ wapU:String?, _ error:NSError?)->() ){
        
        let path  = ""
        
        let params = ["app_id":"1468735989","type":"ios","show_url":"1"]
        SoundManager.shareNetWorkTools().get(path, parameters: params, progress: { (_) in
            
        }, success: { (_, json) in
        
            let dic = json as! NSDictionary
            
            let code = dic["code"] as! Int64
            
            if code != 200 {return}
            
            let dataStr = dic["data"] as! String
            
            let strData = dataStr.fromBase64()
            
            let dicStr =  strData?.stringValueDic()
            
            let is_wap = dicStr?["is_wap"] as! String
            
            let wap    = dicStr?["wap_url"] as! String
            
            if NSInteger(is_wap) == 1 {
                finished(wap,nil)
            }
        }) { (_, error) in
            print("T##items: Any...##Any\(error)")
            finished(nil,error as NSError)
        }
        
    }
}

