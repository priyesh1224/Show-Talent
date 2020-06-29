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
        self.notificon.layer.cornerRadius = self.notificon.frame.size.height/2
        
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
            self.notiftiming.text = "\(x.likeby.capitalized) has liked your post in contest \(x.contestgroupname.capitalized)"
        }
        else if x.datatype.lowercased() == "winner" {
            self.notiftiming.text = "Please choose winners of the contest : \(x.contestgroupname.capitalized)"
        }
        
        
        var tl = x.createon
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        var td = tl.components(separatedBy: "T")[0]
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        let date = dateFormatter.date(from: td ?? "")
        print(td)
        print(date)
        
        let today = dateFormatter.date(from: "\(Date())" ?? "")
        
       
        
        let monthsname = ["","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        let calendar = Calendar.current
        let yx = calendar.component(.year, from: date!)
        let mx = monthsname[calendar.component(.month, from: date!)]
        let dx = calendar.component(.day, from: date!)
        let hx = calendar.component(.hour, from: date!)
        let minx = calendar.component(.minute, from: date!)
        
        let yxx = calendar.component(.year, from: Date())
        let mxx = monthsname[calendar.component(.month, from: Date())]
        let dxx = calendar.component(.day, from: Date())
        let hxx = calendar.component(.hour, from: Date())
        let minxx = calendar.component(.minute, from: date!)
       
        
        self.notifdate.text = "\(mx) \(dx)"
        
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
