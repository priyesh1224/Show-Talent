//
//  AllcommentsTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 24/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class AllcommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var repliedcellimagewidth: NSLayoutConstraint!
    var deletecomment : ((_ x : Int , _ y : Int) -> Void)?
    
    @IBOutlet weak var repliedcellimageheight: NSLayoutConstraint!
    @IBOutlet weak var replybtn: UIButton!
    
    @IBOutlet weak var repliedstackleadingspace: NSLayoutConstraint!
    @IBOutlet weak var repliedstackleadingspace2: NSLayoutConstraint!
    @IBOutlet weak var repliedstackleadingspace3: NSLayoutConstraint!
    
    @IBOutlet weak var imageuser: UIImageView!
    
    
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var comment: UILabel!
    
    
    @IBOutlet weak var likes: UILabel!
    
    @IBOutlet weak var hidestack: UIStackView!
    
    @IBOutlet weak var nestedcomments: UILabel!
    
    
    @IBOutlet weak var editcommentpressed: UIButton!
    
    @IBOutlet weak var deletecommentpressed: UIButton!
    
    @IBOutlet weak var hider: UIStackView!
    
    var currentcommentinfo : comment!
    var commentdeleted: ((_ commentgotdeleted: comment?) -> ())?
    var commentEdited: ((_ commentgotdeleted: comment?) -> ())?
    var notifytoenableediting: ((_ showtools: Bool?,_ currentcomment: comment?,_ mode:String) -> ())?


    func updatecell(x: comment) {
        self.selectionStyle = .none
        self.imageuser.layer.cornerRadius = 30
        
        self.replybtn.contentHorizontalAlignment = .left
        self.currentcommentinfo = x
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        if userid != x.userid {
            self.deletecommentpressed.isHidden = true
            self.editcommentpressed.isHidden = true
        }
        else {
            self.deletecommentpressed.isHidden = false
            self.editcommentpressed.isHidden = true
        }
        username.text = x.profilename.capitalized
        comment.text = x.usercomment.capitalized

        if x.profileimage != "" && x.profileimage != " " {
            downloadprofileimage(url: x.profileimage) { (uim) in
                self.imageuser.image = uim
            }
        }
        if x.status == "replied" || x.status == "reply" {
            username.font = UIFont.boldSystemFont(ofSize: 14)
            comment.font = UIFont.systemFont(ofSize: 12)
            repliedstackleadingspace.constant = 48
            repliedstackleadingspace2.constant = 488
            repliedstackleadingspace3.constant = 48
            repliedcellimagewidth.constant = 40
            repliedcellimageheight.constant = 40
            self.imageuser.layer.cornerRadius = 20
            self.replybtn.isHidden = true

        }
        else {
            username.font = UIFont.boldSystemFont(ofSize: 16)
            comment.font = UIFont.systemFont(ofSize: 14)
            repliedstackleadingspace.constant = 8
            repliedstackleadingspace2.constant = 8
            repliedstackleadingspace3.constant = 8
            repliedcellimagewidth.constant = 60
            repliedcellimageheight.constant = 60
            self.imageuser.layer.cornerRadius = 30

            self.replybtn.isHidden = false
        }
        
    }
    
    
    @IBAction func replybtnpressed(_ sender: UIButton) {
        self.notifytoenableediting!(true,self.currentcommentinfo,"reply")
        
    }
    
    
    
    
    func updatecell2(x: like) {
        self.deletecommentpressed.isHidden = true
        self.replybtn.isHidden = true
        username.text = x.profilename.capitalized
        comment.isHidden = true
        print("Image")
        print(x.profileimage)
        if x.profileimage != "http://thcoreapi.maraekat.com/" {
            downloadprofileimage(url: x.profileimage) { (uim) in
                self.imageuser.image = uim
            }
        }
        
    }
    
    @IBAction func editcomment(_ sender: UIButton) {
        
        self.notifytoenableediting!(true,self.currentcommentinfo,"edit")
                          
    }
    
    
    
    
    
    @IBAction func deletecoment(_ sender: UIButton) {
        if let id = self.currentcommentinfo.comentid as? Int , let b = self.currentcommentinfo.activityid as? Int {
            self.deletecomment!(id ,b)
        }
    }
    
    

    
    
    
    func downloadprofileimage(url:String,completion : @escaping (UIImage?) -> Void) {
           if let cachedimage = Talentshowcase2ViewController.cachepostprofileimage.object(forKey: url as NSString) {
               completion(cachedimage)
           }
           else {
            if url == "" || url == " " {
                return
            }
               Alamofire.request(url, method: .get)
               .validate()
               .responseData(completionHandler: { (responseData) in
                
                   if let rd = responseData.data as? Data {
               Talentshowcase2ViewController.cachepostprofileimage.setObject(UIImage(data: responseData.data!)!, forKey: url as NSString)
                   completion(UIImage(data: responseData.data!))
                   }
               })
           }
       }
    
    
}
