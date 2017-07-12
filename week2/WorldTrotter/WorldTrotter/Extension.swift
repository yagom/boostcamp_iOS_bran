//
//  Extension.swift
//  WorldTrotter
//
//  Created by JU HO YOON on 2017. 7. 11..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var image: UIImage? {
        
        let size = CGSize(width: 30, height: 35)
        let rect = CGRect(origin: .zero, size: size)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.clear.set()
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 30)])
        UIGraphicsEndImageContext()
        
        return image
    }
//    func image() -> UIImage {
//        
//    }
}
