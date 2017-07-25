//
//  HistoryViewController.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 21..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var records: [Record]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        self.records = GameManager.shared.records
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.records = GameManager.shared.records
        self.tableView.reloadData()
    }
    
    @IBAction func closeButtonDidTouchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonDidTouchUpInside(_ sender: UIButton) {
        let alertController = UIAlertController(title: "REALLY?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .destructive) {
            [unowned self] (action) in
            
            GameManager.shared.resetRecords()
            self.records = []
            
            var indexPaths: [IndexPath] = []
            for section in 0 ..< self.tableView.numberOfSections {
                for row in 0 ..< self.tableView.numberOfRows(inSection: section) {
                    let indexPath = IndexPath(row: row, section: section)
                    indexPaths.append(indexPath)
                }
            }
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
            
//            guard let rows = self.tableView.indexPathsForVisibleRows else { return }
//            self.tableView.deleteRows(at: rows, with: .automatic)
//            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.records[indexPath.row].name
        cell.detailTextLabel?.text = self.records[indexPath.row].clearTime.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {
            [unowned self] (action, indexPath) in
            GameManager.shared.deleteRecord(record: self.records[indexPath.row])
            self.records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
}

extension HistoryViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransition(type: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransition(type: .dismiss)
    }
}
