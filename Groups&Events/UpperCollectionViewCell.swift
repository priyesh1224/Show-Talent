//
//  UpperCollectionViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class UpperCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tapp: UIButton!
    var passbackselection : ((_ lang : String) -> Void)?
    var currentdate = ""
    func update(x : customdate)
    {
        self.currentdate = x.actualdate
        tapp.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.tapp.setTitle("\(x.daypart) \(x.dayname)", for: .normal)
        tapp.titleLabel?.textAlignment = .center
        tapp.setTitleColor(#colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1), for: .normal)
        tapp.layer.borderWidth = 1
        tapp.layer.borderColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)
        tapp.layer.cornerRadius = 5
    }
    
    @IBAction func tappedbtn(_ sender: UIButton) {
        self.passbackselection!(self.currentdate)
//        if tapp.titleLabel?.textColor == UIColor.white {
//            tapp.setTitleColor(#colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1), for: .normal)
//            tapp.backgroundColor = UIColor.white
//        }
//        else {
//            tapp.setTitleColor(UIColor.white, for: .normal)
//            tapp.backgroundColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)
//        }
        
        
    }
}
