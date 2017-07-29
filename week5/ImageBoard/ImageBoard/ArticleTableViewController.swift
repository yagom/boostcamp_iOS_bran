//
//  ArticleTableViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100
        
        BoostCampAPI.shared.allBoard { (articles) in
            self.articles = articles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articles = self.articles {
            return articles.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article = self.articles?[indexPath.row] else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell {
            cell.articleImageView.image = #imageLiteral(resourceName: "no_image")
            cell.imageTitleLabel.text = article.imageTitle
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
