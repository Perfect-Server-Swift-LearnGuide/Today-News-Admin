//
//  Handler.swift
//  Today-News-Server
//
//  Created by 百城 on 16/10/29.
//
//

import PerfectHTTP

/// Handler
public enum HandlerType {
    /// 获取文章分类
    case articleCategory
    /// 获取不同分类新闻内容
    case articleContent
}

public struct Handler {
    
    /// 路由处理句柄
    public var handler: RequestHandler?
    
    public init() {
        
    }
    
    public init(handler: HandlerType) {
        
              
    }

}


