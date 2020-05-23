//
//  TalentshowcaseTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 20/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit

class TalentshowcaseTableViewCell: UITableViewCell,UITextFieldDelegate  {

    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var profession: UILabel!
    
    @IBOutlet weak var banner: UIImageView!
    
    
    @IBOutlet weak var likebtn: UIButton!
    
    
    @IBOutlet weak var mainimageheight: NSLayoutConstraint!
    
    @IBOutlet weak var likecount: UIButton!
    
    
    @IBOutlet weak var commentbtn: UIButton!
    
    @IBOutlet weak var comentcount: UILabel!
    
    @IBOutlet weak var viewscount: UILabel!
    
    
    @IBOutlet weak var bannerheight: NSLayoutConstraint!
    
    @IBOutlet weak var commentfield: UITextField!
    
    @IBOutlet weak var mutebtn: UIButton!
    
    
    @IBOutlet weak var rewindbtn: UIButton!
    
    
    @IBOutlet weak var seeallcomments: UIButton!
    
    @IBOutlet weak var playbtn: UIButton!
    
    @IBOutlet weak var forwardbtn: UIButton!
    
    
    @IBOutlet weak var leadcommentuser: UILabel!
    
    
    @IBOutlet weak var stackviewcoverup: UIView!
    
    
    @IBOutlet weak var sv1: UIStackView!
    
    @IBOutlet weak var sv2: UIStackView!
    
    @IBOutlet weak var sv3: UILabel!
    
    
    @IBOutlet weak var sv1width: NSLayoutConstraint!
    
    
    @IBOutlet weak var sv2width: NSLayoutConstraint!
    
    
    @IBOutlet weak var sv3width: NSLayoutConstraint!
    
    
    @IBOutlet weak var leadcomment: UILabel!
    
    @IBOutlet weak var leadcommentuserimage: UIImageView!
    
    var commentposted: ((_ status: commentinfo?) -> ())?
    
    var onSeeAllcomments: ((_ currentholder: videopost, _ iidd : Int) -> ())?
    var onSeeAlllikes: ((_ currentholder: videopost) -> ())?
       var togglelike : ((_ post : videopost,_ status : Bool) -> ())?
    var found = false
    var postid = 0
    var curentvideopost : videopost!
    static var liked : Bool?
    var tobeliked : Bool = false
     var player : AVPlayer!
     var avplayeritem : AVPlayerItem!
    
