//
//  Route.swift
//  Today-News-Server
//
//  Created by 百城 on 16/10/29.
//
//

import PerfectHTTP
import PerfectMustache
import Common
import Handler
struct ListHandler: MustachePageHandler { // all template handlers must inherit from PageHandler
    // This is the function which all handlers must impliment.
    // It is called by the system to allow the handler to return the set of values which will be used when populating the template.
    // - parameter context: The MustacheWebEvaluationContext which provides access to the HTTPRequest containing all the information pertaining to the request
    // - parameter collector: The MustacheEvaluationOutputCollector which can be used to adjust the template output. For example a `defaultEncodingFunc` could be installed to change how outgoing values are encoded.
    
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        var ary = [Any]()
        
//        let dbHandler = DB()
//        let data = dbHandler.getList()
        let data = [["title" : "ddddd", "synopsis" : "fdffg", "test": "test"]]
        for i in 0..<data.count {
            var thisPost = [String:String]()
            thisPost["title"] = data[i]["title"]
            thisPost["synopsis"] = data[i]["synopsis"]
            thisPost["titlesanitized"] = data[i]["test"]
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
public struct Route {
    /// 路由
    public var routes = Routes()
    
    public init() {

        /// 设置主路由
        var routes = Routes(baseUri: Server.Api.baseUrl.rawValue)
        
        routes.add(method: .get, uri: "/", handler: {
            request, response in
            
            // Setting the response content type explicitly to text/html
            response.setHeader(.contentType, value: "text/html")
            // Setting the body response to the generated list via Mustache
            mustacheRequest(
                request: request,
                response: response,
                handler: ListHandler(),
                templatePath: request.documentRoot + "/index.mustache"
            )
            // Signalling that the request is completed
            response.completed()
        }
        )
        
        /// 注册到服务器主路由表上
        self.routes.add(routes: routes)
    }

  }


