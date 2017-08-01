//
//  PhotoCollectionViewLayout.swift
//  Photorama
//
//  Created by JU HO YOON on 2017. 7. 31..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class PhotoCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionViewFrame = self.collectionView?.frame else { return }
        let smallLength = min(collectionViewFrame.width, collectionViewFrame.height)
        self.itemSize = CGSize(width: smallLength, height: smallLength)
        self.collectionView?.isPagingEnabled = true
        self.scrollDirection = .horizontal
    }
    
    
}
