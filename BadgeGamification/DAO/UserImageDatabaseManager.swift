//
//  UserImageDatabaseManager.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 22/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import Firebase

class UserImageDatabaseManager: NSObject {
    static let shared = UserImageDatabaseManager()
    
    var ref: DatabaseReference!
    
    private override init(){
        super.init()
        ref = Database.database().reference()
    }
    
    func uploadImage(profileImage:UIImage, userID:String, completionHandler:@escaping (String?) -> ()){
        let storageRef = Storage.storage().reference().child(userID)
        var URL:String?
        
        if let uploadData = UIImagePNGRepresentation(profileImage) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error == nil {
                    URL = metadata?.downloadURL()?.absoluteString
                    completionHandler(URL)
                } else {
                    print(error.debugDescription)
                }
            })
        }
    }
    
    func updateUserImage(userID:String, url:String){
        let childUpdates = [
            "Users/\(userID)/profileImageURL": url
        ]
        ref.updateChildValues(childUpdates)
    }
    
    
}
