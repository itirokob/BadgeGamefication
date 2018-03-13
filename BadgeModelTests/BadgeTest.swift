//
//  BadgeTest.swift
//  BadgeModelTests
//
//  Created by Bianca Itiroko on 09/03/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import XCTest
@testable import BadgeGamification

class BadgeTest: XCTestCase {
    var badge:Badge!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.badge = nil
    }
    
    func createBadgeWithMissingInfo(){
        self.badge = Badge(dictionary: [
            "name" : "name",
            "badgeIcon" : "badgeIcon",
            "acquisitionDate" : "acquisitionDate"
            ])
    }
    
    func testExample() {
        createBadgeWithMissingInfo()
        XCTAssertNil(badge, "Badge has been created with missing info")
    }
    
    func testFormattingDate(){
        self.badge = Badge(dictionary: [
            "name" : "name",
            "numPoints" : 0,
            "description" : "description",
            "id" : "id",
            "teamName" : "teamName",
            "badgeIcon" : "badgeIcon",
            "acquisitionDate" : "2018-09-13"
            ])
        let date = self.badge.formatDate(date: "2018-09-13")
        XCTAssertNil(date, "Date has been created with wrong formatting")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
