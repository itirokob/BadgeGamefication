//
//  BadgeRequisitionViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseAuth

class BadgeRequisitionViewController: UIViewController, UITextViewDelegate {
    
    var userEmail:String = ""
    
    
    let badgeManager = BadgeService.shared
    let reqManager = BadgeRequisitionService.shared
    let userManager = UserService.shared
    
    var badge:Badge?
    
    @IBOutlet weak var badgeDescription: UILabel!
    @IBOutlet weak var badgeName: UILabel!
    @IBOutlet weak var badgeIcon: UIImageView!
    @IBOutlet weak var explanationTextInput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currBadge = self.badge{
            self.badgeDescription.text = currBadge.descript
            
            self.badgeName.text = currBadge.name
            
            
        } else {
            print("No badge to load")
        }
        
        self.hideKeyboardWhenTappedAround()
        
        self.explanationTextInput.delegate = self
        
        self.badgeIcon.image = selectBadgeIcon(badgeIcon: (self.badge?.badgeIcon)!)
    }
    
    @IBAction func sendRequisition(_ sender: Any) {
        if explanationTextInput.text == ""{
            alert(message: "Missing explanation to get the badge!", completionHandler: {_ in})
        } else if let explanation = explanationTextInput.text{
            self.userEmail = (Auth.auth().currentUser?.email)!
            let userID = (Auth.auth().currentUser?.uid)!

            if let currBadge = self.badge {
                let newBadgeReq = BadgeRequisition(dictionary:[
                    "userEmail": userEmail,
                    "explanation": explanation,
                    "id":"",
                    "userID": userID,
                    "status": "PA",
                    "teamName": currBadge.teamName,
                    "badgeName": currBadge.name,
                    "badgeNumPoints":currBadge.numPoints,
                    "badgeDescription": currBadge.descript,
                    "badgeID": currBadge.id,
                    "badgeIcon": currBadge.badgeIcon
                ])

                if let newBadgeReq = newBadgeReq{
                    reqManager.createBadgeRequisition(teamName: currBadge.teamName, newBadgeReq:newBadgeReq)
                }
                
                alert(message: "Badge requisition done! Wait for admin approval", completionHandler: { _ in
                    self.performSegue(withIdentifier: "unwindToUserBadges", sender: self)
                })
            } else {
                print("No badge to request")
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = UIColor.black
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.text = "Dê uma breve justificativa :D"
            textView.textColor = UIColor.lightGray
        }
        return true
    }
    
}
