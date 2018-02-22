//
//  RegisterReqDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RegisterRequisitionDAO:DAO {
    static let shared = RegisterRequisitionDAO()
    
    private override init(){
        super.init()
    }
    
    let objectName = "RegisterRequisitions"
    
    func createRegisterRequisition(teamName:String, newRegisterReq:RegisterRequistion){
        let path = "Teams/\(teamName)/RegisterRequisitions"

        self.create(dump: RegisterRequistion.self, object: newRegisterReq, path: path, newObjectID: nil)
    }

//    func retrievePendentRegisterRequisitions(teamName:String, completionHandler: @escaping ([RegisterRequistion]?) -> ()){
//        var allReq:[RegisterRequistion] = []
//
//        let path = "Teams/\(teamName)/RegisterRequisitions"
//
//        self.retrieveAll(dump: RegisterRequistion.self, path: path) { (requisitions) in
//            if let registerReq = requisitions {
//                for req in registerReq {
//                    if req.status == "PA"{
//                        allReq.append(req)
//                    }
//                }
//                completionHandler(allReq)
//            } else {
//                completionHandler(nil)
//            }
//        }
//    }
    
    func retrieveAllRegisterReqs(teamName:String, completionHandler: @escaping ([RegisterRequistion]?) -> ()){
//        var allReq:[RegisterRequistion] = []
        
        let path = "Teams/\(teamName)/RegisterRequisitions"
        
        self.retrieveAll(dump: RegisterRequistion.self, path: path) { (requisitions) in
            if let registerReq = requisitions {
//                for req in registerReq {
//                    allReq.append(req)
//                }
                completionHandler(registerReq)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func updateReqStatus(teamName:String, reqID:String, status:String, completionHandler: @escaping (Bool) -> ()){
        let childUpdate = ["Teams/\(teamName)/RegisterRequisitions/\(reqID)/status" : status]
        self.ref.updateChildValues(childUpdate)
        completionHandler(true)
    }
}
