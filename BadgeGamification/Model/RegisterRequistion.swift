//
//  RegisterRequistion.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class RegisterRequistion: NSObject {
    var userEmail:String
    var id:String
    var status:String
    var teamName:String
    var userID:String
    
    init(userEmail:String, id:String, status:String, teamName:String, userID:String){
        self.userEmail = userEmail
        self.status = status
        self.id = id
        self.teamName = teamName
        self.userID = userID
    }
}
