//
//  ImageDetailViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 8. 1..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        return scrollView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.addSubview(self.imageView)
        self.view.addSubview(self.scrollView)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
    }
}
