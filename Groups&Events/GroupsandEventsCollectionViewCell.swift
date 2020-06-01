//
//  GroupsandEventsCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class GroupsandEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventimage: UIImageView!
    
    @IBOutlet weak var eventname: UILabel!
    
    
    
    @IBOutlet weak var eventparticipation: UILabel!
    
    var alreasypostedinview : UIView?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.eventimage.image = #imageLiteral(resourceName: "cover-photo")
        print("Reusing cell")
        self.eventname.text = ""
        alreasypostedinview = nil
    }
    
    
    
    func updatecell(item : groupevent, type:String) {
        

        if type == "groups" || type == "joinedgroups" {
            self.eventparticipation.isHidden = true
        }
        else {
            self.eventparticipation.isHidden = false
            self.eventparticipation.text = "\(item.groupparticipation) Interested"
        }
        if item.groupimage != "" && item.groupimage != " " {
//            if let imm =  GroupandEventsViewController.cachegroupimage.value(forKey: ("\(item.groupid)" as NSString) as String) as? UIImage {
//                print("Value Found")
//                self.eventimage.image = imm
//            }
//            else {
                self.downloadimage(url: item.groupimage) { (imm) in
                    print("setting image")
                    self.eventimage.image = imm
//                    GroupandEventsViewController.cachegroupimage.setObject(imm, forKey: "\(item.groupid)" as NSString)
                        print("Value not found")
//                }
            }
        }
        
        
        eventimage.layer.cornerRadius = 10
        eventname.text = item.groupname.capitalized
    }
    
    
        func updatecell2(item : strevent, type:String) {
            

            if type == "groups" {
                self.eventparticipation.isHidden = true
            }
            else {
                self.eventparticipation.isHidden = false
                self.eventparticipation.text = ""
            }
            if item.contestimage != "" && item.contestimage != " " {
    //            if let imm =  GroupandEventsViewController.cachegroupimage.value(forKey: ("\(item.groupid)" as NSString) as String) as? UIImage {
    //                print("Value Found")
    //                self.eventimage.image = imm
    //            }
    //            else {
                    self.downloadimage(url: item.contestimage) { (imm) in
                        self.eventimage.image = imm
    //                    GroupandEventsViewController.cachegroupimage.setObject(imm, forKey: "\(item.groupid)" as NSString)
                            print("Value not found")
    //                }
                }
            }
            
            
            eventimage.layer.cornerRadius = 10
            eventimage.backgroundColor = UIColor.black
            eventname.text = item.contestname.capitalized
        }
    
    
    
            func updatecell3(item : streventcover, type:String) {
                if type.lowercased() == "joined events" && item.a.participationpostallow == true {
                    alreasypostedinview = UIView(frame: CGRect(x: self.frame.size.width/3.5, y: self.frame.size.height * 0.43, width: self.frame.size.width/1.3, height: 30))
                    alreasypostedinview?.layer.cornerRadius = 15
                    alreasypostedinview?.backgroundColor = UIColor.red
                    var imv = UIImageView(frame: CGRect(x: 4, y: 0, width: 26, height: 30))
                    imv.image = #imageLiteral(resourceName: "Group 1744")
                    imv.contentMode = .scaleAspectFit
                    alreasypostedinview?.addSubview(imv)
                    
                    var ic = UILabel(frame: CGRect(x: 30, y: 0, width: self.frame.size.width/1.6, height: 30))
                    ic.text = "Post Pending"
                    ic.textColor =  UIColor.white
                    alreasypostedinview?.addSubview(ic)
                    self.layer.addSublayer(alreasypostedinview!.layer)
                }
                    self.eventparticipation.isHidden = false
                    self.eventparticipation.text = ""
                
                if item.a.contestimage != "" && item.a.contestimage != " " {
    
                        self.downloadimage(url: item.a.contestimage) { (imm) in
                            self.eventimage.image = imm
        
                                print("Value not found")
      
                    }
                }
                eventimage.layer.cornerRadius = 10
                eventimage.backgroundColor = UIColor.black
                eventname.text = item.a.contestname.capitalized
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
