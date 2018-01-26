//
//  CreateBadgeViewController.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 09/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class CreateBadgeViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var numPointsTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    let badgeManager = BadgeDatabaseManager.shared
    let badgeIcons = [#imageLiteral(resourceName: "icon1"), #imageLiteral(resourceName: "icon2"), #imageLiteral(resourceName: "icon3"), #imageLiteral(resourceName: "icon4"), #imageLiteral(resourceName: "icon5"), #imageLiteral(resourceName: "icon6")]
    
    var teamName:String?
    var selectedIcon:String = "icon1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func saveAction(_ sender: Any) {
        if let name = nameTextField.text, let description = descriptionTextField.text, let numPoints = numPointsTextField.text {
            badgeManager.createBadge(name: name, description: description, numPoints: Int(numPoints)!, teamName: self.teamName!, badgeIcon: selectedIcon)
            //badgeManager.createBadge(name: "nome", description: "descricao", numPoints: 20)
            
            performSegue(withIdentifier: "unwindToExistantBadges", sender: self)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExistantBadges", sender: self)
    }
    
}

extension CreateBadgeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! BadgeIconCollectionViewCell
        
        cell.badgeImage.image = self.badgeIcons[indexPath.row]
//        cell.badgeImage.alpha = CGFloat(self.badgeIcons[indexPath.row].alpha)
//        cell.badgeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectBadgeIcon)))
//        cell.badgeImage.isUserInteractionEnabled = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row{
        case 0:
            selectedIcon = "icon1"
            return
        case 1:
            selectedIcon = "icon2"
            return
        case 2:
            selectedIcon = "icon3"
            return
        case 3:
            selectedIcon = "icon4"
            return
        case 4:
            selectedIcon = "icon5"
            return
        default:
            selectedIcon = "icon6"
            return
        }
    }
    
    @objc func handleSelectBadgeIcon(){
        
    }
}
