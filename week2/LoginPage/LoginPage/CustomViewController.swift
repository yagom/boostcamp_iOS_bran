//
//  CustomViewController.swift
//  LoginPage
//
//  Created by JU HO YOON on 2017. 7. 12..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    var customView: CustomLoginView!
    var layoutConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView = CustomLoginView(frame: .zero)
        self.view.addSubview(customView)
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        customView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        customView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.layoutConstraint = customView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.layoutConstraint.isActive = true
        let temp = customView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200)
        temp.priority = 500
        temp.isActive = true
        
        customView.loginButton.addTarget(self, action: #selector(self.buttonTap), for: .touchUpInside)
    }
    
    func buttonTap(){
//        self.customView.layoutIfNeeded()
//        self.customView.setNeedsLayout()
//        self.view.layoutIfNeeded()
        
//        self.layoutConstraint.isActive = false
//        self.customView.setNeedsUpdateConstraints()
        
//        self.customView.loginButton.leftAnchor.constraint(equalTo: customView.leftAnchor).isActive = true
//        for cons in self.customView.constraints {
//            print(cons.identifier)
//        }
//        self.view.frame = self.view.frame.insetBy(dx: 20, dy: 20)
//        self.customView.imageView.removeFromSuperview()
//        print("number of constraints: \(self.customView.constraints.count)")
    }
}

class CustomLoginView: UIView {
    var imageView: UIImageView!
    var idTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews(){
        self.backgroundColor = UIColor.white
        self.imageView = UIImageView(frame: .zero)
        self.imageView.image = #imageLiteral(resourceName: "gom")
        self.imageView.contentMode = .scaleAspectFit
        self.idTextField = UITextField()
        self.idTextField.placeholder = "ID"
        self.passwordTextField = UITextField()
        self.passwordTextField.placeholder = "PASSWORD"
        self.loginButton = UIButton(type: .system)
        self.loginButton.setTitle("Login", for: .normal)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.idTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.imageView)
        self.addSubview(self.idTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.loginButton)
        
//        self.loginButton.setContentHuggingPriority(UILayoutPriority, for: <#T##UILayoutConstraintAxis#>)
        
        let c1 = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8)
        c1.identifier = "c1"
        c1.isActive = true
        let c2 = NSLayoutConstraint(item: self.imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8)
        c2.identifier = "c2"
        c2.isActive = true
        let c3 = NSLayoutConstraint(item: self.imageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -8)
        c3.identifier = "c3"
        c3.isActive = true
        let c4 = NSLayoutConstraint(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        c4.identifier = "c4"
        c4.isActive = true
        
        let d1 = NSLayoutConstraint(item: self.idTextField, attribute: .top, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1, constant: 8)
        d1.identifier = "d1"
        d1.isActive = true
        let d2 = NSLayoutConstraint(item: self.idTextField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        d2.identifier = "d2"
        d2.isActive = true
        let d3 = NSLayoutConstraint(item: self.idTextField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.6, constant: 8)
        d3.identifier = "d3"
        d3.isActive = true
        
        let e1 = NSLayoutConstraint(item: self.passwordTextField, attribute: .top, relatedBy: .equal, toItem: self.idTextField, attribute: .bottom, multiplier: 1, constant: 8)
        e1.identifier = "e1"
        e1.isActive = true
        let e2 = NSLayoutConstraint(item: self.passwordTextField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        e2.identifier = "e2"
        e2.isActive = true
        let e3 = NSLayoutConstraint(item: self.passwordTextField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.6, constant: 8)
        e3.identifier = "e3"
        e3.isActive = true
        
        let f1 = NSLayoutConstraint(item: self.loginButton, attribute: .top, relatedBy: .equal, toItem: self.passwordTextField, attribute: .bottom, multiplier: 1, constant: 8)
        f1.identifier = "f1"
        f1.isActive = true
        let f2 = NSLayoutConstraint(item: self.loginButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        f2.priority = 500
        f2.identifier = "f2"
        f2.isActive = true
        let f3 = NSLayoutConstraint(item: self.loginButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.6, constant: 8)
        f3.identifier = "f3"
        f3.isActive = true
    }
    override func display(_ layer: CALayer) {
        super.display(layer)
        print("display")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews()")
        for view in self.subviews {
        }
    }
    
    override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        print("updateConstraintsIfNeeded()")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print("layoutIfNeeded()")
    }
    override func updateConstraints() {
        super.updateConstraints()
        print("updateConstraints()")
        
    }
    
}
