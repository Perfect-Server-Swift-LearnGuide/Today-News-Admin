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



/// 创建服务器
let server = Server().server

/// 配置服务器
configureServer(server)

do {
    
	/// 启动服务器
	try server.start()

} catch PerfectError.networkError(let err, let msg) {
    
	print("Network error thrown: \(err) \(msg)")
}
