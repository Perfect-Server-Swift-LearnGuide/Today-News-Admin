//
//  Handler.swift
//  Today-News-Server
//
//  Created by 百城 on 16/10/29.
//
//

import PerfectHTTP
import PerfectMustache

/// Handler
public enum HandlerType {
    /// 首页
    case index
    
}

public struct Handler {
    
    /// 路由处理句柄
    public var handler: MustachePageHandler?
    
    /// Handler Type
    public var type: HandlerType?
    
    ///  template
    public var template: String {
        get{
            guard let type = self.type else {
                return "/.mustache"
            }
            return "/\(type).mustache"
        }
    }
    
    
    public init() {
        
    }
    
    public init(type: HandlerType) {
        self.type = type
        
        switch type {
        case .index:
            self.handler = IndexHandler()
            
        }

    }

}


