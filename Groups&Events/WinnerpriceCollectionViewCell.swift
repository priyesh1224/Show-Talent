//
//  WinnerpriceCollectionViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/19/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class WinnerpriceCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    
    
    
    func update(x: pricewinnerwise)
    {
        self.position.text = "Position : \(x.position)"
        self.amount.text = "Rs \(x.amount)"
    }
    
}
