//
//  CocoaExtension.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        self.downloadImage(url: url)
    }
    
    func downloadImage(url: URL) {
        self.image = #imageLiteral(resourceName: "no_image")
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        
        task.resume()
    }
}

extension UIImageView: URLSessionDownloadDelegate {
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if FileManager.default.fileExists(atPath: location.path) {
            guard let data = FileManager.default.contents(atPath: location.path) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentageWritten = (Double(totalBytesWritten) / Double(totalBytesExpectedToWrite))
        print("\(Int(percentageWritten * 100))%")
    }
}
