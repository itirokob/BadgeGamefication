//
//  TeamService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 07/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class TeamService: NSObject {
    static let shared = TeamService()
    
    private override init(){
        super.init()
    }
    
    let teamManager = TeamDAO.shared
    
    func createTeam(teamName:String, adminID:String, adminName:String) {
        teamManager.createTeam(teamName: teamName, adminID: adminID, adminName: adminName)
    }
    
    func retrieveAllTeams(completionHandler: @escaping ([Team]?)->()){
       teamManager.retrieveAllTeams(completionHandler: completionHandler)
    }
    
    func teamExists(teamName:String, completionHandler: @escaping (Bool) -> ()){
        teamManager.teamExists(teamName: teamName, completionHandler: completionHandler)
    }
}
