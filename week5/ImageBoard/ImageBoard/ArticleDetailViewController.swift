//
//  ArticleDetailViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

protocol ArticleDetailViewControllerDelegate {
    func articleDetailViewController(_: ArticleDetailViewController, didDeleteArticle article: Article)
    func articleDetailViewController(_: ArticleDetailViewController, didUpdateArticle article: Article)
}

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var articleImageView: BRImageView!
    @IBOutlet weak var authorNicknameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var trashBarButton: UIBarButtonItem!
    
    var delegate: ArticleDetailViewControllerDelegate?
    
    @IBAction func editBarButtonDidTap(_ sender: UIBarButtonItem) {
        self.navigationItem.titleView = UITextField()
    }
    
    @IBAction func trashBarButtonDidTap(_ sender: UIBarButtonItem) {
        guard let articleToDelete = self.article else { return }
        
        let alertController = UIAlertController(title: "삭제", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "예", style: .destructive) {
            [unowned self] (action) in
            BoostCampAPI.shared.deleteArticle(with: articleToDelete) { (articleResult) in
                switch articleResult {
                case let .success(articles):
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        guard let articleDeleted = articles.first else { return }
                        
                        self.delegate?.articleDetailViewController(self, didDeleteArticle: articleDeleted)
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
            let barButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
            self.navigationItem.setRightBarButtonItems([barButtonItem], animated: true)
        }
    }
}
