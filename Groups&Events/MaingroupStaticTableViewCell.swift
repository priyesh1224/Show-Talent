//
//  MaingroupStaticTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 22/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class MaingroupStaticTableViewCell: UITableViewCell    {
    
    
    var sendbacktype : ((_ type : String) -> ())?
    
    var postmessage : ((_ content : String) -> ())?
    
    var showallmembers : ((_ show : Bool) -> ())?
    
    var invitemembers : ((_ show : Bool) -> ())?
    var showallevents : ((_ show : Bool) -> ())?
    
     var deletegroup : ((_ show : Bool) -> ())?
    
    
    
    @IBOutlet weak var delgroupbtn: UIButton!
    
    
    
    

    @IBOutlet weak var postbtn: UIButton!
    
    @IBOutlet weak var groupmemberscount: UILabel!
    
    @IBOutlet weak var im2: UIImageView!
    @IBOutlet weak var im1: UIImageView!
    
    @IBOutlet weak var im3: UIImageView!
    
    @IBOutlet weak var allbtn: UIButton!
    
    
    @IBOutlet weak var createeventbtn: UIButton!
    
    @IBOutlet weak var vieweventbtn: MinorButton!
    @IBOutlet weak var holderview: UIView!
    
    
    @IBOutlet weak var textfieldmessage: UITextField!
    
  
    func updatecell(d : obtainhere)
    {
        
        let tp = UITapGestureRecognizer()
        tp.numberOfTapsRequired = 1
        tp.addTarget(self, action: #selector(tapped))
        let tp2 = UITapGestureRecognizer()
        tp2.numberOfTapsRequired = 1
        tp2.addTarget(self, action: #selector(tapped))
        let tp3 = UITapGestureRecognizer()
        tp3.numberOfTapsRequired = 1
        tp3.addTarget(self, action: #selector(tapped))
        im1.isUserInteractionEnabled = true
        im1.addGestureRecognizer(tp)
        im2.isUserInteractionEnabled = true
        im2.addGestureRecognizer(tp2)
        im3.isUserInteractionEnabled = true
        im3.addGestureRecognizer(tp3)
        
        
        self.selectionStyle = .none
        print("Finally Update cell called")
        self.groupmemberscount.text = "\(d.totalmembers) Members"
        allbtn.layer.cornerRadius = allbtn.frame.size.height/2
        postbtn.layer.cornerRadius = postbtn.frame.size.height/2
        
        
        MainGroupViewController.takecount = {a in
            self.groupmemberscount.text = "\(a) Members"
        }
        
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        if userid == d.creator {
            self.delgroupbtn.isHidden = true
        }
        else {
            self.delgroupbtn.isHidden = false
            delgroupbtn.setTitle("Leave Group", for: .normal)
        }
        
        delgroupbtn.layer.cornerRadius = 25
        
        createeventbtn.layer.cornerRadius = 0
        vieweventbtn.layer.cornerRadius = 0
        textfieldmessage.layer.cornerRadius = 25
        textfieldmessage.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        holderview.layer.masksToBounds = false
        holderview.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        holderview.backgroundColor = UIColor.clear
        holderview.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        holderview.layer.shadowOpacity = 0.5
        
        im1.layer.cornerRadius = im1.frame.size.height/2
        im2.layer.cornerRadius = im2.frame.size.height/2
        im3.layer.cornerRadius = im3.frame.size.height/2
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.textfieldmessage.frame.height))
        textfieldmessage.leftView = paddingView
        textfieldmessage.leftViewMode = UITextField.ViewMode.always
        
        var contents = d.members
        
        if contents.count > 0 {
            if contents[0].profileimage != "" && contents[0].profileimage != " " {
                self.downloadimage(url: contents[0].profileimage) { (imm) in
                    self.im1.image = imm
                }
            }
        }
        
        if contents.count > 1 {
            if contents[1].profileimage != "" && contents[1].profileimage != " " {
                self.downloadimage(url: contents[1].profileimage) { (imm) in
                    self.im2.image = imm
                }
            }
        }
        
        if contents.count > 2 {
            if contents[2].profileimage != "" && contents[2].profileimage != " " {
                self.downloadimage(url: contents[2].profileimage) { (imm) in
                    self.im3.image = imm
                }
            }
        }
        
    }
    
    
    
    @IBAction func delgroupbtnpressed(_ sender: Any) {
        self.deletegroup!(true)
        

    }
    
    
    @objc func tapped()
    {
        print("hey")
        self.showallmembers!(true)
    }
    
    
    
    
    @IBAction func postmessagepressed(_ sender: UIButton) {
        if let k = textfieldmessage.text as? String {
                   
                       if k  != "" {
                        self.postbtn.isEnabled = false
                        self.postmessage!(k)
                       }
                       
                   
               }
        
    }
    
    @IBAction func invitebtnpressed(_ sender: UIButton) {
        invitemembers!(true)
    }
    
    @IBAction func createeventpressed(_ sender: UIButton) {
        showallevents!(true)
    }
    
    @IBAction func viewalleventspressed(_ sender: Any) {
        showallevents!(false)
    }
    
    
    @IBAction func allmembersshow(_ sender: UIButton) {
        invitemembers!(true)
//        self.showallmembers!(true)
    }
    
    
    
    
    @IBAction func photobtnpressed(_ sender: UIButton) {
        
        self.sendbacktype!("Image")
        
    }
    
    @IBAction func videobtnpressed(_ sender: UIButton) {
        self.sendbacktype!("Video")
    }
    
    
    
    
    @IBAction func filesbtnpressed(_ sender: UIButton) {
        self.sendbacktype!("Audio")
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
