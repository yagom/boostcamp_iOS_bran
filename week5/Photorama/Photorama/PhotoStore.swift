//
//  PhotoStore.swift
//  Photorama
//
//  Created by JU HO YOON on 2017. 7. 31..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class PhotoStore {
    
    let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()
    
    // 동메달 과제: 응답 정보 출력하기
    func logResponse(response: URLResponse?) {
        if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
            for headerField in httpResponse.allHeaderFields {
                print("\(headerField.key) : \(headerField.value)")
            }
        }
    }
    
    // Fetch From Server
    func fetchRecentPhotos(completion completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            [unowned self] (data, response, error) -> Void in
            
//            self.logResponse(response: response)

            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        
        if let image = photo.image {
            completion(.success(image))
            return
        }
        
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
//            self.logResponse(response: response)
            
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                photo.image = image
            }
            completion(result)
            
        }
        task.resume()
    }
    
    // Process
    func processRecentPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else { return .failure(error!)}
        
        return FlickrAPI.photosFromJSONData(jsonData)
    }
    
    func processImageRequest(data data: Data?, error: Error?) -> ImageResult {
        guard let imageData = data,
            let image = UIImage(data: imageData)
        else {
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(PhotoError.imageCreationError)
            }
        }
        return .success(image)
    }
}
