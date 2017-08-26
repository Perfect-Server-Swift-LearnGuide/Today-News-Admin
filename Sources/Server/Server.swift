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

struct ResponseFilter: HTTPResponseFilter {
    func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        /// 设置响应头
        response.addHeader(.contentType, value: "text/html")
        callback(.done)
    }
    func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        callback(.done)
    }
}

public struct Server {
    /// 服务器
    public var server = HTTPServer()
    
    public init() {
    
        let responseFilters: [(HTTPResponseFilter, HTTPFilterPriority)] = [
            (ResponseFilter(), HTTPFilterPriority.high)
        ]
        
        /// t添加响应过滤器
        server.setResponseFilters(responseFilters)
        
        /// 设置文档根目录
        server.documentRoot = app["hostroot"] as! String
        
        /// 创建路由
        let routes = Route().routes
        
        /// 为服务器注册路由
        server.addRoutes(routes)
        
        /// 监听端口
        server.serverPort = UInt16(app["hostport"] as! Int)

    }


}
