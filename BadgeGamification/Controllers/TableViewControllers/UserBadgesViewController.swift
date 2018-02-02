//
//  UserBadgesViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import FirebaseAuth
import Photos

class UserBadgesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPoints: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    
    var badges:[Badge] = []
    var teamName:String?
    var totalPoints = 0
    
    let userBadgesManager = UserBadgeDAO.shared
    let userManager = UserDAO.getInstance()
    let userImageManager = UserImageDatabaseManager.shared
    let authManager = AuthDatabaseManager.shared
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUser()
        
        self.userImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))
        self.userImage.isUserInteractionEnabled = true
        self.userImage.contentMode = .scaleAspectFill
        self.userImage.layer.cornerRadius = 0.5 * self.userImage.frame.size.width
        self.userImage.clipsToBounds = true
        
//        self.changeSignOutButtonTitle()
        
    }
    
    @IBAction func signOut(_ sender: Any) {
        authManager.signOut()        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveUserBadges()
    }
    
    func retrieveUserBadges(){
        let userID = Auth.auth().currentUser?.uid
        
        userBadgesManager.retrieveAllBadgesFromUser(teamName: teamName!, userID: userID!) { (badges) in
            
            if let badges = badges{
                self.badges = badges
                self.tableView.reloadData()
            
                self.totalPoints = 0
            
                for badge in self.badges {
                    self.totalPoints += badge.numPoints
                }
            
                self.userPoints.text = String(self.totalPoints) + " points"
                
            }
        }
    }
    
    func retrieveUser(){
        let userID = Auth.auth().currentUser?.uid
        
        userManager.retrieveUser(userID: userID!) { (user) in
            if let user = user{
                self.userName.text = user.name
            
                if let cachedImage = self.imageCache.object(forKey: user.profileImageURL as AnyObject ) as? UIImage {
                    self.userImage.image = cachedImage
                    return
                }
            
                if user.profileImageURL != " " {
                    let url = URL(string: user.profileImageURL)
                    let request = URLRequest(url: url!)
                    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                        if error == nil{
                            DispatchQueue.main.async {
                                if let downloadedImage = UIImage(data: data!){
                                    self.imageCache.setObject(downloadedImage, forKey: user.profileImageURL as AnyObject )
                                    self.userImage.image = UIImage(data: data!)
                                }
                            }
                        }
                    }).resume()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.badges.count
    }
    
    func formatAcquisitionDate(date:Date) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return "Owned in \(day)/\(month)/\(year)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userBadgeCell") as! UserBadgesTableViewCell
        
        cell.badgeName.text = badges[indexPath.row].name
        cell.badgeIcon.image = selectBadgeIcon(badgeIcon: badges[indexPath.row].badgeIcon)
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        if let date = badges[indexPath.row].acquisitionDate {
            cell.acquisitionDate.text = formatAcquisitionDate(date: date)
        } else {
            cell.acquisitionDate.text = ""
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "availableBadgesSegue" {
            if let nextView = segue.destination as? AvailableBadgesViewController{
                nextView.teamName = self.teamName
            }
        }
    }
    
    @IBAction func unwindToUserBadges(sender: UIStoryboardSegue) {}
}

//Pick user image handlers
extension UserBadgesViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func handleSelectProfileImage(){
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    let picker = UIImagePickerController()
                    
                    picker.delegate = self
                    picker.allowsEditing = true
                    
                    self.present(picker, animated: true, completion: nil)
                } else {
                    self.alert(message: "No permission to access photo library"){_ in }
                }
            })
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        let userID = Auth.auth().currentUser?.uid
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.userImage.image = selectedImage
            self.userImageManager.uploadImage(profileImage: selectedImage, userID: userID!, completionHandler: { (URL) in
                if let imageURL = URL {
                    self.userImageManager.updateUserImage(userID: userID!, url: imageURL)
                }
            })
        }
        dismiss(animated: true, completion: nil)
        

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
