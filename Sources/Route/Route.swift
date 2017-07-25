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
        routes.add(method: .get, uri: "/upload_files", handler: imageHandler())
        routes.add(method: .get, uri: "/add_article", handler: handler(handler: addArticle))
        routes.add(method: .get, uri: "/delete_article", handler: handler(handler: deleteArticle))
        routes.add(method: .get, uri: "/look_article", handler: handler(handler: lookArticle))
        routes.add(method: .get, uri: "/detail_article/{id}", handler: handler(handler: detailArticle))
        routes.add(method: .get, uri: "/edit_article/{id}", handler: handler(handler: editArticle))
        
        /// 动作请求
        routes.add(method: .post, uri: "/add_article_action", handler: Handler(action:.add_article).action!)
        routes.add(method: .post, uri: "/delete_article_action", handler: Handler(action:.delete_article).action!)
        routes.add(method: .post, uri: "/edit_article_action", handler: Handler(action:.edit_article).action!)
        routes.add(method: .get, uri: "/category_article_action", handler: Handler(action:.category_article).action!)
        routes.add(method: .get, uri: "/get_article_action", handler: Handler(action:.get_article).action!)
        routes.add(method: .post, uri: "/article_thumbnail_upload_action", handler: Handler(action:.article__thumbnail_upload).action!)
        
        /// 处理静态文件
        addFileRoute(urls: ["/themes/**", "/third-party/**", "/laypage_skin/**", "/ueditor.config.js", "ueditor.all.js", "ueditor.parse.js", "/dialogs/**", "/jsp/**", "/lang/**", "/themes/**", "/third-party/**"])
        
        /// 注册到服务器主路由表上
        self.routes.add(routes)
    }
    
    
    
    // MARK: - private method
    
    /// generate requestHandler
    private func imageHandler() -> RequestHandler {
        return { request, response in
            print(request.header(HTTPRequestHeader.Name.contentType)!)
            response.setHeader(.contentType, value: request.header(HTTPRequestHeader.Name.contentType)!)
            response.completed()
        }
    }
    
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

    private mutating func addFileRoute(urls: [String]) {
        routes.add(method: .get, uris: urls, handler: {request, response in
            response.addHeader(.contentType, value: "text/css; charset=\"utf-8\"")
            // 用文档根目录初始化静态文件句柄
            
            let path = request.path
            
            var uriPath = ""
            if path.contains(string: "laypage") {
                uriPath = "/js/lib/laypage/"
            } else {
                uriPath = "/js/lib/ueditor/"
            }

            let handler = StaticFileHandler(documentRoot: request.documentRoot)
            request.path  = uriPath + path
            
            // 用我们的根目录和路径
            // 修改集触发请求的句柄
            handler.handleRequest(request: request, response: response)
            response.completed()
        })
        
    }
    
}


