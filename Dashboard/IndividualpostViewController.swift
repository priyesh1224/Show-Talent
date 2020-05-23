//
//  IndividualpostViewController.swift
//  ShowTalent
//
//  Created by maraekat on 05/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation

class IndividualpostViewController: UIViewController {
    
    
    @IBOutlet weak var ownerimage: UIImageView!
    
    @IBOutlet weak var ownerprofilename: UILabel!
    
    
    @IBOutlet weak var ownertype: UILabel!
    
    @IBOutlet weak var viewscount: UIButton!
    
    @IBOutlet weak var ownerpostthumbnail: UIImageView!
    
    @IBOutlet weak var likebtn: UIButton!
    
    @IBOutlet weak var commentcount: UIButton!
    
    @IBOutlet weak var likecount: UIButton!
    
    
    @IBOutlet weak var leadcommentimage: UIImageView!
    
    @IBOutlet weak var leadcommentusername: UILabel!
    
    @IBOutlet weak var leadcommenttype: UILabel!
    

    
    @IBOutlet weak var postcoverviewheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var writeacommentfield: UITextField!
    
    @IBOutlet weak var postcommentbtn: UIButton!
    
    @IBOutlet weak var playbtn: UIButton!
    
    var activityid = 3230
     var liketobepassed : [like] = []
    var alldata : [videopost] = []
     var contactlisttobepassed : [commentinfo] = []
    
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postcoverviewheight.constant = self.view.frame.size.height/3
        self.ownerimage.layer.cornerRadius = 30
        self.ownerpostthumbnail.layer.cornerRadius = 20
        self.leadcommentimage.layer.cornerRadius = 25
        
