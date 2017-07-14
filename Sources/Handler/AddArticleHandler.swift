//
//  AddArticleHandler.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/13.
//
//

import PerfectLib
import PerfectHTTP
import PerfectMustache
import MongoDB
import DataBase

public struct AddArticleHandler: MustachePageHandler {
    
    /// AddArticle
    public func addArticle() -> RequestHandler {
        return { request, response in
            
            var data = [String : Any]()
            for param in request.params() {
                data[param.0] = param.1
            }
            
            data["createtime"] = try! formatDate(getNow(), format: "%Y/%m/%d %I:%M:%S")
            let db = DB(db: "today_news").collection(name: "article")
            response.appendBody(string: db.save(data: data))
            
            response.completed()
        }

    }
    
    /// Mustache handler
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        var ary = [Any]()
        
        
        let data = [["title": "gdfgds", "synopsis": "synopsis", "titlesanitized":"titlesanitized"]]
        
        for i in 0..<data.count {
            var thisPost = [String:String]()
            thisPost["title"] = data[i]["title"]
            thisPost["synopsis"] = data[i]["synopsis"]
            thisPost["titlesanitized"] = data[i]["titlesanitized"]
            ary.append(thisPost)
        }
        values["posts"] = ary
        
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
}
