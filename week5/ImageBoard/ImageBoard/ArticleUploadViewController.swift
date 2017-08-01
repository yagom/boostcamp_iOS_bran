//
//  ArticleUploadViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 8. 1..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

protocol ArticleUploadViewControllerDelegate {
    func articleUploadViewController(_: ArticleUploadViewController, didUploadWith article: Article)
}

class ArticleUploadViewController: UIViewController {
    
    @IBOutlet weak var articleTitleField: UITextField!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionTextView: UITextView!
    
    var delegate: ArticleUploadViewControllerDelegate?
    
    @IBAction func doneBarButtonDidTap(_ sender: UIBarButtonItem) {
        guard let title = self.articleTitleField.text,
            let description = self.articleDescriptionTextView.text,
            let image = self.articleImageView.image
        else {
            return
        }
        
        let newArticle = Article(title: title, description: description, image: image)
        
        BoostCampAPI.shared.postArticle(with: newArticle) { (articleResult) in
            switch articleResult {
            case let .success(articles):
                
                guard let article = articles.first else { return }
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.articleUploadViewController(self, didUploadWith: article) 
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @IBAction func cancelBarButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func articleImageViewDidTap(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ArticleUploadViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.articleImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
