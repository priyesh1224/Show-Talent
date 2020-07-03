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
    
    @IBOutlet weak var eventdataandtime: UILabel!
    
    @IBOutlet weak var entryfees: UILabel!
    
    @IBOutlet weak var contestimage: UIImageView!
    
    @IBOutlet weak var interestedpeoplecount: UILabel!
    
    
    @IBOutlet weak var eventcreator: UITextView!
    
    @IBOutlet weak var closedcontestbtn: UIButton!
    
    func updatecell(x:strevent,y:String,z:juryorwinner) {
        eventname.isScrollEnabled = false
        closedcontestbtn.layer.cornerRadius = closedcontestbtn.frame.size.height/2
        eventcreator.isScrollEnabled = false
        self.logo.layer.cornerRadius = self.logo.frame.size.height/2
        self.selectionStyle = .none
        
        print(x)
        if(y == "complex"){
            self.expired.isHidden = true
        }
        else {
            self.expired.isHidden = false
        }
        eventname.text = x.contestname.capitalized
        var arr = x.conteststart.components(separatedBy: "T")
        var time = arr[1].components(separatedBy: ".")
         var timein = arr[0].components(separatedBy: "-")
        var arr2 = x.resulton.components(separatedBy: "T")
         var time2 = arr2[1].components(separatedBy: ".")
        var timein2 = arr2[0].components(separatedBy: "-")

        print(timein)
        print(timein2)
        eventdataandtime.text = "\(timein[1])-\(timein[2]) | \(timein2[1])-\(timein2[2])"
        if x.entryfee == 0 {
        entryfees.text = "Entry Free"
        }
        else {
            entryfees.text = "Entry Fees : Rs \(x.entryfee)"
        }
        if x.runningstatus.lowercased() == "closed" ||  x.runningstatus.lowercased() == "close" {
            self.closedcontestbtn.setTitle("Contest Closed", for: .normal)
        }
        else {
             self.closedcontestbtn.setTitle("Participate", for: .normal)
        }
        eventcreator.text = "Created by \(z.name.capitalized)"
        
        if x.contestimage == "" || x.contestimage == " " {
            self.logo.image = #imageLiteral(resourceName: "cover-photo")

        }
        self.downloadimage(url: z.profile) { (im) in
            if let i = im as? UIImage {
                self.logo.image = i
            }
            else {
                self.logo.image = #imageLiteral(resourceName: "cover-photo")
            }
        }
        self.downloadimage(url: x.contestimage) { (im) in
            if let i = im as? UIImage {
                self.contestimage.image = i
            }
            else {
                self.contestimage.image = #imageLiteral(resourceName: "cover-photo")
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
