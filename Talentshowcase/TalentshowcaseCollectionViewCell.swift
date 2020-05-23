//
//  TalentshowcaseCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 20/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TalentshowcaseCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var talentimagewidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var talentimage: UIImageView!
    
    @IBOutlet weak var profileimageoutercover: UIView!
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var profilename: UILabel!
    
    @IBOutlet weak var profileprofession: UILabel!
    
    
    

    func updatecell()
    {
//        self.talentimageheight.constant = self.frame.size.height / 2.5
        if self.frame.size.width * 0.25 < 130 {
            self.talentimagewidth.constant = 130
        }
        else {
        self.talentimagewidth.constant = self.frame.size.width * 0.25
        }
        
        self.profileimageoutercover.layer.cornerRadius = self.profileimageoutercover.frame.size.height / 2

//        self.profileimageoutercover.layer.borderColor = #colorLiteral(red: 0.3537997603, green: 0.3623381257, blue: 0.8117030263, alpha: 1)
//        self.profileimageoutercover.layer.borderWidth = 2
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
        self.talentimage.layer.cornerRadius = 10
    }
    
    
}
