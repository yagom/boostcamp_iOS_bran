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
    
    /* internal은 기본 접근 지정자이므로 굳이 필요한 경우가 아니면 명시하지 않아도 됩니다 */
    @discardableResult internal func createItem() -> Item {
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
