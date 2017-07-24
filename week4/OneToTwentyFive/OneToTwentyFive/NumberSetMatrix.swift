//
//  NumberTable.swift
//  OneToTwentyFive
//
//  Created by JU HO YOON on 2017. 7. 22..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class NumberSetMatrix {
    
    private var numbers: [Int]
    var count: Int {
        get {
            return self.numbers.count
        }
    }
    
    subscript(row: Int, column: Int) -> Int {
        return self.numbers[row * column + column]
    }
    
    subscript(absoluteIndex: Int) -> Int {
        return self.numbers[absoluteIndex]
    }
    
    init(row: Int, column: Int) {
        self.numbers = Array(repeating: 0, count: row * column)
    }
    
    convenience init(row: Int, column: Int, randomFilled filled: Bool) {
        
        self.init(row: row, column: column)
        
        if filled {
            for i in 0 ..< row * column {
                self.numbers[i] = i + 1
            }
            
            let totalCount = row * column
            for i in 0 ..< totalCount {
                let randomIndex = Int(arc4random_uniform(UInt32(self.numbers.count)))
                self.swapNumber(from: i, to: randomIndex)
            }
        }
    }
    
    private func swapNumber(from: Int, to: Int) {
        guard from != to else { return }
        let temporaryInt = self.numbers[from]
        self.numbers[from] = self.numbers[to]
        self.numbers[to] = temporaryInt
    }
    
    func shuffle(){
        for i in 0 ..< self.numbers.count {
            self.numbers[i] = i + 1
        }
        
        for i in 0 ..< self.numbers.count {
            let randomIndex = Int(arc4random_uniform(UInt32(self.numbers.count)))
            self.swapNumber(from: i, to: randomIndex)
        }
    }
}
