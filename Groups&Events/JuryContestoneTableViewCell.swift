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
    
    
    
    
    
   
    
    var passbacktapped : ((_ pass : String) -> ())?
    
    
    func updatecell(x : strevent)
    {
        self.contestname.text = x.contestname.capitalized
        self.selectionStyle = .none
        self.downloadimage(url: x.contestimage) { (im) in
            self.contestimage.image = im
        }

    }
    
    
    
    
    @IBAction func contestdetailspressed(_ sender: UIButton) {
        self.contestdetailsbtn.setTitleColor(#colorLiteral(red: 0.3537997603, green: 0.3623381257, blue: 0.8117030263, alpha: 1), for: .normal)
        self.participantsvideosbtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        self.passbacktapped!("contestdetails")
    }
    
    
    @IBAction func participantsvideospressed(_ sender: UIButton) {
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
