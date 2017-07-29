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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gameSizePickerView: UIPickerView!
    fileprivate var gameSizeRow: Int = 4
    
    
    // MARK: Actions.
    
    @IBAction func dismissFromSegue(sender: UIStoryboardSegue){
        
    }
    
    @IBAction func action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonDidTouchUpInside(_ sender: UIButton) {
        let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.gameRowSize = self.gameSizeRow
        
        self.present(gameViewController, animated: true, completion: nil)
    }
    
    @IBAction func historyButtonDidTouchUpInside(_ sender: UIButton) {
        self.present(self.historyViewController, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.titleLabel.transform = .identity
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
    }
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let number = 4 + (row * 2)
        self.gameSizeRow = number
        print(self.gameSizeRow)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let number = 4 + (row * 2)
        return "\(number) * \(number)"
    }
}
