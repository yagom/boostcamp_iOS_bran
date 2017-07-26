//
//  DetailViewController.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 25..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item! {
        didSet {
            self.navigationItem.title = item.name
        }
    }
    
    // 접근수준 지정자 설정해보기
    let numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let valueInDollars = numberFormatter.string(for: item.valueInDollars) ?? "0"
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = valueInDollars
        dateLabel.text = "\(dateFormatter.string(from: item.dateCreated))"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    // 금메달 과제: 더 많은 뷰 컨트롤러 푸시하기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeDate" {
            let datePickerViewController = segue.destination as! DatePickerViewController
            datePickerViewController.item = self.item
        }
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
        return textField.resignFirstResponder()
    }
}
