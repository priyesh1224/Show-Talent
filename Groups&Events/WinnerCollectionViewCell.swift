//
//  WinnerCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 27/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class WinnerCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userimage: UIImageView!
    
    @IBOutlet weak var winnername: UILabel!
    
    @IBOutlet weak var rank: UILabel!
    
    func updatecell(x:members) {
        self.layer.cornerRadius = 10
        self.winnername.text = x.name.capitalized
        
    }
    
}
