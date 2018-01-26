//
//  BadgeRequisition.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class BadgeRequisition: NSObject {
    var userEmail:String
    var userID:String
    var badge:Badge
    var explanation:String
    var status:String
    var id:String
    var teamName:String
    
    //Adicionar campo userUUID e badgeID
    init(userEmail:String, explanation:String, status:String, id:String, userID:String, badge:Badge, teamName:String){
        self.userEmail = userEmail
        self.userID = userID
        self.explanation = explanation
        self.status = status
        self.id = id
        self.badge = badge
        self.teamName = teamName
    }    
}
