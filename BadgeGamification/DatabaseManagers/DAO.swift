//
//  DAO.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 22/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol PersistenceObject {
    init(dictionary: [AnyHashable:Any])
}

class DAO: NSObject {
    var ref: DatabaseReference!
    
    override init(){
        super.init()
        ref = Database.database().reference()
    }
    
//    func retrieveAll<T:PersistenceObject>(dump: T.Type, teamName:String, objectName:String, userID:String?, completionHandler: @escaping ([T]?) -> ()){
//        var allObjects:[T] = []
//        let path:String = (userID == nil) ? "Teams/\(teamName)/\(objectName)" :  "Teams/\(teamName)/\(objectName)/\(String(describing: userID))"
//
//        ref?.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String:Any]{
//
//                for key in dictionary.keys {
//                    let objectDict = dictionary[key] as? [String:Any]
//
//                    let newObj = T(dictionary: objectDict!)
//
//                    allObjects.append(newObj)
//                }
//
//                completionHandler(allObjects)
//            } else {
//                completionHandler(nil)
//            }
//        })
//    }
    
    func retrieveAll<T:PersistenceObject>(dump: T.Type, path:String, completionHandler: @escaping ([T]?) -> ()){
        var allObjects:[T] = []
//        let path:String = (userID == nil) ? "Teams/\(teamName)/\(objectName)" :  "Teams/\(teamName)/\(objectName)/\(String(describing: userID))"
        
        ref?.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.value != nil{
                if let dictionary = snapshot.value as? [String:Any]{
                    
                    for key in dictionary.keys {
                        let objectDict = dictionary[key] as? [String:Any]
                        
                        let newObj = T(dictionary: objectDict!)
                        
                        allObjects.append(newObj)
                    }
                    
                    completionHandler(allObjects)
                } else {
                    completionHandler(nil)
                }
            }
        })
    }
    
    
}
