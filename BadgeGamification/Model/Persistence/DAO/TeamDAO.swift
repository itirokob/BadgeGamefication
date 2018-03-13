//
//  TeamDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TeamDAO: DAO {
    static let shared = TeamDAO()
    
    private override init(){
        super.init()
    }
    
    func createTeam(teamName:String, adminID:String, adminName:String) {
        let newTeam = Team(dictionary: [
            "teamName": teamName,
            "adminID": adminID,
            "adminName": adminName
        ])
        
        if let newTeam = newTeam{
            self.create(dump: Team.self, object: newTeam, path: "Teams", newObjectID: teamName)
        }
    }
    
    func retrieveAllTeams(completionHandler: @escaping ([Team]?)->()){
        self.retrieveAll(dump: Team.self, path: "Teams") { (teams) in
            if let teams = teams{
                completionHandler(teams)
            } else {
                completionHandler(nil)
            }
        }
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
