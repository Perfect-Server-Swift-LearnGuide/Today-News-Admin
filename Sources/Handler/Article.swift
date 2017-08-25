//
//  Article.swift
//  Today-News-Admin
//
//  Created by Mac on 17/8/25.
//
//

import PerfectLib
import PerfectHTTP
import PerfectMustache
import DataBase
import MongoDB
import Model

public struct Article {
    

    public  static func article()  -> RequestHandler {
        return { req, res in

            var isParams = req.params().count > 0
            let action = req.urlVariables["action"] ?? "error"
            var handler: MustachePageHandler?

            switch action {
                
            /// 查看
            case HandlerType.Article.look.rawValue:
                
                handler = LookArticleHandler()
                if isParams {
                    res.appendBody(string: LookArticleHandler.look(req: req, res: res))
                }
            
            /// 详情
            case HandlerType.Article.detail.rawValue:
                
                handler = DetailArticleHandler(id:req.pathComponents.last ?? "")
                
            /// 编辑
            case HandlerType.Article.edit.rawValue:
                
                handler = EditArticleHandler(id:req.pathComponents.last ?? "")
                if isParams {
                    res.appendBody(string: EditArticleHandler.edit(req: req, res: res))
                }
            
            /// 删除
            case HandlerType.Article.delete.rawValue:
                
                handler = DeleteArticleHandler()
                if isParams {
                    res.appendBody(string: DeleteArticleHandler.delete(req: req, res: res))
                }
            
            /// 添加
            case HandlerType.Article.add.rawValue:
                
                handler = AddArticleHandler()
                if isParams {
                    res.appendBody(string: AddArticleHandler.add(req: req, res: res))
                }
            
            /// 分类
            case HandlerType.Article.category.rawValue:
        
                isParams = true
                res.appendBody(string: CategoryArticleHandler.category(req: req, res: res))
                
            /// 上传
            case HandlerType.Article.upload.rawValue:
                
                isParams = true
                res.appendBody(string: UploadArticleImageHandler.upload(req: req, res: res))
                
            default:
                print("default")
            }
            
            
             if !isParams {
                mustacheRequest(
                    request: req,
                    response: res,
                    handler: handler!,
                    templatePath: req.documentRoot +  "/\(action)_article.mustache"
                )
            }
            
            res.completed()
        }
        
    }
}
