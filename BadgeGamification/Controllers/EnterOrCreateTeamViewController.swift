//
//  EnterOrCreateTeamViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class EnterOrCreateTeamViewController: UIViewController {

    var userName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createTeam"{
            let nextView = segue.destination as? CreateTeamViewController
            
            if let name = self.userName {
                nextView?.adminName = name
            }
        } else if segue.identifier == "enterTeam"{
            let nextView = segue.destination as? AllTeamsViewController
            
            if let name = self.userName {
                nextView?.userName = name
            }
        }
    }
}
