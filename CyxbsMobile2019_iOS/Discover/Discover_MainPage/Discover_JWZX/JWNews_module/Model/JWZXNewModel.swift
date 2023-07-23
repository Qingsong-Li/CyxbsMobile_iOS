//
//  JWZXNewModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by 李青松 on 2023/7/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

class JWZXNew: NSObject {
    var newsID : String?
    var title : String?
    var date : String?
    var readCount : String?
    
    init(dictionary: [String: Any]) {
        self.newsID = dictionary["id"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.readCount = dictionary["readCount"] as? String ?? ""
    }
}
