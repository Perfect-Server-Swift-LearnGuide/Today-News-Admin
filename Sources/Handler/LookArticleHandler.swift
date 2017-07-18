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
import Model

public struct LookArticleHandler: MustachePageHandler {
    
    public func getArticle()  -> RequestHandler {
        return { request, response in
            
            let db = LookArticleModel()
            var requestPage = 1
            if let page = request.param(name: "page") {
                requestPage = Int(page)!
            }
            
            response.appendBody(string: db.articles(page: requestPage))
            response.completed()
        }
        
    }
    
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        
        let db = LookArticleModel()
        let _ = db.articles(page: 1)
        values["articles"] = db.dataList
        values["total"] = db.total()
        
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

