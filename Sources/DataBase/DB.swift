//
//  DB.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/14.
//
//

import PerfectLib
import MongoDB
import PerfectHTTP
import PerfectMustache

public class DB {
    
    /// MongoClient
    public var client: MongoClient
    
    /// MongoDatabase
    public var db: MongoDatabase
    
    /// MongoCollection
    public var collection: MongoCollection?
    
    public init(db: String) {
        
        /// 通过默认的端口连接MongoDB
        self.client = try! MongoClient(uri: "mongodb://127.0.0.1")
        
        /// DataBase
        self.db = self.client.getDatabase(name: db)
    }
    
    /// init collection
    public func collection(name: String) -> Self {
        self.collection = self.db.getCollection(name: name)
        return self
    }
    
    /// close db connect
    public func close() {
        defer {
            self.collection!.close()
            self.db.close()
            self.client.close()
        }
    }
    
}
