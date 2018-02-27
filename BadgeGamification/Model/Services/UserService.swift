//
//  UserService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 07/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class UserService: NSObject {
    static let shared = UserService()
    
    private override init(){
        super.init()
    }
    
//    private static var instance:UserService?
//
//    static func getInstance() -> UserService{
//        if self.instance == nil{
//            self.instance = UserService()
//        }
//        return self.instance!
//    }
    
    let userManager = UserDAO.shared
    
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
        userManager.createUser(name: name, userID: userID, isAdmin: isAdmin, teamName: teamName, status: status)
    }
    
    func retrieveUsersFromTeam(teamName:String, completionHandler: @escaping ([User]?)->()){
       userManager.retrieveUsersFromTeam(teamName: teamName, completionHandler: completionHandler)
    }
    
    func updateStatus(userID:String, status:String){
       userManager.updateStatus(userID: userID, status: status  )
    }
    
    func update(updatedUser:User, userID:String){
        userManager.update(updatedUser: updatedUser, userID: userID)
    }
    
    
}
