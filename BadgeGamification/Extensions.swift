//
//  Extensions.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 01/02/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alert(message: String, completionHandler: @escaping (UIAlertAction) -> (Void)){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completionHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeSignOutButtonTitle() {
        let item = self.navigationItem.leftBarButtonItem
        let button = item!.customView as! UIButton
        button.setTitle("Sign out", for:.normal)
    }
}
