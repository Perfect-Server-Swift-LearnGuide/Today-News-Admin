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
import PerfectMongoDB
import DataBase
import Model

public struct AddArticleHandler: MustachePageHandler {
    
    /// AddArticle
    public static func add(req: HTTPRequest, res: HTTPResponse) -> String {

            var json = ""
            for param in req.params() {
                json = param.0
            }
            let datas = try! json.jsonDecode() as! [[String : Any]]
            var params = [String : Any]()

            for data in datas {
                if let key = data["name"] as? String {
                    params[key] = data["value"] ?? ""
                }
            }
            params["createtime"] = try! formatDate(getNow(), format: "%Y/%m/%d %I:%M:%S")
        
            let db = AddArticleModel()
            return db.add(data: params)
        
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
