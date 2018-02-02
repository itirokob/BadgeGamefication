//
//  AvailableBadgesViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class AvailableBadgesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var badges:[Badge] = []
    let badgeManager = BadgeDAO.shared
    var teamName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.changeSignOutButtonTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveAllBadges()
    }
    
    func retrieveAllBadges(){
        badgeManager.retrieveAllBadges(teamName: teamName!) { (badges) in
            if let allBadges = badges {
                self.badges = allBadges
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.badges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableBadgeCell") as! AvailableBadgesTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        cell.badgeName.text = badges[indexPath.row].name
        cell.badgeIcon.image = selectBadgeIcon(badgeIcon: badges[indexPath.row].badgeIcon)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "badgeReq"{
            let nextView = segue.destination as? BadgeRequisitionViewController
            let index = self.tableView.indexPathForSelectedRow
            nextView?.badge = badges[(index?.row)!]
        }
    }
}
