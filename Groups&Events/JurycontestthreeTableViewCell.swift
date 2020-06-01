//
//  JurycontestthreeTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 05/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit

class JurycontestthreeTableViewCell: UITableViewCell {
    
    
    var passwinner : ((_ x : feeds) -> ())?
    var removewinner : ((_ x : feeds) -> ())?
    var sendclickedevent : ((_ x : String , _ y : Int , _ z : feeds) -> Void)?

    @IBOutlet weak var userimage: UIImageView!
    
    @IBOutlet weak var userprofilename: UILabel!
    
    @IBOutlet weak var reviewbtn: UIButton!
    
    @IBOutlet weak var selectouterview: UIView!
    
    
    @IBOutlet weak var selectbutton: UIButton!
    
    
    @IBOutlet weak var postimage: UIImageView!
    
    
    @IBOutlet weak var likecount: UILabel!
    
    @IBOutlet weak var commentcount: UILabel!
    
    @IBOutlet weak var viewscount: UILabel!
    
    var player : AVPlayer!
    var avplayeritem : AVPlayerItem!
     var layerc : AVPlayerLayer?
    var btn : UIButton?
    var muteunmute : UIButton?
    var audio : AVAudioPlayer?
    var pv : UIProgressView!
    var musicurl = ""
    var currentfeed : feeds?
    
    var sp : UIActivityIndicatorView?
    var postid = 0

    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postimage.image = #imageLiteral(resourceName: "cover-photo")
//        if let m = muteunmute as? UIButton {
//            if self.currentfeed?.type == "Video" || self.currentfeed?.type == "Videos" {
//                m.isHidden = false
//            }
//            else {
//                m.isHidden = true
//            }
//        }
        
