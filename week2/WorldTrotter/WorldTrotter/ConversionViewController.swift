//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by JU HO YOON on 2017. 7. 3..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class MaView: UIView {
//    override func draw(_ rect: CGRect) {
////        let UIGraphicsBeginImageContextWithOptions(<#T##size: CGSize##CGSize#>, <#T##opaque: Bool##Bool#>, <#T##scale: CGFloat##CGFloat#>)
//    }
}

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var imageView = { () -> UIImageView in 
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 170, height: 150))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "gom").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        imageView.tintColor = UIColor.red
        imageView.isOpaque = false
       return imageView
    }()
    var imageView2 = { () -> UIImageView in
        let imageView = UIImageView(frame: CGRect(x: 170, y: 0, width: 170, height: 150))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "gom").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = UIColor.red
        imageView.isOpaque = false
        return imageView
    }()
    var imageView3 = { () -> UIImageView in
        let imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 170, height: 150))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "car").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        imageView.tintColor = UIColor.red
        imageView.isOpaque = false
        return imageView
    }()
    var imageView4 = { () -> UIImageView in
        let imageView = UIImageView(frame: CGRect(x: 170, y: 150, width: 170, height: 150))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "car").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = UIColor.red
        imageView.isOpaque = false
        return imageView
    }()
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(for: value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.imageView2)
        self.view.addSubview(self.imageView3)
        self.view.addSubview(self.imageView4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentTime = Date()
        let hour = Calendar.current.component(Calendar.Component.hour, from: currentTime)
        self.view.backgroundColor = (hour > 6 && hour < 18) ? UIColor.lightGray : UIColor.darkGray
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismisseKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check .
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        
        // Check Alphabet
        var alphabet = CharacterSet()
        alphabet.formUnion(CharacterSet.letters)
        if string.rangeOfCharacter(from: alphabet) != nil {
            return false
        }
        
        // Ultimate Check Code.
        var numberCharacters = CharacterSet()
        numberCharacters.formUnion(CharacterSet.decimalDigits)
        numberCharacters.insert(charactersIn: ".")
        if string.rangeOfCharacter(from: numberCharacters) == nil, string != "" {
            return false
        }

        return true
    }
}
