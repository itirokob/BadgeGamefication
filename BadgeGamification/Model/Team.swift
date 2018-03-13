//
//  Team.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class Team: NSObject, PersistenceObject {
    
    var teamName:String = ""
    var adminID:String = ""
    var adminName:String = ""
    var dictInfo:[AnyHashable:Any] = [:]
    
    init(teamName:String, adminID:String, adminName:String){
        self.teamName = teamName
        self.adminID = adminID
        self.adminName = adminName
        
        self.dictInfo = [
            "teamName":teamName,
            "adminID": adminID,
            "adminName": adminName
        ]
    }
    
    required init?(dictionary: [AnyHashable: Any]){
        if let teamName = dictionary["teamName"] as? String,
            let adminID = dictionary["adminID"] as? String,
            let adminName = dictionary["adminName"] as? String{
            
            self.teamName = teamName
            self.adminID = adminID
            self.adminName = adminName
            
            self.dictInfo = dictionary
        } else {
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
    
    
}
