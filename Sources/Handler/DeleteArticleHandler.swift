//
//  DeleteArticleHandler.swift
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
import Model

public struct DeleteArticleHandler: MustachePageHandler {
    
    /// DeleteArticle
    public func deleteArticle() -> RequestHandler {
        return { request, response in
            
            var data = [String]()
            for param in request.postParams {
                data.append(param.1)
            }
            let db = DeleteArticleModel()
            response.appendBody(string: db.deletes(data))
            
            response.completed()
        }
        
    }
    
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        
        let obj = DeleteArticleModel()
        values["articles"] = obj.articles()
        values["total"] = obj.total
        
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

