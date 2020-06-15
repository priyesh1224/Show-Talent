//
//  TalentContactTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 22/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class TalentContactTableViewCell: UITableViewCell {

    @IBOutlet weak var userimage: UIImageView!
    

    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var userprofession: UILabel!
    
    @IBOutlet weak var addbtn: UIButton!
    
    var passbackcontact : ((_ contact : customcontact , _ status : Bool) -> ())?
    
    var currentcontact : customcontact?
    
    func updatecell(x:customcontact) {
        self.currentcontact = x
        self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2
        self.addbtn.layer.cornerRadius = 10
        self.username.text = x.name.capitalized
        self.userprofession.text = x.profession.capitalized
        
        if x.alreadyshared {
            self.addbtn.isEnabled = false
            self.addbtn.setTitle("Shared", for: .normal)
            self.addbtn.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
            self.addbtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else {
            self.addbtn.isEnabled = true
            self.addbtn.setTitle("Add", for: .normal)
            self.addbtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.addbtn.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        }
        
        if let u = x.profileimage as? String
        {
            if u != "" && u != " " {
                self.downloadimage(url: u) { (imk) in
                    self.userimage.image = imk
                }
            }
        }
        
    }
    
    @IBAction func addbtntapped(_ sender: MinorButton) {
        
        if addbtn.titleLabel?.text == "Add" {
            addbtn.backgroundColor = UIColor.red
            self.passbackcontact!(self.currentcontact! , true)
        }
        else {
            addbtn.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
            self.passbackcontact!(self.currentcontact! , false)
        }
    }
    
    
    typealias imgcomp = (_ x : UIImage) -> Void
    func downloadimage(url : String,p : @escaping imgcomp)
    {
     var uurl = "http://thcoreapi.maraekat.com/Upload/Category/noicon.png"
        var receivedimage : UIImage?
     if let u = url as? String {
        Alamofire.request(u, method:.get).responseData { (rdata) in
         if let d = rdata.data as? Data {
             if let i = UIImage(data: d) as? UIImage {
                 p(i)

             }
         }
        }
     }

    }

    
}
