//
//  CategoryArticle.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/17.
//
//

import PerfectLib
import PerfectHTTP
import PerfectMustache
import MongoDB
import DataBase
import Model

public struct CategoryArticleHandler {

    /// 文章分类
    public static func category(req: HTTPRequest, res: HTTPResponse) -> String {
        let db = CategoryArticleModel()
        return db.find()
    }
    
}
