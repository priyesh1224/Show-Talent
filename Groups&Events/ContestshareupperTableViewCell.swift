//
//  ContestshareupperTableViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/20/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class ContestshareupperTableViewCell: UITableViewCell {

    @IBOutlet var eventimage: UIImageView!
    
    
    @IBOutlet var eventname: Customlabel!
    
    @IBOutlet var interestedpeople: UIButton!
    
    
    func update(x : String, y : String , ima : String)
    {
        self.selectionStyle = .none
        
        self.eventname.text = x.capitalized
        self.interestedpeople.setTitle("", for: .normal)
        
        if let i = ima as? String {
            if i != "" && i != " " {
                self.downloadimage(url: i) { (imm) in
                    if let fi = imm as? UIImage {
                        self.eventimage.image = fi
                    }
                }
            }
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
