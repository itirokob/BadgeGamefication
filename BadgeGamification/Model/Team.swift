//
//  Team.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class Team: NSObject, PersistenceObject {
    
    var teamName:String
    var adminID:String
    var adminName:String
    var dictInfo:[AnyHashable:Any]
    
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
    
    required init(dictionary: [AnyHashable: Any]){
        self.teamName = dictionary["teamName"] as! String
        self.adminID = dictionary["adminID"] as! String
        self.adminName = dictionary["adminName"] as! String
        
        self.dictInfo = dictionary
    }
    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
    
    
}
