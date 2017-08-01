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
    
    // IBOutlet subviews
    @IBOutlet weak var articleImageView: BRImageView!
    @IBOutlet weak var authorNicknameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var imageDescriptionTextView: UITextView!
    
    @IBOutlet var editBarButton: UIBarButtonItem!
    @IBOutlet var trashBarButton: UIBarButtonItem!
    var cancelBarButton: UIBarButtonItem!
    var doneBarButton: UIBarButtonItem!
    
    @IBOutlet var articleTitleField: UITextField!
    var articleTitleLabel: UILabel = {
        let articleTitleLabel = UILabel()
        articleTitleLabel.textAlignment = .center
        return articleTitleLabel
    }()
    
    var article: Article?
    var user: User?
    var isArticleEditing = false {
        didSet {
            if isArticleEditing {
                self.navigationItem.leftBarButtonItems = [self.cancelBarButton]
                self.navigationItem.rightBarButtonItems = [self.doneBarButton]
                
                self.navigationItem.titleView = self.articleTitleField
                self.imageDescriptionTextView.isEditable = true
                
            } else {
                self.navigationItem.leftBarButtonItems = []
                self.navigationItem.rightBarButtonItems = [self.trashBarButton, self.editBarButton]
                
                self.navigationItem.titleView = self.articleTitleLabel
                self.imageDescriptionTextView.isEditable = false
            }
        }
    }
    
    var delegate: ArticleDetailViewControllerDelegate?
    
    lazy var imageDetailViewController: ImageDetailViewController = {
        let imageDetailViewController = ImageDetailViewController()
        return imageDetailViewController
    }()
    
    @objc private func cancelBarButtonDidTap(sender: UIBarButtonItem) {
        self.isArticleEditing = false
    }
    
    @objc private func doneBarButtonDidTap(sender: UIBarButtonItem) {
        self.isArticleEditing = false
        
        guard let originalArticle = self.article,
            let originalImage = self.article?.image
            else {
                return
        }
        let articleEdited = Article(id: originalArticle.id, title: originalArticle.imageTitle, description: originalArticle.imageDescription, image: originalImage)
        guard let title = self.articleTitleField.text else { return }
        
        self.articleTitleLabel.text = title
        
        articleEdited.imageTitle = title
        articleEdited.imageDescription = self.imageDescriptionTextView.text
        articleEdited.image = self.articleImageView.image
        
        BoostCampAPI.shared.updateArticle(with: articleEdited) { (articleResult) in
            switch articleResult {
            case let .success(article):
                
                guard let articleUpdated = article.first else { return }
                
                DispatchQueue.main.async {
                    self.article?.id = articleUpdated.id
                    self.article?.thumbImageURL = articleUpdated.thumbImageURL
                    self.article?.imageURL = articleUpdated.imageURL
                    self.article?.author = articleUpdated.author
                    self.article?.imageDescription = articleUpdated.imageDescription
                    self.article?.imageTitle = articleUpdated.imageTitle
                    self.article?.image = articleUpdated.image
                    self.delegate?.articleDetailViewController(self, didUpdateArticle: articleUpdated)
                }
            case let .failure(error):
                print("error : \(error)")
            }
        }
    }
    
    @IBAction func editBarButtonDidTap(_ sender: UIBarButtonItem) {
        
        self.isArticleEditing = !self.isArticleEditing
        
        self.articleTitleField.text = article?.imageTitle
        self.navigationItem.titleView = self.articleTitleField
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
    
    @IBAction func articleImageViewDidTap(_ sender: UITapGestureRecognizer) {
        if self.isArticleEditing {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            self.imageDetailViewController.imageView.image = self.articleImageView.image
            self.navigationController?.pushViewController(self.imageDetailViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articleTitleLabel.text = self.article?.imageTitle
        self.articleTitleLabel.frame = self.articleTitleField.frame
        self.navigationItem.titleView = self.articleTitleLabel
        self.imageDescriptionTextView.isEditable = false
        
        self.cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBarButtonDidTap(sender:)))
        self.doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBarButtonDidTap(sender:)))
        
        self.navigationItem.title = article?.imageTitle
        self.authorNicknameLabel.text = article?.authorNickname
        self.createdAtLabel.text = article?.createdAt.description
        self.imageDescriptionTextView.text = article?.imageDescription
        
        guard let article = self.article,
            let user = self.user
        else {
            return
        }
        
        self.articleImageView.downloadImage(path: article.downloadImageURL) {
            [unowned self] in
            DispatchQueue.main.async {
                self.article?.image = self.articleImageView.image
            }
        }
        if user.id == article.author {
            print("It`s me")
        } else {
            let barButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
            self.navigationItem.setRightBarButtonItems([barButtonItem], animated: true)
        }
    }
}

extension ArticleDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.articleImageView.image = image
    }
}
