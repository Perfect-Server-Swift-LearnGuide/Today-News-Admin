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
        let index = Index.index()

        /// article
        let article = Article.article()
        
        /// 设置路由
        var routes = Routes()

        routes.add(method: .get, uri: "/article/{action}/**", handler: article)
        routes.add(method: .post, uri: "/article/{action}/**", handler: article)
        routes.add(method: .get, uri: "*", handler: index)
        routes.add(method: .get, uri: "/upload_files", handler: imageHandler())
        
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


