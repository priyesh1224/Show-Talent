//
//  Editprofile1TableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class Editprofile1TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var leftimage: UIImageView!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var rightimage: UIImageView!
    
    
    @IBOutlet weak var leftimage2: UIStackView!
    
    @IBOutlet weak var li2: UIImageView!
    
    @IBOutlet weak var rightimage2: UIImageView!
    
    @IBOutlet weak var content2: UILabel!
    
    func updatecell(x:String,y:Int,z : String)
    {
        print("Received \(x)")
        if(y == 1) {
            self.content.text = "\(x.capitalized)"
        }
        else{
            self.content2.text = "\(x.capitalized)"
        }
        if z != "" {
            if let im = UIImage(named: z){
                if y == 1 {
                leftimage.image = im
                }
                else {
                    li2.image = im
                }
            }
            
        }
        
    }

}
