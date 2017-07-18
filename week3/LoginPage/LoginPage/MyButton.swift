//
//  MyButton.swift
//  LoginPage
//
//  Created by JU HO YOON on 2017. 7. 14..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

@IBDesignable
class MyButton: UIView {
    
    // Subviews Properties.
    private var titleLabel: UILabel!
    private var backgroundImageView: UIImageView!
    open var backgroundImage: UIImage? {
        didSet {
            self.backgroundImageView.image = backgroundImage
        }
    }
    
    // State Property(get-only).
    open var state: UIControlState {
        get {
            var currentState = self.isSelected ? UIControlState.selected : UIControlState.normal
            if self.isHighlighted { currentState.formUnion(UIControlState.highlighted) }
            if (self.isEnabled == false) { currentState.formUnion(UIControlState.disabled) }
            return currentState
        }
    }
    
    // Custom Text and Image Array.
    private var textForStates: [UInt: String?] = [UIControlState.normal.rawValue: "MyButton",
                                                UIControlState.disabled.rawValue: "MyButton",
                                                UIControlState.highlighted.rawValue: "MyButton",
                                                UIControlState.selected.rawValue: "MyButton",
                                                UIControlState.application.rawValue: "MyButton",
                                                UIControlState.reserved.rawValue: "MyButton",
                                                UIControlState.focused.rawValue: "MyButton",
                                                UIControlState.selected.union(UIControlState.highlighted).rawValue: nil]
    private var imageForStates: [UInt: UIImage?] = [UIControlState.normal.rawValue: nil,
                                                  UIControlState.disabled.rawValue: nil,
                                                  UIControlState.highlighted.rawValue: nil,
                                                  UIControlState.selected.rawValue: nil,
                                                  UIControlState.application.rawValue: nil,
                                                  UIControlState.reserved.rawValue: nil,
                                                  UIControlState.focused.rawValue: nil,
                                                  UIControlState.selected.union(UIControlState.highlighted).rawValue: nil]
    
    // Custom Properties.
    open var titleColorNormal = #colorLiteral(red: 0.2862745225, green: 0.3137254119, blue: 0.3411764205, alpha: 1)
    open var titleColorDiable = #colorLiteral(red: 0.9137255549, green: 0.9254901409, blue: 0.9372548461, alpha: 1)
    open var titleColorHighlighted = #colorLiteral(red: 0.2862745225, green: 0.3137254119, blue: 0.3411764205, alpha: 1)
    open var titleColorSelected = #colorLiteral(red: 0.2862745225, green: 0.3137254119, blue: 0.3411764205, alpha: 1)
    
    open var backgroundColorNormal = UIColor.white
    open var backgroundColorDisable = UIColor.white
    open var backgroundColorHighlighted = #colorLiteral(red: 0.9450982213, green: 0.9529412389, blue: 0.9607843757, alpha: 1)
    open var backgroundColorSelected = #colorLiteral(red: 0.9450982213, green: 0.9529412389, blue: 0.9607843757, alpha: 1)
    
    open var borderColorNormal = #colorLiteral(red: 0.8078432679, green: 0.8313725591, blue: 0.8549019694, alpha: 1)
    open var borderColorDisable = #colorLiteral(red: 0.9137255549, green: 0.9254901409, blue: 0.9372548461, alpha: 1)
    
    // open Properties
    open var isHighlighted: Bool = false {
        didSet {
            if self.isHighlighted {
                self.backgroundColor = self.backgroundColorHighlighted
                self.titleLabel.textColor = self.titleColorHighlighted
            } else {
                self.backgroundColor = self.backgroundColorNormal
                self.titleLabel.textColor = self.titleColorNormal
            }
            self.changeTextAndImageWithCurrentState()
        }
    }
    open var isEnabled: Bool = true {
        didSet {
            if self.isEnabled {
                self.layer.borderColor = self.borderColorNormal.cgColor
                self.titleLabel.textColor = self.titleColorNormal
                self.isUserInteractionEnabled = true
            } else {
                self.backgroundColor = self.backgroundColorDisable
                self.layer.borderColor = self.borderColorDisable.cgColor
                self.titleLabel.textColor = self.titleColorDiable
                self.isUserInteractionEnabled = false
            }
            self.changeTextAndImageWithCurrentState()
            self.backgroundColor = self.isSelected ? self.backgroundColorSelected : self.backgroundColorNormal
        }
    }
    open var isSelected: Bool = false {
        didSet {
            if self.isSelected {
                self.backgroundColor = self.backgroundColorSelected
                self.titleLabel.textColor = self.titleColorSelected
            } else {
                self.backgroundColor = self.backgroundColorNormal
                self.titleLabel.textColor = self.titleColorNormal
            }
            self.changeTextAndImageWithCurrentState()
        }
    }
    
    // Initializer.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    private func setupViews(){
        // MyButton.
        self.layer.borderWidth = 1
        self.layer.borderColor = self.borderColorNormal.cgColor
        self.layer.cornerRadius = 5
        
        // Title Label.
        self.titleLabel = UILabel()
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = self.titleColorNormal
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // Background Image View.
        self.backgroundImageView = UIImageView()
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(self.backgroundImageView, belowSubview: self.titleLabel)
        
        self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    // MARK: Functions about touches.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.isHighlighted = true
        NotificationCenter.default.post(name: Notification.Name.init("TouchDown"), object: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.isHighlighted = false
        
        guard let pointEnded = touches.first?.location(in: self) else { return }
        let frameEnded = CGRect(origin: pointEnded, size: self.frame.size)
        let isTouchUpInside = self.frame.intersects(frameEnded)
        
        if isTouchUpInside {
            NotificationCenter.default.post(name: Notification.Name.init("TouchUpInside"), object: self)
            self.isSelected = !self.isSelected
        } else {
            NotificationCenter.default.post(name: Notification.Name.init("TouchUpOutside"), object: self)
        }
        
    }
    
    // MARK: Functions target and selector.
    open func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        
        // Any? 가 any로 항상 성공?
//        let temp = target as Any
        if target == nil {
            var next: UIResponder? = self.next
            while next != nil {
                if next!.responds(to: action) {
//                    print("next: \(next)")
                    break
                }
                next = next!.next
            }
        }
        guard let observerFound = next else { return }
        let observer = target ?? observerFound
        
        switch controlEvents {
        case UIControlEvents.touchDown:
            NotificationCenter.default.addObserver(observer, selector: action, name: Notification.Name.init("TouchDown"), object: self)
        case UIControlEvents.touchUpInside:
            NotificationCenter.default.addObserver(observer, selector: action, name: Notification.Name.init("TouchUpInside"), object: self)
        case UIControlEvents.touchUpOutside:
            NotificationCenter.default.addObserver(observer, selector: action, name: Notification.Name.init("TouchUpOutside"), object: self)
        default :
            break
        }
    }
    
    // MARK: Functions for text and image of each states.
    open func setTitle(title: String, for state: UIControlState) {
        self.textForStates.updateValue(title, forKey: state.rawValue)
        if self.state == state {
            self.changeTextAndImageWithCurrentState()
        }
    }
    
    open func setBackgroundImage(image: UIImage?, for state: UIControlState) {
        self.imageForStates.updateValue(image, forKey: state.rawValue)
        if self.state == state {
            self.changeTextAndImageWithCurrentState()
        }
    }
    
    private func changeTextAndImageWithCurrentState() {
        guard let text = self.textForStates[self.state.rawValue] else { return }
        guard let image = self.imageForStates[self.state.rawValue] else { return }
        self.titleLabel.text = text
        self.backgroundImage = image
    }
}
