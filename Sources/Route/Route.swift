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
        /// AddArticle
        let addArticle = Handler(type: .add_article)
        /// Delete
        let deleteArticle = Handler(type: .delete_article)
        /// Look
        let lookArticle = Handler(type: .look_article)
        /// Detail
        let detailArticle = Handler(type: .detail_article)
        
        /// 设置路由
        var routes = Routes()
        
        routes.add(method: .get, uri: "**", handler: {request, response in
            print("request  \(request.header(HTTPRequestHeader.Name.accept))")
            response.completed()
        })
        routes.add(method: .get, uri: "/", handler: handler(handler: index))
        routes.add(method: .get, uri: "/add_article", handler: handler(handler: addArticle))
        routes.add(method: .get, uri: "/delete_article", handler: handler(handler: deleteArticle))
        routes.add(method: .get, uri: "/look_article", handler: handler(handler: lookArticle))
        routes.add(method: .get, uri: "/detail_article/{id}", handler: handler(handler: detailArticle))
        
        /// 设置动作
        routes.add(method: .get, uri: "/add_article_action", handler: Handler(action:.add_article).action!)
        
        /// 注册到服务器主路由表上
        self.routes.add(routes)
    }

    
    /// generate requestHandler
    private func handler(handler: Handler) -> RequestHandler {
        return { request, response in


//            print("response  \(response.headers)")
            response.setHeader(.contentType, value: "text/html")
            response.setHeader(.contentType, value: "text/css")
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


