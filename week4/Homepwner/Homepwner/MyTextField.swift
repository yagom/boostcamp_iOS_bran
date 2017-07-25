//
//  MyTextField.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 25..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

// 은메달 과제: UITextField 사용자화
class MyTextField: UITextField {
    override func becomeFirstResponder() -> Bool {
//        self.borderStyle = .bezel
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
//        self.borderStyle = .roundedRect
        self.layer.borderWidth = 0
        return super.resignFirstResponder()
    }
}
