//
//  UserDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

class UserDAO:DAO {
    static let shared = UserDAO()

    private override init(){
        super.init()
    }
    
//    private static var instance:UserDAO?
//
//    static func getInstance() -> UserDAO{
//        if self.instance == nil{
//            self.instance = UserDAO()
//        }
//        return self.instance!
//    }
//
    func createUser(name:String, userID:String, isAdmin:String, teamName:String, status:String){
        let newUser = User(dictionary: [
            "name":name,
            "isAdmin":isAdmin,
            "teamName": teamName,
            "status": status,
            "profileImageURL": " ",
            "id" : userID
        ])
        
        let path = "Users"
        
        self.create(dump: User.self, object: newUser!, path: path, newObjectID: userID)
    }
    
    func retrieveUser(userID:String, completionHandler: @escaping (User?)->()){
        ref?.child("Users/\(userID)").observeSingleEvent(of: .value, with: { (snapshot) in
            let user = snapshot.value as? NSDictionary

            if let actualUser = user {

                let newUser = User(dictionary: actualUser as! [AnyHashable : Any])

                completionHandler(newUser)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func retrieveUsersFromTeam(teamName:String, completionHandler: @escaping ([User]?)->()){
        var totalUsers:[User] = []

        self.retrieveAll(dump: User.self, path: "Users") { (users) in
            if let users = users{
                for user in users{
                    if user.teamName == teamName && user.isAdmin == "false" && user.status == "A" {
                        totalUsers.append(user)
                    }
                }
                
                completionHandler(totalUsers)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func updateStatus(userID:String, status:String){
        ref.updateChildValues([
            "Users/\(userID)/status" : status
        ])
    }
    
    func update(updatedUser:User, userID:String){
        let user = [
            "name": updatedUser.name,
            "isAdmin": updatedUser.isAdmin,
            "teamName": updatedUser.teamName,
            "status": updatedUser.status,
            "profileImageURL": updatedUser.profileImageURL,
            "id" : userID
        ]
        
        let childUpdates = [
            "Users/\(userID)":user
        ]

        ref.updateChildValues(childUpdates)
    }
    
    
}
