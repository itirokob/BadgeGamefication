//
//  RegisterRequistion.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class RegisterRequistion: NSObject, PersistenceObject{
    var userEmail:String = ""
    var id:String = ""
    var status:String = ""
    var teamName:String = ""
    var userID:String = ""
    var dictInfo:[AnyHashable:Any] = [:]
    
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
    
    required init?(dictionary: [AnyHashable: Any]){
        if let userEmail = dictionary["userEmail"] as? String,
            let status = dictionary["status"] as? String,
            let id = dictionary["id"] as? String,
            let teamName = dictionary["teamName"] as? String,
            let userID = dictionary["userID"] as? String {
            
            self.userEmail = userEmail
            self.status = status
            self.id = id
            self.teamName = teamName
            self.userID = userID
            self.dictInfo = dictionary
        } else {
            print("Incomplete dictionary in RegisterRequisition object init")
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
}
