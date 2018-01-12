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

public class EditArticleModel {
    
    public init() {
        
    }
    
    /// 编辑文章
    public func edit(data: [String: Any]) -> String {
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection
        
        var updates: [(selector: BSON, update: BSON)] = []

        var response = [String:Any]()
        
        
        if let id = data["id"] as? String, let title = data["title"], let source = data["source"], let content = data["content"], let type = data["type"] as? String, let thumbnails = data["thumbnails"] as? [String] {
            let oldBson = BSON()
            oldBson.append(key: "_id", oid: BSON.OID(id))
            let innerBson = BSON()
            innerBson.append(key: "title", string: title as! String)
            innerBson.append(key: "content", string: content as! String)
            innerBson.append(key: "source", string: source as! String)
            innerBson.append(key: "type", int: Int(type)!)
            innerBson.append(key: "isDelete", bool: false)
            let imageBson = try! BSON(json: try! thumbnails.jsonEncodedString())
            let _ = innerBson.appendArray(key: "thumbnails", array: imageBson)
            
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

}
