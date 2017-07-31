//
//  PhotosViewController.swift
//  Photorama
//
//  Created by JU HO YOON on 2017. 7. 31..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self.photoDataSource
        self.collectionView.delegate = self
        
        store.fetchRecentPhotos { (photosResult) in
            OperationQueue.main.addOperation {
                switch photosResult {
                case let .success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                    self.photoDataSource.photos = photos
                case let .failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        
        self.store.fetchImage(for: photo) { (result) in
            OperationQueue.main.addOperation {
                
                if let photoIndex = self.photoDataSource.photos.index(where: { $0 == photo }) {
                    let photoIndexPath = IndexPath(item: photoIndex, section: 0)
                    
                    if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                        cell.update(with: photo.image)
                    }
                } else {
                    
                }
            }
        }
    }
}

extension PhotosViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                if let destinationViewController = segue.destination as? PhotoInfoViewController {
                    destinationViewController.photo = photo
                    destinationViewController.store = store
                }
            }
        }
    }
}
