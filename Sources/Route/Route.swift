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

public struct Route {
    /// 路由
    public var routes = Routes()
    
    public init() {

        /// Index
        let index = Handler(type: .index)
        
        var routes = Routes()
        
        /// 设置路由
        routes.add(method: .get, uri: "/", handler: handler(handler: index))
        
        /// 注册到服务器主路由表上
        self.routes.add(routes)
    }

    /// generate requestHandler
    private func handler(handler: Handler) -> RequestHandler {
        return { request, response in
            response.setHeader(.contentType, value: "text/html")
            mustacheRequest(
                request: request,
                response: response,
                handler: handler.handler!,
                templatePath: request.documentRoot + handler.template
            )
            response.completed()
        }
    }

    
  }


