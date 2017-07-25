//
//  DrawView.swift
//  TouchTracker
//
//  Created by JU HO YOON on 2017. 7. 25..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation
import UIKit

class DrawView: UIView {
    
//    var currentLine: Line?
    var finishedLines = [Line]()
    var currentLines = [NSValue: Line]()
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = self.lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        self.finishedLineColor.setStroke()

        for line in finishedLines {
            self.strokeLine(line: line)
        }

//        if let line = currentLine {
//            UIColor.red.setStroke()
//            strokeLine(line: line)
//        }
        self.currentLineColor.setStroke()
        for (_ , line) in self.currentLines {
            self.strokeLine(line: line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        currentLine = Line(begin: location, end: location)
        
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            
            let key = NSValue(nonretainedObject: touch)
            self.currentLines[key] = newLine
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        currentLine?.end = location

        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            self.currentLines[key]?.end = touch.location(in: self)
            
            self.currentLines[key]?
            
        }
        
        self.setNeedsDisplay()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if var line = currentLine {
//            let touch = touches.first!
//            let location = touch.location(in: self)
//            line.end = location
//            
//            finishedLines.append(line)
//        }
//        currentLine = nil
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                
                self.finishedLines.append(line)
                self.currentLines.removeValue(forKey: key)
            }
            self.currentLines[key]?.end = touch.location(in: self)
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentLines.removeAll()
        
        self.setNeedsDisplay()
    }
}
