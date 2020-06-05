//
//  CoinsTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/11/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CoinsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var uppericon: UIImageView!
    
    @IBOutlet weak var upperlabel: UILabel!
    
    
    @IBOutlet weak var bottomicon: UIImageView!
    
    @IBOutlet weak var bottomimage: UILabel!
    
    
    @IBOutlet weak var outerview: UIView!
    @IBOutlet weak var loginbtn: UIButton!
    
    
    func updatecell(x : coinearning)
    {

        self.outerview.layer.cornerRadius = 10
        self.loginbtn.layer.cornerRadius = 10
        self.upperlabel.text = x.eventdescription.capitalized
        self.bottomimage.text = "\(x.coin) Coins"
        self.loginbtn.setTitle("Completed", for: .normal)
        self.selectionStyle = .none
        
    }
    
    @IBAction func loginbtntapped(_ sender: Any) {
    }
    
}
