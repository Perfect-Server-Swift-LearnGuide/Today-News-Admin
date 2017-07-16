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
    
    /// 添加文章
    case add_article
    
    /// 删除文章
    case delete_article
    
    /// 查看文章
    case look_article
    
    /// 文章详情
    case detail_article
    
    /// 编辑文章
    case edit_article
    
}

/// Action
public enum ActionType {
    /// 首页
    case index
    
    /// 添加文章
    case add_article
    
    /// 删除文章
    case delete_article
    
    /// 查看文章
    case look_article
    
    /// 编辑文章
    case edit_article
    
}

public struct Handler {
    
    /// 路由处理句柄
    public var handler: MustachePageHandler?
    
    /// 路由处理句柄
    public var action: RequestHandler?
    
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
    
    public init(action: ActionType) {
        
        switch action {
            
        case .add_article:
            self.action = AddArticleHandler().addArticle()
            
        case .delete_article:
            self.action = DeleteArticleHandler().deleteArticle()
            
        case .edit_article:
            self.action = EditArticleHandler().editArticle()
            
        default:
            print("---")
        }
        
    }
    
    public init(type: HandlerType) {
        self.type = type
        
        switch type {
            
        case .index:
            self.handler = IndexHandler()
            
        case .add_article:
            self.handler = AddArticleHandler()
            
        case .delete_article:
            self.handler = DeleteArticleHandler()
            
        case .look_article:
            self.handler = LookArticleHandler()
          
        case .detail_article:
            self.handler = DetailArticleHandler()
            
        case .edit_article:
            self.handler = EditArticleHandler()
        }

    }

}