        if let p = player {
            self.player.pause()
            self.player = nil
        }
        self.layerc?.removeFromSuperlayer()
    }
    
    
    
    
    func updatecell(x : feeds , y : Bool , z : Int , w : Bool)
    {
        self.postid = x.acticityid
        selectbutton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5) 
        if y {
//            selectbutton.backgroundColor = UIColor.black
             selectbutton.setImage(UIImage(named: "check-solid"), for: .normal)
        }
        else {
//            selectbutton.backgroundColor = UIColor.clear
             selectbutton.setImage(UIImage(named: ""), for: .normal)
        }
        
        
        if z > 0 {
            self.selectouterview.isHidden = true
        }
        else {
            self.selectouterview.isHidden = false
        }
        self.currentfeed = x
        self.userprofilename.text = x.profilename.capitalized
        self.likecount.text = "\(x.likes)"
        self.commentcount.text = "\(x.comments.count)"
        self.viewscount.text = "\(x.totalreview)"
        self.postimage.backgroundColor = UIColor.black
        self.selectionStyle = .none
        self.selectbutton.layer.borderColor = UIColor.black.cgColor
        self.selectbutton.layer.borderWidth = 1
        self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2
        self.selectouterview.layer.cornerRadius = self.selectouterview.frame.size.height/2
        self.postimage.layer.cornerRadius = 10
        
        self.downloadimage(url: x.profileimg) { (im) in
            if let imm = im as? UIImage {
                self.userimage.image = imm
            }
        }
        
        if x.type.lowercased() == "video" || x.type.lowercased() == "videos" {
            self.downloadimage(url: x.thumbnail) { (im) in
                if let imm = im as? UIImage {
                    self.postimage.image = imm
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
                                play?.play()
                            }
                            self.postimage.isHidden = true
                            
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
            self.postimage.isHidden = true
            self.musicurl = x.activitypath
            btn = UIButton(frame: CGRect(x: 16, y: CGFloat(70 + ht), width: 60, height: 60))
            btn?.setTitle("", for: .normal)
            btn?.setImage(#imageLiteral(resourceName: "017-play-1"), for: .normal)
            if let b = btn as? UIButton {
                self.addSubview(b)
            }
            btn?.addTarget(self, action: #selector(playaudio), for: .touchUpInside)
            
            pv = UIProgressView(frame: CGRect(x: 84, y: CGFloat(100 + ht), width: self.frame.size.width - 92, height: 60))
            pv.setProgress(0, animated: true)
            self.addSubview(pv)
        }
        else {
            self.downloadimage(url: x.activitypath) { (im) in
                if let imm = im as? UIImage {
                    self.postimage.image = imm
                }
            }
        }
        
        
        if let m = muteunmute as? UIButton {
            if  x.type == "Video" || x.type == "Videos" {
                self.muteunmute?.isHidden = false
            }
            else {
                self.muteunmute?.isHidden = true
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
    
    
    
    @IBAction func checkboxtapped(_ sender: UIButton) {
        
        print("hey")
        if let i = selectbutton.image(for: .normal) as? UIImage  {
            selectbutton.setImage(nil, for: .normal)
            if let t = self.currentfeed {
                self.removewinner!(t)
            }
            
            
        }
        else {
//            selectbutton.backgroundColor = UIColor.clear
            if JurycontestViewController.allowedfurtherselection == false {
                return
            }
            
            //            selectbutton.backgroundColor = UIColor.black
            selectbutton.setImage(UIImage(named: "check-solid"), for: .normal)
            if let t = self.currentfeed {
                self.passwinner!(t)
            }
            
        }
    }
    
    
    
    @objc func playaudio()
    {
        if let a = audio as? AVAudioPlayer {
            if a.isPlaying {
                a.pause()
                if let b = self.btn as? UIButton {
                    b.setImage(#imageLiteral(resourceName: "017-play-1"), for: .normal)
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
    
    
    @objc func updateAudioProgressView()
    {
        if audio!.isPlaying
        {
            // Update progress
            pv.setProgress(Float(audio!.currentTime/audio!.duration), animated: true)
        }
    }
    
    
    typealias videosfetched = (_ x : AVPlayer?) -> Void
    
    func downloadvideo(url :String,a : @escaping videosfetched)
    {
        print("Survived one")
        
        if (player != nil) {
            
            player = nil;
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: .mixWithOthers)
        } catch {
            print(error.localizedDescription)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndedPlaying), name: Notification.Name("AVPlayerItemDidPlayToEndTimeNotification"), object: nil)
        
        
        
            let avasset = AVURLAsset.init(url: (NSURL(string: url) as! URL))
            if let avv = AVPlayerItem(asset: avasset) as? AVPlayerItem {
                avplayeritem = avv
            }
            
         print("Survived Two")
        
        
        //        player = AVPlayer(url: (NSURL(string: url) as! URL))
        
        player = AVPlayer(playerItem: avplayeritem)
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        
        player.isMuted = true
        //        player.automaticallyWaitsToMinimizeStalling = true
        layerc = AVPlayerLayer(player: player)
        sp = UIActivityIndicatorView(frame: CGRect(x: self.postimage.frame.size.width/2 + 30, y: self.postimage.frame.size.height/2 , width: 60, height: 60))
        sp?.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        sp?.color = UIColor.white
        sp?.style = .whiteLarge
        sp?.isHidden = false
        sp?.startAnimating()
         print("Survived Three")
        
        if self.currentfeed?.type == "Video" || self.currentfeed?.type == "Videos" {
            muteunmute = UIButton(frame: CGRect(x: self.frame.size.width - 38, y: 350, width: 25, height: 20))
            muteunmute?.setTitle("", for: .normal)
            muteunmute?.setImage(#imageLiteral(resourceName: "mute"), for: .normal)
            if let b = muteunmute as? UIButton {
                DispatchQueue.main.async {
                self.contentView.addSubview(b)
                }
            }
            muteunmute?.addTarget(self, action: #selector(muteunmuteaudio), for: .touchUpInside)
        }
        else {
            muteunmute?.isHidden = true
            
        }
         print("Survived Four")
        
        DispatchQueue.main.async {
            self.layerc?.backgroundColor = UIColor.black.cgColor
            self.layerc?.videoGravity = AVLayerVideoGravity.resizeAspect
            self.layerc?.cornerRadius = 10
            
            
            self.layerc?.frame = CoreGraphics.CGRect(x: 32,
                                                     y: self.postimage.frame.origin.y,
                                                     width: self.postimage.frame.size.width,
                                                     height: self.postimage.frame.size.height
            )
            //        layer.bounds.size.height = 170
            
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
         print("Survived Five")
        
        if let p = self.player {
            self.postimage.isHidden = true
            a(p)
        }
        else {
            a(nil)
        }
        
        
        
        
    }
    
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        self?.sp?.isHidden = true
                        self?.sp?.stopAnimating()
                    } else {
                        self?.sp?.isHidden = false
                        self?.sp?.startAnimating()
                    }
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
    

    
    @IBAction func reviewbtnpressed(_ sender: Any) {
        if let f = self.currentfeed as? feeds {
            self.sendclickedevent!("review" , self.postid , f)
        }
        
    }
    
    @IBAction func commentbtnpressed(_ sender: Any) {
        if let f = self.currentfeed as? feeds {
            self.sendclickedevent!("comment" , self.postid, f)
        }
        
    }
    
}
