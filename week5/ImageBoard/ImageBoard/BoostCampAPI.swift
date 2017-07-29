//
//  BoostCampAPI.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class BoostCampAPI {
    
    struct urlPath {
        static let baseURL = "https://ios-api.boostcamp.connect.or.kr/"
        static let login = urlPath.baseURL + "login"
        static let user = urlPath.baseURL + "user"
        static let image = urlPath.baseURL + "image"
    }
    
    static let shared = BoostCampAPI()
    
    @discardableResult func allBoard(completionBlock completion: @escaping (_ articles: [Article]?) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: urlPath.baseURL) else { return completion(nil) }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else { return completion(nil) }
            do {
                guard let articles = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: Any]] else { return }
                
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
                
            } catch {
                
            }
            
        }
        task.resume()
    }
    
}
