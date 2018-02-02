//
//  AllTeamsViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 15/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseAuth

class AllTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var userName:String?
    
    var teams:[Team] = []
    
    let teamDatabaseManager = TeamDatabaseManager.shared
    let userDatabaseManager = UserDatabaseManager.getInstance()
    let userBadgeManager = UserBadgesDatabaseManager.shared
    let registerReqDatabaseManager = RegisterReqDatabaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveAllTeams()
        
        self.hideKeyboardWhenTappedAround()

    }
    
    func retrieveAllTeams(){
        teamDatabaseManager.retrieveAllTeams { (teams) in
            if let allTeams = teams{
                self.teams = allTeams
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func joinAction(_ sender: UIButton) {
        let team = teams[sender.tag]
        let userEmail = Auth.auth().currentUser?.email
        let userID = Auth.auth().currentUser?.uid
        
        //Criar requisicao
        let newRegisterReq = RegisterRequistion(dictionary: [
            "userEmail": userEmail!,
            "id": " ",
            "teamName": team.teamName,
            "userID": userID!,
            "status": "PA" //Pendent Approval
        ])
        registerReqDatabaseManager.createRegisterRequisition(teamName: team.teamName, newRegisterReq:newRegisterReq)
        createUser(teamName: team.teamName)
        
        self.alert(message: "Requisition done! Wait for admin approval"){_ in
            self.performSegue(withIdentifier: "unwindToLogin", sender: self)
        }
    }
    
//    func alertRequisitionDone(completionHandler: @escaping (UIAlertAction) -> (Void)){
//        let alert = UIAlertController(title: "", message: "Requisition done! Wait for admin approval", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completionHandler))
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func createUser(teamName:String){
        let userID = Auth.auth().currentUser?.uid
        
        if let userName = self.userName {
            self.userDatabaseManager.createUser(name: userName, userID: userID!, isAdmin: "false", teamName: teamName, status: "PA")
            
            self.userBadgeManager.initializeUserBadgeList(userID: userID!, teamName: teamName)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! TeamTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        cell.teamName.text = teams[indexPath.row].teamName
        cell.adminName.text = teams[indexPath.row].adminName
        cell.joinButton.tag = indexPath.row
        
        return cell
    }
    
}
