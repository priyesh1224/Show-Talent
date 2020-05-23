//
//  SeeAllgeneralTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 02/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class SeeAllgeneralTableViewCell: UITableViewCell {
    
    
    @IBOutlet var svhider: UIStackView!
    @IBOutlet var postedinn: Minorlabel!
    
    
    @IBOutlet var memberscount: UILabel!
    
    
    @IBOutlet weak var nameleading: NSLayoutConstraint!
    

    @IBOutlet weak var outerview: UIView!
    
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var profilename: UILabel!
    
    @IBOutlet weak var itemimage: UIImageView!
    
    var dummytrendingimages = ["contest-ad","contest2","contest3","event-ad","event-ad2","event-ad3"]
    var dummyeventimages = ["ev5","ev6"]


    
    func updatecell(x : strcategory , a : UIColor , b : UIColor)
    {
        self.svhider.isHidden = true
        self.postedinn.text = ""
        
        nameleading.constant = -68
        self.outerview.layer.cornerRadius = 10
        var m = self.applygradient(a: a, b: b)
        outerview.layer.addSublayer(m)
        self.itemimage.contentMode = .scaleAspectFit
        self.selectionStyle = .none
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
        self.itemimage.layer.cornerRadius = 0
        self.profileimage.isHidden = true
        self.profilename.text = x.categoryName.capitalized
        self.downloadimage(url: x.categoryicon) { (im) in
            let iv = UIImageView(frame: CGRect(x: self.frame.size.width * 0.28, y: 30, width: self.frame.size.width * 0.33, height: 100))
            iv.image = im
            iv.contentMode = .scaleAspectFit
            self.outerview.addSubview(iv)
            let lb = UILabel(frame: CGRect(x: 0, y: 130, width: self.outerview.frame.size.width, height: 50))
            lb.textAlignment = .center
            lb.text = x.categoryName.capitalized
            lb.textColor = UIColor.white
            self.outerview.addSubview(lb)
        }
    }
    func applygradient(a:UIColor , b:UIColor) -> CAGradientLayer
       {
           let gl = CAGradientLayer()
           gl.frame = self.bounds
           gl.colors = [a.cgColor,b.cgColor]
           return gl
       }
    
    func updatecell2( x : strtrending , number : Int) {
        self.svhider.isHidden = true
        self.postedinn.text = ""
        
        nameleading.constant = 16
        self.itemimage.contentMode = .scaleAspectFit

        self.selectionStyle = .none

        self.profileimage.isHidden = false
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
        self.itemimage.layer.cornerRadius = 10

        self.profilename.text = x.profilename.capitalized
        self.downloadimage(url: x.profileimage) { (im) in
            self.profileimage.image = im
        }
        
        if number < self.dummytrendingimages.count {
            self.itemimage.image = UIImage(named: self.dummytrendingimages[number])
        }
        else {
            self.downloadimage(url: x.thumbnail) { (im) in
                self.itemimage.image = im
            }
        }
        

        
        if x.activitypath == "" || x.activitypath == " " {
            self.itemimage.image = #imageLiteral(resourceName: "cover-photo")
        }
    }
    
    func updatecell3(x : strevent , number : Int )
    {
        self.svhider.isHidden = true
        self.postedinn.text = ""
        nameleading.constant = -68
        self.itemimage.contentMode = .scaleAspectFill

        self.selectionStyle = .none

        self.profileimage.isHidden = true
        self.itemimage.layer.cornerRadius = 10

        self.profilename.text = x.contestname.capitalized
        
        self.itemimage.image = #imageLiteral(resourceName: "cover-photo")
        if number < self.dummyeventimages.count {
            itemimage.contentMode = .scaleAspectFit
            self.itemimage.image =  UIImage(named: self.dummyeventimages[number])
        }
        else {
            self.downloadimage(url: x.contestimage) { (im) in
                self.itemimage.image = im
            }
        }
        
       
    }
    
    func updatecell4(x: groupevent)
    {
        self.svhider.isHidden = false
        self.postedinn.text = "Group belong to \(x.group_belong.capitalized)"
        self.memberscount.text = "\(x.groupparticipation) Members"
        nameleading.constant = -68
        self.itemimage.contentMode = .scaleAspectFill

        self.selectionStyle = .none

        self.profileimage.isHidden = true
        self.itemimage.layer.cornerRadius = 10

        self.profilename.text = x.groupname.capitalized
        self.downloadimage(url: x.groupimage) { (im) in
            self.itemimage.image = im
        }
        
        if x.groupimage == "" || x.groupimage == " " {
                   self.itemimage.image = #imageLiteral(resourceName: "cover-photo")
               }
    }
    
    func updatecell5(x : streventcover)
    {
        self.svhider.isHidden = true
        self.postedinn.text = ""
        nameleading.constant = -68
        self.itemimage.contentMode = .scaleAspectFill

        self.selectionStyle = .none

        self.profileimage.isHidden = true
        self.itemimage.layer.cornerRadius = 10

        self.profilename.text = x.a.contestname.capitalized
        self.downloadimage(url: x.a.contestimage) { (im) in
             self.itemimage.image = im
         }
        
        self.itemimage.image = #imageLiteral(resourceName: "cover-photo")
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
