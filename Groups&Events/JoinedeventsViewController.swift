//
//  JoinedeventsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 22/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit





struct comment
{
    var id : String
    var comentid : Int
    var activityid : Int
    var profilename : String
    var profileimage : String
    var userid : String
    var usercomment : String
    var ondate : String
    var replycomments : [comment]
    var status : String
    
}


struct feeds {
    var id : String
    var profileimg : String
    var profilename : String
    var thumbnail : String
    var acticityid : Int
    var userid : String
    var activitypath : String
    var type : String
    var category : String
    var views : Int
    var likes : Int
    var title : String
    var description : String
    var publishedon : String
    var categoryid : Int
    var contestid : Int
    var likedbyme : Bool
    var likebyme : [like]
    var comments : [comment]
    var totalreview : Int
}

struct pricewinnerwise
{
    var id : Int
    var position : Int
    var amount : Int
}

class JoinedeventsViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    
    var juryeditmode = "new"
    
    var tablemode = "details"
    
    
    @IBOutlet weak var nopostswarning: UILabel!
    @IBOutlet weak var postpendingwarning: UIView!
    @IBOutlet weak var showcontestdetails: UIButton!
    
    @IBOutlet weak var showcontestposts: UIButton!
    
    
    static var holder : Dictionary<String,UIImage> = [:]
    
    static var justuploaded : ((_ done : Bool) -> Void)?

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var editcontestdetails: CustomButton!
    
    @IBOutlet weak var popupview: UIView!
    
    @IBOutlet weak var coverview: UIView!
    @IBOutlet weak var popupviewheight: NSLayoutConstraint!
    
    @IBOutlet var latesteditbtn: UIButton!
    
    @IBOutlet weak var eventimage: UIImageView!
    @IBOutlet weak var eventimageheight: NSLayoutConstraint!
    static var participatebtnpressedanswer : ((_ pressed : Bool) -> ())?
    var timetopublish = false
    
    var dangeringoingback = false
    var themeid = 0
    var performancetypeid = 0
    var genderid = 0
    var tappedpostid = 0
    var tappedcommentlist : [comment] = []
    var player : AVPlayer!
    var avplayeritem : AVPlayerItem!
    
    var audio : AVAudioPlayer?
    var catname = ["dance","mimicry","music band","story telling","singing","acting"]
    var postbtncolor = ["#012C5E","#012C5E","006F9A","#62AA3C","012C5E","#348FDF"]
    var celltype = ["two","three","four","six","five","one"]
    var primarycoloroptions = ["#410014","#0F0515","#000000","#0ABCD8","#00C5CC","#07EAC3"]
    var secondarycoloroptions = ["#011C39","#16069C","#DC2E23","#4CC100","#004784","#16069C"]
    var primarycolor = UIColor(red: 85/255, green: 190/255, blue: 216/255, alpha: 1)
    var secondarycolor = UIColor(red: 91/255, green: 180/255, blue: 99/255, alpha: 1)
    var insidecolors : Dictionary<String,Dictionary<String,Dictionary<String,Any>>> = [:]
    var allwinnersexistingprices : [pricewinnerwise] = []
    var currentcelltype = "one"
    var currentpostbtncolor = ""
    @IBOutlet weak var deletebtn: UIButton!
    let gradientLayer = CAGradientLayer()
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var totalparticpants = 0

    var typeofpost = "image"
    var pickedcontent = ""
    var eventid = 1248
    var groupid = 0
    var feedidtobepassed = 0
    var eventjoined : strevent?
    var currentevent : strevent?
    var joined = true
    var joinstatus = true
    var contestimage = ""
    var contestvideo = ""
    var contestthumbnail = ""
    var contestfiletype = "image"
    var mode = "approved"
    var allwinners : [juryorwinner] = []
    var categoryselected = "dance"
    var tthemename = "hip hop"
    
    var participantscount = 0
    var reviewscounnt = 0
    var isallowedtopost = false
    
    var allfeeds : [feeds] = []
    var ownereventid = 0
    var loadthisvideo = false
    var videoallowed = false
    
    var performancetype = ""
    var gender = ""
    var winnerscount = 0
    
    
    @IBOutlet weak var backbtnbehindview: UIView!
    
    
   
    
    @IBOutlet var editlayer: Shadowedbuttonview!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        JoinedeventsViewController.holder.removeAll()
        nopostswarning.isHidden = true
        if self.tthemename.lowercased() == "hip-hop" {
            self.tthemename = "hip hop"
        }
        self.showcontestdetails.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        self.editlayer.isHidden = false
        var xt : Dictionary<String,Dictionary<String,Any>> = ["jazz" : ["primary" : "#000000" , "secondary" : "#644761"] , "hip hop" : ["primary" : "#644761" , "secondary" : "#2C1C00"] ,  "cultural dance" : ["primary" : "#171D1A" , "secondary" : "#171D1A"] ]
        
               var yt : Dictionary<String,Dictionary<String,Any>> = ["one act play" : ["primary" : "#060029" , "secondary" : "#232323"] , "group play" : ["primary" : "#171A1A" , "secondary" : "#171A1A"] ,  "other" : ["primary" : "#172524" , "secondary" : "#172524"] ]
        
               var zt : Dictionary<String,Dictionary<String,Any>> = ["solo singing" : ["primary" : "#3F4551" , "secondary" : "#0D0E10"] , "karoke" : ["primary" : "#0D7972" , "secondary" : "#000000"] ,  "sing with instrument" : ["primary" : "#101010" , "secondary" : "#00317A"] ]
        
               var at : Dictionary<String,Dictionary<String,Any>> = ["standup comedy" : ["primary" : "#78694F" , "secondary" : "#171D1A"] , "voice artist" : ["primary" : "#78694F" , "secondary" : "#340202"] ,  "puppeteer" : ["primary" : "#060029" , "secondary" : "#232323"] ]
        
               var bt : Dictionary<String,Dictionary<String,Any>> = ["comedy" : ["primary" : "#172524" , "secondary" : "#172524"] , "tragedy" : ["primary" : "#171825" , "secondary" : "#171825"] ,  "other" : ["primary" : "#171D1A" , "secondary" : "#171D1A"] ]
        
               var ct : Dictionary<String,Dictionary<String,Any>> = ["concert band" : ["primary" : "#0F1F2F" , "secondary" : "#0F1F2F"] , "school band" : ["primary" : "#2F0F0F" , "secondary" : "#2F0F0F"] ,  "rock band" : ["primary" : "#001431" , "secondary" : "#001431"] ]
        
        
        
        insidecolors["dance"] = xt
        insidecolors["acting"] = yt
        insidecolors["singing"] = zt
        insidecolors["mimicry"] = at
        insidecolors["story telling"] = bt
        insidecolors["music band"] = ct
        
        
        for var k in 0 ..< catname.count {
            if catname[k] == self.categoryselected.lowercased() {
                self.currentcelltype = celltype[k]
                self.currentpostbtncolor = postbtncolor[k]
            }
        }
        
        
        
        if let d = self.insidecolors[categoryselected.lowercased()] as? Dictionary<String,Dictionary<String,Any>> {
            if let e  = d["\(tthemename.lowercased())"] as? Dictionary<String,Any> {
                primarycolor = UIColor(hexString: e["primary"] as! String)
                secondarycolor = UIColor(hexString: e["secondary"] as! String)
                print("Category : \(categoryselected.lowercased()) , theme \(tthemename.lowercased()) primary color : \( e["primary"] as! String) secondary color \(e["secondary"] as! String)")
            }
            else {
                for var k in 0 ..< self.catname.count {
                    if categoryselected.lowercased() == catname[k]
                    {
                        primarycolor = UIColor(hexString: primarycoloroptions[k])
                        secondarycolor = UIColor(hexString: secondarycoloroptions[k])
                                        print("Category : \(categoryselected.lowercased()) , theme \(tthemename.lowercased()) primary color : \( primarycoloroptions[k]) secondary color \(secondarycoloroptions[k])")
                    }
                }
            }
        }
        
        
        self.setTableViewBackgroundGradient(sender: self.table, primarycolor, secondarycolor)
        
        backbtnbehindview.backgroundColor = UIColor.white
        table.delegate = self
        table.dataSource = self
        self.popupview.layer.cornerRadius = 10
        self.popupviewheight.constant = self.view.frame.size.height / 3
        self.popupview.isHidden = true
        self.latesteditbtn.layer.cornerRadius = 17.5
        self.editcontestdetails.layer.cornerRadius = 17.5
        self.deletebtn.isHidden = true
        self.latesteditbtn.layer.borderColor = UIColor.white.cgColor
        self.latesteditbtn.layer.borderWidth = 2
        self.editcontestdetails.layer.borderColor = UIColor.white.cgColor
        self.editcontestdetails.layer.borderWidth = 2
        self.editcontestdetails.isHidden = true
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        
//        eventid = 160
        
        
 
            self.eventsummary { (answ) in
                if answ {
                    
  
                    
                    
                    
                    if self.timetopublish {
                        self.editcontestdetails.isHidden = false
                        self.deletebtn.isHidden = false
                    }
                    else {
                        self.editcontestdetails.isHidden = true
                        self.deletebtn.isHidden = true
                    }
                    
                    
                    if self.eventjoined?.participationpostallow == true {
                       self.postpendingwarning.isHidden = false
                    }
                    else {
                        self.postpendingwarning.isHidden = true
                    }
                    
//                    self.table.reloadData()
                    if self.contestfiletype == "Image" {
                        self.downloadimage(url: self.contestimage) { (im) in
                            if let iim = im as? UIImage {
                                self.eventimage.image = iim
                            }
                        }
                    }
                    else if self.contestfiletype == "Video" {
                        self.downloadimage(url: self.contestthumbnail) { (im) in
                            if let iim = im as? UIImage {
                                self.eventimage.image = iim
                            }
                        }
                        
                        DispatchQueue.global(qos: .utility).async {
                            print(self.contestvideo)
                            self.downloadvideo(url: self.contestimage) { (play) in
                                DispatchQueue.main.async {
                                    if play?.status == .readyToPlay {
                                        play?.play()
                                        self.eventimage.isHidden = true
                                    }
                                    
                                    
                                }
                            }
                        }
                        
                    }
                    
                    
                    self.fetchfeeds { (ad) in
                        if ad {
                            self.table.reloadData()
                            
                        }
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    }
                    

                    
                    
                    
                }
                else {
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                }
            }

        
        
        
        
        
        
        self.eventimageheight.constant = self.view.frame.size.height/3.5
        
        

    }
    
    
    func setTableViewBackgroundGradient(sender: UITableView, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        //        sender.backgroundView = backgroundView
    }
    
    
    
    @IBAction func showcontestdetailspressed(_ sender: Any) {
        self.tablemode = "details"
        self.showcontestdetails.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        self.showcontestposts.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        self.table.reloadData()
        if self.allfeeds.count == 0 && self.tablemode != "details" {
            self.nopostswarning.isHidden = false
        }
        else {
            self.nopostswarning.isHidden = true
        }
    }
    
    
    
    
    @IBAction func showcontestpostspressed(_ sender: Any) {
        self.tablemode = "posts"
        self.showcontestdetails.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        self.showcontestposts.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        self.gradientLayer.removeFromSuperlayer()
        self.table.reloadData()
        if self.allfeeds.count == 0 && self.tablemode != "details" {
            self.nopostswarning.isHidden = false
        }
        else {
            self.nopostswarning.isHidden = true
        }
    }
    
    
    
    
    
    typealias videosfetched = (_ x : AVPlayer?) -> Void
    
    func downloadvideo(url :String,a : @escaping videosfetched)
    {
        
        if (player != nil) {
            
            player = nil;
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: .mixWithOthers)
        } catch {
            print(error.localizedDescription)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndedPlaying), name: Notification.Name("AVPlayerItemDidPlayToEndTimeNotification"), object: nil)
        
        
        
        if let avs = Talentshowcase2ViewController.cachepostvideo.object(forKey: url as NSString) as? AVURLAsset {
            avplayeritem = AVPlayerItem(asset: avs)
        }
        else  {
            let avasset = AVURLAsset.init(url: (NSURL(string: url) as! URL))
            if let avv = AVPlayerItem(asset: avasset) as? AVPlayerItem {
                avplayeritem = avv
                Talentshowcase2ViewController.cachepostvideo.setObject(avasset, forKey: url as NSString)
            }
            
        }
        
        
        //        player = AVPlayer(url: (NSURL(string: url) as! URL))
        
        player = AVPlayer(playerItem: avplayeritem)
        player.isMuted = true
        //        player.automaticallyWaitsToMinimizeStalling = true
        var layer = AVPlayerLayer(player: player)
        
        
        DispatchQueue.main.async {
            layer.backgroundColor = UIColor.black.cgColor
            layer.videoGravity = AVLayerVideoGravity.resizeAspect
            
            
            layer.frame = CoreGraphics.CGRect(x: self.coverview.frame.origin.x,
                                              y: 0,
                                              width: self.coverview.frame.size.width,
                                              height: self.view.frame.size.height/3.5
            )
            //        layer.bounds.size.height = 170
            layer.cornerRadius = 0
            layer.masksToBounds = true
            
            self.coverview.clipsToBounds = true
            
            self.coverview.layer.insertSublayer(layer, at: 0)
            self.coverview.layer.insertSublayer(self.editlayer.layer, at: 1)
        }
        
        if let p = self.player {
            a(p)
        }
        else {
            a(nil)
        }
        
        
        
        
    }

    @objc func playerEndedPlaying(_ notification: Notification) {
        DispatchQueue.main.async {[weak self] in
            self!.player?.seek(to: CMTime.zero)
            self!.player?.play()
            //        self!.playbtn.setTitle("Play", for: .normal)
        }
    }
    
    @IBAction func editmyevent(_ sender: Any) {
        self.performSegue(withIdentifier: "ownerevent", sender: nil)
    }
    
    
    @IBAction func deletebtntapped(_ sender: Any) {
        
        
        let alert2 = UIAlertController(title: "Delete Contest", message: "Are you sure you want to delete this contest ? ", preferredStyle: .actionSheet)
        alert2.addAction(UIAlertAction(title: "Delete contest", style: .default, handler: { _ in
            
        
            var url = "\(Constants.K_baseUrl)\(Constants.deletecontest)?id=\(self.eventid)"
            print(url)

            var r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: [:]) { (response, err) in
                if let res = response?.result.value as? Dictionary<String,Any> {
                    print(res)
                    if let code = res["ResponseStatus"] as? Int {
                        if code == 0 {
                                    let alert3 = UIAlertController(title: "Contest Deleted", message: "", preferredStyle: .actionSheet)
                            alert3.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                self.performSegue(withIdentifier: "backtozero", sender: nil)
                            }))
                            self.present(alert3, animated: true, completion: nil)
                            
                            
                        }
                    }
                }
            }
            
            
        }))
        
        alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert2, animated: true, completion: nil)
        
       
        
        
    }
    
    
    typealias progressindata = ((_ done : Bool) -> Void)
    
    
    
    func fetchfeeds(d : @escaping progressindata)
    {
      
        let url = "\(Constants.K_baseUrl)\(Constants.contestfeeds)?contestId=\(self.eventid)"
        
        let useid = UserDefaults.standard.value(forKey: "refid") as! String
        var params : Dictionary<String,Any> = [  "Page": 0,"PageSize": 10]
        print(url)
        print(params)
        let r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String, Any> {
                print(res)
                if let data = res["Results"] as? [Dictionary<String,Any>] {
                    for each in data {
                        
                        print(each)
                        print("--------------------")
                        var id  = ""
                           var profileimg  = ""
                           var profilename  = ""
                           var thumbnail  = ""
                           var acticityid  = 0
                           var userid  = ""
                           var activitypath  = ""
                           var type = ""
                           var category = ""
                           var views = 0
                           var likes = 0
                           var title = ""
                           var description = ""
                           var publishedon = ""
                           var categoryid = 0
                           var contestid = 0
                        var totalreview = 0
                            var lbyme = false
                        var cmmmt : [comment] = []
                        if let p = each["Id"] as? String {
                            profileimg = p
                        }
                        if let p = each["TotalReview"] as? Int {
                            totalreview = p
                        }
                        if let p = each["ProfileImg"] as? String {
                            profileimg = p
                        }
                        if let p = each["ProfileName"] as? String {
                            profilename = p
                        }
                        if let p = each["thumbnail"] as? String {
                            thumbnail = p
                        }
                        if let p = each["ActivityId"] as? Int {
                            acticityid = p
                        }
                        if let p = each["UserId"] as? String {
                            userid = p
                        }
                        if let p = each["ActivityPath"] as? String {
                            activitypath = p
                        }
                        if let p = each["comments"] as? [Dictionary<String,Any>] {
                            for each in p {
                                
                                var id = ""
                                var cid = 0
                                var  aid = 0
                                var pname = ""
                                var pimage = ""
                                var uid = ""
                                var ucomment = ""
                                var ondate = ""
                                var replycomm : [comment] = []
                                if let s =  each["Id"] as? String {
                                    id = s
                                }
                                if let s =  each["CommentId"] as? Int {
                                    cid = s
                                }
                                if let s =  each["ActivityId"] as? Int {
                                    aid = s
                                }
                                if let s =  each["ProfileName"] as? String {
                                    pname = s
                                }
                                if let s =  each["ProfileImage"] as? String {
                                    pimage = s
                                }
                                if let s =  each["UserID"] as? String {
                                    uid = s
                                }
                                if let s =  each["UserComment"] as? String {
                                    ucomment = s
                                }
                                if let s =  each["Ondate"] as? String {
                                    ondate = s
                                }
                                if let s =  each["ReplyComments"] as? [Dictionary<String,Any>] {
                                    for each in s {
                                        var id = ""
                                        var cid = 0
                                        var  aid = 0
                                        var pname = ""
                                        var pimage = ""
                                        var uid = ""
                                        var ucomment = ""
                                        var ondate = ""
                                        var replycomm : [comment] = []
                                        if let s =  each["Id"] as? String {
                                            id = s
                                        }
                                        if let s =  each["CommentId"] as? Int {
                                            cid = s
                                        }
                                        if let s =  each["ActivityId"] as? Int {
                                            aid = s
                                        }
                                        if let s =  each["ProfileName"] as? String {
                                            pname = s
                                        }
                                        if let s =  each["ProfileImage"] as? String {
                                            pimage = s
                                        }
                                        if let s =  each["UserID"] as? String {
                                            uid = s
                                        }
                                        if let s =  each["UserComment"] as? String {
                                            ucomment = s
                                        }
                                        if let s =  each["Ondate"] as? String {
                                            ondate = s
                                        }
                                        if let s =  each["ReplyComments"] as? [Dictionary<String,Any>] {
                                            
                                            
                                        }
                                        var cm = comment(id: id, comentid: cid, activityid: aid, profilename: pname, profileimage: pimage, userid: uid, usercomment: ucomment, ondate: ondate, replycomments: [] , status: "reply")
                                        replycomm.append(cm)
                                        
                                    }
                                    
                                }
                                var cm = comment(id: id, comentid: cid, activityid: aid, profilename: pname, profileimage: pimage, userid: uid, usercomment: ucomment, ondate: ondate, replycomments: replycomm, status: "main")
                                cmmmt.append(cm)
                                
                            }
                        }
                        
                        
                        
                        if let p = each["Type"] as? String {
                                type = p
                            }
                            if let p = each["Category"] as? String {
                                category = p
                            }
                            if let p = each["View"] as? Int {
                                views = p
                            }
                            if let p = each["Like"] as? Int {
                                likes = p
                            }
                            if let p = each["Title"] as? String {
                                title = p
                            }
                            if let p = each["Description"] as? String {
                                description = p
                            }
                        
                        
                        
                        if let cn = each["TotalReview"] as? Int
                        {
                            self.reviewscounnt = cn
                        }
                        if let cn = each["TotalParticipation"] as? Int
                        {
                            self.participantscount = cn
                        }
                        if let cn = each["ParticipantPostAllow"] as? Bool
                        {
                            self.isallowedtopost = cn
                        }
                        
                        
                        
                        
                            if let p = each["PublishOn"] as? String {
                                publishedon = p
                            }
                        if let p = each["CategoryId"] as? Int {
                                   categoryid = p
                               }
                               if let p = each["ContestId"] as? Int {
                                   contestid = p
                               }
                        
                        var liketobepassed : [like] = []
                        var currstatus = false
                        
                        if let likedbyme = each["LikeByMe"] as? [Dictionary<String,AnyObject>] {
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

                        
                       
                        
                        var x = feeds(id: id, profileimg: profileimg, profilename: profilename, thumbnail: thumbnail, acticityid: acticityid, userid: userid, activitypath: activitypath, type: type, category: category, views: views, likes: likes, title: title, description: description, publishedon: publishedon, categoryid: categoryid, contestid: contestid, likedbyme: currstatus, likebyme: liketobepassed, comments: cmmmt, totalreview: totalreview)
                        self.allfeeds.append(x)
                        
                        
                        
                        
                    }
                    
                    if self.allfeeds.count == 0 && self.tablemode != "details" {
                         self.nopostswarning.isHidden = false
                    }
                    else {
                         self.nopostswarning.isHidden = true
                    }
                    
                    
                    if let ev = self.eventjoined as? strevent {
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    }
                    d(true)
                }
            }
        }
    }
    
    
    
    func eventsummary(done : @escaping progressindata)
    {
        
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var url = "\(Constants.K_baseUrl)\(Constants.getparticularevent)?contestId=\(self.eventid)&participentUserId=\(userid)"
        var params : Dictionary<String,Any> = ["contestId": self.eventid]
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        print(params)
        print(url)
        let r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let each = res["Results"] as? Dictionary<String,Any> {
                    var contestid = 0
                    var contestname = ""
                    var allowcategoryid = 0
                    var allowcategory = ""
                    var organisationallow = false
                    var invitationtypeid = 0
                    var invitationtype = ""
                    var entryallowed = 0
                    var entrytype = ""
                    var entryfee = 0
                    var conteststart = ""
                    var contestlocation = ""
                    var description = ""
                    var resulton = ""
                    var contestprice = ""
                    var contestwinnerpricetypeid = 0
                    var contestpricetype = ""
                    var resulttypeid = 0
                    var resulttype = ""
                    var userid = ""
                    var groupid = 0
                    var createon = ""
                    var isactive = false
                    var status = false
                    var runningstatusid = 0
                    var runningstatus = ""
                    var juries : [juryorwinner] = []
                    var cim  = ""
                    var contestimage = ""
                    
                    
                    if let cn = each["ThemeId"] as? Int {
                        self.themeid = cn
                    }
                    if let cn = each["PerformanceTypeId"] as? Int {
                        self.performancetypeid = cn
                    }
                    if let cn = each["Gender"] as? Int {
                        self.genderid = cn
                    }
                    
                    
                    
                    if let cn = each["ContestId"] as? Int {
                        contestid = cn
                        self.ownereventid = cn
                    }
                    if let cn = each["GroupId"] as? Int {
                        
                        self.groupid = cn
                    }
                    if let cn = each["IsActive"] as? Bool {
                        
                        self.timetopublish = !cn
                        
                    }
                    
                    if let cn = each["ContestName"] as? String {
                        contestname = cn
                    }
                    if let cn = each["AllowCategoryId"] as? Int {
                        allowcategoryid = cn
                    }
                    if let cn = each["AllowCategory"] as? String {
                        allowcategory = cn
                    }
                    if let cn = each["OrganizationAllow"] as? Bool {
                        organisationallow = cn
                    }
                    if let cn = each["InvitationTypeId"] as? Int {
                        invitationtypeid = cn
                    }
                    if let cn = each["InvitationType"] as? String {
                        invitationtype = cn
                    }
                    if let cn = each["EntryAllowed"] as? Int {
                        entryallowed = cn
                    }
                    if let cn = each["EntryType"] as? String {
                        entrytype = cn
                    }
                    if let cn = each["EntryFee"] as? Int {
                        entryfee = cn
                    }
                    if let cn = each["ContestStart"] as? String {
                        conteststart = cn
                    }
                    if let cn = each["ContestLocation"] as? String {
                        contestlocation = cn
                    }
                    if let cn = each["Description"] as? String {
                        description = cn
                    }
                    if let cn = each["TotalParticipation"] as? Int {
                        self.totalparticpants = cn
                    }
                    if let p = each["Winners"] as? [Dictionary<String,Any>] {
                        for each in p {
                            var id = 0
                            var userid = ""
                            var name = ""
                            var profile = ""
                            var price = 0
                            var position = 0
                            if let i = each["ID"] as? Int {
                                id = i
                            }
                            if let i = each["Price"] as? Int {
                                price = i
                            }
                            if let i = each["UserId"] as? String {
                                userid = i
                            }
                            if let i = each["Name"] as? String {
                                name = i
                            }
                            if let i = each["Profile"] as? String {
                                profile = i
                            }
                            if let i = each["Position"] as? Int {
                                position = i
                            }
                            var x = juryorwinner(id: id, userid: userid, name: name, profile: profile , price: price , position: position)
                            self.allwinners.append(x)
                            
                        }
                    }
                    print("All winners")
                    print(self.allwinners)
                    
                    if let p = each["WinnerWisePrices"] as? [Dictionary<String,Any>] {
                        for each in p {
                            var id = 0
                            var price = 0
                            var position = 0
                           
                            if let i = each["ID"] as? Int {
                                id = i
                            }
                            if let i = each["Price"] as? Int {
                                price = i
                            }
                            if let i = each["Position"] as? Int {
                                position = i
                            }
                            var x = pricewinnerwise(id: id, position: position, amount: price)
                           
                            self.allwinnersexistingprices.append(x)
                            
                        }
                    }

                    if let cn = each["ResultOn"] as? String {
                        resulton = cn
                    }
                    if let cn = each["ContestPrice"] as? String {
                        contestprice = cn
                    }
                    if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                        contestwinnerpricetypeid = cn
                    }
                    if let cn = each["ContestWinnerPriceType"] as? String {
                      contestpricetype  = cn
                    }
                    if let cn = each["ResultTypeId"] as? Int {
                        resulttypeid = cn
                    }
                    if let cn = each["ResultType"] as? String {
                        resulttype = cn
                    }
                    if let cn = each["UserId"] as? String {
                        userid = cn
                        var ouserid = UserDefaults.standard.value(forKey: "refid") as! String
                        if ouserid == userid {
                            self.editlayer.isHidden = false
                        }
                        else {
                            self.editlayer.isHidden = true
                        }
                    }
                    if let cn = each["GroupId"] as? Int {
                        groupid = cn
                    }
                    if let cn = each["CreateOn"] as? String {
                        createon = cn
                    }
                    if let cn = each["IsActive"] as? Bool {
                        isactive = cn
                    }
                    if let cn = each["Status"] as? Bool {
                        status = cn
                    }
                    if let cn = each["RunningStatusId"] as? Int {
                        runningstatusid = cn
                    }
                    if let cn = each["RunningStatus"] as? String {
                        runningstatus = cn
                    }
                    if let cn = each["ContestImage"] as? String {
                        self.contestimage = cn
                    }

                    if let cn = each["Juries"] as? [Dictionary<String,Any>] {
                        for each in cn {
                            var id = 0
                            var userid = ""
                            var name = ""
                            var profile = ""
                            if let i = each["ID"] as? Int {
                                id = i
                            }
                            if let i = each["UserID"] as? String {
                                userid = i
                            }
                            if let i = each["Name"] as? String {
                                name = i
                            }
                            if let i = each["Profile"] as? String {
                                profile = i
                            }
                            var x = juryorwinner(id: id, userid: userid, name: name, profile: profile)
                            juries.append(x)
                            
                        }
                    }
                    
                    if let cn = each["Joined"] as? Bool {
                        self.joined = cn
                    }
                    
                    if let cn = each["JoinStatus"] as? Bool {
                        self.joinstatus = cn
                    }
                    var tandc = ""
                    if let cn = each["TermAndCondition"] as? String {
                        tandc = cn
                    }
                    if let cn = each["FileType"] as? String {
                        self.contestfiletype = cn
                    }
                    if let cn = each["Thumbnail"] as? String {
                        self.contestthumbnail = cn
                    }
                    
                    if let cn = each["NoOfWinner"] as? Int {
                        self.winnerscount = cn
                    }
                    
                    if let cn = each["PorformaceType"] as? String {
                        self.performancetype = cn
                    }
                    
                    if let cn = each["GenderName"] as? String {
                        self.gender = cn
                    }
                    if let cn = each["ParticipantPostAllow"] as? Bool {
                        self.isallowedtopost = cn
                    }
                    var noofwinn = 0
                    if let cn = each["NoOfWinner"] as? Int {
                        noofwinn = cn
                    }
                    var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: self.contestimage, termsandcondition: tandc, noofwinners: noofwinn)
                   print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                    print(x)
                    print(self.isallowedtopost)
                    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")

                    self.eventjoined = x
                    print(self.joined)
                    print(self.joinstatus)
                    
                    if self.allfeeds.count > 0 {
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    }
                    
                    done(true)
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

    
    @IBAction func closepopuppressed(_ sender: UIButton) {
        self.popupview.isHidden = true
    }
    
    
    
    @IBAction func editcontestdetailspressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "editcontestdetails", sender: nil)
    }
    
    
    
    
    
    typealias contsta = (_ x : Bool) -> Void
    func sharethiscontest(m : @escaping contsta)
    {
        
        if let id = self.eventjoined?.contestid as? Int {
            var url = Constants.K_baseUrl + Constants.sharethiscontest
            var aurl = "\(url)?contestId=\(id)"
            print(aurl)
            var r = BaseServiceClass()
            r.getApiRequest(url: aurl, parameters: [:]) { (response, err) in
                if let res = response?.result.value as? Dictionary<String,Any> {
                    print(res)
                    if let code = res["ResponseStatus"] as? Int {
                        
                        if code == 0 {
                            print("Gott it")
                            m(true)
                        }
                        else {
                            customalert.showalert(x: "Could not share contest !")
                        }
                    }
                }
            }
        }

        
    }
    
    
    
    
    @IBAction func popupvideopressed(_ sender: UIButton) {
        self.pickedcontent = "video"
        performSegue(withIdentifier: "uploadvideoandimage", sender: nil)
    }
    
    
    @IBAction func popupimagepressed(_ sender: UIButton) {
        self.pickedcontent = "image"
        performSegue(withIdentifier: "uploadvideoandimage", sender: nil)
    }
    
    
    @IBAction func popupaudiopressed(_ sender: UIButton) {
        self.pickedcontent = "audio"
        performSegue(withIdentifier: "uploadvideoandimage", sender: nil)
    }
    

    @IBAction func popupfilepressed(_ sender: UIButton) {
        self.pickedcontent = "file"
        performSegue(withIdentifier: "uploadvideoandimage", sender: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tablemode == "details" {
            return 2
        }
        else
        {
            return self.allfeeds.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Me removed opp \(indexPath.row)")
        var makevideoefetch = false
        if (indexPath.section == 0 && indexPath.row == 0) || self.videoallowed == true {
            makevideoefetch = true
        }
        if indexPath.row == allfeeds.count {
            self.videoallowed = true
        }

        if indexPath.section == 0 && tablemode == "details" {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "thf", for: indexPath) as? ThemefixedcellTableViewCell {
                    
                    cell.needtochangejoinedandisallowed = {a in
                        if a {
                            self.joined = true
                            self.isallowedtopost = false
                        }
                    }
                    
                    
                    cell.sharepressed = {a in
                        if a.lowercased() == "contest share" {
                            if let iid = self.eventjoined?.contestid as? Int {
                                
                            
                            self.ownereventid = iid
                            self.sharethiscontest { (ans) in
                                if ans {
                                    self.performSegue(withIdentifier: "contestshare", sender: nil)
                                }
                            }
                            }
                        }
                        else if a.lowercased() == "leave contest" {
                            let alert = UIAlertController(title: "Delete Contest", message: "Are you sure you want to delete/leave this contest ?", preferredStyle: .actionSheet)
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                                
                                var r  = BaseServiceClass()
                                
                                var uid = UserDefaults.standard.value(forKey: "refid")!
                                var params : Dictionary<String,Any> = ["GroupId" : self.eventid , "UserId" : uid]
                                var url = "\(Constants.K_baseUrl)\(Constants.leavecontest)?contestId=\(self.eventid)&userId=\(uid)"
                                
                                r.postApiRequest(url: url, parameters: [:] ) { (response, err) in
                                    if let res = response?.result.value as? Dictionary<String,Any> {
                                        print(res)
                                        if let code = res["ResponseStatus"] as? Int {
                                            if code == 0 {
                                                let alert2 = UIAlertController(title: "Contest Deleted", message: "", preferredStyle: .actionSheet)
                                                alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                                    self.performSegue(withIdentifier: "backtozero", sender: nil)
                                                    
                                                }));
                                                self.present(alert2, animated: true, completion: nil)
                                                
                                            }
                                            else {
                                                if let err = res["Error"] as? Dictionary<String,Any> {
                                                    if let inner = err["ErrorMessage"] as? String {
                                                        self.present(customalert.showalert(x: inner), animated: true, completion: nil)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                
                                
                            }));
                            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    
                    cell.postpressed = {a in
                        if a.lowercased() == "publish contest" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
                            let date = dateFormatter.date(from: self.eventjoined?.conteststart ?? "")
                            print(date)
                            let today = dateFormatter.date(from: dateFormatter.string(from: Date()))
                            print(today)
                            var errorcheck = false
                            if let d = date as? Date {
                                print(today?.timeIntervalSince(d).isLess(than: 0))
                                if d.timeIntervalSince(today!).isLess(than: 0) ?? true {
                                    errorcheck = true
                                }
                                
                                if errorcheck {
                                    self.present(customalert.showalert(x: "Contest Start date has already been passed. Please Edit Start date to continue"), animated: true, completion: nil)
                                }
                                else if self.eventjoined?.contestimage == "" {
                                    let alert = UIAlertController(title: "No Contest Image", message: "Are you sure you want to publish this contest with out an image ?", preferredStyle: .actionSheet)
                                    alert.addAction(UIAlertAction(title: "Publish contest", style: .default, handler: { _ in
                                        
                                        let alert2 = UIAlertController(title: "Publish Contest", message: "Are you sure you want to publish this contest ? Once published it will not be allowed to edit the contest.", preferredStyle: .actionSheet)
                                        alert2.addAction(UIAlertAction(title: "Publish contest", style: .default, handler: { _ in
                                            
                                            var url = "\(Constants.K_baseUrl)\(Constants.publishunpublish)?contestId=\(self.eventid)&publishStatus=true"
                                            var r = BaseServiceClass()
                                            r.postApiRequest(url: url, parameters: [:]) { (response, err) in
                                                if let res = response?.result.value as? Dictionary<String,Any> {
                                                    print(res)
                                                    if let code = res["ResponseStatus"] as? Int {
                                                        if code == 0 {
                                                            
                                                            let alert3 = UIAlertController(title: "Contest Published",message : "", preferredStyle: .actionSheet)
                                                            alert3.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                                                      self.performSegue(withIdentifier: "backtozero", sender: nil)
                                                            }))
                                                            
                                                            self.present(alert3, animated: true, completion: nil)
                                                            
                                                            
                                                      
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            
                                            
                                        }))
                                        
                                        alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                        self.present(alert2, animated: true, completion: nil)
                                        
                                        
                                        
                                    }))
                                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else {
                                    let alert = UIAlertController(title: "Publish Contest", message: "Are you sure you want to publish this contest ? Once published it will not be allowed to edit the contest.", preferredStyle: .actionSheet)
                                    alert.addAction(UIAlertAction(title: "Publish contest", style: .default, handler: { _ in
                                        
                                        var url = "\(Constants.K_baseUrl)\(Constants.publishunpublish)?contestId=\(self.eventid)&publishStatus=true"
                                        var r = BaseServiceClass()
                                        r.postApiRequest(url: url, parameters: [:]) { (response, err) in
                                            if let res = response?.result.value as? Dictionary<String,Any> {
                                                if let code = res["ResponseStatus"] as? Int {
                                                    if code == 0 {
                                                        self.present(customalert.showalert(x: "Contest Published"), animated: true, completion: nil)
                                                       
                                                        self.performSegue(withIdentifier: "backtozero", sender: nil)
                                                    }
                                                }
                                            }
                                        }
                                        
                                        
                                        
                                    }))
                                    
                                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                        else if a.lowercased() == "post" {
                            if let own = self.eventjoined?.contestid as? Int {
                                self.ownereventid = own
                                let alert = UIAlertController(title: "Post", message: nil, preferredStyle: .actionSheet)
                                
                                if self.eventjoined?.entrytype.lowercased() == "image" {
                                    alert.addAction(UIAlertAction(title: "Post Image", style: .default, handler: { _ in
                                        self.typeofpost = "image"
                                        self.performSegue(withIdentifier: "uploadvideoandimage", sender: nil)
                                        
                                    }))
                                }
                                if self.eventjoined?.entrytype.lowercased() == "video" {
                                    
                                    alert.addAction(UIAlertAction(title: "Post Video", style: .default, handler: { _ in
                                        self.typeofpost = "video"
                                        self.performSegue(withIdentifier: "uploadvideoandimage", sender: nil)
                                    }))
                                }
                                if self.eventjoined?.entrytype.lowercased() == "audio" {
                                    
                                    alert.addAction(UIAlertAction(title: "Post Audio", style: .default, handler: { _ in
                                        self.typeofpost = "audio"
                                        self.performSegue(withIdentifier: "postaudio", sender: nil)
                                    }))
                                }
                                
                                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        if a.lowercased() == "participate" {
                            if self.joined == false {
                                print("hello  xyz")
                                self.participate()
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                     if let e = self.eventjoined {
                        cell.update(x : e, p: self.currentpostbtncolor,s : "#FE6F00",b : self.joined ,c : self.joinstatus , isallowed : self.isallowedtopost, timetopublish : self.timetopublish, winnerlist: self.allwinners  )
                    }
                    return cell
                }
            }
        
            else if indexPath.row == 1 {
                if currentcelltype == "one" {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "th1", for: indexPath) as? ThemetypeoneTableViewCell {
                        
                        cell.changejury = {a in
                            if a  {
                                self.juryeditmode = "edit"
                                self.performSegue(withIdentifier: "invitepeople", sender: nil)
                            }
                        }
                        
                        if let e = self.eventjoined {
                            cell.update(x: e ,b : self.joined ,c : self.joinstatus, conimage: self.contestimage, winnerpricelist: self.allwinnersexistingprices , allwinners : self.allwinners , participants : self.totalparticpants , isllowed : self.isallowedtopost , timetopublish : self.timetopublish, win: winnerscount, pt: performancetype, gen: gender, needtoshowapplytheme : false)
                        }
                        return cell
                    }
                }

            if currentcelltype == "two" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th2", for: indexPath) as? ThemetypetwoTableViewCell {
                    cell.changejury = {a in
                        if a  {
                            self.juryeditmode = "edit"
                            self.performSegue(withIdentifier: "invitepeople", sender: nil)
                        }
                    }
                    if let e = self.eventjoined {
                        cell.update(x: e ,b : self.joined ,c : self.joinstatus, conimage: self.contestimage , winnerpricelist: self.allwinnersexistingprices, allwinners : self.allwinners , participants : self.totalparticpants , isllowed : self.isallowedtopost , timetopublish : self.timetopublish, win: winnerscount, pt: performancetype, gen: gender, needtoshowapplytheme : false)
                    }
                    return cell
                }
                }

            if currentcelltype == "three" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th3", for: indexPath) as? ThemetypethreeTableViewCell {
                    cell.changejury = {a in
                        if a  {
                            self.juryeditmode = "edit"
                            self.performSegue(withIdentifier: "invitepeople", sender: nil)
                        }
                    }
                    if let e = self.eventjoined {
                        cell.update(x: e ,b : self.joined ,c : self.joinstatus, conimage: self.contestimage , winnerpricelist: self.allwinnersexistingprices, allwinners : self.allwinners , participants : self.totalparticpants , isllowed : self.isallowedtopost , timetopublish : self.timetopublish, win: winnerscount, pt: performancetype, gen: gender, needtoshowapplytheme : false)
                    }
                    return cell
                }
                }


          if currentcelltype == "four" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th4", for: indexPath) as? ThemetypefourTableViewCell {
                    cell.changejury = {a in
                        if a  {
                            self.juryeditmode = "edit"
                            self.performSegue(withIdentifier: "invitepeople", sender: nil)
                        }
                    }
                    if let e = self.eventjoined {
                        cell.update(x: e ,b : self.joined ,c : self.joinstatus, conimage: self.contestimage , winnerpricelist: self.allwinnersexistingprices, allwinners : self.allwinners , participants : self.totalparticpants , isllowed : self.isallowedtopost , timetopublish : self.timetopublish, win: winnerscount, pt: performancetype, gen: gender, needtoshowapplytheme : false)
                    }
                    return cell
                }
                }

            if currentcelltype == "five" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th5", for: indexPath) as? ThemetypefiveTableViewCell {
                    cell.changejury = {a in
                        if a  {
                            self.juryeditmode = "edit"
                            self.performSegue(withIdentifier: "invitepeople", sender: nil)
                        }
                    }
                    if let e = self.eventjoined {
                        cell.update(x: e ,b : self.joined ,c : self.joinstatus, conimage: self.contestimage , winnerpricelist: self.allwinnersexistingprices, allwinners : self.allwinners , participants : self.totalparticpants , isllowed : self.isallowedtopost , timetopublish : self.timetopublish, win: winnerscount, pt: performancetype, gen: gender, needtoshowapplytheme : false)
                    }
                    return cell
                }
                }

            if currentcelltype == "six" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th6", for: indexPath) as? ThemetypesixTableViewCell {
                    cell.changejury = {a in
                        if a  {
                            self.juryeditmode = "edit"
                            self.performSegue(withIdentifier: "invitepeople", sender: nil)
                        }
                    }
                    if let e = self.eventjoined {
                        cell.update(x: e ,b : self.joined ,c : self.joinstatus, conimage: self.contestimage, winnerpricelist: self.allwinnersexistingprices , allwinners : self.allwinners , participants : self.totalparticpants , isllowed : self.isallowedtopost , timetopublish : self.timetopublish, win: winnerscount, pt: performancetype, gen: gender, needtoshowapplytheme : false)
                    }
                    return cell
                }
                }

        }
        }
        else if indexPath.section == 0 && tablemode == "details" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "joininfocell", for: indexPath) as? JoinedeventinformationTableViewCell {



                cell.publishcontest = { a in
                    if a  {
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
                        let date = dateFormatter.date(from: self.eventjoined?.conteststart ?? "")
                        print(date)
                        let today = dateFormatter.date(from: dateFormatter.string(from: Date()))
                        print(today)
                        var errorcheck = false
                        if let d = date as? Date {
                            print(today?.timeIntervalSince(d).isLess(than: 0))
                            if d.timeIntervalSince(today!).isLess(than: 0) ?? true {
                            errorcheck = true
                        }

                        if errorcheck {
                            self.present(customalert.showalert(x: "Contest Start date has already been passed. Please Edit Start date to continue"), animated: true, completion: nil)
                        }
                        else if self.eventjoined?.contestimage == "" {
                             let alert = UIAlertController(title: "No Contest Image", message: "Are you sure you want to publish this contest with out an image ?", preferredStyle: .actionSheet)
                            alert.addAction(UIAlertAction(title: "Publish contest", style: .default, handler: { _ in

                                let alert2 = UIAlertController(title: "Publish Contest", message: "Are you sure you want to publish this contest ? Once published it will not be allowed to edit the contest.", preferredStyle: .actionSheet)
                                alert2.addAction(UIAlertAction(title: "Publish contest", style: .default, handler: { _ in

                                    var url = "\(Constants.K_baseUrl)\(Constants.publishunpublish)?contestId=\(self.eventid)&publishStatus=true"
                                    var r = BaseServiceClass()
                                    r.postApiRequest(url: url, parameters: [:]) { (response, err) in
                                        if let res = response?.result.value as? Dictionary<String,Any> {
                                            if let code = res["ResponseStatus"] as? Int {
                                                if code == 0 {
                                                    self.present(customalert.showalert(x: "Contest Published"), animated: true, completion: nil)
                                                    cell.publisheddone!(true)
                                                    self.performSegue(withIdentifier: "backtozero", sender: nil)
                                                }
                                            }
                                        }
                                    }



                                }))

                                alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                self.present(alert2, animated: true, completion: nil)



                            }))
                            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            let alert = UIAlertController(title: "Publish Contest", message: "Are you sure you want to publish this contest ? Once published it will not be allowed to edit the contest.", preferredStyle: .actionSheet)
                            alert.addAction(UIAlertAction(title: "Publish contest", style: .default, handler: { _ in

                                var url = "\(Constants.K_baseUrl)\(Constants.publishunpublish)?contestId=\(self.eventid)&publishStatus=true"
                                var r = BaseServiceClass()
                                r.postApiRequest(url: url, parameters: [:]) { (response, err) in
                                    if let res = response?.result.value as? Dictionary<String,Any> {
                                        if let code = res["ResponseStatus"] as? Int {
                                            if code == 0 {
                                                self.present(customalert.showalert(x: "Contest Published"), animated: true, completion: nil)
                                                cell.publisheddone!(true)
                                                self.performSegue(withIdentifier: "backtozero", sender: nil)
                                            }
                                        }
                                    }
                                }



                            }))

                            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        }




                    }
                }




                cell.leftcontest = {a in
                    if a {
                    let alert = UIAlertController(title: "Delete Contest", message: "Are you sure you want to delete/leave this contest ?", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in

                        var r  = BaseServiceClass()

                        var uid = UserDefaults.standard.value(forKey: "refid")!
                        var params : Dictionary<String,Any> = ["GroupId" : self.eventid , "UserId" : uid]
                        var url = "\(Constants.K_baseUrl)\(Constants.leavecontest)?contestId=\(self.eventid)&userId=\(uid)"

                        r.postApiRequest(url: url, parameters: [:] ) { (response, err) in
                            if let res = response?.result.value as? Dictionary<String,Any> {
                                print(res)
                                if let code = res["ResponseStatus"] as? Int {
                                    if code == 0 {
                                        let alert2 = UIAlertController(title: "Contest Deleted", message: "", preferredStyle: .actionSheet)
                                        alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                            self.performSegue(withIdentifier: "backtozero", sender: nil)

                                        }));
                                        self.present(alert2, animated: true, completion: nil)

                                    }
                                    else {
                                        if let err = res["Error"] as? Dictionary<String,Any> {
                                            if let inner = err["ErrorMessage"] as? String {
                                                self.present(customalert.showalert(x: inner), animated: true, completion: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        }



                    }));
                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    }
                }



                cell.taketocontestpost = {a,b in
                    self.ownereventid = b

                    let alert = UIAlertController(title: "Post", message: nil, preferredStyle: .actionSheet)

                    if self.eventjoined?.entrytype.lowercased() == "image" {
                    alert.addAction(UIAlertAction(title: "Post Image", style: .default, handler: { _ in
                        self.typeofpost = "image"
                        self.performSegue(withIdentifier: "uploadvideoandimage", sender: nil)

                    }))
                    }
                    if self.eventjoined?.entrytype.lowercased() == "video" {

                    alert.addAction(UIAlertAction(title: "Post Video", style: .default, handler: { _ in
                        self.typeofpost = "video"
                        self.performSegue(withIdentifier: "uploadvideoandimage", sender: nil)
                    }))
                    }
                    if self.eventjoined?.entrytype.lowercased() == "audio" {

                        alert.addAction(UIAlertAction(title: "Post Audio", style: .default, handler: { _ in
                            self.typeofpost = "audio"
                            self.performSegue(withIdentifier: "postaudio", sender: nil)
                        }))
                    }

                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)




                    print("\(self.eventid) and \(b)")
                }


                cell.taketoedit = {a,b in
                    if a {
                        self.ownereventid = b
                        self.performSegue(withIdentifier: "ownerevent", sender: nil)
                    }
                }

                cell.taketocontestshare = {a, b in
                    self.ownereventid = b
                    self.sharethiscontest { (ans) in
                        if ans {
                            self.performSegue(withIdentifier: "contestshare", sender: nil)
                        }
                    }

                }

                cell.participatebtnpressed = {a in
                        print("Received \(a)")
                    if a {

                        if self.joined == false
                        {
                            print("hello  xyz")
                            self.participate()
                        }
                        else {
                            print("hello  abc")
                            self.popupview.isHidden = false
                        }
                    }
                }
                print("Heyyyyyyyyyyyyyyyy")
                print(self.eventjoined)
                if let e = self.eventjoined {
                    cell.updatecell(x: e ,b : self.joined ,c : self.joinstatus, conimage: self.contestimage , allwinners : self.allwinners , participants : self.totalparticpants , isllowed : self.isallowedtopost , timetopublish : self.timetopublish)
                }

                return cell
            }

        }
        else{
            var userid = UserDefaults.standard.value(forKey: "refid") as! String
            if let cell = tableView.dequeueReusableCell(withIdentifier: "joinedfeedscell", for: indexPath) as? JoinedeventfeedsTableViewCell {

                if loadthisvideo == false && indexPath.row != 0 {
                    makevideoefetch = false
                }
                
                var rs = ""
                if let x = self.eventjoined as? strevent {
                    rs = x.runningstatus
                }
                

                cell.updatecell(x : self.allfeeds[indexPath.row] , y : makevideoefetch , runningstatus : rs.lowercased())

                
                
                cell.tryingtolikeclosedcontest = { a in
                    if a {
                        self.present(customalert.showalert(x: "You can not like/unlike post of a contest which is closed."), animated: true, completion: nil)
                    }
                }
                
                
                cell.sendbackactualcomments = {a,b in
                        self.tappedpostid = a
                        self.tappedcommentlist = b
                        self.performSegue(withIdentifier: "showallcomments", sender: nil)
                    
                }

                cell.sendbackactivityid = {a in
                    self.feedidtobepassed = a
                    self.performSegue(withIdentifier: "goreviews", sender: nil)
                }

                cell.togglelike = {pos,likestatus in



                                    for var index in 0..<self.allfeeds.count {
                                        if self.allfeeds[index].acticityid == pos.acticityid && self.allfeeds[index].contestid == pos.contestid {
                                            self.allfeeds[index].likedbyme = !self.allfeeds[index].likedbyme
                                            if !self.allfeeds[index].likedbyme == true {
                                                self.allfeeds[index].likes = self.allfeeds[index].likes - 1
                                                for var lki in 0..<self.allfeeds[index].likebyme.count {
                                                    if index < self.allfeeds.count
                                                    {
                                                        if lki < self.allfeeds[index].likebyme.count
                                                        {
                                                                    if self.allfeeds[index].likebyme[lki].userid == userid {
                                                                        self.allfeeds[index].likebyme.remove(at: lki)
                                                                    }
                                                        }
                                                    }

                                                            }

                                            }
                                            else {
                                                self.allfeeds[index].likes = self.allfeeds[index].likes + 1

                                                self.allfeeds[index].likebyme.append(like(activityid: self.allfeeds[index].acticityid, id: self.allfeeds[index].id, ondate: "", profilename: "Auth user to be replace with", profileimage: "", userid: userid))

                                            }




                                            break
                                        }
                                    }



                //                    self.table.reloadRows(at: [indexPath], with: .none)
                }



                return cell
            }
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    
    
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let e = self.eventjoined as? strevent {
//
//        }
//        else {
//            return UITableViewCell()
//        }
//
//        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                if let cell = tableView.dequeueReusableCell(withIdentifier: "thf", for: indexPath) as? ThemefixedcellTableViewCell {
//                    cell.update(x: self.eventjoined!, p: "#FF0000", s: "#FFFFFF")
//                    return cell
//                }
//                return UITableViewCell()
//            }
//            else {
//                if currentcelltype == "one" {
//                    if let cell = tableView.dequeueReusableCell(withIdentifier: "th1", for: indexPath) as? ThemetypeoneTableViewCell {
//                        cell.update(x: self.eventjoined!, b: self.joined, c: self.joinstatus, conimage: self.contestimage, allwinners: self.allwinners, participants: self.totalparticpants, isllowed: self.isallowedtopost, timetopublish: self.timetopublish, win: self.winnerscount, pt: self.performancetype, gen: self.gender)
//                        return cell
//                    }
//                }
//                else if currentcelltype == "two" {
//                    if let cell = tableView.dequeueReusableCell(withIdentifier: "th2", for: indexPath) as? ThemetypetwoTableViewCell {
//                         cell.update(x: self.eventjoined!, b: self.joined, c: self.joinstatus, conimage: self.contestimage, allwinners: self.allwinners, participants: self.totalparticpants, isllowed: self.isallowedtopost, timetopublish: self.timetopublish, win: self.winnerscount, pt: self.performancetype, gen: self.gender)
//                        return cell
//                    }
//                }
//                else if currentcelltype == "three" {
//                    if let cell = tableView.dequeueReusableCell(withIdentifier: "th3", for: indexPath) as? ThemetypethreeTableViewCell {
//                        cell.update(x: self.eventjoined!, b: self.joined, c: self.joinstatus, conimage: self.contestimage, allwinners: self.allwinners, participants: self.totalparticpants, isllowed: self.isallowedtopost, timetopublish: self.timetopublish, win: self.winnerscount, pt: self.performancetype, gen: self.gender)
//                        return cell
//                    }
//                }
//                else if currentcelltype == "four" {
//                    if let cell = tableView.dequeueReusableCell(withIdentifier: "th4", for: indexPath) as? ThemetypefourTableViewCell {
//                        cell.update(x: self.eventjoined!, b: self.joined, c: self.joinstatus, conimage: self.contestimage, allwinners: self.allwinners, participants: self.totalparticpants, isllowed: self.isallowedtopost, timetopublish: self.timetopublish, win: self.winnerscount, pt: self.performancetype, gen: self.gender)
//                        return cell
//                    }
//                }
//                else if currentcelltype == "five" {
//                    if let cell = tableView.dequeueReusableCell(withIdentifier: "th5", for: indexPath) as? ThemetypefiveTableViewCell {
//                        cell.update(x: self.eventjoined!, b: self.joined, c: self.joinstatus, conimage: self.contestimage, allwinners: self.allwinners, participants: self.totalparticpants, isllowed: self.isallowedtopost, timetopublish: self.timetopublish, win: self.winnerscount, pt: self.performancetype, gen: self.gender)
//                        return cell
//                    }
//                }
//                else if currentcelltype == "six" {
//                    if let cell = tableView.dequeueReusableCell(withIdentifier: "th6", for: indexPath) as? ThemetypesixTableViewCell {
//                        cell.update(x: self.eventjoined!, b: self.joined, c: self.joinstatus, conimage: self.contestimage, allwinners: self.allwinners, participants: self.totalparticpants, isllowed: self.isallowedtopost, timetopublish: self.timetopublish, win: self.winnerscount, pt: self.performancetype, gen: self.gender)
//                        return cell
//                    }
//                }
//                return UITableViewCell()
//            }
//        }
//
//        return UITableViewCell()
//    }
    
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scrolling Over")
        loadthisvideo = true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Scrolling Starts")
        loadthisvideo = false
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("How about this")
        loadthisvideo = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && self.tablemode == "details" {
            if indexPath.row == 0 {
                if let s = self.eventjoined as? strevent {
                    print("Height \(s.runningstatus.lowercased())   \(self.allwinners.count)")
                    if s.runningstatus.lowercased() == "closed" && self.allwinners.count > 0 {
                        return 550
                    }
                }
                return 280
            }
            else {
                return 1300
            }
            print("Getting height \(self.view.frame.size.height/2.5)")
            var nl = 0.0
            if let e = self.eventjoined {
                var tc = e.description.count
                            nl = Double(CGFloat(tc/55))
                           if nl < 1 {
                               nl = 1.5
                           }
            }
            var x = Double(530) + (30 * nl) + Double(self.allwinners.count * 40)
            if self.timetopublish {
                x = x + 100
            }
            return CGFloat(x)
        }
        else {
            if indexPath.row < self.allfeeds.count {
            print(indexPath.row)
            if self.allfeeds[indexPath.row].type.lowercased() == "audio" {
                var tc = self.allfeeds[indexPath.row].description.count
                var nl = CGFloat(tc/55)
                if nl == 0 {
                    return (200 + (45 * 1.3))
                }
                if nl < 1 || tc == 0 {
                    return (460 + (45 * 1.3))
                }
                return (480 + (45 * nl))
            }
            
            var tc = self.allfeeds[indexPath.row].description.count
            var nl = CGFloat(tc/55)
            if nl == 0 {
                return (460 + (45 * 1.3))
            }
            if nl < 1 || tc == 0 {
                return (660 + (45 * 1.3))
            }
            return (680 + (45 * nl))
            }
        }
        return 800
    }
    
    
    func participate()
    {
        print(UserDefaults.standard.value(forKey: "mobile") as? String)
        print(UserDefaults.standard.value(forKey: "firstname") as? String)
        print(UserDefaults.standard.value(forKey: "lastname") as? String)
        if let m = UserDefaults.standard.value(forKey: "mobile") as? String, let n = UserDefaults.standard.value(forKey: "firstname") as? String , let f = UserDefaults.standard.value(forKey: "lastname") as? String
        {
            var c : Dictionary<String,String> = ["Contact":m,"FirstName" : n , "LastName" : f]
            let r = BaseServiceClass()
            var url = Constants.K_baseUrl + Constants.joinrequest
            var params : Dictionary<String,Any> = ["GroupId": self.eventid,"Contact" : [c]]
            print(params)
            r.postApiRequest(url: url, parameters: params) { (response, err) in
                if let rsv = response?.result.value as? Dictionary<String,Any> {
                    print(rsv)
                    if let code = rsv["ResponseStatus"] as? Int {
                        if code == 0 {
                            self.joined = true
                            self.table.reloadData()
                            JoinedeventsViewController.participatebtnpressedanswer!(true)
                            self.present(customalert.showalert(x: "You are enrolled in this contest."), animated: true, completion: nil)
                        }
                    }
                }
            }
        }

        
        
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Me removed \(indexPath.row)")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "joinedfeedscell", for: indexPath) as? JoinedeventfeedsTableViewCell {
            if let p = cell.player  {
                p.isMuted = true
                p.pause()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? JoinedeventfeedsTableViewCell {
            if let p = cell.player  {
                
                p.isMuted = !p.isMuted
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("I will display \(indexPath.row)")
//        if let cell = tableView.cellForRow(at: inde) as? JoinedeventfeedsTableViewCell {
//            if let p = cell.player  {
//                if p.status == .readyToPlay {
//                    p.play()
//                }
//
//            }
//
//        }
    }
    
    
    
    
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        if dangeringoingback {
            self.performSegue(withIdentifier: "backtozero", sender: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? PostVideoViewController {
            
            seg.type = self.typeofpost
            seg.currentselectedcategory = categorybrief(categoryid: self.eventjoined?.allowcategoryid ?? 0, categoryname: self.eventjoined?.allowcategory ?? "")
            seg.iseventpost = true
            seg.contestid = self.eventid
            seg.justuploaded = { a in
                JoinedeventsViewController.justuploaded!(true)
            }
        }
        
        
        if let seg = segue.destination as? GroupsandEventsContactvc {
            seg.mode = "jury"
            seg.juryeditmode = self.juryeditmode
            seg.passedjuryid = self.eventid
            seg.juryupdated = {a in
                if a {
                    self.eventsummary { (answ) in
                        if answ {
                            if self.timetopublish {
                                self.editcontestdetails.isHidden = false
                                self.deletebtn.isHidden = false
                            }
                            else {
                                self.editcontestdetails.isHidden = true
                                self.deletebtn.isHidden = true
                            }
                            
                            //                    self.table.reloadData()
                            if self.contestfiletype == "Image" {
                                self.downloadimage(url: self.contestimage) { (im) in
                                    if let iim = im as? UIImage {
                                        self.eventimage.image = iim
                                    }
                                }
                            }
                            else if self.contestfiletype == "Video" {
                                self.downloadimage(url: self.contestthumbnail) { (im) in
                                    if let iim = im as? UIImage {
                                        self.eventimage.image = iim
                                    }
                                }
                                
                                
                            }
                            
                            
                            self.table.reloadData()
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                            
                            
                            
                            
                        }
                        else {
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                        }
                    }
                }
            }
        }
        
        if let seg = segue.destination as? ReviewsandRatingsViewController {
            seg.contestid = self.eventid
            seg.postid = self.feedidtobepassed
            var rs = ""
            if let x = self.eventjoined as? strevent {
                rs = x.runningstatus
            }
            seg.currentrunningstatus = rs.lowercased()
        }
        
        if let seg = segue.destination as? NewEventViewController {
            seg.eventid = self.ownereventid ?? 0
            seg.timetopublish = self.timetopublish
            seg.imtoshow = self.eventimage.image
            seg.passbackuploadedimage = { a in
                self.eventjoined?.contestimage = "uploaded"
                self.eventimage.image = a
                
            }
        }
        if let seg = segue.destination as? ContestshareonViewController {
            seg.eventid = self.eventjoined?.contestid ?? 0
            seg.eventimage = self.eventjoined?.contestimage ?? ""
            seg.eventname = self.eventjoined?.contestname ?? ""
            
        }
        
        if let seg = segue.destination as? AllcommentsViewController {
            seg.postid = tappedpostid
            seg.tappedcommentlist = self.tappedcommentlist
            var rs = ""
            if let x = self.eventjoined as? strevent {
                rs = x.runningstatus
            }
            seg.currentrunningstatus = rs.lowercased()
            seg.sendbackupdatedlist = {a,b in
                print("Setting : ")
                print(a)
                print(b)
                self.tappedcommentlist = a
                for var k in 0 ..< self.allfeeds.count {
                    if self.allfeeds[k].acticityid == b {
                        self.allfeeds[k].comments = a
                        self.table.reloadData()
                        break
                    }
                }
            }
            seg.commentposted = {a,b in
//                var c = 0
//                for var k in self.alldata {
//
//                    if k.activityid == a?.activityid {
//                        if let lc = self.table.cellForRow(at: IndexPath(row: c, section: 0)) as? TalentshowcaseTableViewCell {
//
//                            lc.leadcommentuser.text = a?.profilename.capitalized
//                            lc.leadcomment.text = a?.comment.capitalized
//
//                            lc.leadcomment.text = "Hello"
//                            lc.downloadprofileimage(url: a!.profileimage) { (ik) in
//                                lc.leadcommentuserimage.image = ik
//                            }
//                        }
//
//                        k.comments.append(a!)
//                        self.table.reloadData()
//                    }
//                    c=c+1
//                }
            }

        }
        
        if let seg = segue.destination as? ModifiedcontestcreateViewController {
            seg.themeid = self.themeid
            seg.genderid = self.genderid
            seg.performancetypeid = self.performancetypeid
            seg.isineditmode = true
            seg.passedevent = self.eventjoined
            seg.eventid = self.ownereventid
            seg.groupid = self.groupid
            seg.allwinnersexistingprices = self.allwinnersexistingprices
        }
        
        
        if let seg = segue.destination as? AudioUploadViewController {
            
            seg.audiouploaded = { a in
                if a {
                    JoinedeventsViewController.justuploaded!(true)
                    self.fetchfeeds { (f) in
                        self.table.reloadData()
                    }
                }
            }
            
            seg.contestid = self.eventjoined?.contestid ?? 0
            seg.categoryid = self.eventjoined?.allowcategoryid ?? 0
            
        }
        
        
    }
    

   
}
