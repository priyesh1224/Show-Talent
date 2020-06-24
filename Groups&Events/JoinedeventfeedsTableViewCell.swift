//
//  JoinedeventfeedsTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 22/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AVKit
import Alamofire


class JoinedeventfeedsTableViewCell: UITableViewCell , AVAudioPlayerDelegate {

    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var profilename: UILabel!
    
    @IBOutlet weak var profilecategory: UILabel!
    
    @IBOutlet weak var likebtn: UIButton!
    
    @IBOutlet weak var likecount: UILabel!
    
   
    
    @IBOutlet weak var leadcommentimage: UIImageView!
    
    
    @IBOutlet weak var leadcommentname: UILabel!
    
    
    
    @IBOutlet weak var leadcomment: UILabel!
    
    
    @IBOutlet weak var leadcommentregion: UIStackView!
    
    
    @IBOutlet weak var seeallcomments: UIButton!
    
    
    
    @IBOutlet weak var commentcount: UILabel!
    
    @IBOutlet weak var feedimage: UIImageView!
    
    
    
    @IBOutlet weak var actualcommentcount: UILabel!
    
    var btn : UIButton?
    var playerlockfortiming = true
    var alreadysentrequest = false
    
    @IBOutlet weak var feeddescription: UITextView!
    
    var likestatus = false
    
    var postid : Int = 0
    
    var togglelike : ((_ post : feeds,_ status : Bool) -> ())?

    var currentpost : feeds?
    
    var player : AVPlayer!
    var avplayeritem : AVPlayerItem!
    var layerc : AVPlayerLayer?
    var muteunmute : UIButton?
     var sp : UIActivityIndicatorView?
    var audio : AVAudioPlayer?
    var pv : UIProgressView!
    var musicurl = ""
    var currentpostid = 0
    var commentslist : [comment] = []
    var sendbackactivityid : ((_ x : Int) -> Void)?
     var tryingtolikeclosedcontest : ((_ x : Bool) -> Void)?
    var sendbackactualcomments : ((_ x : Int , _ y : [comment]) -> Void)?
    var currentrunningstatus = ""
    
    override class func awakeFromNib() {
        print("New cell appeared")
    }
    
