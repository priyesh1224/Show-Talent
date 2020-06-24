//
//  ProfilemainscreenViewController.swift
//  ShowTalent
//
//  Created by maraekat on 07/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire



struct basicprofile
{
    var follower : Int
    var firstname : String
    var lastname  : String
    var profileimg : String
    var totalpost : Int
    var dob : String
    var gender : String
}


class ProfilemainscreenViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UIImagePickerControllerDelegate,UINavigationControllerDelegate {
 
    
    
    @IBOutlet weak var eventbookinghistoryouterview: UIView!
    
    
    
    
    var basic : basicprofile?
    
    var imgtypes : [String] = []
    var alldata : [videopost] = []
    var videodata : [videopost] = []
    var imagedata : [videopost] = []
    var audiodata : [videopost] = []
    var filedata : [videopost] = []
    
    var basiclock =  false
    var canfetchmore = true
    var oldcount = 0
    
    let pickercontroller = UIImagePickerController()
    var path = CGMutablePath()
       var pathlabel = UILabel()
       let maskLayer = CAShapeLayer()
       var overview : UIView?
       var introcount = 1
    
    var tappeddata = 0
    var pageno = 0
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var profileimage: PaddedImageView!
    
    @IBOutlet weak var try2: UIStackView!
    
    @IBOutlet weak var try1: UIStackView!
    
    @IBOutlet weak var sidebar: UIButton!
    
    @IBOutlet weak var editphotobtn: Paddedbutton!
    
    
    @IBOutlet weak var firstname: UITextView!
    
    @IBOutlet weak var lastname: UILabel!
    
    
    @IBOutlet weak var profession: UILabel!
    
    
    @IBOutlet weak var editprofilebtn: MinorButton!
    
    
    @IBOutlet weak var stackover: UIStackView!
    
    @IBOutlet weak var stackouterview: UIView!
    
    
    @IBOutlet weak var postcount: CustomButton!
    
    @IBOutlet weak var followerscount: CustomButton!
    
    @IBOutlet weak var followingcount: CustomButton!
    
    
    @IBOutlet weak var allbtn: UIButton!
    
    @IBOutlet weak var photobtn: UIButton!
    
    
    @IBOutlet weak var videobtn: UIButton!
    
