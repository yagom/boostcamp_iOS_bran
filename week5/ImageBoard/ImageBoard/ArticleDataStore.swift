//
//  ArticleDataStore.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 8. 1..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

enum ArticleFilterType {
    case all
    case me
}

class ArticleDataStore: NSObject {
    
    static let shared = ArticleDataStore()
    
    var currentUser: User?
    var filterType: ArticleFilterType = .all
    var articles: [Article]?
    var visibleArticles: [Article] {
        guard let articles = self.articles else { return [] }
        switch self.filterType {
        case .all:
            return articles
        case .me:
            return articles.filter { $0.author == self.currentUser?.id }
        }
    }
    
    func fetchArticles(completion: @escaping (ArticleResult) -> Void){
        BoostCampAPI.shared.allBoard { (articleResult) in
            switch articleResult {
            case let .success(articles):
                ArticleDataStore.shared.articles = articles
            case let .failure(error):
                print(error)
            }
            completion(articleResult)
        }
    }
    
    func setFilterType(to filter: ArticleFilterType) {
        self.filterType = filter
    }
}

extension ArticleDataStore: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visibleArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = self.visibleArticles[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell {
            cell.imageTitleLabel.text = article.imageTitle
            cell.authorNicknameLabel.text = article.authorNickname
            cell.createdAtLabel.text = article.createdAt.description
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ArticleDataStore: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.visibleArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let article = self.articles?[indexPath.row] else {
            let cell = ArticleCollectionViewCell()
            cell.backgroundColor = UIColor.red
            return cell
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell {
            cell.articleImageView.downloadImage(path: article.downloadThumbImageURL)
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
