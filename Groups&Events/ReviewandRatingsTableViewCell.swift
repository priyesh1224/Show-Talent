//
//  ReviewandRatingsTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/18/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class ReviewandRatingsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var userimage: UIImageView!
    
    
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var st1: UIButton!
    
    
    @IBOutlet weak var st2: UIButton!
    
    
    @IBOutlet weak var st3: UIButton!
    
    
    @IBOutlet weak var st4: UIButton!
    
    
    @IBOutlet weak var st5: UIButton!
    
    
    @IBOutlet weak var review: UITextView!
    
    
    @IBOutlet weak var allowedit: UIButton!
    @IBOutlet weak var editpostbtn: UIButton!
    
    var newrating = 0
    
    
    var posting : ((_ x: Bool) -> Void)?
     var popup : ((_ x: String) -> Void)?
    
    var currentreview : review?
    func update( x : review)
    {
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var m = ""
        if let g = x.userid as? String {
            m = g
        }
        if m == userid {
            self.allowedit.isHidden = false
        }
        else {
            self.allowedit.isHidden = true
        }
        self.currentreview = x
        self.newrating = x.rating
        self.username.text = x.name.capitalized
        self.review.text = x.review.capitalized
        self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2
        self.editpostbtn.isHidden = true
        self.editpostbtn.layer.cornerRadius = 10
        self.downloadimage(url: x.profileimage) { (im) in
            if let i = im as? UIImage{
                self.userimage.image = i
            }
        }
        
        if x.rating == 1 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(nil, for: .normal)
            st3.setImage(nil, for: .normal)
            st4.setImage(nil, for: .normal)
            st5.setImage(nil, for: .normal)
        }
        else if x.rating == 2 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(nil, for: .normal)
            st4.setImage(nil, for: .normal)
            st5.setImage(nil, for: .normal)
        }
        else if x.rating == 3 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(nil, for: .normal)
            st5.setImage(nil, for: .normal)
        }
        else if x.rating == 4{
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st5.setImage(nil, for: .normal)
        }
        else if x.rating == 5 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st5.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        }
        
    }
    
    
    
    @IBAction func st1tapped(_ sender: Any) {
        if self.editpostbtn.isHidden == false {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            newrating = 1
        }
    }
    
    
    @IBAction func st2tapped(_ sender: Any) {
        if self.editpostbtn.isHidden == false {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            newrating = 2
        }
    }
    
    
    @IBAction func st3tapped(_ sender: Any) {
        if self.editpostbtn.isHidden == false {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            newrating = 3
        }
    }
    
    
    @IBAction func st4tapped(_ sender: Any) {
        if self.editpostbtn.isHidden == false {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            newrating = 4
        }
    }
    
    
    @IBAction func st5tapped(_ sender: Any) {
        if self.editpostbtn.isHidden == false {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st5.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            newrating = 5
        }
    }
    
    
    @IBAction func edittapped(_ sender: Any) {
        self.editpostbtn.isHidden = false
        self.review.isEditable = true
        
        var xy = self.currentreview
        var x = 0
        if let m = xy?.rating as? Int {
            x = m
        }
        
        if x == 1 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
             st4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
             st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        }
        else if x == 2 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
             st3.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
             st4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
             st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        }
        else if x == 3 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
             st4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
             st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        }
        else if x == 4{
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
             st5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        }
        else if x == 5 {
            st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            st5.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        }
        
       
    }
    
    
    @IBAction func posteditedcomment(_ sender: Any) {

        var rw = ""
        var ra = 0
        if let r = currentreview?.review as? String {
            rw = r
        }
        if let r = currentreview?.rating as? Int {
            ra = r
        }
        if self.review.text != rw  || ra != newrating{
            self.posting!(true)
            self.review.isEditable = false
            self.editpostbtn.isHidden = true
            
            
            
            if newrating == 1 {
                st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st2.setImage(nil, for: .normal)
                st3.setImage(nil, for: .normal)
                st4.setImage(nil, for: .normal)
                st5.setImage(nil, for: .normal)
            }
            else if newrating == 2 {
                st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st3.setImage(nil, for: .normal)
                st4.setImage(nil, for: .normal)
                st5.setImage(nil, for: .normal)
            }
            else if newrating == 3 {
                st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st4.setImage(nil, for: .normal)
                st5.setImage(nil, for: .normal)
            }
            else if newrating == 4{
                st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st5.setImage(nil, for: .normal)
            }
            else if newrating == 5 {
                st1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
                st5.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
            }
            
            
            
            var tx = ""
            if let t = self.review.text as? String {
                tx = t
            }
            var iid = 0
            if let i = self.currentreview?.id as? Int {
                iid = i
            }
            var params : Dictionary<String,Any> = ["Id": iid,
                          "Review": tx,
                          "Rating": newrating]
            
            var url = Constants.K_baseUrl + Constants.editreview
            var r = BaseServiceClass()
            
            print(params)
            print(url)
            r.postApiRequest(url: url, parameters: params) { (response, err) in
                if let r = response?.result.value as? Dictionary<String,Any> {
                    if let code = r["ResponseStatus"] as? Int {
                        if code == 0 {
                            self.posting!(false)
                            self.popup!("Review Updated !")
                        }
                        else {
                            self.popup!("Could not update review. Try again !")

                        }
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
