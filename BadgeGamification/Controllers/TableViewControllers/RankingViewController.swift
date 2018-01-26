//
//  RankingViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 24/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

struct FinalRank {
    var user:User?
    var points:Int = 0
}

import UIKit
class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var teamName:String?
    
    let userManager = UserDatabaseManager.getInstance()
    let userListManager = UserListDatabaseManager.shared
    let userBadgesManager = UserBadgesDatabaseManager.shared
    let authManager = AuthDatabaseManager.shared
    
    var IDs:[String] = []
    var usersScore:[String:Int] = [:]
    var teamUsers:[User] = []
    var rank:[FinalRank] = []
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userManager.retrieveUsersFromTeam(teamName: teamName!) { (users) in
            if let allUsers = users {
                self.teamUsers = allUsers
                
                self.getUsersScore()
            }
        }
        
        self.changeSignOutButtonTitle()
    }
    
    @IBAction func signOut(_ sender: Any) {
        authManager.signOut()

    }
    fileprivate func sortRanking() {
        if self.teamUsers.count > 0 && self.usersScore.count > 1{
            self.teamUsers.sort(by: { (user1, user2) -> Bool in
                return self.usersScore[user1.id]! > self.usersScore[user2.id]!
            })
        }
    }
    
    fileprivate func getUsersScore() {
        self.retrieveUserBadgesList(completionHandler: { (userPoints) in
            self.usersScore = userPoints
            self.sortRanking()
            self.tableView.reloadData()
        })
    }
    
    func retrieveUserBadgesList(completionHandler: @escaping ([String:Int])->() ){
        var userWithPoints:[String:Int] = [:]
        for user in teamUsers {
            self.userBadgesManager.retrieveAllBadgesFromUser(teamName: self.teamName!, userID: user.id, completionHandler: { (badgeList) in
                
                let totalPoints = badgeList.reduce(0, { (result:Int, badge:Badge) -> Int in
                    return result + badge.numPoints
                })
                
                userWithPoints[user.id] = totalPoints
                
                completionHandler(userWithPoints)
            })
        }
    }
    
    func getProfilePic(user:User) -> UIImage? {
        var userImage:UIImage?
        
        if let cachedImage = self.imageCache.object(forKey: user.profileImageURL as AnyObject ) as? UIImage {
            userImage = cachedImage
        }
        
        if user.profileImageURL != " " {
            let url = URL(string: user.profileImageURL)
            let request = URLRequest(url: url!)
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: data!){
                            self.imageCache.setObject(downloadedImage, forKey: user.profileImageURL as AnyObject )
                            userImage = UIImage(data: data!)
                            self.tableView.reloadData()
                        }
                    }
                } else {
                    print(error.debugDescription)
                }
            }).resume()
        } else {
            return nil
        }
        
        return userImage
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell") as! RankingTableViewCell
        
        if self.teamUsers.count == self.usersScore.count {
            cell.numPoints.text = String(describing: usersScore[teamUsers[indexPath.row].id]!)
            cell.employeeName.text = teamUsers[indexPath.row].name
            cell.rankPosition.text = String(indexPath.row + 1)

            cell.employeeImage.layer.cornerRadius = 0.5 * cell.employeeImage.frame.size.width
            cell.employeeImage.clipsToBounds = true
            
            if let profilePic = self.getProfilePic(user: teamUsers[indexPath.row]){
                cell.employeeImage.image = profilePic
            } else {
                cell.employeeImage.image = #imageLiteral(resourceName: "genericUserIcon")
            }
        }
        return cell
    }
    
}

