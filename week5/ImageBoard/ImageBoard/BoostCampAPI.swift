//
//  BoostCampAPI.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class BoostCampAPI {
    
    private struct RequestHeader {
        struct Field {
            static let contentType = "Content-Type"
        }
        
        struct Value {
            static let json = "application/json"
            static let formData = "multipart/form-data"
        }
    }
    
    private struct RequestMethod {
        static let get = "GET"
        static let post = "POST"
        static let put = "PUT"
        static let delete = "DELETE"
    }
    
    private struct urlPath {
        static let baseURL = "https://ios-api.boostcamp.connect.or.kr/"
        static let login = urlPath.baseURL + "login"
        static let user = urlPath.baseURL + "user"
        static let image = urlPath.baseURL + "image"
    }
    
    static let shared = BoostCampAPI()
    
    // MARK: All Article
    // Get all articles.
    // if requesting server and creating article object fail, completion argument is nil.
    func allBoard(completionBlock completion: @escaping (_ articles: [Article]?) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: urlPath.baseURL) else { return completion(nil) }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else { return completion(nil) }
            guard let jsonArticles = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: Any]] else { return completion(nil) }
            guard let articles = jsonArticles else { return completion(nil) }
            
            var resultArticles: [Article] = []
            
            for article in articles {
                guard let newArticle = Article(jsonData: article) else { continue }
                resultArticles.append(newArticle)
            }
            
            if resultArticles.count > 0 {
                completion(resultArticles)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // MARK: User
    // Login with user object.
    // if requesting server and creating user object fail, completion argument is nil.
    func login(with user: User, completionBlock completion: @escaping (_ user: User?) -> ()){
        
        let session = URLSession.shared
        
        var jsonBody = [String: Any]()
        jsonBody[User.jsonKey.email] = user.email
        jsonBody[User.jsonKey.password] = user.password
        
        guard let body = try? JSONSerialization.data(withJSONObject: jsonBody, options: JSONSerialization.WritingOptions.prettyPrinted) else { return completion(nil) }
        guard let url = URL(string: urlPath.login) else { return completion(nil) }
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = body
        request.addValue(RequestHeader.Value.json, forHTTPHeaderField: RequestHeader.Field.contentType)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else { return completion(nil) }
            guard let userJson = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else { return completion(nil) }
            guard let user = userJson else { return completion(nil) }
            let resultUser = User(jsonData: user)
            completion(resultUser)
        }
        task.resume()
        
    }
    
    // Sign up with user object.
    // if requesting server and creating user object fail, completion argument is nil.
    func signUp(with user: User, completionBlock completion: @escaping (_ user: User?) -> ()) {
        let session = URLSession.shared
        
        var jsonBody = [String: Any]()
        jsonBody[User.jsonKey.email] = user.email
        jsonBody[User.jsonKey.password] = user.password
        jsonBody[User.jsonKey.nickname] = user.nickname
         
        
        guard let body = try? JSONSerialization.data(withJSONObject: jsonBody, options: JSONSerialization.WritingOptions.prettyPrinted) else { return completion(nil) }
        guard let url = URL(string: urlPath.user) else { return completion(nil) }
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = body
        request.addValue(RequestHeader.Value.json, forHTTPHeaderField: RequestHeader.Field.contentType)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else { return completion(nil) }
            guard let userJson = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else { return completion(nil) }
            guard let user = userJson else { return completion(nil) }
            let resultUser = User(jsonData: user)
            completion(resultUser)
        }
        task.resume()
    }
    
    // MARK: Article
    // Upload article.
    // if requesting server and creating article object fail, completion argument is nil.
    func postArticle(with article: Article, comopletionBlock completion: @escaping (_ article: Article?) -> ()) {
        
        let session = URLSession.shared
        
        var jsonBody = [String: Any]()
        jsonBody[Article.jsonKey.imageTitle] = article.imageTitle
        jsonBody[Article.jsonKey.imageDescription] = article.imageDescription
        jsonBody[Article.jsonKey.imageData] = article.imageData
        
        guard let body = try? JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted),
            let url = URL(string: urlPath.image)
        else {
            return completion(nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = body
        request.addValue(RequestHeader.Value.json, forHTTPHeaderField: RequestHeader.Field.contentType)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data,
                let articleJSON = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any],
                let article = articleJSON
            else {
                return completion(nil)
            }

            let resultArticle = Article(jsonData: article)
            completion(resultArticle)
        }
        task.resume()
    }
    
    
    func updateArticle(with article: Article, comopletionBlock completion: @escaping (_ article: Article?) -> ()) {
        let session = URLSession.shared
        
        var jsonBody = [String: Any]()
        jsonBody[Article.jsonKey.imageTitle] = article.imageTitle
        jsonBody[Article.jsonKey.imageDescription] = article.imageDescription
        jsonBody[Article.jsonKey.imageData] = article.imageData
        
        guard let body = try? JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted),
            let url = URL(string: urlPath.image.appending("/\(article.id)"))
            else {
                return completion(nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = body
        request.addValue(RequestHeader.Value.json, forHTTPHeaderField: RequestHeader.Field.contentType)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data,
                let articleJSON = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any],
                let article = articleJSON
                else {
                    return completion(nil)
            }
            
            let resultArticle = Article(jsonData: article)
            completion(resultArticle)
        }
        task.resume()
    }
    
    func deleteArticle(with article: Article, comopletionBlock completion: @escaping (_ article: Article?) -> ()) {
        let session = URLSession.shared
        
        guard let url = URL(string: urlPath.image.appending("/\(article.id)")) else { return completion(nil) }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.delete
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data,
                let jsonArticles = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]],
                let article = jsonArticles?.first
                else {
                    return completion(nil)
            }

            let resultArticle = Article(jsonData: article)
            completion(resultArticle)
        }
        task.resume()
    }
}
