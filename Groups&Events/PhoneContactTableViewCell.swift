//
//  PhoneContactTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 22/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Contacts

class PhoneContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uimage: UIImageView!
    
    
    var returnValue: ((_ value: customcontact)->())?
    
    
    @IBOutlet weak var uname: UILabel!
    
    
    @IBOutlet weak var unumber: UILabel!
    
    
    @IBOutlet weak var addbtn: UIButton!
    
    var currentcontact : customcontact?
    
    func updatecell(x:customcontact) {
        
        self.currentcontact = x
        
        self.uimage.layer.cornerRadius = self.uimage.frame.size.height/2
        self.addbtn.layer.cornerRadius = 10
        self.addbtn.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.addbtn.layer.borderWidth = 2
        self.uname.text = x.name.capitalized
        var numtext = ""
        if let num = x.number as? [String]{
            for en in num {
                if num.count > 1 {
                numtext = numtext+"\(en) / "
                }
                else {
                    numtext = en
                }
               
            }
             self.unumber.text = "\(numtext)"
        }
        
    }
    
    
    @IBAction func addbtnclicked(_ sender: Any) {
        print("Tapped \(self.currentcontact?.name)")
        returnValue!((self.currentcontact ?? nil)!)
    }
    
    

}
