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
import PerfectMongoDB
import Model

public struct LookArticleHandler: MustachePageHandler {
    
    public static func look(req: HTTPRequest, res: HTTPResponse) -> String {

        let db = LookArticleModel()
        var requestPage = 1
        if let page = req.param(name: "page") {
            requestPage = Int(page)!
        }
        
        return db.articles(page: requestPage)

    }
    
    /// Mustache handler
    public func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        
        let db = LookArticleModel()
        let _ = db.articles(page: 1)
        
        let queryBson = BSON()
        queryBson.append(key: "isDelete", bool: false)
        values["articles"] = db.dataList
        values["total"] = db.total(queryBson)

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

