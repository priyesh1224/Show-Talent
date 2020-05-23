//
//  MainGroupDynamicTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 22/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit

class MainGroupDynamicTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var profilename: UILabel!
    
    
    @IBOutlet weak var grouprelation: UILabel!
    var sp : UIActivityIndicatorView?
    
    @IBOutlet weak var timespan: UILabel!
    
    @IBOutlet weak var postimage: UIImageView!
    
    @IBOutlet weak var postcontent: UILabel!
    var player : AVPlayer!
    var avplayeritem : AVPlayerItem!
    var currentpost : grouppost?
    var audio : AVAudioPlayer?
    var pv : UIProgressView!
    var musicurl = ""
    var layerc : AVPlayerLayer?
    var btn : UIButton?
    var muteunmute : UIButton?
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postimage.image = #imageLiteral(resourceName: "cover-photo")
        if let m = muteunmute as? UIButton {
            if self.currentpost?.posttype == "Video" || self.currentpost?.posttype == "Videos" {
                m.isHidden = false
            }
            else {
                m.isHidden = true
            }
        }
        
        if let p = player {
            self.player.pause()
            self.player = nil
        }
        self.layerc?.removeFromSuperlayer()
    }
    

    func updatecell(x : grouppost)
    {
        self.currentpost = x
        self.selectionStyle = .none

        profileimage.layer.cornerRadius = profileimage.frame.size.height/2
        postimage.layer.cornerRadius = 10
        postcontent.numberOfLines = Int(x.description.count / 40)
        self.profilename.text = x.profilename.capitalized
        self.grouprelation.text = ""
        self.timespan.text = ""
        self.postcontent.text = x.description.capitalized
        
        if x.posttype == "Text" {
            self.postimage.isHidden = true
        }
        else {
            self.postimage.isHidden = false
            if x.posttype == "Photo" {
                if let p = player {
                    self.player.pause()
                    self.player = nil
                }
                self.downloadimage(url: x.postpath) { (im) in
                    self.postimage.image = im
                }
            }
            else if x.posttype == "Video" || x.posttype == "Videos" {
                
                    
                    if let am = MainGroupViewController.holder["\(x.thumbnail)"] as? UIImage {
                        self.postimage.image = am
                    }
                    else {
                        self.postimage.image = #imageLiteral(resourceName: "cover-photo")
                        self.downloadimage(url: x.postpath) { (im) in
                            if let imm = im as? UIImage {
                                self.postimage.image = imm
                                MainGroupViewController.holder["\(x.thumbnail)"] = imm
                            }
                        }
                    }
                    
                if let s =  self.sp as? UIActivityIndicatorView {
                    s.isHidden = false
                    s.startAnimating()
                }
                        
                        DispatchQueue.global(qos: .utility).async {

                            self.downloadvideo(url: x.postpath) { (play) in
                                DispatchQueue.main.async {
                                    self.postimage.isHidden = true
                                    if play?.status == .readyToPlay {
                                        if let s =  self.sp as? UIActivityIndicatorView {
                                            s.isHidden = true
                                            s.stopAnimating()
                                        }
                                        play?.play()
                                        
                                    }
                                    
                                    
                                }
                            }
                        }
                    
                    
                

            }
            else if x.posttype == "Audio" {
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
                self.musicurl = x.postpath
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
            if let m = muteunmute as? UIButton {
                if  x.posttype == "Video" || x.posttype == "Videos" {
                    self.muteunmute?.isHidden = false
                }
                else {
                    self.muteunmute?.isHidden = true
                }
            }
            
        }
        self.downloadimage(url: x.profileimage) { (imm) in
            self.profileimage.image = imm
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
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)

        player.isMuted = true
        //        player.automaticallyWaitsToMinimizeStalling = true
         layerc = AVPlayerLayer(player: player)
        sp = UIActivityIndicatorView(frame: CGRect(x: self.postimage.frame.size.width/2 + 30, y: self.postimage.frame.size.height/2 , width: 60, height: 60))
        sp?.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        sp?.color = UIColor.white
        sp?.style = .whiteLarge
        sp?.isHidden = false
        
        if self.currentpost?.posttype == "Video" || self.currentpost?.posttype == "Videos" {
            muteunmute = UIButton(frame: CGRect(x: self.frame.size.width - 32, y: 32, width: 25, height: 20))
            muteunmute?.setTitle("", for: .normal)
            muteunmute?.setImage(#imageLiteral(resourceName: "mute"), for: .normal)
            if let b = muteunmute as? UIButton {
                self.contentView.addSubview(b)
            }
            muteunmute?.addTarget(self, action: #selector(muteunmuteaudio), for: .touchUpInside)
        }
        else {
            muteunmute?.isHidden = true
            
        }
        
        DispatchQueue.main.async {
            self.layerc?.backgroundColor = UIColor.black.cgColor
            self.layerc?.videoGravity = AVLayerVideoGravity.resizeAspect
            self.layerc?.cornerRadius = 10
            
            
            self.layerc?.frame = CoreGraphics.CGRect(x: 16,
                                              y: self.postimage.frame.origin.y + 20,
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
