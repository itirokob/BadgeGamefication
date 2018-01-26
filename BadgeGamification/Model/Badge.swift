//
//  Badge.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 09/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class Badge: NSObject {
    var name:String
    var numPoints:Int
    var descript:String
    var id:String
    var acquisitionDate:Date?
    var teamName:String
    var badgeIcon:String

    
    init(name:String, description:String, numPoints:Int, id:String, teamName:String, badgeIcon:String){
        self.name = name
        self.numPoints = numPoints
        self.descript = description
        self.id = id
        self.teamName = teamName
        self.badgeIcon = badgeIcon
    }
    
    init(name:String, description:String, numPoints:Int, id:String, teamName:String,badgeIcon:String, acquisitionDate:Date){
        self.name = name
        self.numPoints = numPoints
        self.descript = description
        self.id = id
        self.acquisitionDate = acquisitionDate
        self.teamName = teamName
        self.badgeIcon = badgeIcon
    }

}
