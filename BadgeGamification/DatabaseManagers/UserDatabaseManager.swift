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

class UserDatabaseManager:DAO {
//    static let shared = UserDatabaseManager()
    
//    var ref: DatabaseReference!
    
    private override init(){
        super.init()
//        ref = Database.database().reference()
    }
    
    private static var instance:UserDatabaseManager?
    
    static func getInstance() -> UserDatabaseManager{
        if self.instance == nil{
            self.instance = UserDatabaseManager()
        }
        return self.instance!
    }
    
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
        
        self.create(dump: User.self, object: newUser, path: path, newObjectID: userID)
//
//
//        let path = ref?.child("Users").child(userID)
//
//        path?.setValue([
//            "name":name,
//            "isAdmin":isAdmin,
//            "teamName": teamName,
//            "status": status,
//            "profileImageURL": " ",
//            "id" : userID
//        ])
    }

//    func retrieveUsers(completionHandler: @escaping ([User]?)-> ()){
//        var totalUsers:[User] = []
//        
//        ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let allUsers = snapshot.value as? [String:Any] {
//                for key in allUsers.keys {
//                    let currUser = allUsers[key] as? [String:Any]
//                    
//                    let newUser = User(dictionary: [
//                        "name" : currUser!["name"] as! String,
//                        "isAdmin" : currUser!["isAdmin"] as! String,
//                        "teamName" : currUser!["teamName"] as! String,
//                        "status" : currUser!["status"] as! String,
//                        "profileImageURL" : currUser!["profileImageURL"] as! String,
//                        "id": currUser!["id"] as! String
//                    ])
////                    let newUser = User(name: currUser!["name"] as! String,
////                                       isAdmin: currUser!["isAdmin"] as! String,
////                                       teamName: currUser!["teamName"] as! String,
////                                       status: currUser!["status"] as! String,
////                                       profileImageURL: currUser!["profileImageURL"] as! String,
////                                       id: currUser!["id"] as! String)
//                    totalUsers.append(newUser)
//                }
//                completionHandler(totalUsers)
//            } else {
//                completionHandler(nil)
//            }
//        })
//    }
    
//    func retrieveUsers(completionHandler: @escaping ([User]?)-> ()){
//        var allUsers:[User] = []
//
//        ref?.child("Users").observe(.value, with: { (snapshot) in
//            let user = snapshot.value as? NSDictionary
//
//            if let currUser = user {
//                let jsonUser = JSON(currUser)
//                let newUser = User(name: jsonUser["name"].string!,
//                                   isAdmin: jsonUser["isAdmin"].string!,
//                                   teamName: jsonUser["teamName"].string!,
//                                   status: jsonUser["status"].string!,
//                                   profileImageURL: jsonUser["profileImageURL"].string!,
//                                   id: jsonUser["id"].string!)
//                allUsers.append(newUser)
//                completionHandler(allUsers)
//            } else {
//                completionHandler(nil)
//            }
//        })
//    }
    
    func retrieveUser(userID:String, completionHandler: @escaping (User?)->()){
//        self.retrieveAll(dump: User.self, path: "Users/\(userID)") { (user) in
//            if let user = user {
//                completionHandler(user.first)
//            } else {
//                completionHandler(nil)
//            }
//        }
        
        ref?.child("Users/\(userID)").observeSingleEvent(of: .value, with: { (snapshot) in
            let user = snapshot.value as? NSDictionary

            if let actualUser = user {
//                let jsonUser = JSON(actualUser)

                let newUser = User(dictionary: actualUser as! [AnyHashable : Any])

//                let newUser = User(name: jsonUser["name"].string!,
//                                   isAdmin: jsonUser["isAdmin"].string!,
//                                   teamName: jsonUser["teamName"].string!,
//                                   status: jsonUser["status"].string!,
//                                   profileImageURL: jsonUser["profileImageURL"].string!,
//                                   id: jsonUser["id"].string!)
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
        
        
//        ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let allUsers = snapshot.value as? [String:Any] {
//                for key in allUsers.keys {
//                    let currUser = allUsers[key] as? [String:Any]
//
//                    if currUser!["teamName"] as! String == teamName && currUser!["isAdmin"] as! String == "false" &&  currUser!["status"] as! String == "A"{
//
//                        let newUser = User(name: currUser!["name"] as! String,
//                                           isAdmin: currUser!["isAdmin"] as! String,
//                                           teamName: currUser!["teamName"] as! String,
//                                           status: currUser!["status"] as! String,
//                                           profileImageURL: currUser!["profileImageURL"] as! String,
//                                           id: currUser!["id"] as! String)
//                        totalUsers.append(newUser)
//                    }
//                }
//                completionHandler(totalUsers)
//            } else {
//                completionHandler(nil)
//            }
//        })
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
