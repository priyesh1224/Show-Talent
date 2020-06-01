//
//  EventBookingHistoryTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/28/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class EventBookingHistoryTableViewCell: UITableViewCell {

   
    @IBOutlet weak var outerview: UIView!
    
    @IBOutlet weak var eventimage: UIImageView!
    
    
    @IBOutlet weak var eventname: UITextView!
    
    
    @IBOutlet weak var eventlocation: UITextView!
    
    @IBOutlet weak var eventdate: UITextView!
    
    
    @IBOutlet weak var peopleinterested: UITextView!
    
    
    
    func update(x : bookedevent)
    {
        self.outerview.layer.cornerRadius = 10
        self.downloadimage(url: x.events.imagepath) { (im) in
            if let i = im as? UIImage {
                self.eventimage.image = i
            }
        }
        self.eventimage.layer.cornerRadius = 10
        self.eventname.text = x.events.heading.capitalized
        self.eventlocation.text = x.events.address1.capitalized
        self.eventdate.text = x.events.fromdate
        self.peopleinterested.text = ""
        
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
