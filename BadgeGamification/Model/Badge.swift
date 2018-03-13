//
//  Badge.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 09/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class Badge: NSObject, PersistenceObject {
    var name:String = ""
    var numPoints:Int = 0
    var descript:String = ""
    var id:String = ""
    var acquisitionDate:Date?
    var teamName:String = ""
    var badgeIcon:String = ""
    var dictInfo:[AnyHashable:Any] = [:]

    required init?(dictionary: [AnyHashable: Any]){
        super.init()
        if let name = dictionary["name"] as? String,
            let numPoints = dictionary["numPoints"] as? Int,
            let descript = dictionary["description"] as? String,
            let teamName = dictionary["teamName"] as? String,
            let id = dictionary["id"] as? String,
            let badgeIcon = dictionary["badgeIcon"] as? String,
            let acquisitionDate = dictionary["acquisitionDate"] as? String{
            
            self.name = name
            self.numPoints = numPoints
            self.descript = descript
            self.teamName = teamName
            self.id = id
            self.badgeIcon = badgeIcon
            self.dictInfo = dictionary
            
            if let acqDate = formatDate(date: acquisitionDate){
                self.acquisitionDate = acqDate
            } else {
                self.acquisitionDate = Date()
            }
        } else {
            print("Incomplete dictionary in Badge object init")
            return nil
        }
    }
    
    func formatDate(date:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let formattedDate = dateFormatter.date(from: date){
            return formattedDate
        } else {
            return nil
        }
        
    }
    
    init(name:String, description:String, numPoints:Int, id:String, teamName:String, badgeIcon:String){
        self.name = name
        self.numPoints = numPoints
        self.descript = description
        self.id = id
        self.teamName = teamName
        self.badgeIcon = badgeIcon
        self.dictInfo = [
            "name" : name,
            "numPoints" : numPoints,
            "description" : description,
            "id" : id,
            "teamName" : teamName,
            "badgeIcon" : badgeIcon
        ]
    }
    
    //Two kinds of init because When a badge is added to a user, it has a acquisitionDate
    init(name:String, description:String, numPoints:Int, id:String, teamName:String,badgeIcon:String, acquisitionDate:Date){
        self.name = name
        self.numPoints = numPoints
        self.descript = description
        self.id = id
        self.acquisitionDate = acquisitionDate
        self.teamName = teamName
        self.badgeIcon = badgeIcon
        self.dictInfo = [
            "name" : name,
            "numPoints" : numPoints,
            "description" : description,
            "id" : id,
            "teamName" : teamName,
            "badgeIcon" : badgeIcon,
            "acquisitionDate" : acquisitionDate
        ]
    }
    
    func stringToDate(dateString:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        return date
    }

    func getDictInfo() -> [AnyHashable:Any]{
        return self.dictInfo
    }
}
