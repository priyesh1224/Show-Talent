//
//  HelpTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/14/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

   
    @IBOutlet weak var content: UITextView!
    
    func update(x : String){
        self.selectionStyle = .none
        self.content.text = x
    }
    
    
    @IBAction func sidebtnpressed(_ sender: Any) {
    }
    
    
}
