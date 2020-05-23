//
//  ContestsharebottonTableViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/20/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class ContestsharebottonTableViewCell: UITableViewCell {

   
    @IBOutlet var gimage: UIImageView!
    
    @IBOutlet weak var sharebtnouterview: UIView!
    
    @IBOutlet var gname: UITextView!
    
    
    @IBOutlet var gmembers: UITextView!
    
    
    @IBOutlet var sharebtn: UIButton!
    
    var sharebtnpressed : ((_ x : groupevent) -> Void)?
    var curr : groupevent?
    
    
    func update(x : groupevent)
    {
        self.selectionStyle = .none
        self.curr = x
        sharebtnouterview.layer.borderColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)
        sharebtnouterview.layer.borderWidth = 1
        self.gname.text = x.groupname.capitalized
        self.gmembers.text = "\(x.groupparticipation) Members"
        self.gimage.layer.cornerRadius = 25
        
        
        if let i = x.groupimage as? String {
            if i != "" && i != " " {
                self.downloadimage(url: i) { (imm) in
                    if let fi = imm as? UIImage {
                        self.gimage.image = fi
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func sharebtnpressed(_ sender: UIButton) {
        if let dd = self.curr as? groupevent {
            self.sharebtnpressed!(dd)
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
