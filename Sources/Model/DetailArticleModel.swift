//
//  DetailArticleModel.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/15.
//
//

import DataBase
import MongoDB
import PerfectLib

public class DetailArticleModel {

    public init () {
        
    }
    
    public func find(id: String, values: inout [String:Any]) {
        
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection
        
        /// 获取该集合下所有的信息
        let bson = BSON()
        bson.append(key: "_id", oid: BSON.OID(id))
        let cursor = collection?.find(query: bson)
        while let c = cursor?.next() {
            
            let data = c.dict
            let temp = data["_id"] as? [String : String]
            if let dict = temp {
                values["id"] = dict["$oid"]
            } else {
                values["id"] = ""
            }

            values["createtime"] = data["createtime"] as? String
            values["title"] = data["title"] as? String
            values["content"] = data["content"] as? String
            values["source"] = data["source"] as? String
            values["type"] = data["type"] as? Int
            
            var thumbnails = [[String : String]]()
            if let images = data["thumbnails"] as? [String] {
                for image in images {
                    var id = image.replacingOccurrences(of: "http://127.0.0.1:8282/upload_files/article_thumbnail", with: "")
                    id = id.components(separatedBy: ".").first!
                    thumbnails.append(["imgUrl" : image.replacingOccurrences(of: "http://127.0.0.1:8282", with: ".."),
                                       "id" : id])
                    print(image.replacingOccurrences(of: "http://127.0.0.1:8282", with: ".."))
                }
            }
            values["thumbnails"] = thumbnails
        }
        
    }
    

}
