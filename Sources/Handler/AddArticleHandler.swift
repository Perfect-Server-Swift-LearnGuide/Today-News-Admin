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


            var json = ""
            for param in request.params() {
                json = param.0
            }
            let datas = try! json.jsonDecode() as! [[String : Any]]
            var params = [String : Any]()
            for data in datas {
                if let key = data["name"] as? String {
       
                    if key.contains(string: "thumbnails") {
                        var images = data["value"] as! [String]
                        images = images.map({ (image)  in
                            image.stringByReplacing(string: "..", withString: "127.0.0.1:8282")
                        })
                        params[key] = images
                    } else {
                        params[key] = data["value"] ?? ""
                    }
                }
            }
            params["createtime"] = try! formatDate(getNow(), format: "%Y/%m/%d %I:%M:%S")
            let db = AddArticleModel()
            response.appendBody(string: db.add(data: params))
            
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
