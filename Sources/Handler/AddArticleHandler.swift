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
import Model

public struct AddArticleHandler: MustachePageHandler {
    
    /// AddArticle
    public func addArticle() -> RequestHandler {
        return { request, response in
            
            var data = [String : Any]()
            for param in request.params() {
                data[param.0] = param.1
            }
            
            data["createtime"] = try! formatDate(getNow(), format: "%Y/%m/%d %I:%M:%S")
            let db = AddArticleModel()
            response.appendBody(string: db.add(data: data))
            
            response.completed()
        }

    }
    
    /// Mustache handler
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        values["values"] = ""
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
