//
//  RegisterRequisitionService.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 07/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class RegisterRequisitionService: NSObject {
    static let shared = RegisterRequisitionService()
    
    private override init(){
        super.init()
    }
    
    let registerReqManager = RegisterRequisitionDAO.shared
    
    func createRegisterRequisition(teamName:String, newRegisterReq:RegisterRequistion){
        registerReqManager.createRegisterRequisition(teamName: teamName, newRegisterReq: newRegisterReq)
    }
    
    func retrievePendentRegisterRequisitions(teamName:String, completionHandler: @escaping ([RegisterRequistion]?) -> ()){
        registerReqManager.retrievePendentRegisterRequisitions(teamName: teamName, completionHandler: completionHandler)
    }
    
    func updateReqStatus(teamName:String, reqID:String, status:String, completionHandler: @escaping (Bool) -> ()){
        registerReqManager.updateReqStatus(teamName: teamName, reqID: reqID, status: status, completionHandler: completionHandler)
    }


}
