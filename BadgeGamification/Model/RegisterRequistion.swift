//
//  RegisterRequistion.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class RegisterRequistion: NSObject, PersistenceObject{
    var userEmail:String
    var id:String
    var status:String
    var teamName:String
    var userID:String
    var dictInfo:[AnyHashable:Any]
    
    init(userEmail:String, id:String, status:String, teamName:String, userID:String){
        self.userEmail = userEmail
        self.status = status
        self.id = id
        self.teamName = teamName
        self.userID = userID
        self.dictInfo = [
            "userEmail" : userEmail,
            "status" : status,
            "id" : id,
            "teamName" : teamName,
            "userID" : userID
        ]
    }
    
    required init(dictionary: [AnyHashable: Any]){
        self.userEmail = dictionary["userEmail"] as! String
        self.status = dictionary["status"] as! String
        self.id = dictionary["id"] as! String
        self.teamName = dictionary["teamName"] as! String
        self.userID = dictionary["userID"] as! String
        
        self.dictInfo = dictionary
    }
    
    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
}
