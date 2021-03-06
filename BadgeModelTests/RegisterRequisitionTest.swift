//
//  RegisterRequisitionTest.swift
//  BadgeModelTests
//
//  Created by Bianca Itiroko on 09/03/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import XCTest
@testable import BadgeGamification

class RegisterRequisitionTest: XCTestCase {
    var registerReq:RegisterRequistion!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.registerReq = nil
    }
    
    func createRegisterReqWithMissingInfo(){
        self.registerReq = RegisterRequistion(dictionary: [
            "userEmail" : "userEmail",
            "status" : "status",
            "teamName" : "teamName",
            ])
    }
    
    func testExample() {
        createRegisterReqWithMissingInfo()
        XCTAssertNil(registerReq, "Register requisition has been created with missing info")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
