//
//  CategoryArticleModel.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/17.
//
//

import DataBase
import MongoDB
import PerfectLib

public class CategoryArticleModel {

    public init() {}
    
    public func find() -> String {
        let db = DB(db: "today_news").collection(name: "category")
        let collection: MongoCollection? = db.collection
        
        let queryBson = BSON()
        let cursor = collection?.find(query: queryBson)
        
        var ary = [Any]()
        while let c = cursor?.next() {
            
            let data = dictWithJSON(bson: c) as! [String : Any]
            var thisPost = [String: Any]()

            thisPost["type"] = data["type"] as? Int
            thisPost["title"] = data["title"] as? String
            ary.append(thisPost)
        }
        var response = [String:Any]()
        if ary.count > 0 {
            response["result"] = "success"
            response["data"] = ary
        } else {
            response["result"] = "error"
        }

        db.close()
        
        return try! response.jsonEncodedString()
    }
    
    public func categoryTitle(type: Int) -> String {
        let db = DB(db: "today_news").collection(name: "category")
        let collection: MongoCollection? = db.collection
        
        /// 获取该集合下所有的信息
        let queryBson = BSON()
        queryBson.append(key: "type", int: type)
        let cursor = collection?.find(query: queryBson)
        var title = ""
        while let c = cursor?.next() {
            let data = dictWithJSON(bson: c) as! [String : Any]
            title = data["title"] as! String
        }
        return title
    }
    
    /// 将BSON对象转换为字典
    private func dictWithJSON(bson: BSON) -> JSONConvertible {
        let json = bson.asString
        let jsonDict = try! json.jsonDecode()
        return jsonDict
    }

    
}
