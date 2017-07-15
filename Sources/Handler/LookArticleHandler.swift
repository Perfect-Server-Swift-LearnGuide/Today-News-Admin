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
    
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()

        values["articles"] = LookArticleModel().articles()
        
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

