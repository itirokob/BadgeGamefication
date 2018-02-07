//
//  UserBadgeService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 07/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class UserBadgeService: NSObject {
    static let shared = UserBadgeService()
    
    private override init(){
        super.init()
    }
    
    let userBadgeManager = UserBadgeDAO.shared
    
    func initializeUserBadgeList(userID:String, teamName:String){
        userBadgeManager.initializeUserBadgeList(userID: userID, teamName: teamName)
    }
    
    func addBadgeToUser(teamName: String, userID:String, badge:Badge, acquisitionDateString:String){
        userBadgeManager.addBadgeToUser(teamName: teamName, userID: userID, badge: badge, acquisitionDateString: acquisitionDateString)
    }

    func retrieveAllBadgesFromUser(teamName:String, userID:String, completionHandler: @escaping ([Badge]?)->()){
        userBadgeManager.retrieveAllBadgesFromUser(teamName: teamName, userID: userID, completionHandler: completionHandler)
    }

}
