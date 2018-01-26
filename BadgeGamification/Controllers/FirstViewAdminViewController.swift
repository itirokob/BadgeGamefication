//
//  FirstViewAdminViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 15/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirstViewAdminViewController: UITabBarController {

    let userManager = UserDatabaseManager.getInstance()
    
    var teamName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
