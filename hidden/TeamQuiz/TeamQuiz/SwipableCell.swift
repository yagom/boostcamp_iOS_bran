//
//  SwipableCell.swift
//  TeamQuiz
//
//  Created by JU HO YOON on 2017. 7. 19..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class SwipableCell: UITableViewCell {
    
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    var pointStarted: CGPoint?
    var frameStarted: CGRect?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
        self.setupGestureRecognizer()
    }
    
    private func setupViews(){
        self.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        
        self.leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        self.leftButton.translatesAutoresizingMaskIntoConstraints = false
        self.leftButton.setTitle("LeftAction", for: .normal)
        self.leftButton.backgroundColor = UIColor.brown
        self.contentView.addSubview(self.leftButton)
        
        self.leftButton.rightAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.leftButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.leftButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.leftButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    private func setupGestureRecognizer(){
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        swipeLeftGestureRecognizer.direction = .left
        self.contentView.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        swipeRightGestureRecognizer.direction = .right
        self.contentView.addGestureRecognizer(swipeRightGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.didReceivePanGestureRecognizer(sender:)))
        self.contentView.addGestureRecognizer(panGestureRecognizer)
        
        self.contentView.backgroundColor = #colorLiteral(red: 0.1333334148, green: 0.5411764979, blue: 0.9019607902, alpha: 1)
    }
    
    func didReceivePanGestureRecognizer(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            self.pointStarted = sender.location(in: self)
        case .changed:
            print("cc")
            let currentPoint = sender.location(in: self)
            let xDiff = pointStarted!.x - currentPoint.x
            if  xDiff > 0 {
                if xDiff > 100 { return }
                // swipe left.
//                print("left")
                let currentFrame = self.contentView.frame
                self.contentView.frame = CGRect(x: self.frame.origin.x - xDiff, y: currentFrame.origin.y, width: currentFrame.width, height: currentFrame.height)
            } else {
                if xDiff < -100 { return }
                // swipe right.
//                print("right")
                let currentFrame = self.contentView.frame
                self.contentView.frame = CGRect(x: self.frame.origin.x - xDiff, y: currentFrame.origin.y, width: currentFrame.width, height: currentFrame.height)
            }
        case .cancelled:
            print("cancelled")
            break
        case .ended:
            print("ended")
            print(self.contentView.frame.origin.x)
            if (self.contentView.frame.origin.x) > 40 {
                print("up")
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentView.frame.origin = CGPoint(x: self.frame.origin.x + 100, y: self.contentView.frame.origin.y)
                })
                
            } else if (self.contentView.frame.origin.x) < -40 {
                print("down")
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentView.frame.origin = CGPoint(x: self.frame.origin.x - 100, y: self.contentView.frame.origin.y)
                })
            } else {
                self.contentView.frame = self.frame
            }
            break
        case .failed:
            print("failed")
            break
        case .possible:
            print("possible")
            break
        }
    }
    
    func swipeRight(){
        print("swipe right")
//        let initialFrame = self.contentView.frame
//        UIView.animate(withDuration: 0.5) { 
//            self.contentView.frame = CGRect(x: 100, y: 0, width: initialFrame.width, height: initialFrame.height)
//        }        
    }
    
    func swipeLeft(){
        print("swipe left")
//        let initialFrame = self.contentView.frame
//        UIView.animate(withDuration: 0.5) {
//            self.contentView.frame = CGRect(x: -100, y: 0, width: initialFrame.width, height: initialFrame.height)
//        }
    }
    
    func tap(){
        print("tap")
    }
}
