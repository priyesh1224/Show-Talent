//
//  PreviewcontestTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class PreviewcontestTableViewCell: UITableViewCell {

   
    @IBOutlet weak var content: UILabel!
    
    func update(x : arrayparamss)
    {
        self.content.text = "\(x.k.capitalized) : \(x.v.capitalized)"
    }
    
}
