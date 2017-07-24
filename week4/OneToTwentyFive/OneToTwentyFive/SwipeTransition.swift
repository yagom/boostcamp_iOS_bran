//
//  SwipeTransition.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 23..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

enum SwipeTransitionType {
    case present
    case dismiss
}

class SwipeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var type: SwipeTransitionType
    
    init(type: SwipeTransitionType) {
        self.type = type
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        let animationDuration = self.transitionDuration(using: transitionContext)
        if type == .present {
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
            
            toView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            UIView.animate(withDuration: animationDuration, animations: {
                toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            }) { (completed) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
            
            UIView.animate(withDuration: animationDuration, animations: {
                fromView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            }) { (completed) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
