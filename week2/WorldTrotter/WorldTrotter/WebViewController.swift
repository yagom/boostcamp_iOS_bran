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
    
    // 이미 스토리보드에 view가 추가되어 있으니 loadView를 재정의 할 필요가 없습니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        
        guard let url = URL(string: "https://www.bignerdranch.com") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0).isActive = true
    }
}
