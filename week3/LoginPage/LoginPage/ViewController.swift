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
    @IBOutlet weak var signInButton: MyButton!
    @IBOutlet weak var signInControlButton: MyControlButton!
    
    //MARK: Actions.
    @IBAction func signInButtonTouchUpInside(_ sender: UIButton) {
        print("touch up inside - sign in")
        guard let id = self.idTextField.text, let password = self.passwordTextField.text else { return }
        print("ID : \(id), PW : \(password)")
    }
    
    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        print("touch up inside - sign up")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set button text.
        let highlightedWithSelected = UIControlState.selected.union(.highlighted)
        self.signInButton.setTitle(title: "Normal", for: .normal)
        self.signInButton.setTitle(title: "Highlighted", for: .highlighted)
        self.signInButton.setTitle(title: "Highlighted2", for: highlightedWithSelected)
        self.signInButton.setTitle(title: "Selected", for: .selected)
        self.signInButton.setTitle(title: "Disabled", for: .disabled)
        
        // Set button image.
        let image = #imageLiteral(resourceName: "buttonBorder")
        self.signInButton.setBackgroundImage(image: image.withRenderingMode(.alwaysTemplate), for: .normal)
        self.signInButton.setBackgroundImage(image: image.withRenderingMode(.alwaysTemplate), for: .highlighted)
        self.signInButton.setBackgroundImage(image: image, for: .selected)
        self.signInButton.setBackgroundImage(image: image, for: highlightedWithSelected)
        
        // Set button target.
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(self.touchUpOutsideSignInButton(sender:)), for: .touchUpOutside)
        self.signInButton.addTarget(self, action: #selector(self.touchDownSignInButton(sender:)), for: .touchDown)
        
        self.signInControlButton.addTarget(self, action: #selector(self.touchUpInsideDisableButton), for: .touchUpInside)
        
        /*
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .allEvents)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchDown)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchDownRepeat)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchDragInside)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchDragOutside)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchDragEnter)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchDragExit)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchUpOutside)
        self.signInButton.addTarget(self, action: #selector(self.touchUpInsideSignInButton(sender:)), for: .touchCancel)
        */
        
        /* iOS 9이상에서는 object가 소멸될때(dealloc) 자신이 observer인 것들을 삭제한다.
            모두 중복이면 한번만 불리고, 메서드가 다르거나 envet가 다르면 각 각 불리며, target에 nil을 주면 responder chain을 따라 action갖는 target을 찾아냄.-> 중복 불림.
        var viewController: UIViewController? = UIViewController()
        self.uiButton.addTarget(self, action: #selector(self.touchUpInsideUIButton), for: .touchUpInside)
        self.uiButton.addTarget(self, action: #selector(self.touchUpInsideUIButton), for: .touchUpInside)
        self.uiButton.addTarget(self, action: #selector(self.touchUpInsideUIButton2), for: .touchUpInside)
        self.uiButton.addTarget(viewController, action: #selector(ViewController.tempMethod), for: .touchUpInside)
        viewController = nil
        */
    }
    
    func touchUpInsideDisableButton() {
        self.signInButton.isEnabled = !self.signInButton.isEnabled
    }
    
    @objc private func touchDownSignInButton(sender: Notification){
        print("Touch Down Sign In Button \(sender.object)")
    }
    
    @objc private func touchUpInsideSignInButton(sender: MyButton){
        print("Touch Up Inside Sign In Button \(sender)")
    }
    
    @objc private func touchUpOutsideSignInButton(sender: MyButton) {
        print("Touch Up Outside Sign In Button \(sender)")
    }
}
