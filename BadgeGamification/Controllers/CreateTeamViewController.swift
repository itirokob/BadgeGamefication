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
    
    let teamDatabaseManager = TeamDatabaseManager.shared
    let userDatabaseManager = UserDatabaseManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
//    func alertTeamNameExists(completionHandler: @escaping (UIAlertAction) -> (Void)){
//        let alert = UIAlertController(title: "", message: "This team name is already in use, please choose another one", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completionHandler))
//        self.present(alert, animated: true, completion: nil)
//    }
    
    @IBAction func createTeam(_ sender: Any) {
        if self.teamNameField.text == "" {
            alert(message: "Missing team's name", completionHandler: {_ in})
        } else if let teamName = self.teamNameField.text, let adminID = Auth.auth().currentUser?.uid,  let adminName = self.adminName{
            
            teamDatabaseManager.teamExists(teamName: teamName, completionHandler: { (teamExists) in
                if teamExists{
                    self.alert(message: "This team name is already in use, please choose another one"){_ in}
                } else {
                    self.teamDatabaseManager.createTeam(teamName: teamName, adminID: adminID, adminName: adminName)
                    //Atualizar o teamName, status e isAdmin
                    let updatedUser = User(name: adminName, isAdmin: "true", teamName: teamName, status: "A", profileImageURL: " ", id: adminID)
                    
                    self.userDatabaseManager.update(updatedUser: updatedUser, userID: adminID)

                    self.performSegue(withIdentifier: "adminLogin", sender: nil)
                }
            })
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let teamName = teamNameField.text {
            if segue.identifier == "adminLogin" {
                if let nextView = segue.destination as? UITabBarController{
                    //O viewControllers[0] é o ranking
                    let destination = nextView.viewControllers![1] as! RequisitionsViewController
                    destination.teamName = teamName
                    
                    let destination2 = nextView.viewControllers![2] as! ExistantBadgesViewController
                    destination2.teamName = teamName
                }
            }
        }
    }
    
    func createUser(){
        let adminID = Auth.auth().currentUser?.uid
        
        if let adminName = self.adminName, let teamName = self.teamNameField.text {
            userDatabaseManager.createUser(name: adminName, userID: adminID!, isAdmin: "true", teamName: teamName, status:"A")
        }
    }
}
