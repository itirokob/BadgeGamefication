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
    func getDictInfo() ->[AnyHashable:Any]
}

class DAO: NSObject {
    var ref: DatabaseReference!
    
    override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func retrieveAll<T:PersistenceObject>(dump: T.Type, path:String, completionHandler: @escaping ([T]?) -> ()){
        var allObjects:[T] = []
        
        ref?.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
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
        })
    }
    
    func create<T:PersistenceObject>(dump: T.Type, object: T, path:String, newObjectID:String?){
        let newID = (newObjectID == nil) ? ref?.child(path).childByAutoId().key : newObjectID
        
        var dict = object.getDictInfo()
        
        dict["id"] = newID
        
        ref?.child(path).child(newID!).setValue(dict)
    }
    
}
