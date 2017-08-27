//
//  Constant.swift
//  Today-News-Server
//
//  Created by 百城 on 16/10/29.
//
//



public enum Server {
    
    public enum Route {
        
        /// 首页
        public enum Index:String {
            
            /// 首页
            case index
        }
        
        
        /// 文章
        public enum Article:String {
            
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
        
        
        /// 静态文件
        public enum StaticFile:String {
            
            case js
            
        }
        
        /// 上传文章缩略图
        case article__thumbnail_upload
        
        
    }
    
    /// 目录
    public enum Dir:String {
        
        case dir
        
    }
    
}
