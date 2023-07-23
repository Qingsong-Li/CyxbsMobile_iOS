//
//  JWZXSectionNews.swift
//  CyxbsMobile2019_iOS
//
//  Created by 李青松 on 2023/7/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

class JWZXSectionNews {
    // 页码
    private(set) var page: Int = 0
    
    // 当页的新闻
    private(set) var newsAry: [JWZXNew] = []
    
    static func request(withPage page: Int, success: @escaping (JWZXSectionNews?) -> Void, failure: @escaping (Error) -> Void) {
       
    }
}
