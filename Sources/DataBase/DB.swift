//
//  DB.swift
//  Today-News-Admin
//
//  Created by Mac on 17/7/14.
//
//

import PerfectLib
import PerfectMongoDB
import PerfectHTTP
import Config

public class DB {
    
    /// MongoClient
    public var client: MongoClient
    
    /// MongoDatabase
    public var db: MongoDatabase
    
    /// MongoCollection
    public var collection: MongoCollection?
    
    public init(db: String) {
        
        /// 通过默认的端口连接MongoDB
        
        self.client = try! MongoClient(uri: "mongodb://" +
            database.username  + ":" +
            database.password + "@" +
            database.hostname + ":" +
            database.dbport + "/" +
            db)
        
        /// DataBase
        self.db = self.client.getDatabase(name: db)
        
    }
    
    /// init collection
    public func collection(name: String) -> Self {
        self.collection = self.db.getCollection(name: database.dbprefix + name)
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
    
    /// database connect fail
    fileprivate func outputFail(client: MongoClient) {
        let status = client.serverStatus()
        switch status {
        case .error(let domain, let code, let message):
            print( "Error: \(domain) \(code) \(message)")
        case .replyDoc(_):
            print(true)
        default:
            print("Strange reply type \(status)")
        }
    }
}
