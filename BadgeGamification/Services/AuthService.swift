//
//  AuthService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 01/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import Firebase

class AuthService: NSObject {
    static let shared = AuthService()
    
    private override init(){
        super.init()
    }
    
    let authManager = AuthDatabaseManager.shared
    let userService = UserService.shared
    
    func login(email:String, password:String, completionHandler: @escaping (User?) -> ()){
        authManager.signIn(email: email, password: password) { (success, idOrErrorMessage) in
            if success{
                
                self.userService.retrieveUser(userID: idOrErrorMessage, completionHandler: { (user) in
                    if let currUser = user{
                        completionHandler(currUser)
                    } else {
                        print("Error on login")
                    }
                })
                
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func register(email:String, password:String, name:String, completionHandler: @escaping (Bool, String)->()){
        authManager.register(email: email, password: password) { (success, idOrErrorMessage) in
            
            if success {
                self.userService.createUser(name: name,
                                            userID: idOrErrorMessage,
                                            isAdmin: "false",
                                            teamName: "",
                                            status: "")
                completionHandler(true, "")
            } else {
                completionHandler(false, idOrErrorMessage)
            }
            
        }
    }
    
    func signOut(){
        authManager.signOut()
    }
    
}
