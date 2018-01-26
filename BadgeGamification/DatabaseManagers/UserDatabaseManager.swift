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

class UserDatabaseManager:NSObject {
//    static let shared = UserDatabaseManager()
    
    var ref: DatabaseReference!
    
    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    private static var instance:UserDatabaseManager?
    
    static func getInstance() -> UserDatabaseManager{
        if self.instance == nil{
            self.instance = UserDatabaseManager()
        }
        return self.instance!
    }
    
    func createUser(name:String, userID:String, isAdmin:String, teamName:String, status:String){
        let path = ref?.child("Users").child(userID)
        
        path?.setValue([
            "name":name,
            "isAdmin":isAdmin,
            "teamName": teamName,
            "status": status,
            "profileImageURL": " ",
            "id" : userID
        ])
        
//        path?.child("name").setValue(name)
//        path?.child("isAdmin").setValue(isAdmin)
////        path?.child("teamID").setValue(teamID)
//        path?.child("teamName").setValue(teamName)
//        path?.child("status").setValue(status)
//        path?.child("profileImageURL").setValue(" ")
    }
    
    func retrieveUsers(completionHandler: @escaping ([User]?)-> ()){
        var allUsers:[User] = []
        
        ref?.child("Users").observe(.value, with: { (snapshot) in
            let user = snapshot.value as? NSDictionary
            
            if let currUser = user {
                let jsonUser = JSON(currUser)
                let newUser = User(name: jsonUser["name"].string!,
                                   isAdmin: jsonUser["isAdmin"].string!,
                                   teamName: jsonUser["teamName"].string!,
                                   status: jsonUser["status"].string!,
                                   profileImageURL: jsonUser["profileImageURL"].string!,
                                   id: jsonUser["id"].string!)
                allUsers.append(newUser)
                completionHandler(allUsers)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func retrieveUser(userID:String, completionHandler: @escaping (User)->()){
        ref?.child("Users/\(userID)").observe(.value, with: { (snapshot) in
            let user = snapshot.value as? NSDictionary
            
            if let actualUser = user {
                let jsonUser = JSON(actualUser)
                let newUser = User(name: jsonUser["name"].string!,
                                   isAdmin: jsonUser["isAdmin"].string!,
                                   teamName: jsonUser["teamName"].string!,
                                   status: jsonUser["status"].string!,
                                   profileImageURL: jsonUser["profileImageURL"].string!,
                                   id: jsonUser["id"].string!)
                completionHandler(newUser)
            }
        })
    }
    
    func retrieveUsersFromTeam(teamName:String, completionHandler: @escaping ([User]?)->()){
        var allUsers:[User] = []
        
        ref?.child("Users").observe(.value, with: { (snapshot) in
            let user = snapshot.value as? NSDictionary
            
            if let actualUser = user {
                let json = JSON(actualUser).dictionaryValue
                
                for jsonUser in json{
                    if jsonUser.value["teamName"].string! == teamName && jsonUser.value["isAdmin"].string! == "false" {
                        let newUser = User(name: jsonUser.value["name"].string!,
                                           isAdmin: jsonUser.value["isAdmin"].string!,
                                           teamName: jsonUser.value["teamName"].string!,
                                           status: jsonUser.value["status"].string!,
                                           profileImageURL: jsonUser.value["profileImageURL"].string!,
                                           id: jsonUser.value["id"].string!)
                        allUsers.append(newUser)
                        completionHandler(allUsers)
                    }
                }
            } else {
                completionHandler(nil)
            }
        })
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
            "profileImageURL": updatedUser.profileImageURL
        ]
        
        let childUpdates = [
            "Users/\(userID)":user
        ]

        ref.updateChildValues(childUpdates)
    }
    
    
}
