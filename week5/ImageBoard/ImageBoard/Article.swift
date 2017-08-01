//
//  Article.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class Article {
    
    struct jsonKey {
        static let id = "_id"
        static let createdAt = "created_at"
        static let thumbImageURL = "thumb_image_url"
        static let imageURL = "image_url"
        static let authorNickname = "author_nickname"
        static let author = "author"
        static let imageDescription = "image_desc"
        static let imageTitle = "image_title"
        static let apiVersion = "__v"
        static let imageData = "image_data"
    }
    
    var id: String
    var createdAt: Date
    var thumbImageURL: String
    var imageURL: String
    var authorNickname: String
    var author: String
    var imageDescription: String
    var imageTitle: String
    var apiVersion: String
    var imageData: Data?
    var downloadImageURL: String {
        return BoostCampAPI.urlPath.baseURL + imageURL
    }
    var downloadThumbImageURL: String {
        return BoostCampAPI.urlPath.baseURL + thumbImageURL
    }
    
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
    
    convenience init(title: String, description: String, data: Data) {
        self.init(id: "", createdAt: Date(), thumbImageURL: "", imageURL: "", authorNickname: "", author: "", imageDescription: description, imageTitle: title, apiVersion: "")
        self.imageData = data
    }
    
    convenience init?(jsonData: [String: Any]) {
        guard let id = jsonData[jsonKey.id] as? String,
            let createdAt = jsonData[jsonKey.createdAt] as? Double,
            let thumbImageURL = jsonData[jsonKey.thumbImageURL] as? String,
            let imageURL = jsonData[jsonKey.imageURL] as? String,
            let authorNickname = jsonData[jsonKey.authorNickname] as? String,
            let author = jsonData[jsonKey.author] as? String,
            let imageDescription = jsonData[jsonKey.imageDescription] as? String,
            let imageTitle = jsonData[jsonKey.imageTitle] as? String,
            let apiVersion = jsonData[jsonKey.apiVersion] as? Double
        else {
            return nil
        }
        
        let date = Date(timeIntervalSince1970: createdAt)
        self.init(id: id, createdAt: date, thumbImageURL: thumbImageURL, imageURL: imageURL, authorNickname: authorNickname, author: author, imageDescription: imageDescription, imageTitle: imageTitle, apiVersion: String(apiVersion))
    }
}
