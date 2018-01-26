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
    let badgeManager = BadgeDatabaseManager.shared
    let reqManager = RequisitionsDatabaseManager.shared
    let userManager = UserDatabaseManager.getInstance()
    
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }

    @IBAction func sendRequisition(_ sender: Any) {
        self.userEmail = (Auth.auth().currentUser?.email)!
        let userID = (Auth.auth().currentUser?.uid)!

        if let explanation = explanationTextInput.text, let currBadge = self.badge {
            reqManager.createBadgeRequisition(teamName: currBadge.teamName, userEmail: self.userEmail, badgeName: currBadge.name, explanation: explanation, userID: userID, badgeNumPoints: currBadge.numPoints, badgeDescription: currBadge.descript, badgeID: currBadge.id, badgeIcon: currBadge.badgeIcon)
            
            alert(message: "Badge requisition done! Wait for admin approval", completionHandler: { _ in
                self.performSegue(withIdentifier: "unwindToUserBadges", sender: self)
            })
        } else {
            print("No badge to request")
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
    
//    func alertRequisitionDone(completionHandler: @escaping (UIAlertAction) -> (Void)){
//        let alert = UIAlertController(title: "", message: "Badge requisition done! Wait for admin approval", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completionHandler))
//        self.present(alert, animated: true, completion: nil)
//    }
}
