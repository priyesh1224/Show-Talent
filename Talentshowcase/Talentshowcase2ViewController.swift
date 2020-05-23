//
//  Talentshowcase2ViewController.swift
//  ShowTalent
//
//  Created by maraekat on 20/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit

struct videopost
{
    var activityid : Int
    var activitypath : String
    var category : String
    var descrip : String
    var id:String
    var images:[String]
    var like:Int
    var likebyme : [like]
    var profileimg : String
    var profilename : String
    var publichon : String
    var title : String
    var type: String
    var userid : String
    var views : Int
    var comments : [commentinfo]
    var thumbnail : String
    var status : Bool
}

struct commentinfo
{
    var activityid : Int
    var comment : String
    var commentid : Int
    var id  :String
    var ondate : String
    var profilename : String
    var profileimage : String
    var replycomments : [commentinfo]? //change it to commentinfo later on
    var userid : String
    var status : String // Main or Replied comment
}

struct like {
    var activityid : Int
    var id : String
    var ondate : String
    var profilename : String
    var profileimage : String
    var userid : String
}

class Talentshowcase2ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate , UIScrollViewDelegate{
    

    
    @IBOutlet weak var progressviewheight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var progressview: UIView!
    
    @IBOutlet weak var progressviewlabel: UILabel!
    
    @IBOutlet weak var navigationindicator: UIView!
    
    @IBOutlet weak var popupbtn: UIButton!
    
    @IBOutlet weak var screentitle: UILabel!
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var progressindicatorview: UIView!
    
    
    @IBOutlet weak var progressindicatorwidth: NSLayoutConstraint!
    
    @IBOutlet weak var addfilepopup: UIView!
    
    @IBOutlet weak var popupheight: NSLayoutConstraint!
    
    var alldata : [videopost] = []
    var contactlisttobepassed : [commentinfo] = []
    var liketobepassed : [like] = []
    var mode = ""
    var postid = 0
    static var cachepostthumbnail = NSCache<NSString,UIImage>()
    static var cachepostprofileimage = NSCache<NSString,UIImage>()
    static var cachepostvideo = NSCache<NSString,AVURLAsset>()
    
    var cat = "Video"
    var tapped = ""
    var page = 0
    
    var oldcount = 0
    var canfetchmore = true
    var uselesslock = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupheight.constant = self.view.frame.size.height / 2.5
        self.progressviewheight.constant = 0

        
        self.addfilepopup.layer.cornerRadius = 10
        self.progressview.isHidden = true
        self.addfilepopup.isHidden = true
        setupview()
        self.screentitle.text = self.cat.capitalized
        
            
        self.collection.isHidden = true
        
