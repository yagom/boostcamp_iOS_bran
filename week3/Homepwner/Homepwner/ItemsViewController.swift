//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 14..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    internal var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        self.tableView.estimatedRowHeight = 65
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if self.isEditing {
            sender.setTitle("Edit", for: .normal)
            self.setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            self.setEditing(true, animated: true)
        }
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = self.itemStore.createItem()
        
        if let index = self.itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.itemStore.allItems.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoMoreItemCell", for: indexPath)
            cell.textLabel?.text = "No more items"
            return cell
            
        } else {
            
            let item = self.itemStore.allItems[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
                    return UITableViewCell()
                }
            cell.updateLabels()
            
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$ \(item.valueInDollars)"
            
            let backgroundColor: UIColor = item.valueInDollars < 50 ? #colorLiteral(red: 0.07058838755, green: 0.721568644, blue: 0.5254901648, alpha: 1) : #colorLiteral(red: 0.980392158, green: 0.3215685189, blue: 0.3215686083, alpha: 1)
            cell.backgroundColor = backgroundColor
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let alertTitle = ""
//            let alertMessage = ""
//            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet)
//            
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
//                let item = self.itemStore.allItems[indexPath.row]
//                self.itemStore.removeItem(item: item)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            })
//            alertController.addAction(cancelAction)
//            alertController.addAction(deleteAction)
//            
//            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.itemStore.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // 동메달 과제: Delete 버튼 이름 변경하기 -> EditingStyle 커스터마이징.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rowAction = UITableViewRowAction(style: .destructive, title: "Remove") { (rowAction, indexPath) in
            
            let item = self.itemStore.allItems[indexPath.row]
            
            let alertTitle = "Delete \(item.name)?"
            let alertMessage = "Are you sure you want to delete this item?"
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                self.itemStore.removeItem(item: item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        return [rowAction]
        
    }
    
    // 금메달 과제: 재정렬 막기
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return (indexPath.row != self.itemStore.allItems.count)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return (indexPath.row != self.itemStore.allItems.count)
    }
    
    // 금메달 과제: 재정렬 막기
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == self.itemStore.allItems.count {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
}
