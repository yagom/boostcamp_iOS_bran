//
//  GameViewController.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 22..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: SubViews.
    
    // IBOutlet Subviews.
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var bestRecordLabel: UILabel!
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var numberButtonContainerView: UIView!
    @IBOutlet weak var historyButton: UIButton!
    
    // Number Buttons.
    var numberButtons: [UIButton]!
    
    // MARK: Properties.
    
    // Game Property.
    private var numberMatrix: NumberSetMatrix!
    private var latestSelectedNumber: Int = 0
    private var gameRowSize: Int = 5
    private var gameSize: Int {
        get {
            return self.gameRowSize * self.gameRowSize
        }
    }
    private var records: [Record]! {
        didSet {
            self.updateBestRecord()
        }
    }
    // Time Property.
    private var bestRecord: Record?
    private var timer: Timer?
    private var startTime: Date?
    private var endTime: Date?
    private var gameTime: String {
        get {
            guard let startTime = self.startTime,
                let endtime = self.endTime
            else {
                return "00:00:00"
            }
            
            let dateComponents = Calendar.current.dateComponents([Calendar.Component.month,Calendar.Component.second, Calendar.Component.nanosecond], from: startTime, to: endtime)
            guard let gameTime = Calendar.current.date(from: dateComponents) else { return "00:00:00" }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm:ss:SS"
            
            return dateFormatter.string(from: gameTime)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func homeButtonDidTouchUpInside(_ sender: UIButton) {
        self.endGameTimer()
    }
    
    @IBAction func historyButtonDidTouchUpInside(_ sender: UIButton) {
        guard let mainViewController = self.presentingViewController as? MainViewController else { return }
        self.present(mainViewController.historyViewController, animated: true, completion: nil)
    }
    
    @IBAction func startButtonDidTouchUpInside(_ sender: UIButton) {
        sender.isHidden = true
        self.numberButtonContainerView.isHidden = false
        self.latestSelectedNumber = 0
        self.numberMatrix.shuffle()
        self.resetNumberButtons()
        
        self.startGameTimer()
    }
    
    // MARK: Time Control.

    private func startGameTimer() {
        self.historyButton.isEnabled = false
        self.historyButton.alpha = 0.5
        self.startTime = Date()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
            [unowned self] (timer) in
            self.endTime = Date()
            self.gameTimeLabel.text = self.gameTime
        }
    }
    
    private func endGameTimer() {
        self.historyButton.isEnabled = true
        self.historyButton.alpha = 1
        self.timer?.invalidate()
        self.timer = nil
    }
    
    // MARK: SubViews.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.records = GameManager.shared.records
        
        self.gameTimeLabel.font = self.gameTimeLabel.font.withSize(UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberMatrix = NumberSetMatrix(row: self.gameRowSize, column: self.gameRowSize, randomFilled: true)
        
        self.setupNumberButtons()
    }
    
    private func setupNumberButtons(){
        self.numberButtons = []
        for i in 0 ..< (self.gameSize) {
            let newButton: UIButton = UIButton(type: .custom)
            
            newButton.setTitle(String(self.numberMatrix[i]), for: .normal)
            newButton.backgroundColor = #colorLiteral(red: 0.1333334148, green: 0.5411764979, blue: 0.9019607902, alpha: 1)
            newButton.setTitleColor(UIColor.white, for: .normal)
            newButton.tag = self.numberMatrix[i]
            newButton.addTarget(self, action: #selector(self.numberButtonDidTouchUpInside(sender:)), for: .touchDown)
            newButton.translatesAutoresizingMaskIntoConstraints = false
            numberButtons.append(newButton)
        }
        
        let verticalStackView = UIStackView()
        for i in 0 ..< self.gameRowSize {
            let horizontalStackView = UIStackView()
            for j in 0 ..< self.gameRowSize {
                let buttonIndex = (i * self.gameRowSize) + j
                horizontalStackView.addArrangedSubview(numberButtons[buttonIndex])
            }
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 8
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.backgroundColor = UIColor.red
            verticalStackView.addArrangedSubview(horizontalStackView)
            
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.leftAnchor.constraint(equalTo: verticalStackView.leftAnchor).isActive = true
            horizontalStackView.rightAnchor.constraint(equalTo: verticalStackView.rightAnchor).isActive = true
        }
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 8
        verticalStackView.backgroundColor = UIColor.brown
        self.numberButtonContainerView.addSubview(verticalStackView)
        self.numberButtonContainerView.isHidden = true
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.leftAnchor.constraint(equalTo: self.numberButtonContainerView.leftAnchor).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: self.numberButtonContainerView.rightAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: self.numberButtonContainerView.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.numberButtonContainerView.bottomAnchor).isActive = true
    }
    
    private func updateBestRecord(){
        if self.bestRecord == nil {
            self.bestRecord = Record(name: "No Record", clearTime: "59:59:99", clearDate: Date())
        }
        
        let sortedRecords = self.records.sorted { (record1, record2) -> Bool in
            guard let time1 = record1.clearTimeDate,
                let time2 = record2.clearTimeDate
            else {
                return true
            }
            return time1.compare(time2) == .orderedAscending
        }
        if let bestRecord = sortedRecords.first {
            self.bestRecordLabel.text = "\(bestRecord.name) \(bestRecord.clearTime)"
        } else {
            self.bestRecordLabel.text = "- --:--:--"
        }
    }
    
    // MARK: Game Control.
    
    private func resetNumberButtons(){
//        self.numberButtons.forEach { $0.alpha = 1; $0.isUserInteractionEnabled = true }
        for (index, button) in self.numberButtons.enumerated() {
            button.alpha = 1
            button.isUserInteractionEnabled = true
            button.tag = numberMatrix[index]
            button.setTitle(String(numberMatrix[index]), for: .normal)
        }
    }
    
    @objc private func numberButtonDidTouchUpInside(sender: UIButton) {
        if sender.tag == self.latestSelectedNumber + 1 {
            self.latestSelectedNumber = sender.tag
            
            sender.alpha = 0
            sender.isUserInteractionEnabled = false
        } else {
            guard self.startTime != nil else { return }
            self.startTime = self.startTime!.addingTimeInterval(-1.5)
        }
        
        if self.latestSelectedNumber == self.numberMatrix.count {
            self.gameDidEnded()
        }
    }

    func gameDidEnded(){
        self.endGameTimer()
        self.startButton.isHidden = false
        self.numberButtonContainerView.isHidden = true
        
        let alertController = UIAlertController(title: "Clear!", message: "Enter your name", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter your name"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            [unowned alertController] (action) in
            guard let textField = alertController.textFields?.first else { return }
            guard let text = textField.text else { return }
            
            if text == "" {
                let newRecord = Record(name: "Unknown", clearTime: self.gameTime, clearDate: Date())
                self.records.append(newRecord)
                GameManager.shared.addRecord(record: newRecord)
            } else {
                let newRecord = Record(name: text, clearTime: self.gameTime, clearDate: Date())
                self.records.append(newRecord)
                GameManager.shared.addRecord(record: newRecord)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