        collection.delegate = self
        collection.dataSource = self
        collection.delegate = collection.dataSource as! UICollectionViewDelegate
        self.collection.reloadData()
        self.collectionheight.constant = self.view.frame.size.height/4.8
        table.delegate = self
        table.dataSource = self
        self.progressindicatorview.layer.cornerRadius = 5
        DispatchQueue.global(qos: .userInitiated).async {
            self.modifiedfetch { (ans) in
                if ans {
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
            }
        }

        
        
        
        
        // Do any additional setup after loading the view.
    }
    typealias videosfetched = (_ x : Bool) -> Void
    func modifiedfetch(a:@escaping videosfetched)
    {
         if canfetchmore == true
        {
            self.uselesslock = false
            liketobepassed = []
            let params : Dictionary<String,Int> = ["Page":self.page,"PageSize":9]
            self.page = self.page + 1
            let userid = UserDefaults.standard.value(forKey: "refid") as! String
            var url = Constants.K_baseUrl + Constants.activitydata + "\(userid),\(cat)"
            var r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: params) { (data, err) in
            if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
            if let usefuldata = resv["Results"] as? [AnyObject] {
            if usefuldata.count == 0 {
                self.canfetchmore = false
            }
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
                                    
                                    
                                    var x = videopost(activityid: avii, activitypath: avpp, category: catt, descrip: dess, id: iddd, images: imagess, like: likee, likebyme: self.liketobepassed, profileimg: profimagee, profilename: profnamee, publichon: pbonn, title: titlee, type: typee, userid: u_idd, views: vww, comments: cmntss, thumbnail: tmbb,status: currstatus)
                                    self.alldata.append(x)
                                }

                            }
                            a(true)
           
                    }
                }
                
                
            }
            }
    }
    
    @IBAction func closepopuppressed(_ sender: Any) {
        self.addfilepopup.isHidden = true
    }
    
    @IBAction func popupshowtappedtg(_ sender: UITapGestureRecognizer) {
        self.addfilepopup.isHidden = false
    }
    
    
    @IBAction func sidebarpressed(_ sender: UIButton) {
        self.addfilepopup.isHidden = false

    }
    
    
    @IBAction func popuppressed(_ sender: UIButton) {
        self.addfilepopup.isHidden = false
    }
    
   
    

    
    func textFieldDidBeginEditing(textField: UITextField) {
            self.animateViewMoving(up: true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
            self.animateViewMoving(up: false, moveValue: 100)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:TimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    
    
    func setupview()
    {
    self.navigationindicator.layer.cornerRadius = 10
        self.popupbtn.layer.cornerRadius = 30
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "talentcollection", for: indexPath) as? TalentshowcaseCollectionViewCell {
            cell.updatecell()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 500.0, height: 100.0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            self.oldcount = self.alldata.count
            return self.alldata.count
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        if self.cat == "Video"
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "talenttable", for: indexPath) as? TalentshowcaseTableViewCell {
                cell.selectionStyle = .none
                cell.commentfield.delegate = self
                
            
                
                if self.alldata.count > indexPath.row {
                cell.update(x: self.alldata[indexPath.row])
                }
                
                
                
                cell.togglelike = {pos,likestatus in
                
                    
                    for var index in 0..<self.alldata.count {
                        if self.alldata[index].activityid == pos.activityid {
                            self.alldata[index].status = !self.alldata[index].status
                            if !self.alldata[index].status == true {
                                self.alldata[index].like = self.alldata[index].like - 1
                                
                                for var lki in 0..<self.alldata[index].likebyme.count {
                                        if self.alldata[index].likebyme[lki].userid == userid {
                                            self.alldata[index].likebyme.remove(at: lki)
                                        }
                                    
                                }
                                
                                
                           
                            }
                            else {
                                self.alldata[index].like = self.alldata[index].like + 1
                                
                                
                                self.alldata[index].likebyme.append(like(activityid: self.alldata[index].activityid, id: self.alldata[index].id, ondate: "", profilename: "Auth user to be replace with", profileimage: "", userid: userid))
                                
                                
                            
                            }
                            break
                        }
                    }
                                    
                //                    self.table.reloadRows(at: [indexPath], with: .none)
            }

                
                cell.onSeeAllcomments = {gotdata , iid in
                    
                    self.mode = "comments"
                    self.postid = iid
                    self.contactlisttobepassed = gotdata.comments
                    self.performSegue(withIdentifier: "taketoallcomments", sender: nil)
                }
                cell.onSeeAlllikes = {gotdata in
                    
                    self.mode = "likes"
                    self.liketobepassed = gotdata.likebyme
                    self.performSegue(withIdentifier: "taketoallcomments", sender: nil)
                }
                cell.commentposted = {st in
                   
                    if let sst = st as? commentinfo {
                        for var ec in self.alldata {
                            if ec.activityid == st!.activityid {
                                ec.comments.append(sst)
    //                            self.table.reloadRows(at: [indexPath], with: .automatic)
                                break
                            }
                        }
                        
    //                    self.fetchdata()
                    }
                }
                
        
               
                
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Displaying \(indexPath.row)")
         if self.cat == "Video" {
            if self.alldata.count < 5 && self.page >= 2 {
                self.canfetchmore = false
            }
            print("page outside data count is \(self.alldata.count) with page \(self.page)")
           

            if indexPath.row == self.alldata.count - 5 && self.canfetchmore == true && self.uselesslock == true {
                                print("page actual data count is \(self.alldata.count) \(indexPath.row)")
                
                DispatchQueue.global(qos: .userInitiated).async {
                    self.modifiedfetch { (ans) in
                        if ans {
                            DispatchQueue.main.async {
                                self.table.reloadData()
                            }
                        }
                    }
                }
//                DispatchQueue.global(qos: .background).async {
//                    self.fetchdata()
//                }

            }
                        }
        
                if indexPath.row == self.alldata.count - 1 {
                       self.uselesslock = true
                   }
        
        if self.page >= 2 && indexPath.row == self.alldata.count - 5 {
             self.uselesslock = true
        }
    
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
       
        if self.view.frame.size.height/1.18 < 700 {
            return 700
        }
        return self.view.frame.size.height/1.18
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TalentshowcaseTableViewCell {
            if self.cat == "Video" && self.alldata.count > indexPath.row {
                if let p = cell.player {
                    p.pause()
            
                }
            }
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
//        for k in 0..<alldata.count {
//            if((table.indexPathsForVisibleRows?.contains(IndexPath(row: k, section: 0)))!) {
//                print("\(k) cell is on screen")
//            }
//        }
        if cat == "Video"
        {
        for k in 0..<alldata.count {
            if(!(table.indexPathsForVisibleRows?.contains(IndexPath(row: k, section: 0)))!) {
                if let tc =  table.cellForRow(at: IndexPath(row: k, section: 0)) as? TalentshowcaseTableViewCell {
                    if let ttc = tc.player {
                        ttc.pause()
                        ttc.isMuted = true
                    }
                    tc.playbtn.setTitle("Play", for: .normal)
               
                }
            }
        }
        }
    }
    
    
    
    
    func fetchdata()
    {
        
        print("Fetching Again for page \(self.page)")
        
        
        if self.page == 1 {
            
        }
        
        if canfetchmore == true
        {
//        if self.cat == "Video" {
//            alldata = []
//        }
//        if self.cat  == "Image" {
//            allimagedata = []
//        }
        self.uselesslock = false
        
        liketobepassed = []
            let params : Dictionary<String,Int> = ["Page":self.page,"PageSize":9]
            self.page = self.page + 1
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        

        
        
        
        var url = Constants.K_baseUrl + Constants.activitydata + "\(userid),\(cat)"
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (data, err) in
            if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                
                if let usefuldata = resv["Results"] as? [AnyObject] {
                    print("Received for page \(self.page - 1) is \(usefuldata.count)")
                                     if usefuldata.count == 0 {
                                         self.canfetchmore = false
                                     }
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
                            
                            
                            var x = videopost(activityid: avii, activitypath: avpp, category: catt, descrip: dess, id: iddd, images: imagess, like: likee, likebyme: self.liketobepassed, profileimg: profimagee, profilename: profnamee, publichon: pbonn, title: titlee, type: typee, userid: u_idd, views: vww, comments: cmntss, thumbnail: tmbb,status: currstatus)
                            
                            
                            if self.cat == "Video" {
                                DispatchQueue.main.async {
                                    self.alldata.append(x)
                                }
                                
                            }
                        
                            

                        }

                    }
                    
                    
                    

                   
                    DispatchQueue.main.async {
                        if self.cat == "Video" {
                            if self.alldata.count > 0 {
                                self.table.reloadData()
                            }
                        }
               

                    }
//                                    if self.cat == "Video" {
//                                           print("Now Data is \(self.alldata.count)")
//                                           if self.oldcount == self.alldata.count {
//                                               self.canfetchmore = false
//                                           }
//                                       }
//
                
            }
        }
        
        
    }
    }
    }
    
    
    @IBAction func uploadnewvideo(_ sender: UIButton) {
        tapped = "video"
        self.addfilepopup.isHidden = true
        performSegue(withIdentifier: "movetoupload", sender: nil)
    }
    
    
    
    @IBAction func uploadnewaudio(_ sender: UIButton) {
    }
    
    
    @IBAction func uploadnewimage(_ sender: UIButton) {
        tapped = "image"
        performSegue(withIdentifier: "movetoupload", sender: nil)
    }
    
    
    
    @IBAction func uploadnewfile(_ sender: UIButton) {
        tapped = "file"
        performSegue(withIdentifier: "movetoupload", sender: nil)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let seg = segue.destination as? PostVideoViewController {
            seg.type = self.tapped
            seg.sendprogress = {a in

                DispatchQueue.main.async{
                    
                    self.progressviewheight.constant = 120
                    self.progressview.isHidden = false
                    var per = Int(a.fractionCompleted * 100)
                    
                    
                    var totaltofollow = self.progressview.frame.size.width - 32
                    var bringto = per/100 * Int(totaltofollow)
                    UIView.animate(withDuration: 1) {
                        self.progressindicatorwidth.constant = CGFloat(bringto)
                    }
                    
                    
                    
                    self.progressviewlabel.text = "\(per) % uploaded"
                    if per == 100 {
                        self.progressviewheight.constant = 0
                        self.alldata = []
                        self.page = 0
                       DispatchQueue.global(qos: .userInitiated).async {
                           self.modifiedfetch { (ans) in
                               if ans {
                                   DispatchQueue.main.async {
                                       self.table.reloadData()
                                   }
                               }
                           }
                       }
                        
                    }
                }
            }
        }
        
        
        
        if let seg = segue.destination as? AllcommentsViewController {
            seg.mode = self.mode
            if mode == "comments" {
//                seg.allcomments = self.contactlisttobepassed
                
                seg.postid = self.postid
            }
            else if mode == "likes" {
                seg.alllikes = self.liketobepassed
            }
        }
      }
    }





