//
//  Article.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class Article {
    var id: String
    var createdAt: Date
    var thumbImageURL: String
    var imageURL: String
    var authorNickname: String
    var author: String
    var imageDescription: String
    var imageTitle: String
    var apiVersion: String
    
    init(){
        self.id = ""
        self.createdAt = Date()
        self.thumbImageURL = ""
        self.imageURL = ""
        self.authorNickname = ""
        self.author = ""
        self.imageDescription = ""
        self.imageTitle = ""
        self.apiVersion = ""
    }
    
    init(id: String,
         createdAt: Date,
         thumbImageURL: String,
         imageURL: String,
         authorNickname: String,
         author: String,
         imageDescription: String,
         imageTitle: String,
         apiVersion: String){
        
        self.id = id
        self.createdAt = createdAt
        self.thumbImageURL = thumbImageURL
        self.imageURL = imageURL
        self.authorNickname = authorNickname
        self.author = author
        self.imageDescription = imageDescription
        self.imageTitle = imageTitle
        self.apiVersion = apiVersion
    }
    
    convenience init?(jsonData: [String: Any]) {
        guard let id = jsonData["_id"] as? String,
            let createdAt = jsonData["created_at"] as? Double,
            let thumbImageURL = jsonData["thumb_image_url"] as? String,
            let imageURL = jsonData["image_url"] as? String,
            let authorNickname = jsonData["author_nickname"] as? String,
            let author = jsonData["author"] as? String,
            let imageDescription = jsonData["image_desc"] as? String,
            let imageTitle = jsonData["image_title"] as? String,
            let apiVersion = jsonData["__v"] as? Double
        else {
            return nil
        }
        
        let date = Date(timeIntervalSince1970: createdAt)
        self.init(id: id, createdAt: date, thumbImageURL: thumbImageURL, imageURL: imageURL, authorNickname: authorNickname, author: author, imageDescription: imageDescription, imageTitle: imageTitle, apiVersion: String(apiVersion))
    }
}
