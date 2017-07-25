//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 25..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

// 금메달 과제: 더 많은 뷰 컨트롤러 푸시하기
class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var item: Item!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Change Date"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = self.datePicker.date
    }
    
    
}
