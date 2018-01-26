//
//  RequisitionsDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RequisitionsDatabaseManager:NSObject {
    static let shared = RequisitionsDatabaseManager()
    
    var ref: DatabaseReference!

    private override init(){
        super.init()
        ref = Database.database().reference()
    }
        
    func createBadgeRequisition(teamName:String, userEmail:String, badgeName:String, explanation:String, userID:String, badgeNumPoints:Int, badgeDescription:String, badgeID:String, badgeIcon:String){
        
        let requisitionID = ref?.child("Teams/\(teamName)/BadgeRequisitions").childByAutoId().key
        let path = ref?.child("Teams/\(teamName)/BadgeRequisitions").child(requisitionID!)
        
        path?.setValue([
            "userEmail": userEmail,
            "explanation": explanation,
            "id":requisitionID,
            "userID": userID,
            "status": "PA",
            "teamName": teamName,
            "badgeName": badgeName,
            "badgeNumPoints":badgeNumPoints,
            "badgeDescription": badgeDescription,
            "badgeID": badgeID,
            "badgeIcon": badgeIcon
        ])
    }
    
    func retrievePendentBadgeRequisitions(teamName:String, completionHandler: @escaping ([BadgeRequisition]?)->()){
        var allReq:[BadgeRequisition] = []
        
        ref?.child("Teams/\(teamName)/BadgeRequisitions").observe(.childAdded, with: { (snapshot) in
            let req = snapshot.value as? NSDictionary
            
            if let actualReq = req {
                
                if actualReq.value(forKey: "status") as! String == "PA"{
                    let badge = Badge(
                        name: actualReq.value(forKey: "badgeName") as! String,
                        description: actualReq.value(forKey: "badgeDescription") as! String,
                        numPoints: actualReq.value(forKey: "badgeNumPoints") as! Int,
                        id: actualReq.value(forKey: "badgeID") as! String,
                        teamName:actualReq.value(forKey: "teamName") as! String,
                        badgeIcon: actualReq.value(forKey: "badgeIcon") as! String)
                    
                    let newReq = BadgeRequisition(
                        userEmail: actualReq.value(forKey: "userEmail") as! String,
                        explanation: actualReq.value(forKey: "explanation") as! String,
                        status: actualReq.value(forKey: "status") as! String,
                        id: actualReq.value(forKey: "id") as! String,
                        userID: actualReq.value(forKey: "userID") as! String,
                        badge: badge,
                        teamName: actualReq.value(forKey: "teamName") as! String)
                    allReq.append(newReq)
                }
                
                completionHandler(allReq)
            } else {
                print("Error on retrieving pendent requisitions")
                completionHandler(nil)
            }
        })
    }
    
    func updateReqStatus(teamName:String, reqID:String, status:String, completionHandler: @escaping (Bool) -> ()){
        let childUpdate = ["Teams/\(teamName)/BadgeRequisitions/\(reqID)/status" : status]
        self.ref.updateChildValues(childUpdate)
        completionHandler(true)
    }
    
}
