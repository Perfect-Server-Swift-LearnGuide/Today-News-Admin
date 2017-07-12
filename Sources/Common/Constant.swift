//
//  Constant.swift
//  Today-News-Server
//
//  Created by 百城 on 16/10/29.
//
//



public enum Server {
    
    /// Api
    public enum Api: String {
        /// 根Url
        case baseUrl =  "today_news/"
        /// 文章分类
        case articleCategory =  "article/category"
        /// 分类对于文章
        case articleContent = "article/content"
    }
    
    /// 目录
    public enum Dir: String {
        /// 资源目录
        case resource = "./webroot/"
    }
}
