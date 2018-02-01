//
//  UserService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 01/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class UserService: NSObject {
    static let shared = UserService()
    
    private override init(){
        super.init()
    }
    
    let userManager = UserDatabaseManager.getInstance()
    
    func retrieveUser(userID:String, completionHandler: @escaping (User?)->()) {
        userManager.retrieveUser(userID: userID) { (user) in
            if let currUser = user{
                completionHandler(currUser)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func createUser(name:String, userID:String, isAdmin:String, teamName:String, status:String){
        userManager.createUser(name: name,
                               userID: userID,
                               isAdmin: isAdmin,
                               teamName: teamName,
                               status: status)
    }
}
