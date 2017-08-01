//
//  ArticleTableViewController.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    // Data Properties.
    var selectedArticle: Article?

    // Control RefreshControl
    var isDownloading: Bool = false {
        didSet {
            if isDownloading == false {
                guard let refresControl = self.tableView.refreshControl else { return }
                refresControl.endRefreshing()
            }
        }
    }
    
    lazy var articleDetailViewController: ArticleDetailViewController? = {
        guard let articleDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController") as? ArticleDetailViewController else { return nil }
        return articleDetailViewController
    }()
    
    // Actions.
    @IBAction func filterBarButtonDidTap(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "정렬", message: nil, preferredStyle: .actionSheet)
        let myAction = UIAlertAction(title: "내 게시물만 보기", style: .default) {
            [unowned self] (action) in
            ArticleDataStore.shared.setFilterType(to: .me)
            self.tableView.reloadData()
        }
        let allAction = UIAlertAction(title: "전체 게시물 보기", style: .default) {
            [unowned self] (action) in
            ArticleDataStore.shared.setFilterType(to: .all)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(myAction)
        alertController.addAction(allAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func didUserSignIn(sender: NSNotification){
        print("Get Noti")
        
        guard let user = sender.object as? User else { return }
        print(user.id)
        self.user = user
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let refreshControl = self.refreshControl else { return }
        if refreshControl.isRefreshing {
            if self.isDownloading == false {
                self.fetchArticlesFromBoostCampAPI()
            }
        }
    }
    
    private func fetchArticlesFromBoostCampAPI(){
        self.isDownloading = true
        ArticleDataStore.shared.fetchArticles { (articleResult) in
            switch articleResult {
            case let .success(articles):
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
            self.isDownloading = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUserSignIn(sender:)), name: UserSignInSuccess, object: nil)
        
        self.tableView.dataSource = ArticleDataStore.shared
        self.tableView.estimatedRowHeight = 100
        
        self.tableView.refreshControl = UIRefreshControl()
        
        let signInViewControllerNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewControllerNavigationController")
        
        self.present(signInViewControllerNavigationController, animated: false, completion: nil)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let articleCell = cell as? ArticleTableViewCell else { return }
        let article = ArticleDataStore.shared.visibleArticles[indexPath.row]
        articleCell.articleImageView.downloadImage(path: article.downloadThumbImageURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowArticleUploadViewController" {
            guard let articleUploadViewController = segue.destination as? ArticleUploadViewController else { return }
            articleUploadViewController.delegate = self
        } else if segue.identifier == "ShowArticleDetailViewController" {
            guard let cell = sender as? UITableViewCell else { return }
            self.selectedArticle = ArticleDataStore.shared.visibleArticles[(self.tableView.indexPath(for: cell)?.row)!]
            guard let articleDetailViewController = segue.destination as? ArticleDetailViewController else { return }
            articleDetailViewController.article = self.selectedArticle
        }
    }
}

extension ArticleTableViewController: ArticleUploadViewControllerDelegate {
    func articleUploadViewController(_: ArticleUploadViewController, didUploadWith article: ArticleResult) {
        self.tableView.reloadData()
    }
}
