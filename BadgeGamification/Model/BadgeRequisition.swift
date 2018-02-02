//
//  BadgeRequisition.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class BadgeRequisition: NSObject, PersistenceObject {
    
    
    var userEmail:String
    var userID:String
    var badge:Badge
    var explanation:String
    var status:String
    var id:String
    var teamName:String
    
    var badgeDescription:String
    var badgeID:String
    var badgeIcon:String
    var badgeName:String
    var badgeNumPoints:Int
    
    var dictInfo : [AnyHashable : Any]
    
    //Adicionar campo userUUID e badgeID
    init(userEmail:String, explanation:String, status:String, id:String, userID:String, badge:Badge, teamName:String){
        self.userEmail = userEmail
        self.userID = userID
        self.explanation = explanation
        self.status = status
        self.id = id
        self.badgeDescription = badge.descript
        self.badgeIcon = badge.badgeIcon
        self.badgeID = badge.id
        self.badgeName = badge.name
        self.badgeNumPoints = badge.numPoints
        self.teamName = teamName
        
        self.badge = Badge(name: badge.name, description: badge.descript, numPoints: badge.numPoints, id: badge.id, teamName: badge.teamName, badgeIcon: badge.badgeIcon)
        
        self.dictInfo = [
            "userEmail" : userEmail,
            "userID" : userID,
            "explanation" : explanation,
            "status" :  status,
            "id" : id,
            "teamName" : teamName,
            "badgeDescription" : badge.descript,
            "badgeID" : badge.id,
            "badgeIcon" : badge.badgeIcon,
            "badgeName" : badge.name,
            "badgeNumPoints" : badge.numPoints
        ]
    }
    
    required init(dictionary: [AnyHashable: Any]){
        self.userEmail = dictionary["userEmail"] as! String
        self.userID = dictionary["userID"] as! String
        self.explanation = dictionary["explanation"] as! String
        self.status = dictionary["status"] as! String
        self.id = dictionary["id"] as! String
        self.badgeDescription = dictionary["badgeDescription"] as! String
        self.badgeIcon = dictionary["badgeIcon"] as! String
        self.badgeID = dictionary["badgeID"] as! String
        self.badgeName = dictionary["badgeName"] as! String
        self.badgeNumPoints = dictionary["badgeNumPoints"] as! Int
        self.teamName = dictionary["teamName"] as! String
        
        self.badge = Badge(name: badgeName, description: badgeDescription, numPoints: badgeNumPoints, id: badgeID, teamName: teamName, badgeIcon: badgeIcon)
        
        self.dictInfo = dictionary
    }
    
    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
    
}
