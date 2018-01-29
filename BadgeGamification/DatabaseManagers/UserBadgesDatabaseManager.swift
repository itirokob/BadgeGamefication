//
//  UserBadgesDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserBadgesDatabaseManager:NSObject {
    static let shared = UserBadgesDatabaseManager()
    
    var ref: DatabaseReference!
    
    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func addBadgeToUser(teamName: String, userID:String, badge:Badge, acquisitionDateString:String){
        let path = "Teams/\(teamName)/UserBadgeList/\(userID)/\(badge.id)"
        
        ref?.child("\(path)").setValue([
            "name": badge.name,
            "description": badge.descript,
            "numPoints": badge.numPoints,
            "id": badge.id,
            "teamName": teamName,
            "acquisitionDate": acquisitionDateString,
            "badgeIcon": badge.badgeIcon
        ])
//        ref?.child("\(path)/name").setValue(badge.name)
//        ref?.child("\(path)/description").setValue(badge.descript)
//        ref?.child("\(path)/numPoints").setValue(badge.numPoints)
//        ref?.child("\(path)/id").setValue(badge.id)
//        ref?.child("\(path)/teamName").setValue(teamName)
//        ref?.child("\(path)/acquisitionDate").setValue(acquisitionDateString)
        
    }
    
    func stringToDate(dateString:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        return date
    }
    
    func retrieveAllBadgesFromUser(teamName:String, userID:String, completionHandler: @escaping ([Badge])->()){
        var allBadges:[Badge] = []
        let path = "Teams/\(teamName)/UserBadgeList"
        
        ref?.child("\(path)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let userBadgesList = snapshot.value as? [String: Any] {
                if let userList = userBadgesList[userID] as? [String:Any]{
                    
                    for key in userList.keys {
                        let badge = userList[key] as? [String:Any]
                        
                        let newBadge = Badge(name: badge!["name"] as! String,
                                             description: badge!["description"] as! String,
                                             numPoints: badge!["numPoints"] as! Int,
                                             id: badge!["id"] as! String,
                                             teamName: badge!["teamName"] as! String,
                                             badgeIcon: badge!["badgeIcon"] as! String,
                                             acquisitionDate: self.stringToDate(dateString:
                                                badge!["acquisitionDate"] as! String))
                        
                        allBadges.append(newBadge)
                    }
                    
                    completionHandler(allBadges)
                }
                
            }
        })
    }

    
//    func retrieveAllBadgesFromUser(teamName:String, userID:String, completionHandler: @escaping ([Badge])->()){
//        var allBadges:[Badge] = []
//        let path = "Teams/\(teamName)/UserBadgeList/\(userID)"
//
//        ref?.child("\(path)").observe(.childAdded, with: { (snapshot) in
//            let badge = snapshot.value as? NSDictionary
//
//            if let actualBadge = badge {
//                let newBadge = Badge(
//                    name: actualBadge.value(forKey: "name") as! String,
//                    description: actualBadge.value(forKey: "description") as! String,
//                    numPoints: actualBadge.value(forKey: "numPoints") as! Int,
//                    id: actualBadge.value(forKey: "id") as! String,
//                    teamName: actualBadge.value(forKey: "teamName") as! String,
//                    badgeIcon: actualBadge.value(forKey: "badgeIcon") as! String,
//                    acquisitionDate: self.stringToDate(dateString:
//                        actualBadge.value(forKey: "acquisitionDate") as! String))
//                allBadges.append(newBadge)
//                completionHandler(allBadges)
//            }
//        })
//    }
}
