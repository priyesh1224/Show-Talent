//
//  JuryContestoneTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 05/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class JuryContestoneTableViewCell: UITableViewCell {

    @IBOutlet weak var contestimage: UIImageView!
    
    @IBOutlet weak var contestname: UILabel!
    

    @IBOutlet weak var participantsvideosbtn: UIButton!
    @IBOutlet weak var contestdetailsbtn: UIButton!
    
    
    @IBOutlet weak var highlighterview: UIView!
    
    var presentfilterlist : ((_ x : Bool) -> Void)?
    
    
    @IBOutlet weak var filterselectedbtn: UIButton!
    
   
    @IBOutlet weak var conditionalview: UIView!
    
    var passbacktapped : ((_ pass : String) -> ())?
    
    
    func updatecell(x : strevent , b : String)
    {
        if b == "none" {
            filterselectedbtn.setTitle("None", for: .normal)
        }
        else if b == "likes" {
            filterselectedbtn.setTitle("By Likes", for: .normal)
        }
        else {
            filterselectedbtn.setTitle("By Comments", for: .normal)
        }
        filterselectedbtn.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        filterselectedbtn.layer.borderWidth = 1
        self.contestname.text = x.contestname.capitalized
        self.selectionStyle = .none
        self.downloadimage(url: x.contestimage) { (im) in
            self.contestimage.image = im
        }

    }
    
    
    @IBAction func filterselectedpressed(_ sender: Any) {
        self.presentfilterlist!(true)
    }
    
    
    @IBAction func contestdetailspressed(_ sender: UIButton) {
      
        conditionalview.isHidden = true
        self.contestdetailsbtn.setTitleColor(#colorLiteral(red: 0.3537997603, green: 0.3623381257, blue: 0.8117030263, alpha: 1), for: .normal)
        self.participantsvideosbtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        self.passbacktapped!("contestdetails")
    }
    
    
    @IBAction func participantsvideospressed(_ sender: UIButton) {
        conditionalview.isHidden = false
        self.participantsvideosbtn.setTitleColor(#colorLiteral(red: 0.3537997603, green: 0.3623381257, blue: 0.8117030263, alpha: 1), for: .normal)
        self.contestdetailsbtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        self.passbacktapped!("participantsvideos")
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
