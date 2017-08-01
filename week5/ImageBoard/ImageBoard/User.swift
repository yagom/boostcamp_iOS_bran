//
//  User.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class User: NSObject {
    
    struct jsonKey {
        static let id = "_id"
        static let nickname = "nickname"
        static let password = "password"
        static let email = "email"
        static let apiVersion = "__v"
    }
    
    var id: String
    var nickname: String
    var password: String
    var email: String
    var apiVersion: String
    
    init(id: String, nickname: String, password: String, email: String, apiVersion: String) {
        self.id = id
        self.nickname = nickname
        self.password = password
        self.email = email
        self.apiVersion = apiVersion
    }
    
    convenience init(email: String, password: String) {
        self.init(id: "", nickname: "", password: password, email: email, apiVersion: "")
    }
    
    convenience init(email: String, password: String, nickname: String) {
        self.init(id: "", nickname: nickname, password: password, email: email, apiVersion: "")
    }
    
    convenience init?(jsonData: [String: Any]) {
        guard let id = jsonData[jsonKey.id] as? String,
            let nickname = jsonData[jsonKey.nickname] as? String,
            let password = jsonData[jsonKey.password] as? String,
            let email = jsonData[jsonKey.email] as? String,
            let apiVersion = jsonData[jsonKey.apiVersion] as? Double
        else {
            return nil
        }
        
        self.init(id: id, nickname: nickname, password: password, email: email, apiVersion: String(apiVersion))
    }
}
