//
//  ChooseEachCategoryTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 30/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ChooseEachCategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categorybtn: UIButton!
    
    var currentcategory : categorybrief?
    
    
    var gobackwithdata : ((_ data : categorybrief) -> Void)?
    
    func update(x:categorybrief) {
        self.currentcategory = x
        self.categorybtn.setTitle(x.categoryname.capitalized, for: .normal)
    }
    
    
    
    @IBAction func tappedcell(_ sender: UIButton) {
        gobackwithdata!(self.currentcategory!)
    }
    
    
    
    
}
