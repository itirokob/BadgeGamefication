//
//  BadgeService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 07/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class BadgeService: NSObject {
    static let shared = BadgeService()
    
    override init(){
        super.init()
    }
    
    let badgeManager = BadgeDAO.shared
    
    func createBadge(badge:Badge, teamName:String){
        badgeManager.createBadge(newBadge: badge, teamName: teamName)
    }
    
    func retrieveAllBadges(teamName:String, completion: @escaping ([Badge]?)->()){
        badgeManager.retrieveAllBadges(teamName: teamName, completionHandler: completion)
    }
    
    func retrieveBadge(badgeID:String, teamName:String, completion: @escaping (Badge?)->()){
        badgeManager.retrieveBadge(badgeID: badgeID, teamName: teamName, completionHandler: completion)
    }
}
