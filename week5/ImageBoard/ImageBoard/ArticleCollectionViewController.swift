//
//  ArticleCollectionViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ArticleCollectionViewController: UICollectionViewController {
    
    // Properties
    var isDownloading = false
    
    // IBActions
    @IBAction func filterBarButtonDidTap(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "정렬", message: nil, preferredStyle: .actionSheet)
        let myAction = UIAlertAction(title: "내 게시물만 보기", style: .default) {
            [unowned self] (action) in
            ArticleDataStore.shared.setFilterType(to: .me)
            self.collectionView?.reloadData()
        }
        let allAction = UIAlertAction(title: "전체 게시물 보기", style: .default) {
            [unowned self] (action) in
            ArticleDataStore.shared.setFilterType(to: .all)
            self.collectionView?.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(myAction)
        alertController.addAction(allAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Notification Selector
    @objc func didUserSignIn(sender: NSNotification){
        guard let user = sender.object as? User else { return }
    }
    
    func refreshControlDidValueChange(sender: UIRefreshControl) {
        if sender.isRefreshing {
            if self.isDownloading == false {
                ArticleDataStore.shared.fetchArticles(completion: { (articleResult) in
                    switch articleResult {
                    case let .success(articles):
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    case let .failure(error):
                        print(error)
                    }
                })
            }
        }
    }
    
    // ViewController Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshControlDidValueChange(sender:)), for: .valueChanged)
        self.collectionView?.refreshControl = refreshControl
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUserSignIn(sender:)), name: UserSignInSuccess, object: nil)
        
        self.collectionView?.dataSource = ArticleDataStore.shared
        
        self.isDownloading = true
        ArticleDataStore.shared.fetchArticles { (articleResult) in
            switch articleResult {
            case let .success(articles):
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            case let .failure(error):
                print(error)
            }
            self.isDownloading = false
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowArticleUploadViewController" {
            guard let articleUploadViewController = segue.destination as? ArticleUploadViewController else { return }
            articleUploadViewController.delegate = self
        }
    }
}

extension ArticleCollectionViewController: ArticleUploadViewControllerDelegate {
    func articleUploadViewController(_: ArticleUploadViewController, didUploadWith article: Article) {
        self.collectionView?.reloadData()
    }
}
