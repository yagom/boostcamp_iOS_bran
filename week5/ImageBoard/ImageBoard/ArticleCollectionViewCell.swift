//
//  ArticleCollectionViewCell.swift
//  ImageBoard
//
//  Created by JU HO YOON on 2017. 7. 30..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            } else {
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor.blue
            } else {
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var authorNicknameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
}