    @IBOutlet weak var audiobtn: UIButton!
    
    
    @IBOutlet weak var filesbtn: UIButton!
    
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    var type = "All"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        self.setTableViewBackgroundGradient(UIColor.init(hexString: "#AF1739"), UIColor.init(hexString: "#613A4F"))
        eventbookinghistoryouterview.layer.cornerRadius = 10
        collection.delegate = self
        collection.dataSource = self
        pickercontroller.allowsEditing = true
        pickercontroller.mediaTypes = ["public.image"]
        pickercontroller.delegate = self
        if let u =  UserDefaults.standard.value(forKey: "refid") as? String {

            fetchprofile(firsttime: true)
        }
        
        
        if let v  = UserDefaults.standard.value(forKey: "needtoshowprofiletutorial") as? Bool {
            if v {
                self.overview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
                self.overview?.backgroundColor = #colorLiteral(red: 0.0264734456, green: 0.0264734456, blue: 0.0264734456, alpha: 0.8351122359)

                let tp = UITapGestureRecognizer(target: self, action: #selector(self.handleoverviewtap))
                        tp.numberOfTouchesRequired = 1
                        tp.numberOfTapsRequired = 1
                        tp.isEnabled = true
                self.overview?.addGestureRecognizer(tp)
                self.view.addSubview(self.overview ?? UIView())
                self.maskLayer.backgroundColor = UIColor.white.cgColor
                self.maskLayer.fillRule = .evenOdd
                self.overview?.layer.mask = self.maskLayer
                self.overview?.clipsToBounds = true
                self.pathlabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2.4, width: self.view.frame.size.width, height: 90))
                self.pathlabel.numberOfLines = 0
                self.pathlabel.textAlignment = .center
                self.pathlabel.textColor = UIColor.white
                self.overview?.addSubview(self.pathlabel)
                self.bringinintro(intro: self.introcount)
                UserDefaults.standard.set(false, forKey: "needtoshowprofiletutorial")
            }
        }
        
        
        
      
    }
    
    func bringinintro(intro : Int)
       {
           
          
           
                   
                   
                  
           
           
           if intro == 1 {
            let frame = self.eventbookinghistoryouterview.frame
               
                   path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 6))
                                        path.addRoundedRect(in: CGRect(x: frame.origin.x - 4, y: frame.origin.y - 2, width: frame.size.width + 8, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)
                   path.addRect(CGRect(origin: .zero, size: overview?.frame.size ?? CGSize.zero))
                   maskLayer.path = path

                  
                   pathlabel.text = "Click to see all your events booked. \n\n\n Tap for next suggestion"
                   
           }
           else if intro == 2 {
               let frame = self.try1.convert(editphotobtn.layer.frame, to:self.view)
                      
                      path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 6))
                      path.addRoundedRect(in: CGRect(x: frame.origin.x - 4, y: frame.origin.y - 2, width: frame.size.width + 8, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)

                                maskLayer.path = path
               pathlabel.text = "Click here to change your profile picture. \n\n\n Tap for next suggestion"
           }
           else if intro == 3 {
               let frame = self.try2.convert(editprofilebtn.layer.frame, to:self.view)
                      
                      path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 8))
                      path.addRoundedRect(in: CGRect(x: frame.origin.x - 4, y: frame.origin.y - 2, width: frame.size.width + 8, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)

                                maskLayer.path = path
               pathlabel.text = "Click here to edit/view your profile. \n\n\n Tap for next suggestion"
           }
           else if intro == 4 {
            let frame = sidebar.frame
                      
                      path.addArc(center: CGPoint(x: frame.origin.x+15, y: frame.origin.y+16),
                      radius: frame.size.height/2 + 5,
                         startAngle: 0.0,
                         endAngle: 2.0 * .pi,
                         clockwise: false)

                                maskLayer.path = path
               pathlabel.text = "Click here to see more options. \n\n\n Tap for next suggestion"
           }
               
           else {
               self.overview?.isHidden = true
           }
                   
                   
                   

       }
       
       
       @objc func handleoverviewtap()
       {
           introcount = introcount +  1
           self.bringinintro(intro: introcount)
       }
    func setTableViewBackgroundGradient( _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.eventbookinghistoryouterview.frame.size.width, height: self.eventbookinghistoryouterview.frame.size.height)
        
        self.eventbookinghistoryouterview.layer.insertSublayer(gradientLayer, at: 0)
        //        sender.backgroundView = backgroundView
    }
    
    
    @IBAction func editprofilepressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoedit", sender: nil)
    }
    
    
    
    @IBAction func eventbookinghistoryone(_ sender: Any) {
        self.performSegue(withIdentifier: "showmybookedevents", sender: nil)
    }
    
    
    
    @IBAction func eventbookinghistorytwo(_ sender: Any) {
        self.performSegue(withIdentifier: "showmybookedevents", sender: nil)
    }
    
    
    
    
    func fetchprofile(firsttime : Bool)
    {
        var liketobepassed : [like] = []
        let userid = UserDefaults.standard.value(forKey: "refid") as! String

        let params : Dictionary<String,String> = ["Page":"0","PageSize":"9"]
                  
            print(params)
                  
            var url = "\(Constants.K_baseUrl)\(Constants.profile)\(userid),\(type)"

            print(url)
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
                        
                        
                          if let usefuldata = resv["Results"] as? Dictionary<String,Any> {
                           
                            var follower = 0
                            var firstname = ""
                            var lastname = ""
                            var profileimg = ""
                            var totalpost = 0
                            var dobb = ""
                            var gen = ""
                            if let f = usefuldata["Follower"] as? Int {
                                follower = f
                            }
                            if let tp = usefuldata["TotalPost"] as? Int {
                                totalpost = tp
                            }
                            
                            if let profile = usefuldata["Profile"] as? Dictionary<String,AnyObject> {
                                if let fn = profile["FirstName"] as? String {
                                    firstname = fn
                                }
                                if let ln = profile["LastName"] as? String {
                                    lastname = ln
                                }
                                if let pi = profile["ProfileImg"] as? String {
                                    profileimg = pi
                                }
                                if let db = profile["Dob"] as? String {
                                    dobb = db
                                }
                                if let g = profile["Gender"] as? String {
                                    gen = g.lowercased()
                                }
                            }
                            
                            var basic = basicprofile(follower: follower, firstname: firstname, lastname: lastname, profileimg: profileimg, totalpost: totalpost,dob : dobb,gender: gen)
                            self.basic = basic
                            print(basic)
                            
                            if let activities = usefuldata["Activities"] as? [Dictionary<String,AnyObject>] {
                                
                                
                                if firsttime == true {
                                for rawdetails in activities {
                                    
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
                                            
                                            
                                            
                                            
                                            liketobepassed.append(xc)
                                            
                                            
                                            
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
                                    var x = videopost(activityid: avii, activitypath: avpp, category: catt, descrip: dess, id: iddd, images: imagess, like: likee, likebyme: liketobepassed, profileimg: profimagee, profilename: profnamee, publichon: pbonn, title: titlee, type: typee, userid: u_idd, views: vww, comments: cmntss, thumbnail: tmbb,status: currstatus)
                                    
                                    
                                    if self.type == "All" {
                                        self.alldata.append(x)
                                    }                                  
                                    else if self.type == "Video" {
                                        self.videodata.append(x)
                                    }
                                    else if self.type == "Image" {
                                        self.imagedata.append(x)
                                    }
                                    else if self.type == "Audio" {
                                        self.audiodata.append(x)
                                    }
                                    else if self.type == "File" {
                                        self.filedata.append(x)
                                    }
                                    
                                    print(x)
                                }
                                    
                                    
                                    if self.type == "All" {
                                        self.oldcount = self.alldata.count
                                    }
                                    else if self.type == "Video" {
                                        self.oldcount = self.videodata.count
                                    }
                                    else if self.type == "Image" {
                                        self.oldcount = self.imagedata.count
                                    }
                                    else if self.type == "Audio" {
                                        self.oldcount = self.audiodata.count
                                    }
                                    else if self.type == "File" {
                                        self.oldcount = self.filedata.count
                                    }
                                self.collection.reloadData()
                                if self.basiclock == false {
                                    self.setupbasic()
                                    self.basiclock = true
                                }
                              }
                                
                                
                               
                                
                                
                                
                                
                            }
                            
                            
                              
                          }
                          
                      }
                  }

        
    }
    
    
    
    func loadmore(page:Int)
    {
        print("Loading More")
        var liketobepassed : [like] = []
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        
        self.pageno = self.pageno + 1

        let params : Dictionary<String,String> = ["Page":"\(self.pageno)","PageSize":"9"]
                  
            print(params)
                  
            var url = "\(Constants.K_baseUrl)\(Constants.profile)71345b14-7cec-47fb-95f3-96c9e079c5a2,\(type)"

            print(url)
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
                        
                        
                          if let usefuldata = resv["Results"] as? Dictionary<String,Any> {
                           
                            var follower = 0
                            
                            var totalpost = 0
                    
                            if let f = usefuldata["Follower"] as? Int {
                                follower = f
                            }
                            if let tp = usefuldata["TotalPost"] as? Int {
                                totalpost = tp
                            }
                            
              
                            
                          
          
                            
                            if let activities = usefuldata["Activities"] as? [Dictionary<String,AnyObject>] {
                                
                                
                               
                                for rawdetails in activities {
                                    
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
                                            
                                            
                                            
                                            
                                            liketobepassed.append(xc)
                                            
                                            
                                            
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
                                    var x = videopost(activityid: avii, activitypath: avpp, category: catt, descrip: dess, id: iddd, images: imagess, like: likee, likebyme: liketobepassed, profileimg: profimagee, profilename: profnamee, publichon: pbonn, title: titlee, type: typee, userid: u_idd, views: vww, comments: cmntss, thumbnail: tmbb,status: currstatus)
                                    
                                    
                                    if self.type == "All" {
                                        self.alldata.append(x)
                                    }
                                    else if self.type == "Video" {
                                        self.videodata.append(x)
                                    }
                                    else if self.type == "Image" {
                                        self.imagedata.append(x)
                                    }
                                    else if self.type == "Audio" {
                                        self.audiodata.append(x)
                                    }
                                    else if self.type == "File" {
                                        self.filedata.append(x)
                                    }
                                    
                                    print(x)
                                }
                                
                                if self.type == "All" {
                                    if self.oldcount == self.alldata.count {
                                        self.canfetchmore = false
                                    }
                                    else {
                                        self.oldcount = self.alldata.count
                                    }
                                }
                                else if self.type == "Video" {
                                    if self.oldcount == self.videodata.count {
                                        self.canfetchmore = false
                                    }
                                    else {
                                        self.oldcount = self.videodata.count
                                    }
                                }
                                else if self.type == "Image" {
                                    if self.oldcount == self.imagedata.count {
                                        self.canfetchmore = false
                                    }
                                    else {
                                        self.oldcount = self.imagedata.count
                                    }
                                }
                                else if self.type == "Audio" {
                                    if self.oldcount == self.audiodata.count {
                                        self.canfetchmore = false
                                    }
                                    else {
                                        self.oldcount = self.audiodata.count
                                    }
                                }
                                else if self.type == "File" {
                                    if self.oldcount == self.filedata.count {
                                        self.canfetchmore = false
                                    }
                                    else {
                                        self.oldcount = self.filedata.count
                                    }
                                }
                                self.collection.reloadData()
                           
                              
                            }
                            
                              
                          }
                          
                      }
                  }

    }
    
    
    @IBAction func changeprofilepicture(_ sender: Paddedbutton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
                    self.pickercontroller.sourceType = .camera
         
                        self.pickercontroller.mediaTypes = ["public.image"]
                    
                    self.pickercontroller.allowsEditing = true
                    self.present(self.pickercontroller, animated: true, completion: nil)
                    
                }
            
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            
            self.pickercontroller.sourceType = .photoLibrary
      
                self.pickercontroller.mediaTypes = ["public.image"]
            
            self.pickercontroller.allowsEditing = true
            self.present(self.pickercontroller, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let mt = info[.mediaType] as? String {
            
            if picker.sourceType == .photoLibrary {
                let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                      if (assetPath.absoluteString?.hasSuffix("JPG"))! {
                          print("JPG")
                          self.imgtypes.append("jpg")
                      }
                      else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
                          self.imgtypes.append("png")
                          }
                      else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
                          self.imgtypes.append("gif")
                      }
                      else {
                          self.imgtypes.append("unknown")
                      }
            }
            else if picker.sourceType == .camera {
                self.imgtypes.append("jpg")
            }
                   
                   if mt == "public.image" {
                       if let image = info[.editedImage] as? UIImage {
                           self.profileimage.image = image
                        self.UploadImage(img:[image])
                           
                       }

                   }
                   
                  
               }
               self.pickercontroller.dismiss(animated: true, completion: nil)
    }
    
    
    func UploadImage(img : [UIImage])
           {
          
               let request = ImageUploadRequest()
            
   
            
               var params = Dictionary<String , Any>()
            params = [:]
               
               let images = [String]()
               print(params)
              
            print(img)
            request.uploadImageprofilepicture(imagesdata:img, params: params , extensiontype : self.imgtypes) {  (response, err) in
                   
                   if response != nil{
                
                    print(response)
                    print("--------------------------")
          
                       print("Image Uploaded Sucessfully")
                    DispatchQueue.main.async {
                        
                        self.pickercontroller.dismiss(animated: true) {
    //                        self.dismiss(animated: true, completion: nil)
                        }
                    }
                      
                   }
                       
                   else
                   {
                    DispatchQueue.main.async {
                        self.pickercontroller.dismiss(animated: true, completion: nil)
                    }
                   }
                   
               }
           }
    
    
    func setupbasic()
    {
        var f = ""
        var l = ""
        if let fn = self.basic?.firstname as? String {
            f = fn
        }
        if let ln = self.basic?.lastname as? String {
            l = ln
        }
        var totalname = "\(f) \(l)"
        var styletext = NSMutableAttributedString(string: totalname, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)])
        styletext.setAttributes([NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1) ,  NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)], range: (totalname as NSString).range(of: l))
        self.firstname.attributedText = styletext
