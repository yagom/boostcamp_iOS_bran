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
    
    internal func removeItem(item: Item) {
        if let index = self.allItems.index(of: item) {
            self.allItems.remove(at: index)
        }
    }
    
    internal func moveItem(at fromIndex: Int, to toIndex: Int) {
        guard fromIndex != toIndex else { return }
        
        let moveItem = self.allItems[fromIndex]
        
        self.allItems.remove(at: fromIndex)
        
        self.allItems.insert(moveItem, at: toIndex)
    }
    
    
    init() {
        for _ in 0 ..< 5 {
            _ = self.createItem()
        }
    }
}
