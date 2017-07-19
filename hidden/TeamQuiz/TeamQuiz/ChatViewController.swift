//
//  ChatViewController.swift
//  TeamQuiz
//
//  Created by JU HO YOON on 2017. 7. 19..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class Message {
    var user = 0
    var message: String = ""
    
    init(user: Int, message: String) {
        self.user = user
        self.message = message
    }
}

class ChatViewController: UITableViewController {
    var messages:[Message] = []
    
    var sampleMessages: [String] = ["Hi",
                                    "Hello",
                                    "How r u doing?",
                                    "i`m tired",
                                    "No, i`m happy",
                                    "really?",
                                    "what`s going on?",
                                    "My papa",
                                    "go straight",
                                    "turn left",
                                    "turn right",
                                    "okay, good bye",
                                    "show me the money 6",
                                    "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",
                                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem(title: "I Say", style: .plain, target: self, action: #selector(self.sayFromMe))
        let rightBarButton = UIBarButtonItem(title: "You Say", style: .plain, target: self, action: #selector(self.sayFromYou))
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.tableView.estimatedRowHeight = 60
        
        self.tableView.separatorInset = .zero
        self.tableView.separatorStyle = .none
    }
    
    func sayFromMe(){
        let message = self.sampleMessages[Int(arc4random_uniform(UInt32(self.sampleMessages.count)))]
        let newMessage = Message(user: 0, message: message)
        self.messages.append(newMessage)
        let newIndexPath = IndexPath(row: self.messages.count - 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        self.tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: false)
//        self.tableView.reloadData()
    }
    
    func sayFromYou(){
        let message = self.sampleMessages[Int(arc4random_uniform(UInt32(self.sampleMessages.count)))]
        let newMessage = Message(user: 1, message: message)
        self.messages.append(newMessage)
        let newIndexPath = IndexPath(row: self.messages.count - 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        self.tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: false)
//        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        if self.messages[indexPath.row].user == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTalkCell", for: indexPath) as? MyTalkCell else { return MyTalkCell() }
            cell.messageLabel?.text = message.message
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "YouTalkCell", for: indexPath) as? YouTalkCell else { return YouTalkCell() }
            cell.messageLabel?.text = message.message
            return cell
        }
    }
}
