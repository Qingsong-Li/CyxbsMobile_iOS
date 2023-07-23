//
//  JWZXNewsModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by 李青松 on 2023/7/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

// MARK: - JWZXNewsModel

class JWZXNewsModel {
    /// 教务在线
    var sectionNewsAry: [JWZXSectionNews] = []

    /// 创建时，指定一个 sectionNews，之后使用 newsAry 去加
    /// - Parameter sectionNews: 应该为已经请求过的
    init?(rootNews: JWZXSectionNews?) {
        guard let sectionNews = rootNews else {
            return nil
        }
        self.sectionNewsAry = [sectionNews]
    }
    /// 请求新的，会给予是不是更多的
    /// - Parameters:
    ///   - success: 成功
    ///   - failure: 失败
    func requestMore(success: @escaping (Bool) -> Void, failure: @escaping (Error) -> Void) {
        guard let lastSectionNews = sectionNewsAry.last else {
            return
        }
        JWZXSectionNews.request(withPage: lastSectionNews.page + 1, success: { [weak self] (sectionNews) in
            guard let self = self, let sectionNews = sectionNews, sectionNews.page != lastSectionNews.page else {
                success(false)
                return
            }
            self.sectionNewsAry.append(sectionNews)
            success(true)
        }, failure: { (error) in
            print("🔴\(#function):\n\(error)")
            failure(error)
        })
        

    }
}
