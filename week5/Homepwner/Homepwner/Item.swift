//
//  Item.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 14..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    private struct Codingkey {
        static let name = "name"
        static let valueInDollars = "valueInDollars"
        static let serialNumber = "serialNumber"
        static let dateCreated = "dateCreated"
        static let itemKey = "itemKey"
    }
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: Date
    let itemKey: String
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: Codingkey.name)
        aCoder.encode(self.valueInDollars, forKey: Codingkey.valueInDollars)
        aCoder.encode(self.serialNumber, forKey: Codingkey.serialNumber)
        aCoder.encode(self.dateCreated, forKey: Codingkey.dateCreated)
        aCoder.encode(self.itemKey, forKey: Codingkey.itemKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Codingkey.name) as? String,
            let serialNumber = aDecoder.decodeObject(forKey: Codingkey.serialNumber) as? String?,
            let dateCreated = aDecoder.decodeObject(forKey: Codingkey.dateCreated) as? Date,
            let itemKey = aDecoder.decodeObject(forKey: Codingkey.itemKey) as? String
        else {
            return nil
        }
        
        self.name = name
        self.valueInDollars = aDecoder.decodeInteger(forKey: Codingkey.valueInDollars)
        self.serialNumber = serialNumber
        self.dateCreated = dateCreated
        self.itemKey = itemKey
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var index = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(index)]
            
            index = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(index)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName,
                      serialNumber: randomSerialNumber,
                      valueInDollars: randomValue)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
}
