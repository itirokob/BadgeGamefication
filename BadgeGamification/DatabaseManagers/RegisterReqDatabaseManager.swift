//
//  RegisterReqDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RegisterReqDatabaseManager:DAO {
    static let shared = RegisterReqDatabaseManager()
    
//    var ref: DatabaseReference!
    
    private override init(){
        super.init()
//        ref = Database.database().reference()
    }
    
    let objectName = "RegisterRequisitions"
    
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
        
        let path = "Teams/\(teamName)/RegisterRequisitions"
        
        self.retrieveAll(dump: RegisterRequistion.self, path: path) { (requisitions) in
            if let registerReq = requisitions {
                for req in registerReq {
                    if req.status == "PA"{
                        allReq.append(req)
                    }
                }
                completionHandler(allReq)
            } else {
                completionHandler(nil)
            }
        }
        
//        ref?.child("Teams/\(teamName)").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let team = snapshot.value as? [String: Any] {
//                if let registerReqs = team["RegisterRequisitions"] as? [String:Any]{
//                    for key in registerReqs.keys {
//                        let registerReqDict = registerReqs[key] as? [String:Any]
//
//                        if registerReqDict!["status"] as? String == "PA"{
//                            let newReq = RegisterRequistion(
//                                userEmail: registerReqDict!["userEmail"] as! String,
//                                id: registerReqDict!["id"] as! String,
//                                status: registerReqDict!["status"] as! String,
//                                teamName: registerReqDict!["teamName"] as! String,
//                                userID: registerReqDict!["userID"] as! String)
//
//                            allReq.append(newReq)
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
        let childUpdate = ["Teams/\(teamName)/RegisterRequisitions/\(reqID)/status" : status]
        self.ref.updateChildValues(childUpdate)
        completionHandler(true)
    }
}
