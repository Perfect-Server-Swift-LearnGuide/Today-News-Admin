//
//  Server.swift
//  Today-News-Server
//
//  Created by sunquan on 2016/10/30.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Route
import Config


struct RequestFilter: HTTPRequestFilter {
    
    func filter(request: HTTPRequest, response: HTTPResponse, callback: (HTTPRequestFilterResult) -> ()) {
       
        if  let accept =  request.header(HTTPRequestHeader.Name.accept) {
            if accept.contains(string: "text/html") {
                response.setHeader(.contentType, value: "text/html")
            } else if accept.contains(string: "text/css") {
                response.setHeader(.contentType, value: "text/css")
            } else if accept.contains(string: "javascript") {
                response.setHeader(.contentType, value: "text/javascript")
            } else if accept.contains(string: "json") {
                response.setHeader(.contentType, value: "application/json")
            }
        } else {
            response.setHeader(.contentType, value: "text/html")
        }
        

        callback(.execute(request, response))
    }
    
}

public struct Server {
    /// 服务器
    public var server = HTTPServer()
    
    public init() {
    
        let responseFilters: [(HTTPRequestFilter, HTTPFilterPriority)] = [
            (RequestFilter(), HTTPFilterPriority.high)
        ]
        
        /// 添加过滤器
        server.setRequestFilters(responseFilters)
        
        /// 设置文档根目录
        server.documentRoot = app.hostroot
        
        /// 创建路由
        let routes = Route().routes
        
        /// 为服务器注册路由
        server.addRoutes(routes)
        
        /// 监听端口
        server.serverPort = UInt16(app.hostport)

    }


}
