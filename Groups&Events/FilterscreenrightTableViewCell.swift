//
//  FilterscreenrightTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 04/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FilterscreenrightTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var chkbox: UIButton!
    
    func updatecell(x: String) {
        self.selectionStyle = .none
        self.content.text = x.capitalized
        self.chkbox.layer.borderColor = UIColor.black.cgColor
        self.chkbox.layer.borderWidth = 1
    }
    
}
