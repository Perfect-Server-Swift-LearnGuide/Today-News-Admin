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
        
        /// staticFile
        let staticFile = StaticFile.staticFile(type: "js")
        
        /// 设置路由
        var routes = Routes()

        routes.add(method: .get, uri: "/article/{action}/**", handler: article)
        routes.add(method: .post, uri: "/article/{action}/**", handler: article)
        routes.add(method: .get, uris: ["/{action}", "/"], handler: index)
        routes.add(method: .get, uri: "/upload_files", handler: imageHandler())
        routes.add(method: .get, uri: "/js/**", handler: staticFile)
        
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
    
}


