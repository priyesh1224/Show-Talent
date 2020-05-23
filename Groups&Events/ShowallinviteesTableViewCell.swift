//
//  ShowallinviteesTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 14/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class ShowallinviteesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var removebtn: UIButton!
    @IBOutlet weak var memberimage: UIImageView!
    
    @IBOutlet weak var membername: UILabel!
    
    var removeuser : ((_ x : fetchedmember) -> Void)?
    
    var currentuser : fetchedmember?
    func update(x : fetchedmember , y : Bool) {
        self.currentuser = x
        self.membername.text = x.name.capitalized
        self.memberimage.layer.cornerRadius = 25
        
        if y {
            self.removebtn.isHidden = false
        }
        else {
            self.removebtn.isHidden = true
        }
        
        if x.profileimage != "" && x.profileimage != " " {
            self.downloadimage(url: x.profileimage) { (imm) in
                 self.memberimage.image = imm
             }
        }
        
 
        
    }
    
    
    @IBAction func removemembertapped(_ sender: UIButton) {
        self.removeuser!(self.currentuser ?? fetchedmember(id: 0, name: "", profileimage: "", userid: "", countrycode: "", mobile: ""))
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
