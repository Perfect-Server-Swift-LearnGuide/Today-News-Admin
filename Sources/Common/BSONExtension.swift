//
//  JSONConvertibleExesion.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/18.
//
//

import MongoDB
import PerfectLib

extension BSON {
    
    /// 将BSON对象转换为字典
    public var dict: [String: Any] {
        get{
            let json = self.asString
            let jsonDict = try! json.jsonDecode()
            return jsonDict as! [String : Any]
        }
        set{}
    }
    
}
