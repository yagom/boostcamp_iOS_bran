//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by JU HO YOON on 2017. 7. 4..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        let webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        let url = URL(string: "https://www.bignerdranch.com")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0).isActive = true
    }
}
