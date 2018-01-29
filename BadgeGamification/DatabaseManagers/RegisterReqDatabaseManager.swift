//
//  RegisterReqDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RegisterReqDatabaseManager:NSObject {
    static let shared = RegisterReqDatabaseManager()
    
    var ref: DatabaseReference!
    
    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func createRegisterRequisition(userEmail:String, teamName:String, userID:String){
        let registerID = ref?.child("Teams/\(teamName)/RegisterRequisitions").childByAutoId().key
        let path = ref?.child("Teams/\(teamName)/RegisterRequisitions").child(registerID!)
        
        path?.setValue([
            "userEmail": userEmail,
            "id": registerID,
            "teamName": teamName,
            "userID": userID,
            "status": "PA" //Pendent Approval
        ])
//        
//        path?.child("userEmail").setValue(userEmail)
//        path?.child("id").setValue(registerID)
//        path?.child("teamName").setValue(teamName)
//        path?.child("userID").setValue(userID)
//        path?.child("status").setValue("PA") //PA = Pendent Approval
    }

    func retrievePendentRegisterRequisitions(teamName:String, completionHandler: @escaping ([RegisterRequistion]?) -> ()){
        var allReq:[RegisterRequistion] = []
        
        ref?.child("Teams/\(teamName)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let team = snapshot.value as? [String: Any] {
                if let registerReqs = team["RegisterRequisitions"] as? [String:Any]{
                    for key in registerReqs.keys {
                        let registerReqDict = registerReqs[key] as? [String:Any]
                        
                        let newReq = RegisterRequistion(
                            userEmail: registerReqDict!["userEmail"] as! String,
                            id: registerReqDict!["id"] as! String,
                            status: registerReqDict!["status"] as! String,
                            teamName: registerReqDict!["teamName"] as! String,
                            userID: registerReqDict!["userID"] as! String)
                        
                        allReq.append(newReq)
                    }
                    
                    completionHandler(allReq)
                } else {
                    print("Error on retrieving pendent requisitions")
                    completionHandler(nil)
                }
            }
        })
    }
    
//    func retrievePendentRegisterRequisitions(teamName:String, completionHandler: @escaping ([RegisterRequistion]?) -> ()){
//        var allReq:[RegisterRequistion] = []
//
//        ref?.child("Teams/\(teamName)/RegisterRequisitions").observe(.childAdded, with: { (snapshot) in
//            let req = snapshot.value as? NSDictionary
//
//            if let actualReq = req {
//
//                if actualReq.value(forKey: "status") as! String == "PA"{
//                    let newReq = RegisterRequistion(userEmail: actualReq.value(forKey: "userEmail") as! String, id: actualReq.value(forKey: "id") as! String, status: actualReq.value(forKey: "status") as! String, teamName: actualReq.value(forKey: "teamName") as! String, userID: actualReq.value(forKey: "userID") as! String)
//                    allReq.append(newReq)
//                }
//
//                completionHandler(allReq)
//            } else {
//                print("Error on retrieving pendent requisitions")
//                completionHandler(nil)
//            }
//        })
//    }
//
    func updateReqStatus(teamName:String, reqID:String, status:String, completionHandler: @escaping (Bool) -> ()){
        let childUpdate = ["Teams/\(teamName)/RegisterRequisitions/\(reqID)/status" : status]
        self.ref.updateChildValues(childUpdate)
        completionHandler(true)
    }
}
