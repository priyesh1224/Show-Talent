//
//  UpdateUserCategoryTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class UpdateUserCategoryTableViewCell: UITableViewCell {

  
    @IBOutlet weak var cliekbtn: UIButton!
    
    @IBOutlet weak var btnouterview: UIView!
    
    @IBOutlet weak var categoryname: UILabel!
     var currentcategory : categorybrief?
    var passfordelete : ((_ x : categorybrief , _ y : Bool) -> Void)?
    
    
    func update(x : categorybrief)
    {
        self.currentcategory = x
        self.selectionStyle = .none
        btnouterview.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        btnouterview.layer.borderWidth = 1
        btnouterview.layer.cornerRadius = 2
        cliekbtn.setImage(#imageLiteral(resourceName: "check-solid"), for: .normal)
        self.categoryname.text = x.categoryname.capitalized
    }
    

    @IBAction func clickbtntapped(_ sender: Any) {
        if let ss = self.currentcategory as? categorybrief {
        if cliekbtn.image(for: .normal) == nil {
            cliekbtn.setImage(#imageLiteral(resourceName: "check-solid"), for: .normal)
            self.passfordelete!(ss , false)
        }
        else {
            cliekbtn.setImage(nil, for: .normal)
            self.passfordelete!(ss , true)
        }
        }
    }
}
