//
//  ButtonTableViewCell.swift
//  ShowTalent
//
//  Created by apple on 9/18/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import LGButton

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btn: LGButton!
 //   @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
