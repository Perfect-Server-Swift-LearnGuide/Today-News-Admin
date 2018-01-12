//
//  LookArticleModel.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/15.
//
//

import DataBase
import PerfectMongoDB
import PerfectLib
import Common

public class LookArticleModel {

    /// dataList
    public var dataList = [Any]()
    
    /// dartabase
    var db: DB
    
    /// colllection
    var collection: MongoCollection?
    
    public init() {
        db = DB(db: "today_news").collection(name: "article")
        collection =  db.collection
    }
    
    /// 生成文章列表
    public func articles(page: Int) -> String {

        /// 获取该集合下所有的信息
        let queryBson = BSON()
        queryBson.append(key: "isDelete", bool: false)
        let limit = 6
        let skip = limit * (page - 1)
        let cursor = collection?.find(query: queryBson, fields: nil, flags: MongoQueryFlag.none, skip: skip, limit: limit, batchSize: 0)

        while let c = cursor?.next() {
            
            let data = c.dict

            var thisPost = [String:Any]()
            let temp = data["_id"] as? [String : Any]
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

            self.dataList.append(thisPost)
        }
        
        var response = [String:Any]()
        response["total"] = total(queryBson)
        response["result"] = self.dataList

        return try! response.jsonEncodedString()
    }
    
    /// get total num
    public func total(_ bson: BSON) -> Int {
        let result: MongoResult = collection!.count(query: bson)
        switch result {
        case .replyInt(let total):
            return total
        default:
            return 0
        }
    }
    
}
