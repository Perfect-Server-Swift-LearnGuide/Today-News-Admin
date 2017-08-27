//
//  StaticFile.swift
//  Today-News-Admin
//
//  Created by Mac on 17/8/26.
//  Copyright © 2017年 lovemo. All rights reserved.
//

import PerfectLib
import PerfectHTTP
import PerfectMustache
import Common

public struct StaticFile {
    
    public  static func staticFile(type: String)  -> RequestHandler {
        return { req, res in
            
            switch type {
                
            /// js
            case Server.Route.StaticFile.js.rawValue:
                
                let handler = StaticFileHandler(documentRoot: req.documentRoot)
                handler.handleRequest(request: req, response: res)

            default:
                print("default")
            }
            
            
            res.completed()
        }
    }
}
