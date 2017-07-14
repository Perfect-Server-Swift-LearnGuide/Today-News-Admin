//
//  LookArticleHandler.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/13.
//
//

import PerfectLib
import PerfectHTTP
import PerfectMustache
import DataBase
import MongoDB

public struct LookArticleHandler: MustachePageHandler {
    
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        var ary = [Any]()
        
        let db = DB(db: "today_news").collection(name: "article")
        let collection: MongoCollection? = db.collection

        /// 获取该集合下所有的信息
        let cursor = collection?.find(query: BSON())

        while let c = cursor?.next() {

            let data = dictWithJSON(bson: c) as! [String : Any]

            var thisPost = [String:String]()
            thisPost["createtime"] = data["createtime"] as? String
            thisPost["title"] = data["title"] as? String
            thisPost["content"] = data["content"] as? String
            ary.append(thisPost)
        }

        values["articles"] = ary
        
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
    
    /// 将BSON对象转换为字典
    private func dictWithJSON(bson: BSON) -> JSONConvertible {
        let json = bson.asString
        let jsonDict = try! json.jsonDecode()
        return jsonDict
    }
}

