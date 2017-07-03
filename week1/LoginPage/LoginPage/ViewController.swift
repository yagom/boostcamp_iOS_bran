//
//  ViewController.swift
//  LoginPage
//
//  Created by JU HO YOON on 2017. 7. 1..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties.
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Actions.
    @IBAction func signInButtonTouchUpInside(_ sender: UIButton) {
        print("touch up inside - sign in")
        guard let id = self.idTextField.text, let password = self.passwordTextField.text else { return }
        print("ID : \(id), PW : \(password)")
    }
    
    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        print("touch up inside - sign up")
    }
}
