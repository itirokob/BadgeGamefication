//
//  Badge.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 09/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class Badge: NSObject, PersistenceObject {
    var name:String
    var numPoints:Int
    var descript:String
    var id:String
    var acquisitionDate:Date?
    var teamName:String
    var badgeIcon:String
    var dictInfo:[AnyHashable:Any]

    required init(dictionary: [AnyHashable: Any]){
        self.name = dictionary["name"] as! String
        self.numPoints = dictionary["numPoints"] as! Int
        self.descript = dictionary["description"] as! String
        self.teamName = dictionary["teamName"] as! String
        self.id = dictionary["id"] as! String
        self.badgeIcon = dictionary["badgeIcon"] as! String
        self.dictInfo = dictionary
        
        if let acquisitionDate = dictionary["acquisitionDate"]{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            guard let date = dateFormatter.date(from: acquisitionDate as! String) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            self.acquisitionDate = date
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
            "descript" : description,
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
            "descript" : description,
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

}
