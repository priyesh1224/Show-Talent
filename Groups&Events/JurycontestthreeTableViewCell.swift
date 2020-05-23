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

    @IBOutlet weak var userimage: UIImageView!
    
    @IBOutlet weak var userprofilename: UILabel!
    
    
    @IBOutlet weak var selectouterview: UIView!
    
    
    @IBOutlet weak var selectbutton: UIButton!
    
    
    @IBOutlet weak var postimage: UIImageView!
    
    
    @IBOutlet weak var likecount: UILabel!
    
    @IBOutlet weak var commentcount: UILabel!
    
    @IBOutlet weak var viewscount: UILabel!
    
    var player : AVPlayer!
    var avplayeritem : AVPlayerItem!
    
    var currentfeed : feeds?
    func updatecell(x : feeds , y : Bool , z : Int , w : Bool)
    {
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
        self.commentcount.text = "5"
        self.viewscount.text = "\(x.views) views"
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
        
        if x.type.lowercased() == "video" {
            self.downloadimage(url: x.thumbnail) { (im) in
                if let imm = im as? UIImage {
                    self.postimage.image = imm
                }
            }
            
            if w {
                
                DispatchQueue.global(qos: .userInitiated).async {
                    self.downloadvideo(url: x.activitypath) { (play) in
                        DispatchQueue.main.async {
                            if play?.status == .readyToPlay {
                                play?.play()
                            }
                            self.postimage.isHidden = true
                            
                        }
                    }
                }
            }
            

            
            
            
        }
        else {
            self.downloadimage(url: x.activitypath) { (im) in
                if let imm = im as? UIImage {
                    self.postimage.image = imm
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
    
    
    
    @IBAction func checkboxtapped(_ sender: UIButton) {
        
        print("hey")
        if selectbutton.image(for: .normal) != UIImage(named: "check-solid") {
            if JurycontestViewController.allowedfurtherselection == false {
                    return
                }
            
//            selectbutton.backgroundColor = UIColor.black
            selectbutton.setImage(UIImage(named: "check-solid"), for: .normal)
            if let t = self.currentfeed {
                self.passwinner!(t)
            }
        }
        else {
//            selectbutton.backgroundColor = UIColor.clear
            selectbutton.setImage(UIImage(named: ""), for: .normal)
            if let t = self.currentfeed {
                self.removewinner!(t)
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
            
            
            layer.frame = CoreGraphics.CGRect(x: self.postimage.frame.origin.x,
                                              y: self.postimage.frame.origin.y + 5,
                                              width: self.postimage.frame.size.width,
                                              height: self.postimage.frame.size.height
            )
            //        layer.bounds.size.height = 170
            layer.cornerRadius = 10
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
        
        
        
        
    }
    
    
    
    @objc func playerEndedPlaying(_ notification: Notification) {
        DispatchQueue.main.async {[weak self] in
            self!.player?.seek(to: CMTime.zero)
            self!.player?.play()
            //        self!.playbtn.setTitle("Play", for: .normal)
        }
    }

    
    
    
}
