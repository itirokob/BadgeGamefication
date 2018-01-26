//
//  BadgeReqTableViewCell.swift
//  BadgeGamification
//
//  Created by Bianca Itiroko on 10/01/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class BadgeReqTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeEmail: UILabel!
    @IBOutlet weak var badgeName: UILabel!
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var badgeOrEmployeeImage: UIImageView!
    @IBOutlet weak var denyButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
