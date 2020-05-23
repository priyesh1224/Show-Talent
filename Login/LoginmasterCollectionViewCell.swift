//
//  LoginmasterCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 03/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class LoginmasterCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    func updatecell(x:String,y:Int) {
        self.title.text = x
        if self.tag == y {
            self.title.font = UIFont.boldSystemFont(ofSize: 32)
             self.title.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        else {
            self.title.font = UIFont.systemFont(ofSize: 30)
            self.title.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
}