//        self.lastname.text = self.basic?.lastname.capitalized
        
        self.profession.text =  NSString.localizedStringWithFormat(" %@", "Profession") as String as String
        if let foll = self.basic?.follower as? Int {
            self.followerscount.setTitle("\(foll)", for: .normal)

        }
        if let tp = self.basic?.totalpost as? Int {
            self.postcount.setTitle("\(tp)", for: .normal)

        }
        if self.basic?.profileimg != "" && self.basic?.profileimg != " " {
            self.downloadimage(url: self.basic!.profileimg) { (immm) in
                self.profileimage.image = immm
            }
        }
    }
    
//    func clearImageFromCache(x : String) {
//        let URL = NSURL(string: "https://cdn.domain.com/profile/image.jpg")!
//        let URLRequest = NSURLRequest(url: URL as URL)
//
//
//
//        // Clear the URLRequest from the in-memory cache
//        imageDownloader.imageCache?.removeImageForRequest(URLRequest, withAdditionalIdentifier: nil)
//
//        // Clear the URLRequest from the on-disk cache
//        imageDownloader.sessionManager.session.configuration.URLCache?.removeCachedResponseForRequest(URLRequest)
//    }
    
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
    func setupview()
    {
        self.stackouterview.backgroundColor = UIColor.white
        self.stackouterview.layer.cornerRadius = 20
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/1.6
        self.editprofilebtn.layer.cornerRadius = 5
        self.editphotobtn.layer.cornerRadius = 15
        self.stackover.layer.cornerRadius = 10
        
        self.allbtn.titleLabel!.font = UIFont(name: "ProximaNova-Bold", size: 16)
        self.videobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.photobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.audiobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.filesbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
    }
    
    
    @IBAction func logoutuser(_ sender: UIButton) {
        
        
        performSegue(withIdentifier: "moreprofile", sender: nil)
        
//        var contact = UserDefaults.standard.value(forKey: "mobile")
//        var firstname = UserDefaults.standard.value(forKey: "firstname")
//        var lastname = UserDefaults.standard.value(forKey: "lastname")
//        print(contact)
//        print(firstname)
//        print(lastname)
//
//
//
//        let defaults = UserDefaults.standard
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            defaults.removeObject(forKey: key)
//        }
//        UserDefaults.standard.set(nil, forKey: "refid")
//        performSegue(withIdentifier: "userloggedout", sender: nil)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if self.type == "All" {
            return self.alldata.count
         }
         else if self.type == "Video" {
            return self.videodata.count
         }
         else if self.type == "Image" {
            return self.imagedata.count
         }
         else if self.type == "Audio" {
            return self.audiodata.count
         }
         else if self.type == "File" {
            return self.filedata.count
         }
        return 0
     }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cell = collectionView.cellForItem(at: indexPath) {
            let size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
              
       return size
        }
        return CGSize(width: 100, height: 100)
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilecell", for: indexPath) as? ProfileMainScreenCollectionViewCell {

            if self.type == "All" && indexPath.row < self.alldata.count{
                cell.update(x:self.alldata[indexPath.row])
            }
            else if self.type == "Video" && indexPath.row < self.videodata.count {
                cell.update(x:self.videodata[indexPath.row])
            }
            else if self.type == "Image" && indexPath.row < self.imagedata.count {
                cell.update(x:self.imagedata[indexPath.row])
            }
            else if self.type == "Audio" && indexPath.row < self.audiodata.count {
                cell.update(x:self.audiodata[indexPath.row])
            }
            else if self.type == "File" && indexPath.row < self.filedata.count {
                cell.update(x:self.filedata[indexPath.row])
            }
            if self.type == "All" {
                if indexPath.row == self.alldata.count - 5 && self.alldata.count < self.basic!.totalpost{
                                 print("Reachedddd End")
                                if canfetchmore == true {
                                 self.loadmore(page: self.pageno)
                                }
                             }
                         }
                         else if self.type == "Video" && self.videodata.count < self.basic!.totalpost{
                             if indexPath.row == self.videodata.count - 5 {
                                  if canfetchmore == true {
                                   self.loadmore(page: self.pageno)
                                  }
                                
                            }
                         }
                         else if self.type == "Image" {
                              if indexPath.row == self.imagedata.count - 5 && self.imagedata.count < self.basic!.totalpost {
                                  if canfetchmore == true {
                                   self.loadmore(page: self.pageno)
                                  }
                                
                            }
                         }
                         else if self.type == "Audio" {
                              if indexPath.row == self.audiodata.count - 5 && self.audiodata.count < self.basic!.totalpost {
                                  if canfetchmore == true {
                                   self.loadmore(page: self.pageno)
                                  }
                                
                            }
                         }
                         else if self.type == "File" {
                              if indexPath.row == self.filedata.count - 5  && self.filedata.count < self.basic!.totalpost{
                                  if canfetchmore == true {
                                   self.loadmore(page: self.pageno)
                                  }
                                
                            }
                         }
            
            return cell
        }
        
             
        
         return UICollectionViewCell()
     }
    
    
    
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("End Reached")
//        if self.type == "All" {
//            if totalpost > self.alldata.count {
//                self.loadmore(page: self.pageno)
//            }
//        }
//        else if self.type == "Video" {
//            if totalpost > self.videodata.count {
//                 self.loadmore(page: self.pageno)
//             }
//        }
//        else if self.type == "Image" {
//            if totalpost > self.imagedata.count {
//                 self.loadmore(page: self.pageno)
//             }
//        }
//        else if self.type == "Audio" {
//            if totalpost > self.audiodata.count {
//                 self.loadmore(page: self.pageno)
//             }
//        }
//        else if self.type == "File" {
//            if totalpost > self.filedata.count {
//                 self.loadmore(page: self.pageno)
//             }
//        }
    }
    
                                
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tappeddata = indexPath.row
        performSegue(withIdentifier: "expandpost", sender: nil)
    }
    

    @IBAction func backpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func allbtnpressed(_ sender: UIButton) {
        self.allbtn.titleLabel!.font = UIFont(name: "ProximaNova-Bold", size: 16)
        self.videobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.photobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.audiobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.filesbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        
        
        self.type = "All"
        if self.alldata.count == 0 {
            fetchprofile(firsttime: true)
        }
        else {
            self.collection.reloadData()
            self.collection.layoutIfNeeded()

        }
    }
    
    
    @IBAction func photobtnpressed(_ sender: UIButton) {
        self.allbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.videobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.photobtn.titleLabel!.font = UIFont(name: "ProximaNova-Bold", size: 16)
           self.audiobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.filesbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.type = "Image"
        if self.imagedata.count == 0 {
            fetchprofile(firsttime: true)
        }
        else {
            self.collection.reloadData()
            self.collection.layoutIfNeeded()
        }
    }
    
    
    @IBAction func videobtnpressed(_ sender: UIButton) {
        self.allbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.videobtn.titleLabel!.font = UIFont(name: "ProximaNova-Bold", size: 16)
           self.photobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.audiobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.filesbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.type = "Video"
        if self.videodata.count == 0 {
            fetchprofile(firsttime: true)
        }
        else {
            self.collection.reloadData()
            self.collection.layoutIfNeeded()
            

        }
    }
    
    
    @IBAction func audiobtnpressed(_ sender: UIButton) {
        self.allbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.videobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.photobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
           self.audiobtn.titleLabel!.font = UIFont(name: "ProximaNova-Bold", size: 16)
           self.filesbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        self.type = "Audio"
        if self.audiodata.count == 0 {
            fetchprofile(firsttime: true)
        }
        else {
            self.collection.reloadData()
            self.collection.layoutIfNeeded()
        }
    }
    
    
    @IBAction func filesbtnpressed(_ sender: UIButton) {
        self.allbtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 8)
           self.videobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 8)
           self.photobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 8)
           self.audiobtn.titleLabel!.font = UIFont(name: "NeusaNextStd-Light", size: 8)
           self.filesbtn.titleLabel!.font = UIFont(name: "ProximaNova-Bold", size: 16)
        self.type = "File"
        if self.filedata.count == 0 {
            fetchprofile(firsttime: true)
        }
        else {
            self.collection.reloadData()
            self.collection.layoutIfNeeded()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? EditProfileDetailsViewController {
            seg.sendfeedback = {a in
                if(a) {
                    self.fetchprofile(firsttime: false)
                }
            }
            seg.passedprofile = self.basic
        }
        
        
        if let seg = segue.destination as? Editprofile1ViewController {
            seg.fn = self.firstname.attributedText
            if let i = self.profileimage.image {
                seg.profimage = i
            }
            seg.passedprofile = self.basic
            seg.further = { a in
                if a {
                    self.fetchprofile(firsttime: false)
                }
            }
        }
        
        
        if let seg = segue.destination as? ProfileTablePostsViewController {
            if self.type == "All" {
                seg.passeddata = self.alldata
            }
            else if self.type == "Video" {
                seg.passeddata = self.videodata
            }
            else if self.type == "Image" {
                seg.passeddata = self.imagedata
            }
            else if self.type == "Audio" {
                seg.passeddata = self.audiodata
            }
            else if self.type == "File" {
                seg.passeddata = self.filedata
            }
            
            seg.cat = self.type
            seg.currentindex = self.tappeddata
            
        }
        
        
    }
    

}
