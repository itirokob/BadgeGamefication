//
//  BadgeRequisitionService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 07/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class BadgeRequisitionService: NSObject {
    static let shared = BadgeRequisitionService()
    
    private override init(){
        super.init()
    }
    
    let badgeReqManager = BadgeRequisitionDAO.shared
    
    func createBadgeRequisition(teamName:String, newBadgeReq:BadgeRequisition){
        badgeReqManager.createBadgeRequisition(teamName: teamName, newBadgeReq: newBadgeReq)
    }
    
    func retrievePendentBadgeRequisitions(teamName:String, completionHandler: @escaping ([BadgeRequisition]?)->()){
//        badgeReqManager.retrievePendentBadgeRequisitions(teamName: teamName, completionHandler: completionHandler)
        var allReq:[BadgeRequisition] = []

        badgeReqManager.retrieveAllBadgeReqs(teamName: teamName) { (badges) in
            if let badges = badges{
                for badge in badges {
                    if badge.status == "PA" {
                        allReq.append(badge)
                    }
                }
                
                completionHandler(allReq)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func updateReqStatus(teamName:String, reqID:String, status:String, completionHandler: @escaping (Bool) -> ()){
        badgeReqManager.updateReqStatus(teamName: teamName, reqID: reqID, status: status, completionHandler: completionHandler)
    }
}
