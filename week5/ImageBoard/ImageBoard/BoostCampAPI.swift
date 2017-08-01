//
//  BoostCampAPI.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

enum UserResult {
    case success(User)
    case failure(UserError)
}

enum UserError: Error {
    case emailOverlaped
    case userJSONSerializationFail
    case userInitializationFail
}

enum ArticleResult {
    case success([Article])
    case failure(ArticleError)
}

enum ArticleError: Error {
    case articleJSONSerializationFail
    case articleInitializationFail
}

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
    
    struct urlPath {
        static let baseURL = "https://ios-api.boostcamp.connect.or.kr"
        static let login = urlPath.baseURL + "/login"
        static let user = urlPath.baseURL + "/user"
        static let image = urlPath.baseURL + "/image"
    }
    
    static let shared = BoostCampAPI()
    
    // MARK: All Article
    // Get all articles.
    // if requesting server and creating article object fail, completion argument is nil.
    func allBoard(completionBlock completion: @escaping (_ articleResult: ArticleResult) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: urlPath.baseURL) else {
            return completion(.failure(.articleJSONSerializationFail))
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            self.logResponse(data: data, response: response, error: error)
            
            guard let jsonData = data,
                let jsonArticles = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: Any]],
                let articles = jsonArticles
            else {
                return completion(.failure(.articleJSONSerializationFail))
            }
            
            var resultArticles: [Article] = []
            
            for article in articles {
                guard let newArticle = Article(jsonData: article) else { continue }
                resultArticles.append(newArticle)
            }
            
            if resultArticles.count > 0 {
                completion(.success(resultArticles))
            } else {
                completion(.failure(.articleJSONSerializationFail))
            }
        }
        task.resume()
    }
    
    // MARK: User
    // Login with user object.
    // if requesting server and creating user object fail, completion argument is nil.
    func signIn(with user: User, completionBlock completion: @escaping (_ user: UserResult) -> ()){
        
        let session = URLSession.shared
        
        var jsonBody = [String: Any]()
        jsonBody[User.jsonKey.email] = user.email
        jsonBody[User.jsonKey.password] = user.password
        
        guard let body = try? JSONSerialization.data(withJSONObject: jsonBody, options: JSONSerialization.WritingOptions.prettyPrinted),
            let url = URL(string: urlPath.login)
        else {
            return completion(.failure(.userJSONSerializationFail))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = body
        request.addValue(RequestHeader.Value.json, forHTTPHeaderField: RequestHeader.Field.contentType)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            self.logResponse(data: data, response: response, error: error)
            
            guard let jsonData = data,
                let userJson = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any],
                let user = userJson
            else {
                return completion(.failure(.userJSONSerializationFail))
            }
            
            guard let resultUser = User(jsonData: user) else { return completion(.failure(UserError.userInitializationFail)) }
            completion(.success(resultUser))
        }
        task.resume()
        
    }
    
    // Sign up with user object.
    // if requesting server and creating user object fail, completion argument is nil.
    func signUp(with user: User, completionBlock completion: @escaping (_ user: UserResult) -> ()) {
        let session = URLSession.shared
        
        var jsonBody = [String: Any]()
        jsonBody[User.jsonKey.email] = user.email
        jsonBody[User.jsonKey.password] = user.password
        jsonBody[User.jsonKey.nickname] = user.nickname
        
        guard let body = try? JSONSerialization.data(withJSONObject: jsonBody, options: JSONSerialization.WritingOptions.prettyPrinted),
            let url = URL(string: urlPath.user)
        else {
            return completion(.failure(.userJSONSerializationFail))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = body
        request.addValue(RequestHeader.Value.json, forHTTPHeaderField: RequestHeader.Field.contentType)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            self.logResponse(data: data, response: response, error: error)
            
            if let urlResponse = response as? HTTPURLResponse {
                
                if urlResponse.statusCode == 406 {
                    return completion(.failure(UserError.emailOverlaped))
                }
            }
            
            guard let jsonData = data,
                let userJson = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any],
                let user = userJson
            else {
                return completion(.failure(.userJSONSerializationFail))
            }
            
            guard let resultUser = User(jsonData: user) else { return completion(.failure(UserError.userInitializationFail)) }
            completion(.success(resultUser))
        }
        task.resume()
    }
    
    // MARK: Article
    // Upload article.
    // if requesting server and creating article object fail, completion argument is nil.
    func postArticle(with article: Article, comopletionBlock completion: @escaping (_ articleResult: ArticleResult) -> ()) {
        
        let session = URLSession.shared
        
        guard let image = article.image,
            let imageData = UIImageJPEGRepresentation(image, 0.5)
        else {
            return
        }

//        var jsonBody = [String: String]()
//        jsonBody[Article.jsonKey.imageTitle] = article.imageTitle
//        jsonBody[Article.jsonKey.imageDescription] = article.imageDescription
        
        var parameters = [
            Article.jsonKey.imageTitle: article.imageTitle,
            Article.jsonKey.imageDescription: article.imageDescription
        ]

        guard let url = URL(string: urlPath.image) else { return }

        var request = URLRequest(url: url)
        let boundary = "Boundary-\(UUID().uuidString)"
        request.httpMethod = RequestMethod.post
        request.addValue("multipart/form-data; boundary=\(boundary)\r\n", forHTTPHeaderField: RequestHeader.Field.contentType)
        request.httpBody = createBody(parameters: parameters,
                              boundary: boundary,
                              data: imageData,
                              mimeType: "image/jpeg",
                              filename: "article.jpg")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            self.logResponse(data: data, response: response, error: error)
            
            guard let jsonData = data,
                let articleJSON = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                let article = articleJSON
            else {
                return completion(.failure(.articleJSONSerializationFail))
            }
            
            guard let resultArticle = Article(jsonData: article) else { return completion(.failure(.articleInitializationFail)) }
            completion(.success([resultArticle]))
        }
        task.resume()
    }
    
    
    func updateArticle(with article: Article, comopletionBlock completion: @escaping (_ articleResult: ArticleResult) -> ()) {
        let session = URLSession.shared
        
        guard let image = article.image,
            let imageData = UIImageJPEGRepresentation(image, 0.5)
        else {
            return
        }
        
        var jsonBody = [String: Any]()
        jsonBody[Article.jsonKey.imageTitle] = article.imageTitle
        jsonBody[Article.jsonKey.imageDescription] = article.imageDescription
        jsonBody[Article.jsonKey.imageData] = imageData
        
        guard let body = try? JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted),
            let url = URL(string: urlPath.image.appending("/\(article.id)"))
            else {
                return completion(.failure(.articleJSONSerializationFail))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = body
        request.addValue(RequestHeader.Value.formData, forHTTPHeaderField: RequestHeader.Field.contentType)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            self.logResponse(data: data, response: response, error: error)
            
            guard let jsonData = data,
                let articleJSON = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any],
                let article = articleJSON
                else {
                    return completion(.failure(.articleJSONSerializationFail))
            }
            
            guard let resultArticle = Article(jsonData: article) else { return completion(.failure(.articleInitializationFail)) }
            completion(.success([resultArticle]))
        }
        task.resume()
    }
    
    func deleteArticle(with article: Article, comopletionBlock completion: @escaping (_ articleResult: ArticleResult) -> ()) {
        let session = URLSession.shared
        
        guard let url = URL(string: urlPath.image.appending("/\(article.id)")) else { return completion(.failure(.articleJSONSerializationFail)) }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.delete
        
        let task = session.dataTask(with: request) { (data, response, error) in
            self.logResponse(data: data, response: response, error: error)
            
            guard let jsonData = data,
                let jsonArticles = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]],
                let article = jsonArticles?.first
                else {
                    return completion(.failure(.articleJSONSerializationFail))
            }

            guard let resultArticle = Article(jsonData: article) else { return completion(.failure(.articleInitializationFail)) }
            completion(.success([resultArticle]))
        }
        task.resume()
    }
    
    // Print Log.
    private func logResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let httpResponse = response as? HTTPURLResponse,
            let jsonData = data,
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        {
            print("response status : \(httpResponse.statusCode)")
            print("error : \(error?.localizedDescription)")
            print("data : \(jsonObject)")
        }
    }
    
    // Helper
    private func createBody(parameters: [String: String],
                            boundary: String,
                            data: Data,
                            mimeType: String,
                            filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
}
