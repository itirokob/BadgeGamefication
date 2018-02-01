//
//  BadgeIconCollectionViewCell.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 23/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class BadgeIconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var badgeImage: UIImageView!
    
    var opacity = 1
    
    override var isSelected: Bool {
        didSet {
            self.badgeImage.alpha = isSelected ? 0.4 : 1.0
        }
    }
}

