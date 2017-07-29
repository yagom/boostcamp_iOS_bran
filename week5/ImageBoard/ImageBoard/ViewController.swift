//
//  ViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BoostCampAPI.shared.allBoard { (articles) in
            print(articles)
        }
    }
    
}

