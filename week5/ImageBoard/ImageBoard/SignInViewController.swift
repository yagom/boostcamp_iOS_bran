//
//  ViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

// UIApplicationDidReceiveMemoryWarning 처럼 시점을 써주면 좋습니다.
// DidUserSignInSuccess
let UserSignInSuccess: Notification.Name = Notification.Name(rawValue: "UserSignInSuccess")

class SignInViewController: UIViewController {

    // IBOutlet Subviews
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: User?
    
    // IBAction
    @IBAction func signInButtonTap(_ sender: UIButton) {
        guard let email = self.emailTextField.text,
            let password = self.passwordTextField.text
        else {
            return
        }
        
        let requestUser = User(email: email, password: password)
        BoostCampAPI.shared.signIn(with: requestUser) { (responseUser) in
            switch responseUser {
            case let .success(user):
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: UserSignInSuccess, object: user)
                }
                break
            case let .failure(error):
                break
            }
            
        }
    }
    
    // ViewController Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSignUpViewController" {
            guard let signUpViewController = segue.destination as? SignUpViewController else { return }
            signUpViewController.delegate = self
        }
    }
}

extension SignInViewController: SignUpViewControllerDelegate {
    func signUpViewController(_: SignUpViewController, signUpSuccessWith user: User) {
        
        self.user = user
        self.emailTextField.text = user.email
        
        let alertController = UIAlertController(title: "회원가입완료", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
