//
//  UploadArticleImageHandler.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/24.
//  Copyright © 2017年 lovemo. All rights reserved.
//

import PerfectHTTP
import PerfectLib
import Config

public struct UploadArticleImageHandler  {
    
    public init(){}
    
    /// 上传文章缩略图
    public static func upload(req: HTTPRequest, res: HTTPResponse) -> String {
        

        var imgs = [[String:Any]]()
        if let uploads = req.postFileUploads , uploads.count > 0 {
            
            // 创建路径用于存储已上传文件
            let fileDir = Dir(Dir.workingDir.path + req.documentRoot + "/\(app["upload"] as! String)/")
            do {
                try fileDir.create()
            } catch {
                print(error)
            }
            
            for upload in uploads {
                
                let judgeResult: (Bool, String) = self.judge(contenType: upload.contentType, fileSize: upload.fileSize)
                
                if judgeResult.0 {
                    // 将文件转移走，如果目标位置已经有同名文件则进行覆盖操作。
                    let thisFile = File(upload.tmpFileName)
                    let path = upload.fieldName + self.ext(contentType: upload.contentType)
                    
                    do {
                        let _ = try thisFile.moveTo(path: fileDir.path + path, overWrite: true)
                        imgs.append(["url" : "./\(app["upload"] as! String)/" + path])
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        if imgs.count > 0 {
            return try! ["result" : ["msg" : "success", "urls" : imgs]].jsonEncodedString()
        } else {
            return try! ["result" : ["msg" : "error", "urls" : ""]].jsonEncodedString()
        }

    }
    
   static func  ext(contentType: String) -> String {
        let filterStr = ["gif", "jpg", "jpeg", "bmp", "png"];
        for str in filterStr {
            if contentType.contains(string: str) {
                return ".\(str)"
            }
        }
        return ".jpg"
    }
    
    static func judge(contenType: String, fileSize: Int) -> (Bool, String) {
        
        let filter = ["gif", "jpg", "jpeg", "bmp", "png"];
        var contain = false
        for str in filter {
            if contenType.contains(string: str) {
                contain = true
            }
        }
        
        if !contain {
            return (false, try! ["result" : "上传失败, 图片格式不对"].jsonEncodedString())
        }
        
        if fileSize > 1000 * 1000 * 10 {
            return (false, try! ["result" : "上传失败, 图片尺寸太大"].jsonEncodedString())
        }
        
        return (true, try! ["result" : "上传成功"].jsonEncodedString())
    }
    
}
