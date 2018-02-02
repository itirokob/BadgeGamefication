//
//  RequisitionsDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RequisitionsDatabaseManager:DAO{
    static let shared = RequisitionsDatabaseManager()
    
//    var ref: DatabaseReference!

    private override init(){
        super.init()
//        ref = Database.database().reference()
    }
    
    let objectName = "BadgeRequisitions"
    
    func createBadgeRequisition(teamName:String, newBadgeReq:BadgeRequisition){
        
        let path = "Teams/\(teamName)/BadgeRequisitions"
        
        self.create(dump: BadgeRequisition.self, object: newBadgeReq, path: path, newObjectID: nil)
//
//
//        let requisitionID = ref?.child("Teams/\(teamName)/BadgeRequisitions").childByAutoId().key
//        let path = ref?.child("Teams/\(teamName)/BadgeRequisitions").child(requisitionID!)
//
//        path?.setValue([
//            "userEmail": userEmail,
//            "explanation": explanation,
//            "id":requisitionID,
//            "userID": userID,
//            "status": "PA",
//            "teamName": teamName,
//            "badgeName": badgeName,
//            "badgeNumPoints":badgeNumPoints,
//            "badgeDescription": badgeDescription,
//            "badgeID": badgeID,
//            "badgeIcon": badgeIcon
//        ])
    }
    
    func retrievePendentBadgeRequisitions(teamName:String, completionHandler: @escaping ([BadgeRequisition]?)->()){
        var allReq:[BadgeRequisition] = []

        let path = "Teams/\(teamName)/BadgeRequisitions"
        
        self.retrieveAll(dump: BadgeRequisition.self, path: path) { (badgeRequisitions) in
            if let badgeReq = badgeRequisitions {
                for req in badgeReq {
                    if req.status == "PA"{
                        allReq.append(req)
                    }
                }
                completionHandler(allReq)
            } else {
                completionHandler(nil)
            }
        }
        
//        var allReq:[BadgeRequisition] = []
//
//        ref?.child("Teams/\(teamName)").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let team = snapshot.value as? [String: Any] {
//                if let badgeReqs = team["BadgeRequisitions"] as? [String:Any]{
//                    for key in badgeReqs.keys {
//                        let badgeReqDict = badgeReqs[key] as? [String:Any]
//
//                        if badgeReqDict!["status"] as! String == "PA"{
//                            let badge = Badge(
//                                name: badgeReqDict!["badgeName"] as! String,
//                                description: badgeReqDict!["badgeDescription"] as! String,
//                                numPoints: badgeReqDict!["badgeNumPoints"] as! Int,
//                                id: badgeReqDict!["badgeID"] as! String,
//                                teamName: badgeReqDict!["teamName"] as! String,
//                                badgeIcon: badgeReqDict!["badgeIcon"] as! String)
//
//                            let badgeReq = BadgeRequisition(
//                                userEmail: badgeReqDict!["userEmail"] as! String,
//                                explanation: badgeReqDict!["explanation"] as! String,
//                                status: badgeReqDict!["status"] as! String,
//                                id: badgeReqDict!["id"] as! String,
//                                userID: badgeReqDict!["userID"] as! String,
//                                badge: badge,
//                                teamName: badgeReqDict!["teamName"] as! String)
//
//                            allReq.append(badgeReq)
//                        }
//                    }
//
//                    completionHandler(allReq)
//                } else {
//                    print("Error on retrieving pendent requisitions")
//                    completionHandler(nil)
//                }
//            }
//        })
    }
    
    func updateReqStatus(teamName:String, reqID:String, status:String, completionHandler: @escaping (Bool) -> ()){
        let childUpdate = ["Teams/\(teamName)/BadgeRequisitions/\(reqID)/status" : status]
        self.ref.updateChildValues(childUpdate)
        completionHandler(true)
    }
    
}
