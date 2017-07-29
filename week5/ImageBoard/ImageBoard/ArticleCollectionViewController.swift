//
//  ArticleCollectionViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ArticleCollectionViewController: UICollectionViewController {
    
    var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BoostCampAPI.shared.allBoard { (articles) in
            self.articles = articles
            
            DispatchQueue.main.async {
                self.collectionView!.reloadData()
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let articles = self.articles {
            return articles.count
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let article = self.articles?[indexPath.row] else {
            let cell = ArticleCollectionViewCell()
            cell.backgroundColor = UIColor.red
            return cell
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell {
            cell.articleImageView.image = #imageLiteral(resourceName: "no_image")
            cell.imageTitleLabel.text = article.imageTitle
            cell.authorNicknameLabel.text = article.authorNickname
            cell.createdAtLabel.text = article.createdAt.description
            return cell
        } else {
            let cell = ArticleCollectionViewCell()
            cell.backgroundColor = UIColor.red
            return cell
        }
    }
    
}
