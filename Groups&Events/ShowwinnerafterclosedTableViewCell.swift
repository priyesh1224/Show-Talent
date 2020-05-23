//
//  ShowwinnerafterclosedTableViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/7/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ShowwinnerafterclosedTableViewCell: UITableViewCell {

  
    @IBOutlet var position: UILabel!
    
    @IBOutlet var name: UILabel!
    
    
    @IBOutlet var price: UILabel!
    
    func updatecell(x: juryorwinner , p : Int , price : String)
    {
        self.selectionStyle = .none
        self.position.text = "\(p)"
        self.name.text = x.name.capitalized
        self.price.text = price
    }
    
}
