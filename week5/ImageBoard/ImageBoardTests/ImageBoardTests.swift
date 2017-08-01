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
    
    func testArticleAPI() {
        var completed = false
        BoostCampAPI.shared.allBoard { (articles) in
            XCTAssertNotNil(articles)
            print(articles)
//            for article in articles! {
//                print(article.id)
//                print(article.imageTitle)
//            }
            completed = true
        }
        while true {
            if completed { break }
        }
    }
    
    func testLoginAPI() {
        var expectation = XCTestExpectation(description: "SignIn")
        let user = User(id: "test", nickname: "Test again", password: "test", email: "test@test.com", apiVersion: "")
        var completed = false
        BoostCampAPI.shared.signIn(with: user) { (resultUser) in
            switch resultUser {
            case let .success(user):
                print(user.id)
                break
            case let .failure(error):
                print(error)
                
            }
            XCTAssertNotNil(resultUser)
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testUpdateArticleAPI() {
        
        
    }
    
    func testSignUpUser(){
        return
        var expectation = XCTestExpectation(description: "SignUp")
        let newUser = User(email: "test33@test.com", password: "test", nickname: "TEST")
        BoostCampAPI.shared.signUp(with: newUser) { (userResult) in
            print(userResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
}
