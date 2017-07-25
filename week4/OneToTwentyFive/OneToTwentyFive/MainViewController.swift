//
//  ViewController.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 21..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    lazy var gameViewController: GameViewController = {
        let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        return gameViewController
    }()
    lazy var historyViewController: HistoryViewController = {
        let historyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        return historyViewController
    }()
    
    @IBAction func dismissFromSegue(sender: UIStoryboardSegue){
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBAction func action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonDidTouchUpInside(_ sender: UIButton) {
        
    }
    @IBAction func historyButtonDidTouchUpInside(_ sender: UIButton) {
        self.present(self.historyViewController, animated: true, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        self.view.layer.removeAllAnimations()
//        self.titleLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.titleLabel.transform = .identity
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
