//
//  EventDataFeedComplexTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class EventDataFeedComplexTableViewCell: UITableViewCell {

   
    @IBOutlet weak var expired: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var eventname: UITextView!
    
    @IBOutlet weak var eventdataandtime: UITextView!
    
    @IBOutlet weak var eventlocation: UITextView!
    
    
    @IBOutlet weak var eventcreator: UITextView!
    
    
    func updatecell(x:strevent,y:String,z:juryorwinner) {
        eventname.isScrollEnabled = false
        eventdataandtime.isScrollEnabled = false
        eventlocation.isScrollEnabled = false
        eventcreator.isScrollEnabled = false
        self.logo.layer.cornerRadius = self.logo.frame.size.height/2
        self.selectionStyle = .none
        if(y == "complex"){
            self.expired.isHidden = true
        }
        else {
            self.expired.isHidden = false
        }
        eventname.text = x.contestname.capitalized
        var arr = x.conteststart.components(separatedBy: "T")
        var time = arr[1].components(separatedBy: ".")

        
        eventdataandtime.text = "\(arr[0]) \(time[0])"
        eventlocation.text = x.contestlocation.capitalized
        eventcreator.text = "Created by \(z.name.capitalized)"
        
        if x.contestimage == "" || x.contestimage == " " {
            self.logo.image = #imageLiteral(resourceName: "cover-photo")

        }
        self.downloadimage(url: x.contestimage) { (im) in
            if let i = im as? UIImage {
                self.logo.image = i
            }
            else {
                self.logo.image = #imageLiteral(resourceName: "cover-photo")
            }
        }
    }
    
    
    typealias imgcomp = (_ x : UIImage) -> Void
    func downloadimage(url : String,p : @escaping imgcomp)
    {
     var uurl = "http://thcoreapi.maraekat.com/Upload/Category/noicon.png"
        var receivedimage : UIImage?

     if let u = url as? String {
            if u == "http://thcoreapi.maraekat.com/" {
                let ih = #imageLiteral(resourceName: "cover-photo")
                p(ih)
            }
            else
            {
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

    
}
