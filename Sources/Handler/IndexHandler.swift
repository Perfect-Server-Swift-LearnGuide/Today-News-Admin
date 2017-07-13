//
//  IndexHandler.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/13.
//
//

import PerfectLib
import PerfectHTTP
import PerfectMustache

public struct IndexHandler: MustachePageHandler {
    
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

