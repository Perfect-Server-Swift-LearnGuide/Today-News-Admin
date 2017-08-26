//
//  Index.swift
//  Today-News-Admin
//
//  Created by Mac on 17/8/25.
//
//

import PerfectLib
import PerfectHTTP
import PerfectMustache

public struct Index {
    
    public  static func index()  -> RequestHandler {
        return { req, res in
            
            let isParams = req.params().count > 0
            var action = req.pathComponents.last ?? "index"
            action = action == "/" ? "index" : action
            var handler: MustachePageHandler?
            
            switch action {
                
                /// 首页
                case HandlerType.Index.index.rawValue:
                
                handler = IndexHandler()

                default:
                print("default")
            }
            
            if !isParams {
                if let hand = handler {
                    mustacheRequest(
                        request: req,
                        response: res,
                        handler: hand,
                        templatePath: req.documentRoot +  "/\(action).mustache"
                    )
                }

            }
            
            res.completed()
        }
    }
}
