//
//  ExistantBadgesViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 09/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class ExistantBadgesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let badgeDatabaseManager = BadgeDAO.shared
    var badges:[Badge] = []
    var teamName:String?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let authManager = AuthService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        retrieveBadges()
    }

    func retrieveBadges(){
        badgeDatabaseManager.retrieveAllBadges(teamName: teamName!) { (badges) in
            if let allBadges = badges{
                self.badges = allBadges
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createBadgeSegue"{
            if let nextView = segue.destination as? CreateBadgeViewController{
                nextView.teamName = self.teamName
            }
        }
    }
    
    @IBAction func unwindToExistantBadges(segue: UIStoryboardSegue) {}
    
    @IBAction func signOut(_ sender: Any) {
        authManager.signOut()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.badges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BadgeTableViewCell
        
        let currBadge = badges[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        cell.badgeName.text = currBadge.name
        cell.badgeDescription.text = currBadge.descript
     
        
        cell.badgeNumPoints.text = String(currBadge.numPoints)
        cell.badgeIcon.image = selectBadgeIcon(badgeIcon: currBadge.badgeIcon)
        
        return cell
    }
}

extension UIViewController{
    func selectBadgeIcon(badgeIcon:String) -> UIImage{
        return UIImage(named: badgeIcon)!
    }
}