    func updatecell(x : feeds , y : Bool , runningstatus : String)
    {
        
        print("Allocatin this cell")
        
        JoinedeventsViewController.deallocateplayer = { a in
            print("Got Tapped")
            
                if let p = self.player as? AVPlayer  {
                  self.player.pause()
                    self.player = nil
                }
                if let ai = self.audio {
                    self.audio?.pause()
                    self.audio = nil
                }
                self.layerc?.removeFromSuperlayer()
            
        }
        
        
        currentrunningstatus = runningstatus
        leadcommentimage.layer.cornerRadius = 20
        if x.comments.count == 0 {
            self.leadcommentregion.isHidden = true
            self.seeallcomments.isHidden = false
            self.seeallcomments.setTitle("Write a comment", for: .normal)
        }
        else {
            var lastcomm = x.comments.last
            self.seeallcomments.setTitle("See all comments", for: .normal)
            self.leadcomment.text = lastcomm?.usercomment
            self.leadcommentname.text = lastcomm?.profilename.capitalized
            self.downloadimage(url: lastcomm?.profileimage ?? "") { (im) in
                if let i = im as? UIImage {
                    self.leadcommentimage.image = i
                }
            }
        }
        
        
        self.commentcount.text = "\(x.totalreview)"
        self.actualcommentcount.text = "\(x.comments.count)"
        
        currentpostid = x.acticityid
        print("Video playing is \(y)")
        
        commentslist = x.comments
        self.currentpost = x
        self.likecount.text = "\(x.likes)"
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        var found = false
        for each in x.likebyme {
            if each.userid == userid {
                found = true
                break
            }
        }
        likestatus = found
        if found == true {
            self.likebtn.setImage(UIImage(named: "liked"), for: .normal)

        }
        else {
            self.likebtn.setImage(UIImage(named: "like"), for: .normal)

        }
        
        self.postid = x.acticityid
        self.selectionStyle = .none
        feeddescription.backgroundColor = UIColor.clear
        feeddescription.isEditable = false
        self.profileimage.layer.cornerRadius = 25
        self.feedimage.layer.cornerRadius = 10
        self.profilename.text = x.profilename.capitalized
        self.profilecategory.text = x.category.capitalized
        self.feeddescription.text = x.description.capitalized
        self.downloadimage(url: x.profileimg) { (im) in
            if let imm = im as? UIImage {
                self.profileimage.image = imm
            }
        }
        if x.type.lowercased() == "video" {
            
            if let am = JoinedeventsViewController.holder["\(x.thumbnail)"] as? UIImage {
                self.feedimage.image = am
            }
            else {
                self.feedimage.image = #imageLiteral(resourceName: "cover-photo")
                self.downloadimage(url: x.thumbnail) { (im) in
                    if let imm = im as? UIImage {
                        self.feedimage.image = imm
                        JoinedeventsViewController.holder["\(x.thumbnail)"] = imm
                    }
                }
            }
            
            if let s =  self.sp as? UIActivityIndicatorView {
                s.isHidden = false
                s.startAnimating()
            }
            
            
                DispatchQueue.global(qos: .utility).async {
                    self.downloadvideo(url: x.activitypath) { (play) in
                        DispatchQueue.main.async {
                            if play?.status == .readyToPlay {
                                if let s =  self.sp as? UIActivityIndicatorView {
                                    s.isHidden = true
                                    s.stopAnimating()
                                }
//                                play?.play()
                                self.feedimage.isHidden = true
                            }
                            
                            
                        }
                    }
                }
            

        }
        else if x.type.lowercased() == "audio" {
            var ht = 0.0
            var tc = x.description.count
            var nl = CGFloat(tc/55)
            if nl == 0 {
                ht =  Double(35 * 1.3)
            }
            else if nl < 1 || tc == 0 {
                ht = Double(35 * 1.3)
            }
            else {
                ht = Double((35 * nl))
            }
            self.feedimage.isHidden = true
            self.musicurl = x.activitypath
             btn = UIButton(frame: CGRect(x: 16, y: CGFloat(40 + ht), width: 60, height: 60))
            btn?.setTitle("", for: .normal)
            btn?.setImage(#imageLiteral(resourceName: "Group 1622"), for: .normal)
            if let b = btn as? UIButton {
              self.addSubview(b)
            }
            
            btn?.addTarget(self, action: #selector(playaudio), for: .touchUpInside)
            
             pv = UIProgressView(frame: CGRect(x: 84, y: CGFloat(60 + ht), width: self.frame.size.width - 92, height: 60))
            pv.setProgress(0, animated: true)
            self.addSubview(pv)
            
        }
        else {
            
            if let am = JoinedeventsViewController.holder["\(x.activitypath)"] as? UIImage {
                self.feedimage.image = am
            }
            else {
                self.feedimage.image = #imageLiteral(resourceName: "cover-photo")
                self.downloadimage(url: x.activitypath) { (im) in
                    if let imm = im as? UIImage {
                        self.feedimage.image = imm
                        JoinedeventsViewController.holder["\(x.activitypath)"] = imm
                    }
                }
            }
        }
        
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.feedimage.image = nil
        self.feedimage.isHidden = false
        self.feedimage.backgroundColor = UIColor.black
        if let p = player {
            self.player.pause()
            self.player = nil
            muteunmute?.setImage(#imageLiteral(resourceName: "mute"), for: .normal)
        }
         self.layerc?.removeFromSuperlayer()

    }
    
    @objc func muteunmuteaudio()
    {
        print("Muting")
        if let p = self.player as? AVPlayer {
            p.isMuted = !p.isMuted
            if p.isMuted {
                if let m = muteunmute as? UIButton {
                    muteunmute?.setImage(#imageLiteral(resourceName: "mute"), for: .normal)
                }
            }
            else {
                if let m = muteunmute as? UIButton {
                    muteunmute?.setImage(#imageLiteral(resourceName: "unmute"), for: .normal)
                }
            }
        }
    }
    
    @IBAction func sendbackactualcommentcount(_ sender: Any) {
        
        self.sendbackactualcomments!(currentpostid, commentslist)
    }
    
    
    
    
    
    
    
    
    @IBAction func commenttapped(_ sender: Any) {
        if let m = self.currentpost?.acticityid as? Int {
            self.sendbackactivityid!(m)
        }
        
    }
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let b = self.btn as? UIButton {
            b.setImage(#imageLiteral(resourceName: "Group 1622"), for: .normal)
        }
        pv.setProgress(0, animated: false)
    }
    
    @objc func playaudio()
    {
        if let a = audio as? AVAudioPlayer {
            a.delegate = self
            if a.isPlaying {
                a.pause()
                if let b = self.btn as? UIButton {
                    b.setImage(#imageLiteral(resourceName: "Group 1622"), for: .normal)
                }
                
            }
            else {
                a.play()
                if let b = self.btn as? UIButton {
                    b.setImage(#imageLiteral(resourceName: "Group 1621"), for: .normal)
                }
            }
        }
        else if let mp3URL = self.musicurl as? String {
            var v = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
                do
                {
                    // 2
                    let fileURL = NSURL(string:mp3URL)
                    let soundData = NSData(contentsOf:fileURL! as URL)
                    self.audio = try AVAudioPlayer(data: soundData! as Data)
                    
                    audio?.play()
                    if self.alreadysentrequest == false {
                        self.self.sendseenrequest()
                        self.alreadysentrequest = true
                    }
//                    audio = try AVAudioPlayer(contentsOf: NSURL(string: v) as! URL)
                    // 3
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
                    pv.setProgress(Float(audio!.currentTime/audio!.duration), animated: false)
                }
                catch
                {
                    print("An error occurred while trying to extract audio file")
                }
            
        }
        
    }
    
    @objc func updateAudioProgressView()
    {
        if let a = audio {
            if audio!.isPlaying
            {
                // Update progress
                pv.setProgress(Float(audio!.currentTime/audio!.duration), animated: true)
                if Float(audio!.currentTime/audio!.duration) == 1.0 {
                    pv.setProgress(0, animated: false)
                }
            }
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
        
        
        
        if let avs = JoinedeventsViewController.cachepostvideo.object(forKey: url as NSString) as? AVURLAsset {
            avplayeritem = AVPlayerItem(asset: avs)
        }
        else  {
            let avasset = AVURLAsset.init(url: (NSURL(string: url) as! URL))
            if let avv = AVPlayerItem(asset: avasset) as? AVPlayerItem {
                avplayeritem = avv
                JoinedeventsViewController.cachepostvideo.setObject(avasset, forKey: url as NSString)
            }
            
        }
        
        
        //        player = AVPlayer(url: (NSURL(string: url) as! URL))
        
        player = AVPlayer(playerItem: avplayeritem)
        player.automaticallyWaitsToMinimizeStalling = true
        DispatchQueue.main.async{
            self.feedimage.isHidden = true
        }
        avplayeritem.addObserver(self,
        forKeyPath: #keyPath(AVPlayerItem.status),
        options: [.old, .new],
        context: nil)
        if let p = player {
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        
        
        player.isMuted = true
        }
        //        player.automaticallyWaitsToMinimizeStalling = true
         layerc = AVPlayerLayer(player: player)
        sp = UIActivityIndicatorView(frame: CGRect(x: self.feedimage.frame.size.width/2 + 30, y: self.feedimage.frame.size.height/2 , width: 60, height: 60))
        sp?.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        sp?.color = UIColor.white
        sp?.style = .whiteLarge
        sp?.isHidden = false
        sp?.startAnimating()
        muteunmute = UIButton(frame: CGRect(x: self.frame.size.width - 38, y: 350, width: 25, height: 20))
        muteunmute?.setTitle("", for: .normal)
        muteunmute?.setImage(#imageLiteral(resourceName: "mute"), for: .normal)
        if let b = muteunmute as? UIButton {
            DispatchQueue.main.async {
                self.contentView.addSubview(b)
            }
        }
        muteunmute?.addTarget(self, action: #selector(muteunmuteaudio), for: .touchUpInside)
        DispatchQueue.main.async {
            self.layerc?.backgroundColor = UIColor.black.cgColor
            self.layerc?.videoGravity = AVLayerVideoGravity.resizeAspect
            
            
            self.layerc?.frame = CoreGraphics.CGRect(x: self.feedimage.frame.origin.x,
                                              y: self.feedimage.frame.origin.y + 20,
                                              width: self.feedimage.frame.size.width,
                                              height: self.feedimage.frame.size.height
            )
            //        layer.bounds.size.height = 170
            self.layerc?.cornerRadius = 0
            self.layerc?.masksToBounds = true
            
            self.contentView.clipsToBounds = true
            if let l = self.layerc as? AVPlayerLayer {
                self.contentView.layer.addSublayer(l)
                if let s = self.sp?.layer as? CALayer {
                    self.contentView.layer.addSublayer(s)
                }
                if let s = self.muteunmute?.layer as? CALayer {
                    //                    self.contentView.layer.addSublayer(s)
                }
                
            }
        }
        
        if let p = self.player {
            a(p)
        }
        else {
            a(nil)
        }
        
        
      
        
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === player {
         if keyPath == "timeControlStatus" {
                if #available(iOS 10.0, *) {
                    
                }
            } else if keyPath == "rate" {
                
            }
        }
        
        if keyPath == #keyPath(AVPlayerItem.status) {
                   let status: AVPlayerItem.Status
                   if let statusNumber = change?[.newKey] as? NSNumber {
                       status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
                   } else {
                       status = .unknown
                   }

                   // Switch over status value
                   switch status {
                   case .readyToPlay:
                       print("Status Ready to play")
                       
//                       player.play()
                       if let p = player as? AVPlayer {
                        sp?.isHidden = true
                        p.play()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.0) {
                                                   // check if player is still playing
                            if let p = self.player {
                                                   if self.player.rate != 0 && self.alreadysentrequest == false {
                                                       
                                                       if self.playerlockfortiming == false {
                                                       print("Player reached 5 seconds \(self.currentpost?.acticityid)")
                                                           self.sendseenrequest()
                                                       }
                                                       self.playerlockfortiming = false
                                                   }
                                                }
                                               }
                        
                       }
                       
                       // Player item is ready to play.
                   case .failed:
                       print("Status Failed")
                       // Player item failed. See error.
                   case .unknown:
                       print("Status unknown")
                       // Player item is not yet ready.
                   }
               }
    }
    
    
    
    func sendseenrequest()
       {
        print("Triggering")
           if let i = self.currentpost?.acticityid as? Int {
               let r = BaseServiceClass()
               let url = "\(Constants.K_baseUrl)\(Constants.uservideotrigger)?Activityid=\(i)"
            print(url)
               r.getApiRequest(url: url, parameters: [:]) { (response, err) in
                   if let res = response?.result.value as? Dictionary<String,Any> {
                       print(res)
                       self.alreadysentrequest = true
                   }
               }
           }
       }
    
    
    @objc func playerEndedPlaying(_ notification: Notification) {
        DispatchQueue.main.async {[weak self] in
            self!.player?.seek(to: CMTime.zero)
            self!.player?.play()
            //        self!.playbtn.setTitle("Play", for: .normal)
        }
    }
    
    
    @IBAction func liketaped(_ sender: UIButton) {
        if currentrunningstatus == "closed" {
            self.tryingtolikeclosedcontest!(true)
        }
        else
        {
            if likestatus == false {
                self.likebtn.setImage(UIImage(named: "liked"), for: .normal)
                likestatus = true
                fetchdata(lk : 1)
            }
            else {
                self.likebtn.setImage(UIImage(named: "like"), for: .normal)
                likestatus = false
                fetchdata(lk : 0)
            }
        }
    }
    
    
    
    
    
    
        func fetchdata(lk:Int)
           {
               self.likebtn.isEnabled = false
               let userid = UserDefaults.standard.value(forKey: "refid") as! String
               let params : Dictionary<String,Any> = ["PostId":self.postid as? Int ,"UserId": userid as? String,"LikeType":lk as? Int]

               var url = Constants.K_baseUrl + Constants.contestlike
               var r = BaseServiceClass()
               r.postApiRequest(url: url, parameters: params) { (data, err) in
                   print(data)
                   if let st = data?.response?.statusCode as? Int {
                       if st == 200 {
                           if lk == 0 {
                           
    //                        self.likeicon.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                            self.likecount.text = "\(Int(self.likecount.text!)! - 1)"
                            self.likebtn.isEnabled = true
                            self.likestatus = false
                            self.togglelike!(self.currentpost!, false)
                          

                           }
                           else {

                            self.likecount.text = "\(Int(self.likecount.text!)! + 1)"
                               self.likebtn.isEnabled = true
                            
                            self.likestatus = true
                            self.togglelike!(self.currentpost!, true)

                           }
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
}
