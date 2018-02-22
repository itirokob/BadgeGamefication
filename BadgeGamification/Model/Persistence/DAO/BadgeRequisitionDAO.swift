//
//  RequisitionsDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import FirebaseDatabase

class BadgeRequisitionDAO:DAO{
    static let shared = BadgeRequisitionDAO()
    
    private override init(){
        super.init()
    }
    
    let objectName = "BadgeRequisitions"
    
    func createBadgeRequisition(teamName:String, newBadgeReq:BadgeRequisition){
        
        let path = "Teams/\(teamName)/BadgeRequisitions"
        
        self.create(dump: BadgeRequisition.self, object: newBadgeReq, path: path, newObjectID: nil)

    }
    
//    func retrievePendentBadgeRequisitions(teamName:String, completionHandler: @escaping ([BadgeRequisition]?)->()){
//        var allReq:[BadgeRequisition] = []
//
//        let path = "Teams/\(teamName)/BadgeRequisitions"
//        
//        self.retrieveAll(dump: BadgeRequisition.self, path: path) { (badgeRequisitions) in
//            if let badgeReq = badgeRequisitions {
//                for req in badgeReq {
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
    
    func retrieveAllBadgeReqs(teamName:String, completionHandler: @escaping ([BadgeRequisition]?) -> ()){
//        var allReq:[BadgeRequisition] = []
        
        let path = "Teams/\(teamName)/BadgeRequisitions"
        
        self.retrieveAll(dump: BadgeRequisition.self, path: path) { (badgeRequisitions) in
            if let badgeReq = badgeRequisitions {
//                for req in badgeReq {
//                    allReq.append(req)
//                }
                completionHandler(badgeReq)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func updateReqStatus(teamName:String, reqID:String, status:String, completionHandler: @escaping (Bool) -> ()){
        let childUpdate = ["Teams/\(teamName)/BadgeRequisitions/\(reqID)/status" : status]
        self.ref.updateChildValues(childUpdate)
        completionHandler(true)
    }
    
}
