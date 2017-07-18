//
//  LookArticleModel.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/15.
//
//

import DataBase
import MongoDB
import PerfectLib
import Common

public class LookArticleModel {

    public init() {
        
    }
    
    /// 生成文章列表
    public func articles() -> [Any] {
        var ary = [Any]()
        
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection
        
        /// 获取该集合下所有的信息
        let queryBson = BSON()
        queryBson.append(key: "isDelete", bool: false)
        let cursor = collection?.find(query: queryBson)
        
        while let c = cursor?.next() {
        
            let data = c.dict
            var thisPost = [String:String]()
            let temp = data["_id"] as? [String : String]
            if let dict = temp {
                thisPost["id"] = dict["$oid"]
            } else {
                thisPost["id"] = ""
            }
            
            if let type = data["type"] as? Int {
                thisPost["category"] = CategoryArticleModel().categoryTitle(type: type)
            } else {
                thisPost["category"] = CategoryArticleModel().categoryTitle(type: 0)
            }

            thisPost["createtime"] = data["createtime"] as? String
            thisPost["title"] = data["title"] as? String
            thisPost["content"] = data["content"] as? String
            
            ary.append(thisPost)
        }
        return ary
    }
    
}
