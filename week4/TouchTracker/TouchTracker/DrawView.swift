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
    var finishedCircles = [Circle]()
    var currentCircle = [NSValue: Circle]()
    
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
    
    func strokeCircle(circle: Circle) {
        let path = UIBezierPath()
        path.addArc(withCenter: circle.center, radius: circle.radius, startAngle: 0, endAngle: 90, clockwise: true)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
//        self.finishedLineColor.setStroke()

        for line in finishedLines {
            line.lineColor.setStroke()
            self.strokeLine(line: line)
        }
        
        for circle in finishedCircles {
            UIColor.black.setStroke()
            self.strokeCircle(circle: circle)
        }

        for (_ , line) in self.currentLines {
            line.lineColor.setStroke()
            self.strokeLine(line: line)
        }
        
        for (_ , circle) in self.currentCircle {
            UIColor.black.setStroke()
            self.strokeCircle(circle: circle)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        currentLine = Line(begin: location, end: location)
        if touches.count > 1 {
            var firstPoint: CGPoint?
            var secondPoint: CGPoint?
            let key = NSValue(nonretainedObject: touches.first!)
            for touch in touches {
                if firstPoint == nil {
                    firstPoint = touch.location(in: self)
                    continue
                } else {
                    secondPoint = touch.location(in: self)
                }
            }
            
            let dx = (firstPoint!.x - secondPoint!.x)
            let dy = (firstPoint!.y - secondPoint!.y)
            
            let centerX = (dx > 0) ? secondPoint!.x + dx : firstPoint!.x - dx
            let centerY = (dy > 0) ? secondPoint!.y + dy : firstPoint!.y - dy
            
            let radius = sqrt(pow(dx, 2) + pow(dy, 2))
            
            let newCircle = Circle(center: CGPoint(x: centerX, y: centerY), radius: radius)
            
            self.currentCircle[key] = newCircle
            print(newCircle)
        } else {
            for touch in touches {
                let location = touch.location(in: self)
                let newLine = Line(begin: location, end: location)
                
                let key = NSValue(nonretainedObject: touch)
                self.currentLines[key] = newLine
            }
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.count > 1 {
            var firstPoint: CGPoint?
            var secondPoint: CGPoint?
            let key = NSValue(nonretainedObject: touches.first!)
            for touch in touches {
                if firstPoint == nil {
                    firstPoint = touch.location(in: self)
                    continue
                } else {
                    secondPoint = touch.location(in: self)
                }
            }
            
            let dx = (firstPoint!.x - secondPoint!.x)
            let dy = (firstPoint!.y - secondPoint!.y)
            
            let centerX = (dx > 0) ? secondPoint!.x + dx : firstPoint!.x - dx
            let centerY = (dy > 0) ? secondPoint!.y + dy : firstPoint!.y - dy
            
            self.currentCircle[key]?.center = CGPoint(x: centerX, y: centerY)
            self.currentCircle[key]?.radius = sqrt(pow(dx, 2) + pow(dy, 2))
        } else {
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                self.currentLines[key]?.end = touch.location(in: self)
            }
        }
        
        self.setNeedsDisplay()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if touches.count > 1 {
            var firstPoint: CGPoint?
            var secondPoint: CGPoint?
            let key = NSValue(nonretainedObject: touches.first!)
            for touch in touches {
                if firstPoint == nil {
                    firstPoint = touch.location(in: self)
                    continue
                } else {
                    secondPoint = touch.location(in: self)
                }
            }
            
            let dx = (firstPoint!.x - secondPoint!.x)
            let dy = (firstPoint!.y - secondPoint!.y)
            
            let centerX = (dx > 0) ? secondPoint!.x + dx : firstPoint!.x - dx
            let centerY = (dy > 0) ? secondPoint!.y + dy : firstPoint!.y - dy
            
            let radius = sqrt(pow(dx, 2) + pow(dy, 2))
            
            let newCircle = Circle(center: CGPoint(x: centerX, y: centerY), radius: radius)
            
            if var circle = self.currentCircle[key] {
                circle.center = newCircle.center
                self.finishedCircles.append(circle)
                self.currentLines.removeValue(forKey: key)
            }
            
        } else {
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                
                if var line = currentLines[key] {
                    line.end = touch.location(in: self)
                    
                    self.finishedLines.append(line)
                    self.currentLines.removeValue(forKey: key)
                }
                self.currentLines[key]?.end = touch.location(in: self)
            }
        }
        
        
        
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentLines.removeAll()
        
        self.setNeedsDisplay()
    }
}
