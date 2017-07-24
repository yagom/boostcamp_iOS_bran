//
//  Record.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 22..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

struct RecordPropertyName {
    static let name = "name"
    static let clearTime = "clearTime"
    static let clearDate = "clearDate"
}

class Record: NSObject, NSCoding {
    
    var name: String
    var clearDate: Date
    var clearTime: String
    var clearTimeDate: Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm:ss:SS"
            guard let date = dateFormatter.date(from: self.clearTime) else { return nil }
            return date
        }
    }
    
    init(name: String, clearTime: String, clearDate: Date) {
        self.name = name
        self.clearTime = clearTime
        self.clearDate = clearDate
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: RecordPropertyName.name)
        aCoder.encode(self.clearTime, forKey: RecordPropertyName.clearTime)
        aCoder.encode(self.clearDate, forKey: RecordPropertyName.clearDate)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        if aDecoder.containsValue(forKey: RecordPropertyName.name)
            && aDecoder.containsValue(forKey: RecordPropertyName.clearTime) {
            
            guard let name = aDecoder.decodeObject(forKey: RecordPropertyName.name) as? String,
                let clearTime = aDecoder.decodeObject(forKey: RecordPropertyName.clearTime) as? String,
                let clearDate = aDecoder.decodeObject(forKey: RecordPropertyName.clearDate) as? Date
            else { return nil }
            
            self.name = name
            self.clearTime = clearTime
            self.clearDate = clearDate
        } else {
            
            return nil
        }
        
    }
}
