//
//  Line.swift
//  TouchTracker
//
//  Created by JU HO YOON on 2017. 7. 25..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

struct Line {
    
    var begin: CGPoint = CGPoint.zero
    var end: CGPoint = CGPoint.zero
    var lineColor: UIColor {
        get {
            let dx: Double = Double(begin.x - end.x)
            let dy: Double = Double(begin.y - end.y)
            let pi: Double = Double.pi
        
            let radians = dx / sqrt(pow(dy, 2) + pow(dx, 2))
            let angle = acos(radians) * 180 / pi
            let value = CGFloat(angle / 180)
            
            if value > 0 {
                return UIColor(red: 1 - value, green: value, blue: value, alpha: 1)
            } else if value < 0.15 {
                return UIColor(red: 1 - value, green: 1 - value, blue: value, alpha: 1)
            } else if value < 0.3 {
                return UIColor(red: 1 - value, green: value, blue: 1 - value, alpha: 1)
            } else if value < 0.45 {
                return UIColor(red: 1 - value, green: 1 - value, blue: 1 - value, alpha: 1)
            } else if value < 0.6 {
                return UIColor(red: value, green: 1 - value, blue: value, alpha: 1)
            } else if value < 0.75 {
                return UIColor(red: value, green: 1 - value, blue: 1 - value, alpha: 1)
            } else if value < 0.9 {
                return UIColor(red: 1 - value, green: value, blue: 1 - value, alpha: 1)
            } else {
                return UIColor(red: value, green: value, blue: value, alpha: 1)
            }
            
        }
    }
}
