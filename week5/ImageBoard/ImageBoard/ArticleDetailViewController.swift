//
//  ArticleDetailViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var articleImageView: BRImageView!
    @IBOutlet weak var authorNicknameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var trashBarButton: UIBarButtonItem!
    
    @IBAction func editBarButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func trashBarButtonDidTap(_ sender: UIBarButtonItem) {
        guard let articleToDelete = self.article else { return }
        BoostCampAPI.shared.deleteArticle(with: articleToDelete) { (articleResult) in
            switch articleResult {
            case let .success(articles):
                guard let articleDeleted = articles.first else { return }
                print("delete : \(articleDeleted.imageTitle)")
            case let .failure(error):
                print(error)
            }
        }
    }
    
    var article: Article?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = article?.imageTitle
        self.authorNicknameLabel.text = article?.authorNickname
        self.createdAtLabel.text = article?.createdAt.description
        self.imageDescriptionLabel.text = article?.imageDescription
        
        guard let article = self.article,
            let user = self.user
        else {
            return
        }
        
        self.articleImageView.downloadImage(path: article.downloadImageURL)
        if user.id == article.author {
            print("It`s me")
        } else {
            self.navigationItem.setRightBarButton(nil, animated: false)
        }
    }
}
