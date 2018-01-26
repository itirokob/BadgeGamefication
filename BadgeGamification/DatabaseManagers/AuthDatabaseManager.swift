//
//  DatabaseManager.swift
//  
//
//  Created by Bianca Itiroko on 08/01/18.
//

import Foundation
import FirebaseAuth

let WRONG_PASSWORD = 17009
let USER_NOT_FOUND = 17011
let WEAK_PASSWORD = 17026
let EMAIL_IN_USE = 17007

class AuthDatabaseManager:NSObject{
    static let shared = AuthDatabaseManager()

    private override init(){
        super.init()
    }
    
    func signIn(email:String, password:String, completionHandler: @escaping (Bool, String) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if user != nil {
                print("User logged succesfully")
                completionHandler(true, (user?.uid)!)
            } else {
                print("Error on loging in: \(error.debugDescription)")
                completionHandler(false, self.treatError(error: error! as NSError))
            }
        }
    }
    
    func treatError(error:NSError) -> String {
        var message:String
        
        switch(error.code) {
        case WRONG_PASSWORD:
            message = "Wrong password"
            break
            
        case USER_NOT_FOUND:
            message = "User not found"
            break
            
        case WEAK_PASSWORD:
            message = "Weak password. Try one with at least 6 characters"
            break
        
        case EMAIL_IN_USE:
            message = "Email already in use"
            break
            
        default:
            message = String(describing: (error.localizedDescription))
        }
        
        return message
    }
    
    func register(email:String, password:String, completionHandler: @escaping (Bool, String) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let newUser = user {
                print("User created succesfully")
                completionHandler(true, newUser.uid)
            } else {
                print("Error on register: \(String(describing: (error?.localizedDescription)!))")
                completionHandler(false, self.treatError(error: error! as NSError))
            }
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            
            print("Logged out successfully")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    

}

