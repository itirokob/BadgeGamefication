//
//  TeamDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TeamDatabaseManager: DAO {
    static let shared = TeamDatabaseManager()
    
//    var ref: DatabaseReference!
    
    private override init(){
        super.init()
//        ref = Database.database().reference()
    }
    
    func createTeam(teamName:String, adminID:String, adminName:String) {
        let path = ref?.child("Teams").child(teamName)

        path?.child("teamName").setValue(teamName)
        path?.child("adminID").setValue(adminID)
        path?.child("adminName").setValue(adminName)
    }
    
    func retrieveAllTeams(completionHandler: @escaping ([Team]?)->()){
        self.retrieveAll(dump: Team.self, path: "Teams") { (teams) in
            if let teams = teams{
                completionHandler(teams)
            } else {
                completionHandler(nil)
            }
        }
        
//        var allTeams:[Team] = []
//
//        ref?.child("Teams").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            if let team = snapshot.value as? [String:Any]{
//                for key in team.keys {
//                    let currTeam = team[key] as? [String:Any]
//
//                    let newTeam = Team(teamName: currTeam!["teamName"] as! String,
//                                       adminID: currTeam!["adminID"] as! String,
//                                       adminName: currTeam!["adminName"] as! String)
//
//                    allTeams.append(newTeam)
//                }
//                completionHandler(allTeams)
//            } else {
//                completionHandler(nil)
//            }
//        })
    }
    
    func teamExists(teamName:String, completionHandler: @escaping (Bool) -> ()){
//        self.retrieveAllTeams { (teams) in
//            if let teams = teams{
//                for team in teams{
//                    if team.teamName == teamName {
//                        completionHandler(true)
//                    } else {
//                        completionHandler(false)
//                    }
//                }
//            }
//        }
        
        ref?.child("Teams").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(teamName){
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
}