        self.ownerimage.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.ownerimage.layer.borderWidth = 2
        self.leadcommentimage.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.leadcommentimage.layer.borderWidth = 2
        self.postcommentbtn.layer.cornerRadius = 5
        fetchdata()
       
    }
    
    func renderdata()
    {
        
        if alldata[0].type == "Image" {
            self.playbtn.isHidden = true
        }
        else {
            self.playbtn.isHidden = false
        }
        
        
        self.ownerprofilename.text = self.alldata[0].profilename.capitalized
        self.ownertype.text = self.alldata[0].category.capitalized
       
        
        
        downloadimage(url: self.alldata[0].profileimg) { (im) in
            self.ownerimage.image = im
        }
        
        if alldata[0].type == "Image" {
            downloadimage(url: self.alldata[0].activitypath) { (im) in
                self.ownerpostthumbnail.image = im
            }
        }
        else {
            downloadimage(url: self.alldata[0].thumbnail) { (im) in
                self.ownerpostthumbnail.image = im
            }
        }

        
        
        
        self.likecount.setTitle("\(self.alldata[0].like)", for: .normal)
        
        self.commentcount.setTitle("\(self.alldata[0].comments.count)", for:.normal)
        
        self.viewscount.setTitle("\(self.alldata[0].views) views", for: .normal)
        
        if alldata[0].status == true {
            likebtn.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
            
        }
        else {
            likebtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        }
        
        if self.alldata[0].comments.count == 0 {
            self.leadcommentusername.text = "No comments found"
            self.leadcommenttype.isHidden = true
            
            self.leadcommentimage.isHidden = true
        }
        else {
            self.leadcommentusername.text = self.alldata[0].comments[0].profilename.capitalized
            
            downloadimage(url: self.alldata[0].comments[0].profileimage) { (im) in
                self.leadcommentimage.image = im
            }
            
            self.leadcommenttype.text = self.alldata[0].comments[0].comment.capitalized
            self.leadcommenttype.isHidden = false
            
            self.leadcommentimage.isHidden = false
        }
        
        
    }
    
    
    typealias imgcomp = (_ x : UIImage) -> Void
    func downloadimage(url : String,p : @escaping imgcomp)
    {
        print(url)
        var receivedimage : UIImage?
        Alamofire.request(url, method:.get).responseData { (rdata) in
           
            p(UIImage(data: rdata.data!)!)
        }

    }

    
    
   
    
    func fetchdata()
    {
        liketobepassed = []
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        var aid = 0
        if let a = activityid as? Int {
            aid = a
        }
        let params : Dictionary<String,Any> = ["activityFeedId":"\(aid)","userid":userid]
        print(params)
                  
               var vtok = ""
               var vfn = ""
               var vln = ""
               var vpi = ""
               var vrn = ""
                  
            var url = "\(Constants.K_baseUrl)\(Constants.actfeedbyid)?activityFeedId=\(aid)&userid=\(userid)"
        
                  var r = BaseServiceClass()
                  r.postApiRequest(url: url, parameters: params) { (data, err) in
                      if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                       
                        if let rs = resv["ResponseStatus"] as? Int {
                                          if rs == 1 {
                                              if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                                  if let m = errrr["ErrorMessage"] as? String {
                                                      self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                                  }
                                              }
                                          }
                                      }
                        
                        if let usefuldata = resv["Results"] as? [AnyObject] {
                            print(usefuldata)
                            for eachv in usefuldata  {
                                if let rawdetails = eachv as? Dictionary<String,AnyObject> {
                                    
                                    var avii = 0
                                    var avpp = ""
                                    var catt = ""
                                    var dess = ""
                                    var iddd = ""
                                    var imagess : [String] = []
                                    var likee = 0
                                    var likedbymee : [Dictionary<String,AnyObject>] = []
                                    var profimagee = ""
                                    var profnamee = ""
                                    var pbonn = ""
                                    var titlee = ""
                                    var typee = ""
                                    var u_idd = ""
                                    var vww = 0
                                    var cmntss : [commentinfo] = []
                                    var tmbb = ""
                                    
                                    
                                    if let avi = rawdetails["ActivityId"] as? Int {
                                        avii = avi
                                    }
                                    if let avp = rawdetails["ActivityPath"] as? String {
                                        avpp = avp
                                        
                                    }
                                    if let cat = rawdetails["Category"] as? String {
                                        catt = cat
                                        
                                    }
                                    if let des = rawdetails["Description"] as? String {
                                        dess = des
                                    }
                                    if let idd = rawdetails["Id"] as? String {
                                        iddd = idd
                                    }
                                    if let images = rawdetails["Images"] as? [String] {
                                        imagess = images
                                    }
                                    if let like = rawdetails["Like"] as? Int {
                                        likee = like
                                        
                                    }
                                    var currstatus = false
                                    if let likedbyme = rawdetails["LikeByMe"] as? [Dictionary<String,AnyObject>] {
                                        for eachcom in likedbyme {
                                            var cmactids = 0
                                            var cmuserids = ""
                                            var cmmidd = 0
                                            var cmmondateee = ""
                                            var idd = ""
                                            var cmmprofnamee = ""
                                            var cmmprofimagee = ""

                                            var cmmuidd = ""
                                            if let cmactid = eachcom["ActivityId"] as? Int {
                                                cmactids = cmactid
                                            }
                                            
                                            if let cmuserid = eachcom["UserID"] as? String {
                                                if userid == cmuserid {
                                                    currstatus = true
                                                }
                                                
                                                 cmuserids = cmuserid
                                             }
                                            if let cmmiddd = eachcom["Id"] as? String {
                                                 idd = cmmiddd
                                             }
                                            if let cmmondatee = eachcom["Ondate"] as? String {
                                                 cmmondateee = cmmondatee
                                             }

                                            if let cmmprofname = eachcom["ProfilName"] as? String {
                                                 cmmprofnamee = cmmprofname
                                             }
                                            if let cmmprofimage = eachcom["ProfileImage"] as? String {
                                                 cmmprofimagee = cmmprofimage
                                             }

                                            var xc = like(activityid: cmactids, id: idd, ondate: cmmondateee, profilename: cmmprofnamee, profileimage: cmmprofimagee, userid: cmuserids)
                                            
                                            
                                            
                                            
                                            self.liketobepassed.append(xc)
                                            
                                            
                                            
                                        }
                                    }
                                    if let profimage = rawdetails["ProfileImg"] as? String {
                                        profimagee = profimage
                                    }
                                    if let profname = rawdetails["ProfileName"] as? String {
                                        profnamee = profname
                                    }
                                    if let pbon = rawdetails["PublishOn"] as? String {
                                        pbonn = pbon
                                    }
                                    if let title = rawdetails["Title"] as? String {
                                        titlee = title
                                    }
                                    if let type = rawdetails["Type"] as? String {
                                        typee = type
                                    }
                                    if let u_id = rawdetails["UserId"] as? String {
                                        u_idd = u_id
                                    }
                                    if let vw = rawdetails["View"] as? Int {
                                        vww = vw
                                    }
                                    if let cmnts = rawdetails["comments"] as? [Dictionary<String,AnyObject>] {
                                        for eachcom in cmnts {
                                            var cmaii = 0
                                            var cmmm = ""
                                            var cmmidd = 0
                                            var cmmondatee = ""
                                            var idd = ""
                                            var cmmprofnamee = ""
                                            var cmmprofimagee = ""
                                            var cmmreplycmmm : Dictionary<String,AnyObject> = [:]
                                            var cmmuidd = ""
                                            if let cmai = eachcom["ActivityId"] as? Int {
                                                cmaii = cmai
                                            }
                                            
                                            if let cmm = eachcom["Comment"] as? String {
                                                 cmmm = cmm
                                             }
                                            if let cmmid = eachcom["CommentId"] as? Int {
                                                 cmmidd = cmmid
                                             }
                                            if let cmmondate = eachcom["Ondate"] as? String {
                                                 cmmondatee = cmmondate
                                             }
                                            if let id = eachcom["Id"] as? String {
                                                idd = id
                                            }
                                            if let cmmprofname = eachcom["ProfilName"] as? String {
                                                 cmmprofnamee = cmmprofname
                                             }
                                            if let cmmprofimage = eachcom["ProfileImage"] as? String {
                                                 cmmprofimagee = cmmprofimage
                                             }
                                            if let cmmreplycmm = eachcom["ReplyComments"] as? Dictionary<String,AnyObject> {
                                                 cmmreplycmmm = cmmreplycmm
                                             }
                                            if let cmmuid = eachcom["UserID"] as? String {
                                                cmmuidd = cmmuid
                                                 
                                             }
                                            
                                            
                                            var xc = commentinfo(activityid: cmaii, comment: cmmm, commentid: cmmidd, id: idd, ondate: cmmondatee, profilename: cmmprofnamee, profileimage: cmmprofimagee, replycomments: nil, userid: cmmuidd,status:"")
                                            
                                            
                                            cmntss.append(xc)
                                            
                                            
                                            
                                        }
                                    }
                                    if let tmb = rawdetails["thumbnail"] as? String {
                                        tmbb = tmb
                                    }
                                    
                                    
                                    print("For \(profnamee) and \(likee)")
                                    var x = videopost(activityid: avii, activitypath: avpp, category: catt, descrip: dess, id: iddd, images: imagess, like: likee, likebyme: self.liketobepassed, profileimg: profimagee, profilename: profnamee, publichon: pbonn, title: titlee, type: typee, userid: u_idd, views: vww, comments: cmntss, thumbnail: tmbb,status: currstatus)
                                    
                                   
                                        self.alldata.append(x)
                                 
                                    self.renderdata()

                                }

                            }
                            
                        }
                        
                        
                          
                          
                      }
                  }

    }
    
    
    
    @IBAction func seeallcommentstapped(_ sender: UIButton) {
        self.type = "comments"
        performSegue(withIdentifier: "takemetoallcomments", sender: nil)
    }
    
    
    
    
    
    @IBAction func likebtnpressed(_ sender: UIButton) {
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        if alldata[0].status == true {
            self.fetchdata(lk: 0)
            alldata[0].status = false
            alldata[0].like = alldata[0].like - 1
            self.likebtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
       
            self.likecount.setTitle("\(alldata[0].like)", for: .normal)
            
            for var k in 0..<self.alldata[0].likebyme.count {
                if self.alldata[0].likebyme[k].userid == userid {
                    self.alldata[0].likebyme.remove(at: k)
                }
            }
            
        }
        else {
            self.fetchdata(lk: 1)
            alldata[0].status = true
            alldata[0].like = alldata[0].like + 1
            self.likebtn.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
            self.likecount.setTitle("\(alldata[0].like)", for: .normal)
            
            var p = ""
            var pi = ""
            if let pe = UserDefaults.standard.value(forKey: "name") as? String {
                p = pe
            }
            if let pii = UserDefaults.standard.value(forKey: "profileimage") as? String {
                pi = pii
            }
            
            var nl = like(activityid: self.alldata[0].activityid, id: "", ondate: "", profilename: p, profileimage: pi, userid: userid)
            self.alldata[0].likebyme.append(nl)
        }
        
    }
    
    
    @IBAction func likecountpressed(_ sender: UIButton) {
        self.type = "likes"
        self.performSegue(withIdentifier: "takemetoallcomments", sender: nil)
    }
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playvideopressed(_ sender: Any) {
        performSegue(withIdentifier: "playvideo", sender: nil)
    }
    
    @IBAction func postcommentpressed(_ sender: UIButton) {
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        if writeacommentfield.text == "" || writeacommentfield.text == " " {
            
        }
        else {
            var p = ""
                       var pi = ""
                       if let pe = UserDefaults.standard.value(forKey: "name") as? String {
                           p = pe
                       }
                       if let pii = UserDefaults.standard.value(forKey: "profileimage") as? String {
                           pi = pii
                       }
            
            self.postcomment(cmnttxt: self.writeacommentfield.text!)
            
            
        }
        
    }
    
    
    
    func postcomment(cmnttxt : String)
       {
        var newcomment : commentinfo!
           
           let userid = UserDefaults.standard.value(forKey: "refid") as! String
        let params : Dictionary<String,Any> = ["PostId":self.alldata[0].activityid  as? Int ,"UserId": userid as? String,"UserComment":cmnttxt as? String]

           
           var header : Dictionary<String,String> = [:]
           header["Accept"] = "application/json"
           header["Content-Type"] = "application/json"
           header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6Ijg3MGRlNWZhLWYyMDItNDFlNC04MjJlLTc4Y2M4MjdkY2YxNCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzY5MDEwLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9._wID6Wy6x7a6Yv5186x3M-no7tQ1sKVAAbqJf4ZjrAg"
           
           
           
           var url = Constants.K_baseUrl + Constants.postCOmment
           var r = BaseServiceClass()
           r.postApiRequest(url: url, parameters: params) { (data, err) in
               print("-----------------")
            if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {

                    
                    
                    
                    if let cid = inv["CommentId"] as? Int,let aid = inv["ActivityId"] as? Int,let pn = inv["ProfilName"] as? String,let pi = inv["ProfileImage"] as? String,let uid = inv["UserID"] as? String,let cm = inv["Comment"] as? String,let on = inv["Ondate"] as? String  {
                        
                        newcomment = commentinfo(activityid: aid, comment: cm, commentid: cid, id: "", ondate: on, profilename: pn, profileimage: pi, replycomments: nil, userid: uid,status:"")
           
                        self.leadcommentusername.text = newcomment.profilename.capitalized
                        self.leadcommenttype.text = newcomment.comment.capitalized
                        
                        self.leadcommenttype.isHidden = false
                        
                        self.leadcommentimage.isHidden = false
                        self.writeacommentfield.text = ""
                        self.writeacommentfield.resignFirstResponder()
                        
                        self.downloadimage(url: pi) { (im) in
                            self.leadcommentimage.image = im
                        }
                        self.alldata[0].comments.append(newcomment)
                        self.commentcount.setTitle("\(self.alldata[0].comments.count)", for: .normal)
                        
                    }
                
                    
                    
                    print(inv)
                }
            }
         
           }
           
           
       }

    
        func fetchdata(lk:Int)
        {
            self.likebtn.isEnabled = false
            let userid = UserDefaults.standard.value(forKey: "refid") as! String
            let params : Dictionary<String,Any> = ["PostId":self.alldata[0].activityid as? Int ,"UserId": userid as? String,"LikeType":lk as? Int]

            
            var header : Dictionary<String,String> = [:]
            header["Accept"] = "application/json"
            header["Content-Type"] = "application/json"
            header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6Ijg3MGRlNWZhLWYyMDItNDFlNC04MjJlLTc4Y2M4MjdkY2YxNCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzY5MDEwLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9._wID6Wy6x7a6Yv5186x3M-no7tQ1sKVAAbqJf4ZjrAg"
            
            
            
            var url = Constants.K_baseUrl + Constants.postLike
            var r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: params) { (data, err) in
                print("-----------------")
                
                if let st = data?.response?.statusCode as? Int {
                    if st == 200 {
                        if lk == 0 {
                            print("Disliked")
                            self.likebtn.isEnabled = true
                        }
                        else {
                            print("Liked")
                            self.likebtn.isEnabled = true
                        }
                    }
                }
            }
            
            
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let se = segue.destination as? AVPlayerViewController {
            var u =  URL(string: self.alldata[0].activitypath)
            if let m = u as? URL {
                se.player = AVPlayer(url: m)
                
            }
        

        }
        
        
        if let seg = segue.destination as? AllcommentsViewController {
            seg.mode  = self.type
            seg.postid = self.alldata[0].activityid
            if self.type == "likes" {
                seg.alllikes = self.alldata[0].likebyme

            }
        }
    }

}
