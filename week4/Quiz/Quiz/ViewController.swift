//
//  ViewController.swift
//  Quiz
//
//  Created by JU HO YOON on 2017. 7. 2..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From What is cognac made?",
                               "What is 7+7?",
                               "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes",
                             "14",
                             "Montpelier"]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentQuestionLabel.text = questions[currentQuestionIndex]
        
        self.updateOffScreenLabel()
    }
    
    private func updateOffScreenLabel(){
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.currentQuestionLabel.alpha = 0
        
    }

    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        self.currentQuestionLabel.text = question
        answerLabel.text = "???"
        
        self.animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        let screenWidth = view.frame.width
        
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
//        UIView.animate(withDuration: 0.5,
//                       delay: 0,
//                       options: [.curveLinear],
//                       animations: {
//            self.currentQuestionLabel.alpha = 0
//            self.nextQuestionLabel.alpha = 1
//            self.view.layoutIfNeeded()
//        }) { _ in
//            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
//            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
//            
//            self.updateOffScreenLabel()
//        }
        
        // 동메달 과제: 스프링 애니메이션.
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.1,
                       options: [],
                       animations: {
//            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }) { _ in
            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            
            self.updateOffScreenLabel()
        }
    }

}

