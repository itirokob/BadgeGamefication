//
//  UserBadges.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 22/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class UserBadge: NSObject {
    var name:String
    var numPoints:Int
    var descript:String
    var id:String
    var acquisitionDate:Date?
    var teamName:String
    
    init(name:String, description:String, numPoints:Int, id:String, teamName:String, acquisitionDate:Date){
        self.name = name
        self.numPoints = numPoints
        self.descript = description
        self.id = id
        self.acquisitionDate = acquisitionDate
        self.teamName = teamName
    }
}
