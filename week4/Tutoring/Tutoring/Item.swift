//
//  Item.swift
//  Tutoring
//
//  Created by JU HO YOON on 2017. 7. 27..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        content = aDecoder.decodeObject(forKey: "content") as! String
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.content, forKey: "content")
    }
}
