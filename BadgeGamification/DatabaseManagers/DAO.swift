//
//  DAO.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 22/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DAO: NSObject {
    let variables = Variables.shared
    static let shared = DAO()
    
    var ref: DatabaseReference!
    
    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func create(teamName:String, parameters:[String], type:String){
        let vars = variables.getVariables(type: type)
        
        let URL = variables.getPath(teamName: teamName, type: type)
        let newItemID = ref?.child(URL).childByAutoId().key
        let path = ref?.child(URL).child(newItemID!)
        
        for i in 0...vars.count {
            path?.child(vars[i]).setValue(parameters[i])
        }
    }
    
    
}
