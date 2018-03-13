//
//  BadgeRequisition.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class BadgeRequisition: NSObject, PersistenceObject {
    
    
    var userEmail:String = ""
    var userID:String = ""
    var badge:Badge?
    var explanation:String = ""
    var status:String = ""
    var id:String = ""
    var teamName:String = ""
    
    var badgeDescription:String = ""
    var badgeID:String = ""
    var badgeIcon:String = ""
    var badgeName:String = ""
    var badgeNumPoints:Int = 0
    
    var dictInfo : [AnyHashable : Any] = [:]
    
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
    
    required init?(dictionary: [AnyHashable: Any]){
        if let userEmail = dictionary["userEmail"] as? String,
            let userID = dictionary["userID"] as? String,
            let explanation = dictionary["explanation"] as? String,
            let status = dictionary["status"] as? String,
            let id = dictionary["id"] as? String,
            let badgeDescription = dictionary["badgeDescription"] as? String,
            let badgeIcon = dictionary["badgeIcon"] as? String,
            let badgeID = dictionary["badgeID"] as? String,
            let badgeName = dictionary["badgeName"] as? String,
            let badgeNumPoints = dictionary["badgeNumPoints"] as? Int,
            let teamName = dictionary["teamName"] as? String {
            
            self.userEmail = userEmail
            self.userID = userID
            self.explanation = explanation
            self.status = status
            self.id = id
            self.badgeDescription = badgeDescription
            self.badgeIcon = badgeIcon
            self.badgeID = badgeID
            self.badgeName = badgeName
            self.badgeNumPoints = badgeNumPoints
            self.teamName = teamName
            
            self.badge = Badge(name: badgeName, description: badgeDescription, numPoints: badgeNumPoints, id: badgeID, teamName: teamName, badgeIcon: badgeIcon)
            
            self.dictInfo = dictionary
        } else {
            print("Incomplete dictionary in BadgeRequisition object init")
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
    
}
