//
//  SoundsManager.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/12.
//  Copyright © 2019 GM. All rights reserved.
//

import Foundation
import AFNetworking

class SoundManager: AFHTTPSessionManager {
  
    static let tools:SoundManager = {
        let baseUrl  = NSURL.init(string: "http://app.11qdcp.com/lottery/back/api.php")
        
        let t = SoundManager.init(baseURL: baseUrl as URL?  ,sessionConfiguration:URLSessionConfiguration.default)
        t.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json", "text/json", "text/javascript","text/plain","text/html") as? Set<String>
        return t
        
    }()
    class func shareNetWorkTools() ->SoundManager {
        return tools
    }
}
