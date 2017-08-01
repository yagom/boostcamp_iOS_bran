//
//  ArticleCollectionLayout.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ArticleCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        let itemWidth = (collectionView.frame.width) / CGFloat(2.0)
        let itemHeight = (itemWidth - 8 * 2) + (8 * 5) + 20.5 * 3
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
}
