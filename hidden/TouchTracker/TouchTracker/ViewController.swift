//
//  ViewController.swift
//  TouchTracker
//
//  Created by JU HO YOON on 2017. 7. 11..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeView))
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapView(gestureRecognizer:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delaysTouchesBegan = true
        self.view.addGestureRecognizer(doubleTapGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView))
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        tapGestureRecognizer.delaysTouchesBegan = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressView))
        longPressGestureRecognizer.require(toFail: longPressGestureRecognizer)
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(longPressGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panView))
        panGestureRecognizer.cancelsTouchesInView = true
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    var panCount = 0
    func panView(panGestureRecognizer: UIPanGestureRecognizer){
        panCount += 1
        if panCount > 5 { return }
        print("Pan")
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func longPressView(){
        print("longPressView")
    }
    
    func swipeView(){
        print("swipeView")
    }
    
    func doubleTapView(gestureRecognizer: UITapGestureRecognizer) {
        print("double Tap")
    }
    
    func tapView(gestureRecognizer: UIGestureRecognizer){
        print("tap")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchBegan")
    }


}

