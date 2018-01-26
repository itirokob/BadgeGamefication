//
//  UserListDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 24/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserListDatabaseManager: NSObject {
    static let shared = UserListDatabaseManager()
    
    var ref: DatabaseReference!
    
    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func createUserInList(teamName:String, userID:String){
        ref?.child("Teams/\(teamName)/UsersList").childByAutoId().setValue([
            "userID":userID
        ])
    }
    
    func retrieveUsersFromList(teamName:String, completionHandler: @escaping ([String]?)->()){
        var allUsersIDs:[String] = []
        
        ref?.child("Teams/\(teamName)/UsersList").observe(.childAdded, with: { (snapshot) in
            let user = snapshot.value as? NSDictionary
            
            if let currUser = user{
                allUsersIDs.append(currUser.value(forKey: "userID") as! String)
                
                completionHandler(allUsersIDs)
            } else {
                completionHandler(nil)
            }
        })
    }
}
