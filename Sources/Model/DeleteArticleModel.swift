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

public class DeleteArticleModel {

    public var total = 0
    
    public init() {
        
    }
    
    /// 删除文章
    public func deletes(_ deletes: [String]) -> String {
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection

        var updates: [(selector: BSON, update: BSON)] = []
        for id in deletes {
                let oldBson = BSON()
                  oldBson.append(key: "_id", oid: BSON.OID(id))
                let innerBson = BSON()
                innerBson.append(key: "isDelete", bool: true)
                 let newdBson = BSON()
                 newdBson.append(key: "$set", document: innerBson)
                 updates.append((selector: oldBson, update: newdBson))
        }
        
        let result:MongoResult = collection!.update(updates: updates)
        
        var response = [String:Any]()
        switch result {
        case .success:
            response["result"] = "success"
        default:
            response["result"] = "error"
        }
        
        db.close()
        
        return try! response.jsonEncodedString()
        
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
            total += 1
            let data = dictWithJSON(bson: c) as! [String : Any]

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
    
    /// 将BSON对象转换为字典
    private func dictWithJSON(bson: BSON) -> JSONConvertible {
        let json = bson.asString
        let jsonDict = try! json.jsonDecode()
        return jsonDict
    }
}
