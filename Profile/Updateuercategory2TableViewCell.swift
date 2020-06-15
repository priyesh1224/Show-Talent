//
//  Updateuercategory2TableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class Updateuercategory2TableViewCell: UITableViewCell {

   
    @IBOutlet weak var clickbtn: UIButton!
    
    @IBOutlet weak var btnouterview: UIView!
    
    @IBOutlet weak var categoryname: UILabel!
    var currentcategory : categorybrief?
    
    var passforadd : ((_ x : categorybrief , _ y : Bool) -> Void)?
    
    
    func update(x : categorybrief)
    {
        self.currentcategory = x
        self.selectionStyle = .none
        btnouterview.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        btnouterview.layer.borderWidth = 1
        btnouterview.layer.cornerRadius = 2
        self.categoryname.text = x.categoryname.capitalized
    }
    
    
    @IBAction func clickbtntapped(_ sender: Any) {
        if let ss = self.currentcategory as? categorybrief {
        if clickbtn.image(for: .normal) == nil {
            clickbtn.setImage(#imageLiteral(resourceName: "check-solid"), for: .normal)
            self.passforadd!(ss , true)
        }
        else {
            clickbtn.setImage(nil, for: .normal)
            self.passforadd!(ss , false)
        }
        }
    }
    
}
