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

public class LookArticleModel {

    public init() {
        
    }
    
    /// 生成文章列表
    public func articles() -> [Any] {
        var ary = [Any]()
        
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection
        
        /// 获取该集合下所有的信息
        let cursor = collection?.find(query: BSON())
        
        while let c = cursor?.next() {
            
            let data = dictWithJSON(bson: c) as! [String : Any]

            var thisPost = [String:String]()
            let temp = data["_id"] as? [String : String]
            if let dict = temp {
                thisPost["id"] = dict["$oid"]
            } else {
                thisPost["id"] = ""
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
