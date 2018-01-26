//
//  ExistantBadgesViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 09/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class ExistantBadgesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let badgeDatabaseManager = BadgeDatabaseManager.shared
    var badges:[Badge] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        retrieveBadges()
    }

    func retrieveBadges(){
        badgeDatabaseManager.retrieveAllBadges { (badges) in
            self.badges = badges
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.badges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BadgeTableViewCell
        
        cell.badgeName.text = badges[indexPath.row].name
        
        return cell
    }
    
    
}
