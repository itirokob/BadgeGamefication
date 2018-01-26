//
//  DatabaseManager.swift
//  
//
//  Created by Bianca Itiroko on 08/01/18.
//

import Foundation
import FirebaseAuth


class AuthDatabaseManager:NSObject{
    static let shared = AuthDatabaseManager()

    private override init(){
        super.init()
    }
    
    func signIn(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                print("User logged succesfully")
            } else {
                print("Error on loging in: \(error.debugDescription)")
            }
        }
    }
    
    func register(email:String, password:String){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil{
                print("User created succesfully")
            } else {
                print("Error on register: \(error.debugDescription)")
                
            }
        }
    }
    

}

