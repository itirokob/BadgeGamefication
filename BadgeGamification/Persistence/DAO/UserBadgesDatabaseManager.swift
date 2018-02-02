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
    
    private override init(){
        super.init()
    }
    
    let objectName = "UserBadgeList"
    
    func initializeUserBadgeList(userID:String, teamName:String){
        ref?.child("Teams/\(teamName)/UserBadgeList/\(userID)")
    }
    
    func addBadgeToUser(teamName: String, userID:String, badge:Badge, acquisitionDateString:String){
        let path = "Teams/\(teamName)/UserBadgeList/\(userID)"
       
        badge.dictInfo["acquisitionDate"] = acquisitionDateString
        
        self.create(dump: Badge.self, object: badge, path: path, newObjectID: badge.id)
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
            completionHandler(badges)
//            if let badges = badges{
//                completionHandler(badges)
//            } else {
//                completionHandler(nil)
//            }
        }
    }
}
