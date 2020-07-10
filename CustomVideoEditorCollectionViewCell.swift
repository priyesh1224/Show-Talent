//
//  CustomVideoEditorCollectionViewCell.swift
//  ShowTalent
//
//  Created by admin on 09/07/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CustomVideoEditorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var im: UIImageView!
    
    @IBOutlet weak var lb: UILabel!
    
    func update(x : String)
    {
        lb.text = x.capitalized
    }
    
}
