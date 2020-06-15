//
//  AudioUploadViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/27/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AVFoundation

class AudioUploadViewController: UIViewController , AVAudioRecorderDelegate , AVAudioPlayerDelegate{
    
    var sendprogress : ((_ done : Progress) -> Void)?
    
    var audiouploaded : ((_ done : Bool) -> Void)?

    @IBOutlet weak var playbtn: UIButton!
    
    @IBOutlet weak var headphonesbtn: UIImageView!
    
    @IBOutlet weak var outerview2: UIView!
    
    @IBOutlet weak var outerview1: UIView!
    @IBOutlet weak var statuslabel: Minorlabel!
    
    @IBOutlet weak var donebtn: CustomButton!
    
    @IBOutlet weak var timerlabel: UILabel!
    var isrecording = false
    
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer?
    var currentselectedcategory : categorybrief?
    
    var uploadurl : URL?
    
    var contestid = 160
    var categoryid = 0
    
    var groupmode = false
    var groupid = 0
    
    var timer:Timer?
    var timeLeft = 0
    
    @IBOutlet weak var audiopreviewview: UIView!
    
    
    @IBOutlet weak var startrecording: CustomButton!
    
    
    
    @IBOutlet weak var newplaybtn: UIButton!
    
    
    
    
    
    
    
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func onTimerFires() {
        timeLeft = timeLeft +  1
        print("Started with \(self.timeLeft)")
        
        
        
        
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds : self.timeLeft)
        
        if s < 0 {
            self.timerlabel.text = "Contest over"
            self.timer?.invalidate()
            self.timer = nil
        }
        else {
            self.timerlabel.text = "\(h):\(m):\(s)"
        }
        
        
        //        s = Int(timeLeft % 60)
        //        print(s)
        //        timeLeft = Int(timeLeft/60)
        //        m = Int(timeLeft % 60)
        //        print(m)
        //        timeLeft = Int(timeLeft/60)
        //        h = Int(timeLeft % 60)
        //        print(h)
        //        timeLeft = Int(timeLeft/60)
        //        d = Int(timeLeft % 60)
        //        print(d)
        //        timeLeft = Int(timeLeft/60)
        //        //                print("\(d)D \(h)Hr \(m)M \(s)S")
        //
        //
        //        self.timeLabel.text = "\(d)D \(h)Hr \(m)M \(s)S"
        