    var currcat = ""

    
    
    
    @IBAction func postcommentpressed(_ sender: UIButton) {
        
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
               print("-----------------")
            if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {

                    
                    
                    
                    if let cid = inv["CommentId"] as? Int,let aid = inv["ActivityId"] as? Int,let pn = inv["ProfilName"] as? String,let pi = inv["ProfileImage"] as? String,let uid = inv["UserID"] as? String,let cm = inv["Comment"] as? String,let on = inv["Ondate"] as? String  {
                        
                        newcomment = commentinfo(activityid: aid, comment: cm, commentid: cid, id: "", ondate: on, profilename: pn, profileimage: pi, replycomments: nil, userid: uid,status:"")
           
                        self.leadcommentuser.text = newcomment.profilename.capitalized
                        self.leadcomment.text = newcomment.comment.capitalized
                        self.downloadprofileimage(url: newcomment.profileimage) { (iem) in
                            self.leadcommentuserimage.image = iem
                        }
                        self.curentvideopost.comments.append(newcomment)
                        
                    }
                
                    
                    
                    print(inv)
                }
            }
               if let st = data?.response?.statusCode as? Int {
                   if st == 200 {
                    print(newcomment)
                    self.commentposted!(newcomment)
                    self.commentfield.text = ""
                   }
                   else {
                    self.commentposted!(nil)
                    }
                    
               }
           }
           
           
       }
    
    
    
    func update(x:videopost)
    {
        
        print("here is the updated cell")
        print(x.activityid)
        print(x.like)
        print(x.likebyme)
        print("-----------------------")
        profileimage.layer.cornerRadius = profileimage.frame.size.height/2

//        self.sv1width.constant = self.stackviewcoverup.frame.size.width/3.1
//        self.sv2width.constant = self.stackviewcoverup.frame.size.width/2.5
//        self.sv3width.constant = self.stackviewcoverup.frame.size.width/2.9
        self.mainimageheight.constant = self.frame.size.height/2.5
        
        
        self.currcat = x.type
        self.postid = x.activityid
        var dummycurrentuserid = UserDefaults.standard.value(forKey: "refid") as! String //replace with current logged in user id
        
        if x.status == true {
                   self.likebtn.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
               }
               else {
                   self.likebtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
               }
        
//        self.commentfield.delegate = self
        self.curentvideopost = x
        name.text = x.profilename.capitalized
        profession.text = x.title.capitalized
        likecount.setTitle("\(x.likebyme.count)", for: .normal)
        comentcount.text = "\(x.comments.count)"
        viewscount.text = "\(x.views) views"
        
        if x.comments.count == 0 {
            self.seeallcomments?.isHidden = true
            self.leadcommentuser?.text = "No comments to show"
            self.leadcomment?.text = ""
            self.leadcommentuserimage?.image = nil
        }
        else {
            if let s = self.seeallcomments {
            self.seeallcomments.isHidden = false
            }
            self.leadcommentuserimage?.layer.cornerRadius = (self.leadcommentuserimage?.frame.size.height ?? 100)/2
            self.leadcommentuser?.text = x.comments.last?.profilename.capitalized
            self.leadcomment?.text = x.comments.last?.comment.capitalized
            downloadprofileimage(url: x.comments.last!.profileimage) { (im) in
                self.leadcommentuserimage?.image = im
            }
        }
        
        
        if let x = Talentshowcase2ViewController.cachepostvideo.object(forKey: (x.activitypath as? NSString)!) as? AVURLAsset {
            if let avv = AVPlayerItem(asset: x) as? AVPlayerItem {
                 avplayeritem = avv
                player = AVPlayer(playerItem: avplayeritem)
                player.play()
                
            }
        }
        else {
            DispatchQueue.global(qos: .userInitiated).async {
                self.downloadvideo(url: x.activitypath) { (play) in
                    DispatchQueue.main.async {
                        play?.play()

                    }
                }
            }

        }
        
        
        
        
 

        
   
        
        downloadprofileimage(url: x.profileimg) { (im) in
            self.profileimage.image = im
        }
        
    
           var u = NSURL(string: x.thumbnail)
                    var size = CGSize(width: self.banner.frame.size.width, height: 290)
                    if let im = Talentshowcase2ViewController.cachepostthumbnail.object(forKey: x.thumbnail as NSString) {
                        var w = im.size.width
                        var h = im.size.height
                        var mw = self.banner.frame.size.width
                        var  r = Float(w) / Float(h)
                        var mh = Float(mw) / r
                        DispatchQueue.main.async {
                            self.mainimageheight.constant = CGFloat(mh)

                        }
            //            if mh > 580 {
            //                self.mianviewheight.constant = 580
            //            }
            //            if mh < 380 {
            //                self.mianviewheight.constant = 380
            //            }
                        self.banner.image = im
                    }
                    else if let uu = u  {
                        do {
                        var ix = try UIGraphicsRenderer.renderImageAt(url: uu, size: size, scale: 4)
                            if let imagere = ix as? UIImage{
                                var w = imagere.size.width
                                            var h = imagere.size.height
                                            var mw = self.banner.frame.size.width
                                            var  r = Float(w) / Float(h)
                                            var mh = Float(mw) / r
                                

                                          self.mainimageheight.constant = CGFloat(mh)
                                
            //                                if mh > 380 {
            //                                    self.mianviewheight.constant = 580
            //                                }
            //                                if mh < 280 {
            //                                    self.mianviewheight.constant = 380
            //                                }
                                Talentshowcase2ViewController.cachepostthumbnail.setObject(imagere, forKey: x.thumbnail as NSString)
                                self.banner.image = imagere
                            }
                        }
                        catch {
                            
                        }
                    }
                  
        
       
            
        

        self.banner.layer.cornerRadius = 0
        self.profileimage.layer.borderWidth = 2
        self.profileimage.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.commentfield.resignFirstResponder()
        return true
    }
    
    @objc func playerEndedPlaying(_ notification: Notification) {
       DispatchQueue.main.async {[weak self] in
        self!.player?.seek(to: CMTime.zero)
        self!.player?.pause()
//        self!.playbtn.setTitle("Play", for: .normal)
       }
    }
    
    
    @IBAction func mutebtnpressed(_ sender: UIButton) {
        player.isMuted = !player.isMuted
    }
    
    @IBAction func rewindbtnpressed(_ sender: UIButton) {
        rewindVideo(by: 10)
        
    }
    
    func rewindVideo(by seconds: Float64) {
        if let currentTime = player?.currentTime() {
            var newTime = CMTimeGetSeconds(currentTime) - seconds
            if newTime <= 0 {
                newTime = 0
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }

    func forwardVideo(by seconds: Float64) {
        if let currentTime = player?.currentTime(), let duration = player?.currentItem?.duration {
            var newTime = CMTimeGetSeconds(currentTime) + seconds
            if newTime >= CMTimeGetSeconds(duration) {
                newTime = CMTimeGetSeconds(duration)
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }
    
    @IBAction func playbtnpressed(_ sender: UIButton) {
        if player.timeControlStatus == .playing {
            player.pause()
//            self.playbtn.setTitle("Play", for: .normal)
        }
        else {
            player.play()
//            self.playbtn.setTitle("Pause", for: .normal)
        }
    }
    
    
    @IBAction func forwardbtnpressed(_ sender: UIButton) {
        forwardVideo(by: 10)
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
                    
                    self.banner.alpha = 0
                    layer.frame = CoreGraphics.CGRect(x: 0,
                                                      y: 100,
                                                      width: self.frame.size.width,
                                                      height: self.frame.size.height/2.6
            )
            //        layer.bounds.size.height = 170
                    layer.cornerRadius = 0
                    layer.masksToBounds = true
                    
                    self.contentView.clipsToBounds = true
                    
                        self.contentView.layer.addSublayer(layer)
        }
       
        if let p = self.player {
            a(p)
        }
        else {
            a(nil)
        }
        
        
//        self.banner.isHidden = true
//        self.playbtn.setTitle("Pause", for: .normal)
        
//        var audiotap = UITapGestureRecognizer(target: self, action: #selector(mutevideo))
//        audiotap.numberOfTapsRequired = 1
//
//        var audiobtn = UIButton(frame: CGRect(x: 5, y: 10, width: 50, height: 40))
//        audiobtn.backgroundColor = UIColor.black
//        audiobtn.setImage(#imageLiteral(resourceName: "music-black"), for: .normal)
//        audiobtn.setBackgroundImage(
//            #imageLiteral(resourceName: "left-arrow"), for: .normal)
//        audiobtn.addTarget(self, action: #selector(mutevideo), for: .touchUpInside)
//        audiobtn.addGestureRecognizer(audiotap)
//        audiobtn.isEnabled = true
        
        
  
        
//        let controlls = UIView(frame: CGRect(x: 0, y: 140, width: self.frame.size.width - 32, height: 60))
//        controlls.backgroundColor = UIColor.black
//        layer.addSublayer(audiobtn.layer)
//        layer.insertSublayer(audiobtn.layer, at: 10)
//       layer.addSublayer(controlls.layer)
        
        



        
        
        
//        var avvc = AVPlayerViewController()
//        player = AVPlayer(url: URL(string: url)!)
//
//        avvc.player = player
//        avvc.view.frame = self.banner.frame
//        avvc.showsPlaybackControls = true
//        self.addSubview(avvc.view)
//        player.play()
        
    }
    
    @objc func mutevideo()
    {
        player.isMuted = !player.isMuted
        print("set muted to \(player.isMuted)")
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
                    print(responseData.data)
            Talentshowcase2ViewController.cachepostthumbnail.setObject(UIImage(data: responseData.data!)!, forKey: url as NSString)
                completion(UIImage(data: responseData.data!))
                }
            })
        }
    }
    
    
 
    
    
    
    @IBAction func seeallcommentsclicked(_ sender: UIButton) {
        self.onSeeAllcomments!(self.curentvideopost,self.postid)
    }
    
    
    @IBAction func commenttapped(_ sender: UIButton) {
        self.onSeeAllcomments!(self.curentvideopost,self.postid)
    }
    
    
    @IBAction func liketapped(_ sender: UIButton) {
    }
    
    @IBAction func likecountpressed(_ sender: UIButton) {
        self.onSeeAlllikes!(self.curentvideopost)

    }
    
    
    
    @IBAction func likebtnclicked(_ sender: UIButton) {
        let dummycurrentuserid = UserDefaults.standard.value(forKey: "refid") as! String
        var poststatus = 0
               if self.curentvideopost.status == false {
                   poststatus = 1
                self.likebtn.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
               }
               else {
                   poststatus = 0
                self.likebtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
               }
               print("sending \(poststatus)")
               fetchdata(lk: poststatus)
        
        
        

    }
    
    
    
    
    func fetchdata(lk:Int)
    {
        self.likebtn.isEnabled = false
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        let params : Dictionary<String,Any> = ["PostId":self.postid as? Int ,"UserId": userid as? String,"LikeType":lk as? Int]

        
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
//                        self.likebtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                        self.likecount.setTitle("\(Int(self.likecount.title(for: .normal)!)! - 1)", for: .normal)
                        self.likebtn.isEnabled = true
                        self.curentvideopost.status = false
                        self.togglelike!(self.curentvideopost, false)
                        
                        

                    }
                    else {
                        
                        
//                        self.likebtn.setImage(#imageLiteral(resourceName: "liked"), for: .normal)
                       
                       print("Liked")
                        self.likecount.setTitle("\(Int(self.likecount.title(for: .normal)!)! + 1)", for: .normal)
                        self.likebtn.isEnabled = true
                        
                       
                         self.curentvideopost.status = true
                                               self.togglelike!(self.curentvideopost, true)

                    }
                }
            }
        }
        
        
    }
    
    
    
    
}
