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
        /// Edit
        let editArticle = Handler(type: .edit_article)
        
        
        /// 设置路由
        var routes = Routes()
        
        /// 模板页面
        routes.add(method: .get, uri: "/", handler: handler(handler: index))
        routes.add(method: .get, uri: "/add_article", handler: handler(handler: addArticle))
        routes.add(method: .get, uri: "/delete_article", handler: handler(handler: deleteArticle))
        routes.add(method: .get, uri: "/look_article", handler: handler(handler: lookArticle))
        routes.add(method: .get, uri: "/detail_article/{id}", handler: handler(handler: detailArticle))
        routes.add(method: .get, uri: "/edit_article/{id}", handler: handler(handler: editArticle))
        
        /// 动作请求
        routes.add(method: .post, uri: "/add_article_action", handler: Handler(action:.add_article).action!)
        routes.add(method: .post, uri: "/delete_article_action", handler: Handler(action:.delete_article).action!)
        routes.add(method: .post, uri: "/edit_article_action", handler: Handler(action:.edit_article).action!)
        
        /// 处理静态文件
        self.addUEditorRoute(path: "themes")
        self.addUEditorRoute(path: "third-party")

        /// 注册到服务器主路由表上
        self.routes.add(routes)
    }
    

    
    /// generate requestHandler
    private func handler(handler: Handler) -> RequestHandler {
        return { request, response in

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

    private mutating func addUEditorRoute(path: String) {
        routes.add(method: .get, uri: "/\(path)/**", handler: {request, response in
            response.addHeader(.contentType, value: "text/css; charset=\"utf-8\"")
            // 获得符合通配符的请求路径
            request.path = request.urlVariables[routeTrailingWildcardKey]!
            // 用文档根目录初始化静态文件句柄
            let handler = StaticFileHandler(documentRoot: request.documentRoot + "/\(path)")
            // 用我们的根目录和路径
            // 修改集触发请求的句柄
            handler.handleRequest(request: request, response: response)
            response.completed()
        })
        
    }
    
}


