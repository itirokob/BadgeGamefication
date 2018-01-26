//
//  BadgeDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 09/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import SwiftyJSON

class BadgeDatabaseManager:NSObject {
    static let shared = BadgeDatabaseManager()
    
    var ref: DatabaseReference!

    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func createBadge(name:String, description:String, numPoints:Int, teamName:String, badgeIcon:String){
        let badgeID = ref?.child("Teams/\(teamName)/Badges").childByAutoId().key
        let path = ref?.child("Teams/\(teamName)/Badges").child(badgeID!)
        
        path?.setValue([
            "teamName": teamName,
            "name": name,
            "description":description,
            "numPoints": numPoints,
            "badgeIcon": badgeIcon,
            "id": badgeID!
        ])
    }
    
    func retrieveAllBadges(teamName:String, completionHandler: @escaping ([Badge]?)->()){
        var allBadges:[Badge] = []
        
        
        ref?.child("Teams/\(teamName)/Badges").observe(.childAdded, with: { (snapshot) in
            let badge = snapshot.value as? NSDictionary
            
            if let actualBadge = badge {
                let jsonBadge = JSON(actualBadge)
                let newBadge = Badge(name: jsonBadge["name"].string!,
                                     description: jsonBadge["description"].string!,
                                     numPoints: jsonBadge["numPoints"].int!,
                                     id: jsonBadge["id"].string!,
                                     teamName: jsonBadge["teamName"].string!, badgeIcon: jsonBadge["badgeIcon"].string!)
                allBadges.append(newBadge)
                completionHandler(allBadges)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func retrieveBadge(badgeID:String, teamName:String, completionHandler: @escaping (Badge?)->()){
        ref?.child("Teams/\(teamName)/Badges").child(badgeID).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            let badge = snapshot.value as? NSDictionary
            
            if let actualBadge = badge {
                let jsonBadge = JSON(actualBadge)
                completionHandler(
                    Badge(name: jsonBadge["name"].string!,
                          description: jsonBadge["description"].string!,
                          numPoints: jsonBadge["numPoints"].int!,
                          id: jsonBadge["id"].string!,
                          teamName: jsonBadge["teamName"].string!,
                          badgeIcon: jsonBadge["badgeIcon"].string!)
                )
            } else {
                completionHandler(nil)
            }
        })
        
    }
}
