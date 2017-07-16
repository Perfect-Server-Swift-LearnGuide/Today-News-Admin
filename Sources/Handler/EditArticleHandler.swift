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


public struct EditArticleHandler: MustachePageHandler {
    
    /// EditArticle
    public func editArticle() -> RequestHandler {
        return { request, response in
            
            var data = [String : String]()
            for param in request.params() {
                data[param.0] = param.1
            }
            
            let db = EditArticleModel()
            response.appendBody(string: db.edit(data: data))
            
            response.completed()
        }
        
    }
    
    
    /// Mustache handler
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        let request = contxt.webRequest

        let id = request.urlVariables["id"] ?? ""
        DetailArticleModel().find(id: id, values: &values)
        
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
