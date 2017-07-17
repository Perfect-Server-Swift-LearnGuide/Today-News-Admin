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

public class EditArticleModel {
    
    public init() {
        
    }
    
    /// 删除文章
    public func edit(data: [String: String]) -> String {
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection
        
        var updates: [(selector: BSON, update: BSON)] = []

        var response = [String:Any]()
        if let id = data["id"], let title = data["title"], let content = data["content"], let type = data["type"] {
            let oldBson = BSON()
            oldBson.append(key: "_id", oid: BSON.OID(id))
            let innerBson = BSON()
            innerBson.append(key: "title", string: title)
            innerBson.append(key: "content", string: content)
            innerBson.append(key: "type", int: Int(type)!)
            innerBson.append(key: "isDelete", bool: false)
            let newdBson = BSON()
            newdBson.append(key: "$set", document: innerBson)
            updates.append((selector: oldBson, update: newdBson))

            let result:MongoResult = collection!.update(updates: updates)
            
            switch result {
            case .success:
                response["result"] = "success"
            default:
                response["result"] = "error"
            }
            
            db.close()
        } else {
            response["result"] = "error"
        }

        
        return try! response.jsonEncodedString()
        
    }
    
    /// 将BSON对象转换为字典
    private func dictWithJSON(bson: BSON) -> JSONConvertible {
        let json = bson.asString
        let jsonDict = try! json.jsonDecode()
        return jsonDict
    }
}
