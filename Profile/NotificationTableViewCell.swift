//
//  NotificationTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class NotificationTableViewCell: UITableViewCell {
    
    

    
    @IBOutlet weak var notificon: UIImageView!
    
    @IBOutlet weak var notifmatter: UILabel!
    
    
    @IBOutlet weak var notifdate: UITextView!
    
    
    @IBOutlet weak var notiftiming: UILabel!
    
    
    @IBOutlet weak var indicator: UIView!
    
    func updatecell(x : notifications) {
        self.notifmatter.text = x.title.capitalized
       
        self.notiftiming.text = x.body
        indicator.layer.cornerRadius = 10

            indicator.isHidden = false
        
        
        self.downloadimage(url: x.icon) { (im) in
            if let i = im as? UIImage {
                self.notificon.image = i
            }
        }
        
        
        if x.datatype.lowercased() == "groupmember" {
            self.notiftiming.text = "You are invited to join group \(x.contestgroupname.capitalized)"
        }
        else if x.datatype.lowercased() == "juryadd" {
            self.notiftiming.text = "You are invited to be a jury of contest \(x.contestgroupname.capitalized)"
        }
        else if x.datatype.lowercased() == "contestinvitation" {
             self.notiftiming.text = "You are invited to join contest \(x.contestgroupname.capitalized)"
        }
        else if x.datatype.lowercased() == "nearcontest" {
           self.notiftiming.text = "You have nearby contest \(x.contestgroupname.capitalized)"
        }
        else if x.datatype.lowercased() == "contestwinner" {
            self.notiftiming.text = "You have been selected as winner in contest \(x.contestgroupname.capitalized)"
        }
        else if x.datatype.lowercased() == "contestpostlike" {
            self.notiftiming.text = "Someone has liked your post in contest \(x.contestgroupname.capitalized)"
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
