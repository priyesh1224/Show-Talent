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
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.eventimage.image = #imageLiteral(resourceName: "cover-photo")
        print("Reusing cell")
        self.eventname.text = ""
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
                

      
                    self.eventparticipation.isHidden = false
                    self.eventparticipation.text = ""
                
                if item.a.contestimage != "" && item.a.contestimage != " " {
        //            if let imm =  GroupandEventsViewController.cachegroupimage.value(forKey: ("\(item.groupid)" as NSString) as String) as? UIImage {
        //                print("Value Found")
        //                self.eventimage.image = imm
        //            }
        //            else {
                        self.downloadimage(url: item.a.contestimage) { (imm) in
                            self.eventimage.image = imm
        //                    GroupandEventsViewController.cachegroupimage.setObject(imm, forKey: "\(item.groupid)" as NSString)
                                print("Value not found")
        //                }
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
