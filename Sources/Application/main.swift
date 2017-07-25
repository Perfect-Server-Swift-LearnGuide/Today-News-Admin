//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Server
import Common
import MongoDB



/// 创建服务器
let server = Server().server

/// 配置服务器
configureServer(server)

do {
//    var json = [String : Any]()
//    let param = "[{\"name\":\"title\",\"value\":\"rrt\"},{\"name\":\"source\",\"value\":\"y567\"},{\"name\":\"type\",\"value\":\"0\"},{\"name\":\"content\",\"value\":\"<p>请输入文章内容</p>\"},{\"name\":\"images\",\"value\":[\"../upload_files/article_thumbnail2017-07-25-22-24-01.png\",\"../upload_files/article_thumbnail2017-07-25-22-24-04.png\"]}]"
//    
//    let datas = try! param.jsonDecode() as! [[String : Any]]
//    var params = [String : Any]()
//    for data in datas {
//        if let key = data["name"] as? String {
//            if key.contains(string: "images") {
//                var images = data["value"] as! [String]
//                images = images.map({ (image)  in
//                    image.stringByReplacing(string: "..", withString: "127.0.0.1:8282")
//                })
//                params[key] = images
//            } else {
//                params[key] = data["value"] ?? ""
//            }
//        }
//    }
//
//    print(params)
    
	/// 启动服务器
	try server.start()

} catch PerfectError.networkError(let err, let msg) {
    
	print("Network error thrown: \(err) \(msg)")
}
