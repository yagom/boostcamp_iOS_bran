//
//  ViewController.swift
//  Tutoring
//
//  Created by JU HO YOON on 2017. 7. 27..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UITextView!
    
    var item: Item!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let item = item {
            
            titleField.text = item.title
            descriptionView.text = item.content
        }
        titleField.delegate = self
        descriptionView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let title = titleField.text {
            item.title = title
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let description = descriptionView.text {
            item.content = description
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let title = titleField.text {
            item.title = title
        }
        return true
    }
    
}

