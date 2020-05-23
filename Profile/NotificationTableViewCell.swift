//
//  NotificationTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var notificon: UIImageView!
    
    @IBOutlet weak var notifmatter: UILabel!
    
    
    @IBOutlet weak var notiftiming: UILabel!
    
    
    @IBOutlet weak var indicator: UIView!
    
    func updatecell(x : notifications) {
        self.notifmatter.text = x.content.capitalized
       
        self.notiftiming.text = x.time
        indicator.layer.cornerRadius = 10
        if(x.status == "read") {
            indicator.isHidden = true
        }
        else {
            indicator.isHidden = false
        }
    }
    
    
}
