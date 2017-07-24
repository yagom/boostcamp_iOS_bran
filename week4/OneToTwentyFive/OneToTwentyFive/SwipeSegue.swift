//
//  SwipeSegue.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 23..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class SwipeSegue: UIStoryboardSegue {
    override func perform() {
        self.source.view.addSubview(self.destination.view)
        self.destination.view.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: self.destination.view.frame.width, height: self.destination.view.frame.height)
        UIView.animate(withDuration: 0.5, animations: {
            self.destination.view.frame = CGRect(x: 0, y: 0, width: self.destination.view.frame.width, height: self.destination.view.frame.height)
        }) { (completed) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
}

class SwipeSegueForUnwind: UIStoryboardSegue {
    override func perform() {
        guard let fromView = self.source.view.snapshotView(afterScreenUpdates: true) else { return }
        guard let toView = self.destination.view.snapshotView(afterScreenUpdates: true) else { return }
        self.source.view.addSubview(toView)
        self.source.view.addSubview(fromView)
        UIView.animate(withDuration: 0.5, animations: {
            fromView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: self.source.view.frame.width, height: self.destination.view.frame.height)
        }) { (completed) in
            self.source.dismiss(animated: false, completion: {
            })
        }
    }
}
