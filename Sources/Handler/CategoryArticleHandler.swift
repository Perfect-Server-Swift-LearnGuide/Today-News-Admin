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

public class CategoryArticleHandler {

    public init() {}
    
    public func category() -> RequestHandler  {
        return { request, response in
            
            let db = CategoryArticleModel()
            response.appendBody(string: db.find())
            
            response.completed()
        }
    }
    
}
