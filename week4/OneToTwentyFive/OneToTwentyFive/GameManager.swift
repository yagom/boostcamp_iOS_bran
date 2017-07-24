//
//  GameManager.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 22..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class GameManager {
    
    static var shared: GameManager = GameManager()
    var records: [Record]
    
    init() {
        self.records = GameManager.unarchiveRecords()
    }
    
    // Control One Record
    @discardableResult func addRecord(record: Record) -> Bool {
        self.records.append(record)
        _ = self.archiveRecords()
        self.archiveRecords()
        return true
    }
    
    @discardableResult func deleteRecord(record: Record) -> Bool {
        guard let recordIndex = self.records.index(of: record) else { return false }
        self.records.remove(at: recordIndex)
        self.archiveRecords()
        return true
    }
    
    // Control Record Array
    @discardableResult func archiveRecords() -> Bool {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
        let archiveURL = documentsDirectory.appendingPathComponent("records")
        return NSKeyedArchiver.archiveRootObject(self.records, toFile: archiveURL.path)
    }
    
    private class func unarchiveRecords() -> [Record] {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
        let archiveURL = documentsDirectory.appendingPathComponent("records")
        guard let loadedRecords = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [Record] else { return [] }
        return loadedRecords
    }
    
    @discardableResult func resetRecords() -> Bool {
        self.records = []
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
        let archiveURL = documentsDirectory.appendingPathComponent("records")
        return NSKeyedArchiver.archiveRootObject(self.records, toFile: archiveURL.path)
    }
}
