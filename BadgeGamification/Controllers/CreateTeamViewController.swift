//
//  CreateTeamViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 12/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateTeamViewController: UIViewController {

    @IBOutlet weak var teamNameField: UITextField!
    
    var adminName:String?
//    var teamID:String?
    
    let teamService = TeamService.shared
    let userService = UserService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func createTeam(_ sender: Any) {
        if self.teamNameField.text == "" {
            alert(message: "Missing team's name", completionHandler: {_ in})
        } else if let teamName = self.teamNameField.text, let adminID = Auth.auth().currentUser?.uid,  let adminName = self.adminName{
            
            teamService.teamExists(teamName: teamName, completionHandler: { (teamExists) in
                if teamExists{
                    self.alert(message: "This team name is already in use, please choose another one"){_ in}
                } else {
                    self.teamService.createTeam(teamName: teamName, adminID: adminID, adminName: adminName)
                    //Atualizar o teamName, status e isAdmin
                    let updatedUser = User(name: adminName, isAdmin: "true", teamName: teamName, status: "A", profileImageURL: " ", id: adminID)
                    
                    self.userService.update(updatedUser: updatedUser, userID: adminID)

                    self.performSegue(withIdentifier: "unwindToLoginWithSegue", sender: self)
                }
            })
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let teamName = teamNameField.text {
            if segue.identifier == "unwindToLoginWithSegue" {
                if let nextView = segue.destination as? LoginViewController{
                    nextView.haveAccount = true
                    nextView.updateMode()
                }
            }
        }
    }
    
    func createUser(){
        let adminID = Auth.auth().currentUser?.uid
        
        if let adminName = self.adminName, let teamName = self.teamNameField.text {
            userService.createUser(name: adminName, userID: adminID!, isAdmin: "true", teamName: teamName, status:"A")
        }
    }
}
