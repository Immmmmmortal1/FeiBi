//
//  Image.swift
//  FeiBi
//
//  Created by shuxia on 2019/6/16.
//  Copyright © 2019 GM. All rights reserved.
//

import Foundation
extension Date{
    
    static func AddImageToView() -> Bool {
        let today = Date()
        let  dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd"
        let start = dateFormate.date(from: "2019-06-01")
        let end = dateFormate.date(from: "2019-06-20")
        if today.compare(start!) == ComparisonResult.orderedAscending {
            return true
        }
        if today.compare(end!) == ComparisonResult.orderedDescending {
            return true
        }
        return false
    }
    
}
