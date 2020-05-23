//
//  OfferTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/14/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

   
    @IBOutlet weak var offername: Customlabel!
    
    @IBOutlet weak var offercondition: UILabel!
    
    @IBOutlet weak var offerdes: UILabel!
    @IBOutlet weak var ofefrimage: UIImageView!
    
    func update(x : String, y : String,z : String)
    {
        self.offername.textColor = #colorLiteral(red: 0.5647058824, green: 0.03529411765, blue: 0.2666666667, alpha: 1)
        self.offercondition.textColor = #colorLiteral(red: 0.3450980392, green: 0.3490196078, blue: 0.3647058824, alpha: 1)
        self.offerdes.textColor = #colorLiteral(red: 0.3450980392, green: 0.3490196078, blue: 0.3647058824, alpha: 1)
        
        self.offername.text = x.capitalized
        self.offercondition.text = y.capitalized
        self.offerdes.text = z.capitalized
        
    }
    
}
