//
//  BRImageView.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class BRImageView: UIImageView {
    
    fileprivate var downloadProgressView: UIProgressView = {
       let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor = UIColor.red
        return progressView
    }()
    fileprivate var layoutDidSet = false
    fileprivate var completionBlock: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layoutDidSet == false {
            self.addSubview(self.downloadProgressView)
            self.downloadProgressView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            self.downloadProgressView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            self.downloadProgressView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.downloadProgressView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.layoutDidSet = true
        }
    }
}

extension BRImageView {
    
    override func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        self.downloadImage(url: url)
    }
    
    override func downloadImage(url: URL) {
        self.image = #imageLiteral(resourceName: "no_image")
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        
        self.downloadProgressView.isHidden = false
        
        task.resume()
    }
    
    func downloadImage(path: String, completion: @escaping () -> () ) {
        guard let url = URL(string: path) else { return }
        self.image = #imageLiteral(resourceName: "no_image")
        self.completionBlock = completion
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        
        self.downloadProgressView.isHidden = false
        
        task.resume()
    }
}

extension BRImageView {
    
    public override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if FileManager.default.fileExists(atPath: location.path) {
            guard let data = FileManager.default.contents(atPath: location.path) else { return }
            DispatchQueue.main.async {
                self.downloadProgressView.isHidden = true
                self.image = UIImage(data: data)
            }
            self.completionBlock?()
            self.completionBlock = nil
            
        }
    }
    
    public override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentageWritten = (Double(totalBytesWritten) / Double(totalBytesExpectedToWrite))
        DispatchQueue.main.async {
            self.downloadProgressView.setProgress(Float(percentageWritten), animated: true)
        }
    }
}
