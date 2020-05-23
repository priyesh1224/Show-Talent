//
//  LowerCollectionViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class LowerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tppp: UIButton!
    
    var passbackselection : ((_ lang : languages) -> Void)?
    var currenlanguage : languages?
    func update(x : languages)
       {
        self.currenlanguage = x
           self.tppp.setTitle("\(x.language.capitalized)", for: .normal)
        tppp.setTitleColor(#colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1), for: .normal)
        tppp.layer.borderWidth = 1
        tppp.layer.borderColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)
        tppp.layer.cornerRadius = 15

       }
    
    
    @IBAction func tppressed(_ sender: UIButton) {
        
        self.passbackselection!(self.currenlanguage!)
//        if tppp.titleLabel?.textColor == UIColor.white {
//            tppp.setTitleColor(#colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1), for: .normal)
//            tppp.backgroundColor = UIColor.white
//        }
//        else {
//            tppp.setTitleColor(UIColor.white, for: .normal)
//            tppp.backgroundColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)
//        }
    }
    
}
