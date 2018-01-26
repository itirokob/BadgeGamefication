//
//  Variables.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 22/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation

class Variables:NSObject{
    static let shared = Variables()
    
    let badge = ["teamName", "name", "description", "numPoints", "id"]
    let badgeRequisition = ["userEmail", "explanation", "id", "userID", "status", "teamName", "badgeName", "badgeNumPoints", "badgeDescription", "badgeID"]
    let registerRequisition = ["userEmail", "id", "teamName", "userID", "status"]
    let userBadge = ["name", "description", "numPoints", "id", "teamName", "acquisitionDate"]
    let user = ["name", "isAdmin", "teamName", "status"]
    let team = ["teamName", "adminID", "adminName"]
    
    func getPath(teamName:String, type:String) -> String {
        switch type {
        case "Badge":
            return "Teams/\(teamName)/Badges"
        case "BadgeRequisition":
            return "Teams/\(teamName)/BadgeRequisitions"
        case "RegisterRequisition":
            return "Teams/\(teamName)/RegisterRequisitions"
        case "User":
            return "Users"
        case "Team":
            return "Teams/\(teamName)"
        default:
            return " "
        }
    }
    
    func getVariables(type:String) -> [String]{
        switch type {
        case "Badge":
            return badge
        case "BadgeRequisition":
            return badgeRequisition
        case "RegisterRequisition":
            return registerRequisition
        case "User":
            return user
        case "Team":
            return team
        case "UserBadge":
            return userBadge
        default:
            return []
        }
    }
}
