//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 14..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    internal var itemStore: ItemStore! {
        didSet {
            self.cheapItems = itemStore.allItems.filter { $0.valueInDollars < 50 }
            self.expensiveItems = itemStore.allItems.filter { $0.valueInDollars >= 50 }
        }
    }
    // 이렇게 구현하는것에 단점이 있는지. 주소값(4byte?)배열정도만 먹을것이라는 생각.
    private var cheapItems: [Item] = []
    private var expensiveItems: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 동메달 과제: 멀티 섹션
        if section == 0 {
            return "Cheap Item"
        } else if section == 1 {
            return "Expensive Item"
        } else {
            return nil
        }
    }
    
    // 금메달 과제: 테이블 커스터마이징
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 동메달 과제: 멀티 섹션, 은메달 과제: 고정행
        switch section {
        case 0:
            return self.cheapItems.count + 1
        case 1:
            return self.expensiveItems.count + 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reusableCell: UITableViewCell
        var item: Item
        
        // 은메달 과제: 고정행
        if (indexPath.section == 0 && indexPath.row == self.cheapItems.count) ||
            (indexPath.section == 1 && indexPath.row == self.expensiveItems.count) {
            reusableCell = tableView.dequeueReusableCell(withIdentifier: "NoMoreItemCell", for: indexPath)
            reusableCell.textLabel?.text = "No more items!"
            return reusableCell
        }
        
        switch indexPath.section {
        case 0:
            item = self.cheapItems[indexPath.row]
            reusableCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellRow", for: indexPath)
        case 1:
            item = self.expensiveItems[indexPath.row]
            reusableCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        default:
            // 이부분을 어떻게 처리해야할 지...
            // section의 개수는 확정적이기때문에 else가 없다고 가정해서 밑에 cell과 item에 그냥 접근해도 되는것인지.
            // TableView, Collection에서 갖가지 Cell 분기를 어떻게 관리해야할지.
            return UITableViewCell()
        }
        
        reusableCell.textLabel?.text = item.name
        reusableCell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        reusableCell.detailTextLabel?.text = "$ \(item.valueInDollars)"
        reusableCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        reusableCell.imageView?.image = #imageLiteral(resourceName: "money")

        return reusableCell
        
//        let cell = reusableCell ?? UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
        
//        return cell
    }
}
