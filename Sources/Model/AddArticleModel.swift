//
//  AddArticleModel.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/17.
//
//

import DataBase
import MongoDB
import PerfectLib


public class AddArticleModel {
    
    public init() { }
    
    public func add(data: [String: Any]) -> String {
        
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection
        let doc = try! BSON(json: try! data.jsonEncodedString())
        doc.append(key: "isDelete", bool: false)
        let result: MongoResult = collection!.insert(document: doc)
        
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
}
