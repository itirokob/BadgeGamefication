//
//  RequisitionsViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class RequisitionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let reqManager = BadgeRequisitionService.shared
    let registerManager = RegisterRequisitionService.shared
    let userBadgesManager = UserBadgeService.shared
    let userManager = UserService.getInstance()
    let userListsManager = UserListDatabaseManager.shared
    let authManager = AuthService.shared
    
    var requisitions:[BadgeRequisition] = []
    var registerRequisitions:[RegisterRequistion] = []
    var mode = ""
    var teamName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mode = checkSegmented()
//        self.changeSignOutButtonTitle()
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func signOut(_ sender: Any) {
        authManager.signOut()

    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        mode = checkSegmented()
        retrieveReqs()
        self.tableView.reloadData()
    }
    
    func checkSegmented() -> String{
        if segmentedControl.selectedSegmentIndex == 0{
            return "B" //Badges
        } else {
            return "R" //Registers
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveReqs()
    }
    
    func retrieveReqs(){
        if mode == "B"{
            reqManager.retrievePendentBadgeRequisitions(teamName: teamName!) { (reqs) in
                if let requisitions = reqs {
                    self.requisitions = requisitions
                    self.tableView.reloadData()
                }
            }
        } else {
            registerManager.retrievePendentRegisterRequisitions(teamName: teamName!, completionHandler: { (registers) in
                if let registers = registers {
                    self.registerRequisitions = registers
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mode == "B" ? self.requisitions.count : self.registerRequisitions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedheightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if mode == "B"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reqCell") as! BadgeReqTableViewCell
            let req = requisitions[indexPath.row]
            cell.badgeName.isHidden = false
            cell.explanation.isHidden = false
            cell.badgeOrEmployeeImage.isHidden = false
            
            cell.badgeName.text = req.badge.name
            cell.employeeEmail.text = req.userEmail
            
            cell.explanation.text = req.explanation
            
            cell.explanation.sizeToFit()
            
            cell.approveButton.tag = indexPath.row
            cell.denyButton.tag = indexPath.row
            cell.badgeOrEmployeeImage.image = self.selectBadgeIcon(badgeIcon: req.badge.badgeIcon)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.approveButton.layer.cornerRadius = 10
            cell.approveButton.clipsToBounds = true
            
            cell.denyButton.layer.cornerRadius = 10
            cell.denyButton.clipsToBounds = true
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "regCell") as! RegisterReqTableViewCell
            let req = registerRequisitions[indexPath.row]
            
            cell.employeeEmail.text = req.userEmail
            cell.approveButton.tag = indexPath.row
            cell.denyButton.tag = indexPath.row
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.approveButton.layer.cornerRadius = 10
            cell.approveButton.clipsToBounds = true
            
            cell.denyButton.layer.cornerRadius = 10
            cell.denyButton.clipsToBounds = true
            
            return cell
        }
    }
    
    func updateReqStatus(userID:String, id:String, status:String, indexPath:Int){
        if mode == "B"{
            reqManager.updateReqStatus(teamName: teamName!, reqID: id, status: status) { (success) in
                if success {
                    self.requisitions.remove(at: indexPath)
                    DispatchQueue.main.async{
                        self.tableView.deleteRows(at: [IndexPath(item: indexPath, section: 0)], with: .fade)
                        self.tableView.reloadData()
                    }
                    print("Requisicao atualizada!")
                }else{
                    print("Error on approving badge")
                }
            }
        } else {
            registerManager.updateReqStatus(teamName: teamName!, reqID: id, status: status, completionHandler: { (success) in
                if success {
                    self.registerRequisitions.remove(at: indexPath)
                    DispatchQueue.main.async {
                        self.tableView.deleteRows(at:  [IndexPath(item: indexPath, section: 0)], with: .fade)
                        self.tableView.reloadData()
                        self.userManager.updateStatus(userID: userID, status: "A")

                    }
                    
                    print("Requisicao atualizada!")
                } else {
                    print("Error on approving badge")
                }
            })
        }
    }
    
    func dateToString(format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
    
    @IBAction func approveBadge(_ sender: UIButton) {
        let req = requisitions[sender.tag]
        
        self.updateReqStatus(userID: req.userID, id: req.id, status: "A", indexPath: sender.tag)
        userBadgesManager.addBadgeToUser(teamName: teamName!, userID: req.userID, badge: req.badge, acquisitionDateString: dateToString(format: "dd-MM-yyyy"))

    }
    
    @IBAction func denyBadge(_ sender: UIButton) {
        let req = requisitions[sender.tag]
        self.updateReqStatus(userID: req.userID, id: req.id, status: "R", indexPath: sender.tag)
                //MyTODO: adicionar um feedback para o usuário. Talvez não um pop, mas só uma mensagem que apareça na parte inferior do app
    }
    
    @IBAction func approveRegister(_ sender: UIButton) {
        let req = registerRequisitions[sender.tag]
        self.updateReqStatus(userID: req.userID, id: req.id, status: "A", indexPath: sender.tag)
        self.userListsManager.createUserInList(teamName: self.teamName!, userID: req.userID)

    }
    
    @IBAction func denyRegister(_ sender: UIButton) {
        let req = registerRequisitions[sender.tag]
        self.updateReqStatus(userID: req.userID, id: req.id, status: "R", indexPath: sender.tag)
    }
    
    
}
