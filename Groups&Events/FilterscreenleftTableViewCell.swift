//
//  FilterscreenleftTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 04/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FilterscreenleftTableViewCell: UITableViewCell {

  
    @IBOutlet weak var content: UILabel!
    
    func updatecell(x : String) {
        self.content.text = x.capitalized
    }
    
}
