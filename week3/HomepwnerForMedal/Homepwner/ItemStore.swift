//
//  ItemStore.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 14..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class ItemStore {
    open var allItems = [Item]()
    
    internal func createItem() -> Item {
        let newItem = Item(random: true)
        
        self.allItems.append(newItem)
        
        return newItem
    }
    
    init() {
        for _ in 0 ..< 10 {
            _ = self.createItem()
        }
    }
}
