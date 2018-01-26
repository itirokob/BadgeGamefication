//
//  AvailableBadgesTableViewCell.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 11/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class AvailableBadgesTableViewCell: UITableViewCell {
    @IBOutlet weak var badgeName: UILabel!
    
    @IBOutlet weak var badgeIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
