//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello, Swift2"

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

// Stride.
for x in stride(from: 0, to: 100, by: 10) {
    print(x)
}

enum MacBook {
    case air
    case pro
}


enum Device {
    case iPhone(Int, String)
    case iPad(Int)
    case iWatch(Int)
    case iMac(Int)
}

let m1 = Device.iMac(1)
let m2 = Device.iMac(2)
let p1 = Device.iPhone(7, "S")

if m1 == Device.iMac(1) {
    print("ver")
}

switch p1 {
case .iPhone(let version, let S):
    print("This is iPhone\(version)\(S)")
case .iMac(let version):
    print("This is iMAC\(version)")
    break
default:
    print("Default")
}

let b1 = MacBook.air
let b2 = MacBook.air

if b1 == b2 {
    print("true")
}