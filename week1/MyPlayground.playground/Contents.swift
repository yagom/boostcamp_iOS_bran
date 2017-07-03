//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello, Swift"

var nextYear: Int
var bodyTemp: Float
var hsPet: Bool

// 배열
var arrayOfInts: Array<Int> = []
for i in 0...9 {
    arrayOfInts.append(i*10)
}
for (i, number) in arrayOfInts.enumerated() {   // 배열의 인덱스까지 추출하려면 enumerated() -> 튜플의 시퀀스를 반환
    print("\(i), \(number)")
}

// 딕셔너리
var nameByParkingSpace = ["13": "Alice", "27": "Bob"]
for (space, name) in nameByParkingSpace {   // 딕셔너리 나열할 때도 튜플을 이용하면 유용함.
    print("\(space), \(name)")
}

var reading1: Float?
var reading2: Float?
var reading3: Float?

if let r1 = reading1,
    let r2 = reading2,
    let r3 = reading3 {
    let avgReading = (r1 + r2 + r3) / 3
    
} else {
    let errorString = "Instrument reported a reading that was nil."
}

