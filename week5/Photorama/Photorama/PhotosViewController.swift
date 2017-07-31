//
//  PhotosViewController.swift
//  Photorama
//
//  Created by JU HO YOON on 2017. 7. 31..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var store: PhotoStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos { (photosResult) in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) recent photos.")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImage(for: firstPhoto, completion: { (imageResult) in
                        
                        switch imageResult {
                        case let .success(image):
                            OperationQueue.main.addOperation {
                                self.imageView.image = image
                            }
                        case let .failure(error):
                            print("Error downloading image: \(error)")
                        }
                    })
                }
                
            case let .failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
    }
}
