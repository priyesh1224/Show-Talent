//
//  TalentshowcaseTableViewCell2.swift
//  ShowTalent
//
//  Created by maraekat on 29/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class TalentshowcaseTableViewCell2: UITableViewCell {
    
    
    @IBOutlet weak var postbtn: UIButton!
    
    
    @IBOutlet weak var seeallcomments: UIButton!
    
    var shouldadjustheight  = false
    
    var diff = 0
    var commentposted: ((_ status: commentinfo?) -> ())?
    var adjustheight: ((_ status: CGFloat?) -> ())?
    var onSeeAllcomments: ((_ currentholder: videopost, _ iidd : Int) -> ())?
    var onSeeAlllikes: ((_ currentholder: videopost) -> ())?
    var togglelike : ((_ post : videopost,_ status : Bool) -> ())?

    @IBOutlet weak var bannerheight: NSLayoutConstraint!
    
    
    var found = false
    var postid = 0
    var curentvideopost : videopost!
    static var liked : Bool?
    var tobeliked : Bool = false
    var currcat = ""

    
    @IBOutlet weak var mianviewheight: NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var pim: UIImageView!
    
    @IBOutlet weak var pname: UILabel!
    
    
    @IBOutlet weak var pprof: UILabel!
    
    @IBOutlet weak var mainpic: UIImageView!
    
    
    @IBOutlet weak var likeicon: UIButton!
    
    
    @IBOutlet weak var likelabel: UIButton!
    
    
    @IBOutlet weak var commenticon: UIButton!
    
    
    @IBOutlet weak var commentlabel: UILabel!
    
    
    @IBOutlet weak var viewslabel: UILabel!
    
    
    @IBOutlet weak var leaduserimage: UIImageView!
    
    
    @IBOutlet weak var leadusername: UILabel!
    
    
    @IBOutlet weak var leadusercomment: UILabel!
    
    
    @IBOutlet weak var commentfield: UITextField!
    
    
    
    
    
    @IBAction func commentposted(_ sender: UIButton) {
        if self.commentfield.text  != "" {
            if let cm = self.commentfield.text as? String {
                self.postcomment(cmnttxt: cm)

            }
            
        }
    }
    func postcomment(cmnttxt : String)
          {
           var newcomment : commentinfo!
              
              let userid = UserDefaults.standard.value(forKey: "refid") as! String
           let params : Dictionary<String,Any> = ["PostId":self.postid as? Int ,"UserId": userid as? String,"UserComment":cmnttxt as? String]

              
              var header : Dictionary<String,String> = [:]
              header["Accept"] = "application/json"
              header["Content-Type"] = "application/json"
              header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6Ijg3MGRlNWZhLWYyMDItNDFlNC04MjJlLTc4Y2M4MjdkY2YxNCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzY5MDEwLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9._wID6Wy6x7a6Yv5186x3M-no7tQ1sKVAAbqJf4ZjrAg"
              
              
              var url = Constants.K_baseUrl + Constants.postCOmment
              var r = BaseServiceClass()
              r.postApiRequest(url: url, parameters: params) { (data, err) in
               if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                   if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {

                       
                       
                       
                       if let cid = inv["CommentId"] as? Int,let aid = inv["ActivityId"] as? Int,let pn = inv["ProfilName"] as? String,let pi = inv["ProfileImage"] as? String,let uid = inv["UserID"] as? String,let cm = inv["Comment"] as? String,let on = inv["Ondate"] as? String  {
                           
                           newcomment = commentinfo(activityid: aid, comment: cm, commentid: cid, id: "", ondate: on, profilename: pn, profileimage: pi, replycomments: nil, userid: uid,status:"")
              
                           self.leadusername.text = newcomment.profilename.capitalized
                           self.leadusercomment.text = newcomment.comment.capitalized
                           self.downloadprofileimage(url: newcomment.profileimage) { (iem) in
                               self.leaduserimage.image = iem
                           }
                           self.curentvideopost.comments.append(newcomment)
                           
                       }
                   
                       
                       
                   }
               }
                  if let st = data?.response?.statusCode as? Int {
                      if st == 200 {
                       self.commentposted!(newcomment)
                       self.commentfield.text = ""
                      }
                      else {
                       self.commentposted!(nil)
                       }
                       
                  }
              }
              
              
          }
    
    
    @IBAction func seeallcommentstapped(_ sender: UIButton) {
        self.onSeeAllcomments!(self.curentvideopost,self.postid)

    }
    
    
    @IBAction func likeicontapped(_ sender: UIButton) {
        let dummycurrentuserid = UserDefaults.standard.value(forKey: "refid") as! String
       
        
        
        var poststatus = 0
        if self.curentvideopost.status == false {
            poststatus = 1
            self.likeicon.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
        }
        else {
            poststatus = 0
            self.likeicon.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        }
        fetchdata(lk: poststatus)
    }
    
    func fetchdata(lk:Int)
       {
           self.likeicon.isEnabled = false
           let userid = UserDefaults.standard.value(forKey: "refid") as! String
           let params : Dictionary<String,Any> = ["PostId":self.postid as? Int ,"UserId": userid as? String,"LikeType":lk as? Int]

           
           var header : Dictionary<String,String> = [:]
           header["Accept"] = "application/json"
           header["Content-Type"] = "application/json"
           header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6Ijg3MGRlNWZhLWYyMDItNDFlNC04MjJlLTc4Y2M4MjdkY2YxNCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzY5MDEwLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9._wID6Wy6x7a6Yv5186x3M-no7tQ1sKVAAbqJf4ZjrAg"
           
           
           
           var url = Constants.K_baseUrl + Constants.postLike
           var r = BaseServiceClass()
           r.postApiRequest(url: url, parameters: params) { (data, err) in
               
               if let st = data?.response?.statusCode as? Int {
                   if st == 200 {
                       if lk == 0 {
                       
//                        self.likeicon.setImage(#imageLiteral(resourceName: "like"), for: .normal)

                           self.likelabel.setTitle("\(Int(self.likelabel.title(for: .normal)!)! - 1)", for: .normal)
                        self.likeicon.isEnabled = true
                        self.curentvideopost.status = false
                        self.togglelike!(self.curentvideopost, false)
                      

                       }
                       else {

                          
//                        self.likeicon.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
                           self.likelabel.setTitle("\(Int(self.likelabel.title(for: .normal)!)! + 1)", for: .normal)
                           self.likeicon.isEnabled = true
                        
                        self.curentvideopost.status = true
                        self.togglelike!(self.curentvideopost, true)

                       }
                   }
               }
           }
    }
    
    
    @IBAction func likelabeltapped(_ sender: UIButton) {
        self.onSeeAlllikes!(self.curentvideopost)

    }
    
    
    @IBAction func commenticontapped(_ sender: UIButton) {
    }
    
    
    
    func updatecell(x:videopost)
    {
        pim.layer.cornerRadius = pim.frame.size.height/2
        if let p = self.postbtn {
            self.postbtn.layer.cornerRadius = self.postbtn.frame.size.height/2
        }
        var wid = self.mainpic.frame.size.width
        var hei = wid * 0.6
        self.bannerheight.constant = hei
        
        
        self.curentvideopost = x
        self.postid = x.activityid
        
        likelabel.setTitle("\(x.like)", for: .normal)
        commentlabel.text = "\(x.comments.count)"
        viewslabel.text = "\(x.views) views"
        
        var dummycurrentuserid = UserDefaults.standard.value(forKey: "refid") as! String
            
        if x.status == true {
            self.likeicon.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
        }
        else {
            self.likeicon.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        }

        pname.text = x.profilename.capitalized
        pprof.text = x.title.capitalized
        
        self.mainpic.layer.cornerRadius = 0
               self.pim.layer.cornerRadius = self.pim.frame.size.height/2
               self.pim.layer.borderWidth = 2
        self.pim.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        
        if x.comments.count == 0 {
                   self.leadusername.text = "No comments to show"
            self.seeallcomments?.isHidden = true
                   self.leadusercomment.text = ""
                   self.leaduserimage.image = nil
               }
               else {
                   self.leadusername.text = x.comments.last?.profilename.capitalized
            self.leaduserimage.layer.cornerRadius = self.leaduserimage.frame.size.height/2
                    self.seeallcomments?.isHidden = false
                   self.leadusercomment?.text = x.comments.last?.comment.capitalized
                   downloadprofileimage(url: x.comments.last!.profileimage) { (im) in
                       self.leaduserimage.image = im
                   }
               }
        
        
        downloadprofileimage(url: x.profileimg) { (im) in
            self.pim.image = im
        }
        var u = NSURL(string: x.activitypath)
        var size = CGSize(width: self.mainpic.frame.size.width, height: 340)
        if let im = Talentshowcase2ViewController.cachepostthumbnail.object(forKey: x.activitypath as NSString) {
            var w = im.size.width
            var h = im.size.height
            var mw = self.mainpic.frame.size.width
            var  r = Float(w) / Float(h)
            var mh = Float(mw) / r
            self.mianviewheight?.constant = self.frame.size.height * 0.5
//            if mh > 580 {
//                self.mianviewheight.constant = 580
//            }
//            if mh < 380 {
//                self.mianviewheight.constant = 380
//            }
            self.mainpic.image = im
        }
        else if let uu = u  {
            do {
            var ix = try UIGraphicsRenderer.renderImageAt(url: uu, size: size, scale: 1)
                if let imagere = ix as? UIImage{
                    var w = imagere.size.width
                                var h = imagere.size.height
                                var mw = self.mainpic.frame.size.width
                                var  r = Float(w) / Float(h)
                                var mh = Float(mw) / r
                    if let m = mianviewheight {
                                self.mianviewheight.constant = self.frame.size.height * 0.5
                    }
//                                if mh > 380 {
//                                    self.mianviewheight.constant = 580
//                                }
//                                if mh < 280 {
//                                    self.mianviewheight.constant = 380
//                                }
                    Talentshowcase2ViewController.cachepostthumbnail.setObject(imagere, forKey: x.activitypath as NSString)
                    self.mainpic.image = imagere
                }
            }
            catch {
                
            }
        }
      
        
//        downloadpostthumbnail(url: x.activitypath) { (imm) in
//
//            var originalheight = self.mainpic.frame.size.height
//
//
//            var w = imm?.size.width
//            var h = imm?.size.height
//            var mw = self.mainpic.frame.size.width
//            var  r = Float(w!) / Float(h!)
//            var mh = Float(mw) / r
//            self.mianviewheight.constant = CGFloat(mh)
//            if mh > 380 {
//                self.mianviewheight.constant = 380
//            }
//            if mh < 280 {
//                self.mianviewheight.constant = 280
//            }
//
//            print("Hola \(x.profilename) \(mh)")
//
//
//            self.mainpic.image = imm
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.commentfield.resignFirstResponder()
           return true
       }
    
    func downloadprofileimage(url:String,completion : @escaping (UIImage?) -> Void) {
        if let cachedimage = Talentshowcase2ViewController.cachepostprofileimage.object(forKey: url as NSString) {
            completion(cachedimage)
        }
        else {
            Alamofire.request(url, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                if responseData.data != nil {
            Talentshowcase2ViewController.cachepostprofileimage.setObject(UIImage(data: responseData.data!)!, forKey: url as NSString)
                completion(UIImage(data: responseData.data!))
                }
            })
        }
    }
    
    
    func downloadpostthumbnail(url:String,completion : @escaping (UIImage?) -> Void) {
        if let cachedimage = Talentshowcase2ViewController.cachepostthumbnail.object(forKey: url as NSString) {
            completion(cachedimage)
        }
        else {
            Alamofire.request(url, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                if responseData.data != nil {
            Talentshowcase2ViewController.cachepostthumbnail.setObject(UIImage(data: responseData.data!)!, forKey: url as NSString)
                completion(UIImage(data: responseData.data!))
                }
            })
        }
    }
    
    
}
