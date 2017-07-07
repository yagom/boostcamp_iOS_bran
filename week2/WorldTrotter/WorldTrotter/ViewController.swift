//
//  ViewController.swift
//  WorldTrotter
//
//  Created by JU HO YOON on 2017. 7. 2..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {
    
    var textLabel: UILabel!
    @IBInspectable var labelFontSize: CGFloat = 0.0 {
        didSet {
            self.textLabel.font = UIFont.systemFont(ofSize: labelFontSize)
            
        }
    }
    
    struct Person: Equatable {
        var name: String
        var age: Int
        
        static func+(lhs: Person, rhs: Int) -> Person {
            return Person(name: lhs.name, age: lhs.age + rhs)
        }
        
        static prefix func++(lhs: inout Person) -> Person {
            lhs.age += 1
            return lhs
        }
        
        public static func ==(gasdf2: Person, rhs2: Person) -> Bool {
            return true
        }
    }
    
    override func viewDidLoad() {
        let p1 = Person(name: "asdf", age: 1)
        let p2 = Person(name: "dfdfdf", age: 2)
        let isSame: Bool = (p1 == p2)
        if p1 == p2 {
            
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
//        let firstView = UIView(frame: firstFrame)
//        firstView.backgroundColor = UIColor.blue
//        view.addSubview(firstView)
//        
//        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
//        let secondView = UIView(frame: secondFrame)
//        secondView.backgroundColor = UIColor.green
//        firstView.addSubview(secondView)
//        
////        UILabel.appearance().backgroundColor = UIColor.red
//        
//        
//        let firstLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
//        firstLabel.text = "ASDF"
//        view.addSubview(firstLabel)
//        let secondLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
//        secondLabel.text = "^^"
//        firstLabel.addSubview(secondLabel)
//        
//        UILabel.appearance(whenContainedInInstancesOf: [UILabel.self]).backgroundColor = UIColor.red
//    }

}
