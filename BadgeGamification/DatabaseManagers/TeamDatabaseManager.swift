//
//  TeamDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TeamDatabaseManager: NSObject {
    static let shared = TeamDatabaseManager()
    
    var ref: DatabaseReference!
    
    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func createTeam(teamName:String, adminID:String, adminName:String) {
        let path = ref?.child("Teams").child(teamName)

        path?.child("teamName").setValue(teamName)
        path?.child("adminID").setValue(adminID)
        path?.child("adminName").setValue(adminName)
    }
    
    func retrieveAllTeams(completionHandler: @escaping ([Team]?)->()){
        var allTeams:[Team] = []
        
        ref?.child("Teams").observe(.childAdded, with: { (snapshot) in
            let team = snapshot.value as? NSDictionary
            
            if let actualTeam = team {
                let newTeam = Team(teamName: actualTeam.value(forKey: "teamName") as! String, adminID: actualTeam.value(forKey: "adminID") as! String, adminName: actualTeam.value(forKey: "adminName") as! String)
                allTeams.append(newTeam)
                completionHandler(allTeams)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func teamExists(teamName:String, completionHandler: @escaping (Bool) -> ()){
        ref?.child("Teams").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(teamName){
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
}
