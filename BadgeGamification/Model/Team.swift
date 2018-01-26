//
//  Team.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class Team: NSObject {
    var teamName:String
//    var teamID:String
    var adminID:String
    var adminName:String
    
    init(teamName:String, adminID:String, adminName:String){
        self.teamName = teamName
//        self.teamID = teamID
        self.adminID = adminID
        self.adminName = adminName
    }
}
