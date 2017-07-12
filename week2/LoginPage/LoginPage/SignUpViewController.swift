//
//  SignUpViewController.swift
//  LoginPage
//
//  Created by JU HO YOON on 2017. 7. 9..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: View Properties.
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    //MARK: Overiding Properties.
    override open var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return UIInterfaceOrientationMask.all
        }
    }
    
    //MARK: UIViewController Functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Add TapGestureRecognizer at profileImageView programmatically.
//        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInsideProfileImageView(sender:)))
//        self.profileImageView.addGestureRecognizer(tapGestureRecognizer1)
        
//        // Add TapGestureRecognizer at self.view to dismiss keyboard programmatically.
//        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(sender:)))
//        self.view.addGestureRecognizer(tapGestureRecognizer2)
        
        // Add UITextFieldDelegate.
        self.passwordTextField.isSecureTextEntry = true
        self.passwordCheckTextField.isSecureTextEntry = true
        self.idTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordCheckTextField.delegate = self
        
        
    }
    
    func didChangeKeyboardVisible(){
        
    }
    
    //MARK: Actions.
    @IBAction func touchUpInsideProfileImageView(sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        self.idTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordCheckTextField.resignFirstResponder()
        self.bioTextView.resignFirstResponder()
    }
    
    @IBAction func touchUpInsideCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpInsideSignUpButton(_ sender: UIButton) {
        if let password = passwordTextField.text, let passwordCheck = passwordCheckTextField.text {
            if !password.isEmpty && !passwordCheck.isEmpty && password == passwordCheck {
                self.dismiss(animated: true, completion: nil)
                return
            }
        }
        print("check password")
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: UIImagePickerControllerDelegate.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.profileImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
