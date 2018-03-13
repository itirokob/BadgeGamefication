//
//  UserTest.swift
//  BadgeModelTests
//
//  Created by Bianca Itiroko on 09/03/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import XCTest
@testable import BadgeGamification

class UserTest: XCTestCase {
    var user:User!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.user = nil
    }
    
    func createUserWithMissingInfo(){
        self.user = User(dictionary: [
            "name" : "name",
            "isAdmin" : "isAdmin",
            "profileImageURL" : "profileImageURL",
            ])
    }
    
    func testExample() {
        createUserWithMissingInfo()
        
        XCTAssertNil(user, "User has been created with missing info")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