        //                if self.timeLeft <= 0 {
        //                    self.timer?.invalidate()
        //                    self.timer = nil
        //                }
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: .common)
        timer?.invalidate()
        self.timerlabel.text = "0:0:0"
        playbtn.isHidden = true
        donebtn.layer.cornerRadius = 25
        headphonesbtn.layer.cornerRadius = 50
        headphonesbtn.layer.borderColor = UIColor.black.cgColor
        headphonesbtn.layer.borderWidth = 1
        outerview1.layer.cornerRadius = 60
        outerview1.clipsToBounds = true
        outerview2.clipsToBounds = true
        headphonesbtn.backgroundColor = UIColor.white
        outerview2.layer.cornerRadius = 70
        outerview1.backgroundColor = #colorLiteral(red: 0.7725490196, green: 0.9294117647, blue: 0.8274509804, alpha: 1)
        outerview2.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.9647058824, blue: 0.9176470588, alpha: 1)
        startrecording.layer.cornerRadius = 25
        self.timerlabel.text = "00:00:00"
        self.audiopreviewview.isHidden = true
        self.donebtn.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func newplaybtnpressed(_ sender: Any) {
        print("Url is \(whistleRecorder.url.absoluteString)")
        
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.stop()
            newplaybtn.setImage(#imageLiteral(resourceName: "017-play-1"), for: .normal)
            
        }
        else if whistleRecorder?.isRecording == false{
            
            
            var error : NSError?
            do
            {
                print("Did enter do")
                audioPlayer = try AVAudioPlayer(contentsOf: whistleRecorder.url)
                print("did pass try")
                audioPlayer?.delegate = self
                
                if let err = error{
                    print("audioPlayer error: \(err.localizedDescription)")
                }else{
                    newplaybtn.setImage(#imageLiteral(resourceName: "Group 1621"), for: .normal)
                    audioPlayer?.play()
                }
            }
            catch {
                
            }
            
            
            
        }
    }
    
    
    @IBAction func startrecordingtapped(_ sender: Any) {
        
        if isrecording {
            self.whistleRecorder.stop()
            self.headphonesbtn.image = UIImage(named: "001-microphone copy")
            self.startrecording.setTitle("Start Recording", for: .normal)
            audiopreviewview.isHidden = false
            self.donebtn.isEnabled = true
            self.timer?.invalidate()
            
        }
        
        
        if !isrecording {
            whistleRecorder = nil
    
            recordingSession = AVAudioSession.sharedInstance()
            isrecording = true
            do {
                try recordingSession.setCategory(.playAndRecord, mode: .default)
                try recordingSession.setActive(true)
                recordingSession.requestRecordPermission() { [unowned self] allowed in
                    DispatchQueue.main.async {
                        if allowed {
                            self.timeLeft = 0
                            self.timer?.fire()
                            self.startrecording.setTitle("Stop Recording", for: .normal)
                            self.headphonesbtn.image = UIImage(named: "001-microphone")
                            self.audiopreviewview.isHidden = true
                            
                            self.donebtn.isEnabled = false
                            let audioURL = self.getWhistleURL()
                            print(audioURL.absoluteString)
                            
                            // 4
                            let settings = [
                                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                AVSampleRateKey: 12000,
                                AVNumberOfChannelsKey: 1,
                                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                            ]
                            
                            do {
                                // 5
                                self.whistleRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
                                self.uploadurl = audioURL
                                self.whistleRecorder.delegate = self
                                self.whistleRecorder.record()
                            } catch {
                                self.finishRecording(success: false)
                            }
                        }
                    }
                }
            } catch {
                finishRecording(success: false)
            }
        }
    }
    
    
    
    
    
    @IBAction func playbtnpressed(_ sender: Any) {
        
        print("Url is \(whistleRecorder.url.absoluteString)")
        
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.stop()
        }
        else if whistleRecorder?.isRecording == false{
           
            
            var error : NSError?
            do
            {
                print("Did enter do")
                audioPlayer = try AVAudioPlayer(contentsOf: whistleRecorder.url)
                print("did pass try")
                audioPlayer?.delegate = self
                
                if let err = error{
                    print("audioPlayer error: \(err.localizedDescription)")
                }else{
                    audioPlayer?.play()
                }
            }
            catch {
                
            }
            
            
            
        }
        
    }
    
    @IBAction func backbtntapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func UploadAudio()
    {
        
        
        
        let request = VideoUploadRequest()
        
        request.sendprogress = {a in
            DispatchQueue.main.async {
//                self.sendprogress!(a)
            }
            
        }
        
        var cid = 0
        if let cc = self.currentselectedcategory?.categoryid as? Int {
            cid = cc
        }
        
        
        var params = Dictionary<String , Any>()
        
        if groupmode {
            
             params = ["PostType":"Audio","PostDesc":"","GroupId":self.groupid]
        }
        else {
            params = [
                "ContestId":self.contestid,
                "PostType" :"Audio",
                "PostDesc" : "",
                "CategoryId" : self.categoryid,
                "Title" : "Test"]
        }
        
        
       
        
        //        request.upload(videoURL: (videopath?.absoluteURL)!, success: nil, failure: nil,params: params ) { (data, err) in
        //
        //        }
        //
        print(params)
        
        var movieData: NSData?
        if let m = self.uploadurl as? URL {
            do {
                movieData = try NSData(contentsOf: m)
                
            } catch _ {
                movieData = nil
                return
            }
            //        DispatchQueue.global(qos: .background).async {
            if groupmode {
                request.uploadAudio(imagesdata: movieData , params: params , url : Constants.K_baseUrl + Constants.grouppost) {  (response, err) in
                    print(response)
                    if response != nil{
                        print("Audio Uploaded Sucessfully")
                        
                    }
                        
                    else
                    {
                        print("Some thing went wrong please try again!")
                    }
                    
                }
            }
            else {
                request.uploadAudio(imagesdata: movieData , params: params , url : Constants.K_baseUrl + Constants.participatepost) {  (response, err) in
                    print(response)
                    if response != nil{
                        print("Audio Uploaded Sucessfully")
                        self.audiouploaded!(true)
                    }
                        
                    else
                    {
                        print("Some thing went wrong please try again!")
                         self.audiouploaded!(false)
                    }
                    
                }
            }
            
            //        }
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    
   
    
    @IBAction func headphonesbtntapped(_ sender: Any) {
        

    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Heyyyyyyyyyyyyyyy")
        isrecording = false
        
        if !flag {
            finishRecording(success: false)
        }
    }
    
    
    func finishRecording(success: Bool) {
        
        
        whistleRecorder.stop()
        whistleRecorder = nil
        
        if success {
            
            
        } else {
            
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your audio; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func donebtntapped(_ sender: Any) {
        if let m = self.uploadurl as? URL {
            self.UploadAudio()
        }
        
    }
    




 func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

 func getWhistleURL() -> URL {
    return getDocumentsDirectory().appendingPathComponent("post.m4a")
}

}
