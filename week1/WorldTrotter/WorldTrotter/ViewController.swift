//
//  ViewController.swift
//  WorldTrotter
//
//  Created by JU HO YOON on 2017. 7. 2..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
        let firstView = UIView(frame: firstFrame)
        firstView.backgroundColor = UIColor.blue
        view.addSubview(firstView)
        
        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
        let secondView = UIView(frame: secondFrame)
        secondView.backgroundColor = UIColor.green
        firstView.addSubview(secondView)
        
//        UILabel.appearance().backgroundColor = UIColor.red
        
        
        let firstLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        firstLabel.text = "ASDF"
        view.addSubview(firstLabel)
        let secondLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        secondLabel.text = "^^"
        firstLabel.addSubview(secondLabel)
        
        UILabel.appearance(whenContainedInInstancesOf: [UILabel.self]).backgroundColor = UIColor.red
    }

}
