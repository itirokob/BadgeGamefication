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

class BadgeDatabaseManager: DAO{
    static let shared = BadgeDatabaseManager()

    override init(){
        super.init()
    }
    
    func createBadge(newBadge:Badge, teamName:String){
        let path = "Teams/\(teamName)/Badges"
        self.create(dump: Badge.self, object: newBadge, path:path, newObjectID: nil)
        
    }

    func retrieveAllBadges(teamName:String, completionHandler: @escaping ([Badge]?)->()){
        let path = "Teams/\(teamName)/Badges"

        self.retrieveAll(dump: Badge.self, path: path) { (badges) in
            if let badges = badges{
                completionHandler(badges)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func retrieveBadge(badgeID:String, teamName:String, completionHandler: @escaping (Badge?)->()){
        let path = "Teams/\(teamName)/Badges/\(badgeID)"
        
        self.retrieveAll(dump: Badge.self, path : path) { (badge) in
            if let badge = badge {
                completionHandler(badge.first)
            } else {
                completionHandler(nil)
            }
        }
        
    }
}
