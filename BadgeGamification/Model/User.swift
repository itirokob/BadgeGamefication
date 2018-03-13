//
//  User.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class User: NSObject, PersistenceObject{
    var name:String = ""
    var isAdmin:String = ""
    var teamName:String = ""
    var status:String = ""
    var profileImageURL:String = ""
    var id:String = ""
    var dictInfo: [AnyHashable:Any] = [:]

    required init?(dictionary: [AnyHashable: Any]){
        
        if  let name = dictionary["name"] as? String,
            let isAdmin = dictionary["isAdmin"] as? String,
            let teamName = dictionary["teamName"] as? String,
            let status = dictionary["status"] as? String,
            let profileImageURL = dictionary["profileImageURL"] as? String,
            let id = dictionary["id"] as? String {
            
            self.name = name
            self.isAdmin = isAdmin
            self.teamName = teamName
            self.status = status
            self.profileImageURL = profileImageURL
            self.id = id
            self.dictInfo = dictionary
        } else {
            print("Dictionary incomplete to create User object")
            return nil
        }        
    }

    init(name:String, isAdmin:String, teamName:String, status:String, profileImageURL:String, id:String){
        self.name = name
        self.isAdmin = isAdmin
        self.teamName = teamName
        self.status = status
        self.profileImageURL = profileImageURL
        self.id = id
        self.dictInfo = [
            "name" : name,
            "isAdmin" : isAdmin,
            "teamName" : teamName,
            "status" : status,
            "profileImageURL" : profileImageURL,
            "id" : id
        ]
    }
    
    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
}
