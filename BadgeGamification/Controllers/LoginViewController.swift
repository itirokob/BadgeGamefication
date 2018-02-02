//
//  LoginViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 08/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInOrUp: UILabel!
    @IBOutlet weak var loginRegisterButton: UIButton!
    @IBOutlet weak var haveAccOrNot: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    
    let authManager = AuthDatabaseManager.shared
    
    var haveAccount:Bool = true
    
    var teamName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMode()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        haveAccount = true
        
    }
    
    func updateMode(){
        signInOrUp.text = self.haveAccount ? "Sign in" : "Sign up"
        loginRegisterButton.setTitle(self.haveAccount ? "Login" : "Register", for: .normal)
        haveAccOrNot.setTitle(self.haveAccount ? "I don't have a account" : "I have a account", for: .normal)
        
        nameField.isHidden = self.haveAccount ? true : false
    }
    
    //    func alertWaitForApproval(completionHandler: @escaping (UIAlertAction) -> (Void)){
    //        let alert = UIAlertController(title: "", message: "Your account is not approved yet. Wait for admin approval!", preferredStyle: .alert)
    //        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completionHandler))
    //        self.present(alert, animated: true, completion: nil)
    //    }
    
    fileprivate func treatUserStatus(_ user: (User)) {
        if user.status == "A" {
            self.performSegue(withIdentifier: "loginNotAdmin", sender: nil)
        } else if user.status == "PA"{
            alert(message: "Your account is not approved yet. Wait for admin approval!", completionHandler: { _ in })
        } else if user.status == "" {
            self.performSegue(withIdentifier: "register", sender: nil)
        }
    }
    
    fileprivate func logIn(_ id: String, _ userManager: UserDAO) {
        userManager.retrieveUser(userID: id, completionHandler: { (user) in
            if let user = user{
                self.teamName = user.teamName
                if user.isAdmin == "true" {
                    self.performSegue(withIdentifier: "loginAdmin", sender: nil)
                } else {
                    self.treatUserStatus(user)
                }
            }
        })
    }
    
    fileprivate func userHaveAccount(_ email: String, _ pass: String, _ userManager: UserDAO) {
        authManager.signIn(email: email, password: pass, completionHandler: { (success, idOrErrorMessage) in
            if success {
                self.logIn(idOrErrorMessage, userManager)
            } else {
                self.alert(message: idOrErrorMessage) {_ in}
            }
        })
    }
    
    fileprivate func registerUser(_ email: String, _ pass: String, _ userManager: UserDAO, _ name: String) {
        authManager.register(email: email, password: pass, completionHandler:  { (success, idOrErrorMessage) in
            if success {
                userManager.createUser(name: name, userID: idOrErrorMessage, isAdmin: "false", teamName: "", status: "")
                
                self.performSegue(withIdentifier: "register", sender: nil)
            } else {
                
                self.alert(message: idOrErrorMessage){_ in}
            }
        })
    }
    @IBAction func adminLogin(_ sender: Any) {
        let userManager = UserDAO.getInstance()
        
        authManager.signIn(email: "admin@admin.com", password: "123456", completionHandler: { (success, idOrErrorMessage) in
            if success {
                self.logIn(idOrErrorMessage, userManager)
            } else {
                self.alert(message: idOrErrorMessage) {_ in}
            }
        })
    }
    
    @IBAction func userLogin(_ sender: Any) {
        let userManager = UserDAO.getInstance()
        
        authManager.signIn(email: "user@user.com", password: "123456", completionHandler: { (success, idOrErrorMessage) in
            if success {
                self.logIn(idOrErrorMessage, userManager)
            } else {
                self.alert(message: idOrErrorMessage) {_ in}
            }
        })
        
    }
    @IBAction func loginAction(_ sender: Any) {
        let userManager = UserDAO.getInstance()
        
        if haveAccount {
            if let email = emailTextField.text, let pass = passwordTextField.text {
                userHaveAccount(email, pass, userManager)
            } else {
                alert(message: "Both email and password can't be empty"){_ in}
                print("Problemas no login")
            }
        } else {
            if let email = emailTextField.text, let pass = passwordTextField.text, let name = nameField.text {
                registerUser(email, pass, userManager, name)
            } else {
                alert(message: "Email, password and name can't be empty") {_ in}
                print("Problemas no registro")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let name = nameField.text {
            if segue.identifier == "register"{
                if let nextView = segue.destination as? UINavigationController{
                    let destination = nextView.viewControllers[0] as? EnterOrCreateTeamViewController
                    destination?.userName = name
                }
            } else if segue.identifier == "loginAdmin" {
                if let nextView = segue.destination as? UITabBarController{
                    //Ranking
                    let navRanking = nextView.viewControllers![0] as! UINavigationController
                    let ranking = navRanking.viewControllers[0] as! RankingViewController
                    
                    ranking.teamName = self.teamName
                    
                    //Requisições
                    let navRequisitions = nextView.viewControllers![1] as! UINavigationController
                    let requisitions = navRequisitions.viewControllers[0] as! RequisitionsViewController
                    
                    requisitions.teamName = self.teamName
                    
                    //Badges existentes
                    let navExistantBadges = nextView.viewControllers![2] as! UINavigationController
                    
                    let existantBadges = navExistantBadges.viewControllers[0] as! ExistantBadgesViewController
                    existantBadges.teamName = self.teamName
                }
            } else if segue.identifier == "loginNotAdmin" {
                if let nextView = segue.destination as? UINavigationController{
                    let destination = nextView.viewControllers[0] as! UserBadgesViewController
                    destination.teamName = self.teamName
                }
            }
        }
    }
    
    @IBAction func changeStateHaveAccOrNot(_ sender: Any) {
        haveAccount = !haveAccount
        updateMode()
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue){}
    
    @IBAction func signOut(segue:UIStoryboardSegue){
        authManager.signOut()
    }
}

