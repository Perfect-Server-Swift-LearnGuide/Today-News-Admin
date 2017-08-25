//
//  HandlerType.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/17.
//
//

/// Handler
public enum HandlerType {
    
    /// 首页
    enum Index:String {
        
        /// 首页
        case index
    }
    
    
    /// 文章
    enum Article:String {
        
        /// 查看
        case look
        
        /// 详情
        case detail
        
        /// 编辑
        case edit
        
        /// 删除
        case delete
        
        /// 添加
        case add
        
        /// 分类
        case category
        
        /// 上传
        case upload
        
    }
    
    
    /// 上传文章缩略图
    case article__thumbnail_upload
    
    
}
