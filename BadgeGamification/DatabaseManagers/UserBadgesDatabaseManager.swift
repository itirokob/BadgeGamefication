//
//  UserBadgesDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserBadgesDatabaseManager:DAO {
    static let shared = UserBadgesDatabaseManager()
    
//    var ref: DatabaseReference!
    
    private override init(){
        super.init()
//        ref = Database.database().reference()
    }
    
    let objectName = "UserBadgeList"
    
    func initializeUserBadgeList(userID:String, teamName:String){
        ref?.child("Teams/\(teamName)/UserBadgeList/\(userID)")
    }
    
    func addBadgeToUser(teamName: String, userID:String, badge:Badge, acquisitionDateString:String){
        let path = "Teams/\(teamName)/UserBadgeList/\(userID)"
       
        badge.dictInfo["acquisitionDate"] = acquisitionDateString
        
        self.create(dump: Badge.self, object: badge, path: path, newObjectID: badge.id)
        
//        ref?.child("\(path)").setValue([
//            "name": badge.name,
//            "description": badge.descript,
//            "numPoints": badge.numPoints,
//            "id": badge.id,
//            "teamName": teamName,
//            "acquisitionDate": acquisitionDateString,
//            "badgeIcon": badge.badgeIcon
//        ])
        
    }
    
    func stringToDate(dateString:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        return date
    }
    
    func retrieveAllBadgesFromUser(teamName:String, userID:String, completionHandler: @escaping ([Badge]?)->()){
        let path = "Teams/\(teamName)/UserBadgeList/\(userID)"
        
        self.retrieveAll(dump: Badge.self, path: path) { (badges) in
            if let badges = badges{
                completionHandler(badges)
            } else {
                completionHandler(nil)
            }
        }
//        let path = "Teams/\(teamName)/UserBadgeList"
//
//        ref?.child("\(path)").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let userBadgesList = snapshot.value as? [String: Any] {
//                if let userList = userBadgesList[userID] as? [String:Any]{
//
//                    for key in userList.keys {
//                        let badge = userList[key] as? [String:Any]
//
//                        let newBadge = Badge(name: badge!["name"] as! String,
//                                             description: badge!["description"] as! String,
//                                             numPoints: badge!["numPoints"] as! Int,
//                                             id: badge!["id"] as! String,
//                                             teamName: badge!["teamName"] as! String,
//                                             badgeIcon: badge!["badgeIcon"] as! String,
//                                             acquisitionDate: self.stringToDate(dateString:
//                                                badge!["acquisitionDate"] as! String))
//
//                        allBadges.append(newBadge)
//                    }
//
//                    completionHandler(allBadges)
//                } else {
//                    completionHandler(nil)
//                }
//
//            }
//        })
    }
}
