//
//  FlickrAPI.swift
//  Photorama
//
//  Created by JU HO YOON on 2017. 7. 31..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

enum Method: String {
    case recentPhotos = "flickr.photos.getRecent"
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

enum FlickrError: Error {
    case invalidJSONData
}

struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:MM:ss"
        return formatter
    }()
    
    private static func flickrURL(method: Method, parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)
        
        var queryItems = [URLQueryItem]()
        
        let baseParams: [String: String] = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components?.queryItems = queryItems
        
        if let url = components?.url {
            return url
        } else {
            return URL(string: "")!
        }
    }
    
    static func recentPhotosURL() -> URL {
        return flickrURL(method: .recentPhotos, parameters: ["extras" : "url_h, date_taken"])
    }
    
    static func photosFromJSONData(_ data: Data) -> PhotosResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let jsonDictionary = jsonObject as? [String: Any],
                let photos = jsonDictionary["photos"] as? [String: AnyObject],
                let photosArray = photos["photo"] as? [[String: AnyObject]]
            else {
                return .failure(FlickrError.invalidJSONData)
            }
            
            var finalPhotos = [Photo]()
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(photoJSON) {
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .failure(FlickrError.invalidJSONData)
            }
            
            return .success(finalPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func photoFromJSONObject(_ json: [String: AnyObject]) -> Photo? {
        guard let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["datetaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = self.dateFormatter.date(from: dateString)
        else {
            return nil
        }
        
        return Photo(title: title, remoteURL: url, photoID: photoID, dateTaken: dateTaken)
    }
}
