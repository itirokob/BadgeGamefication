//
//  User.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:String
    var isAdmin:String
    var teamName:String
    var status:String
    var profileImageURL:String
    var id:String
//    var email:String
    
    init(name:String, isAdmin:String, teamName:String, status:String, profileImageURL:String, id:String){
        self.name = name
        self.isAdmin = isAdmin
        self.teamName = teamName
        self.status = status
        self.profileImageURL = profileImageURL
        self.id = id
    }
}
