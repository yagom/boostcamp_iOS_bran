//
//  SignUpViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 8. 1..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate {
    func signUpViewController(_: SignUpViewController, signUpSuccessWith user:User)
}

class SignUpViewController: UIViewController {
    
    // IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    // Delegate
    var delegate: SignUpViewControllerDelegate?
    
    // IBAction
    @IBAction func signUpButtonDidTap(_ sender: UIButton) {
        
        guard self.validateAllTextField() else { return }
        
        guard let email = emailTextField.text,
            let nickname = nicknameTextField.text,
            let password = passwordTextField.text
        else {
            return
        }
        let newUser = User(email: email, password: password, nickname: nickname)
        
        BoostCampAPI.shared.signUp(with: newUser) { (userResult) in
            
            DispatchQueue.main.async {
                
                // switch 구문에서 enum의 모든 case를 명시했을 경우에는 default를 작성하지 않아도 됩니다. (동작할 일이 없으므로)
                switch userResult {
                case let .success(user):
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.signUpViewController(self, signUpSuccessWith: user)
                case let .failure(userError):
                    let alertTitle = "알림"
                    var message: String?
                    
                    switch userError {
                    case .emailOverlaped:
                        message = "Code : 403\nMessage : Fobidden\n[\"error\":\"email overlaped!\"]"
                    case .userInitializationFail:
                        message = "Init Error"
                    case .userJSONSerializationFail:
                        message = "Serialization Error"
                    default:
                        message = "Default"
                    }
                    
                    let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    // Validate SignUp TextFields
    private func validateAllTextField() -> Bool {
        return (self.validateNoEmptyField() && self.validateEmailFormat() && self.validatePasswordCheck())
    }
    
    private func validateNoEmptyField() -> Bool {
        if let email = self.emailTextField.text,
            let nickname = self.nicknameTextField.text,
            let password = self.passwordTextField.text,
            let passwordCheck = self.passwordCheckTextField.text {
            
            if email.characters.count > 0
                && nickname.characters.count > 0
                && password.characters.count > 0
                && passwordCheck.characters.count > 0 {
                
                return true
            }
        }
        
        let alertController = UIAlertController(title: "입력하지 않은 필드가 존재합니다.", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        return false
    }
    
    private func validateEmailFormat() -> Bool {
        guard let email = self.emailTextField.text else { return false }
        let emailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "self matches %@", emailRegularExpression)
        let isEmailFormat = predicate.evaluate(with: email)
        
        self.emailTextField.textColor = isEmailFormat ? .black : .red
        return isEmailFormat
    }
    
    private func validatePasswordCheck() -> Bool {
        if let password = self.passwordTextField.text,
            let passwordCheck = self.passwordCheckTextField.text {

            if (password.characters.count > 0 && passwordCheck.characters.count > 0 && password == passwordCheck) {
                return true
            }
        }
        
        let alertController = UIAlertController(title: "암호와 암호확인이 일치하지 않습니다.", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        return false
    }

    // ViewController Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "회원가입"
        
        self.emailTextField.delegate = self
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.emailTextField {
            // TODO: 한발 늦게 작동함 replace text이기 떄문에.
            guard var text = textField.text else { return true }
            
        } else {
            
        }
        
        return true
    }
}
