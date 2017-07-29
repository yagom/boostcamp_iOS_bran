//
//  ImageBoardTests.swift
//  ImageBoardTests
//
//  Created by JU HO YOON on 2017. 7. 29..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import XCTest
@testable import ImageBoard

class ImageBoardTests: XCTestCase {
    
    func articleTest() {
        BoostCampAPI.shared.allBoard { (articles) in
            XCTAssertNotNil(articles)
        }
    }
    
}
