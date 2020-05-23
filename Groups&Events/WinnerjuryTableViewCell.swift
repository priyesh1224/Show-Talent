//
//  WinnerjuryTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 06/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class WinnerjuryTableViewCell: UITableViewCell {

    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
    func updatecell(x : feeds , y : Int , z : String)
    {
        self.position.text = "\(y + 1)"
        self.name.text = x.profilename.capitalized
        self.price.text = z
        
    }
    
}
