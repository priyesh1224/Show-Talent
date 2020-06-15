//
//  WinnersmodifiedCollectionViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/26/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class WinnersmodifiedCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var winnername: UILabel!
    
    @IBOutlet weak var position: UILabel!
    
    
    @IBOutlet weak var award: UILabel!
    
    
    
    
    func update(x : juryorwinner , y : strevent?)
    {
        self.winnername.text = x.name.capitalized
        self.position.text = "Position : \(x.position)"
        if let yy = y as? strevent {
            if yy.contestprice.lowercased() == "cash" {
                self.award.text = "Cash Rs. \(x.price)"
            }
            else {
                self.award.text = "\(yy.contestprice.capitalized) \(x.price)"

            }
        }
        
    }
    
    
}
