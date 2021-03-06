//
//  ThemefixedcellTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/18/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ThemefixedcellTableViewCell: UITableViewCell, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet weak var interestedpeopple: UITextView!
    
    var postpressed : ((_ x : String) -> Void)?
    var sharepressed : ((_ x : String) -> Void)?
    
    var needtochangejoinedandisallowed : ((_ x : Bool) -> Void)?
    
   
    @IBOutlet weak var postvideobtn: UIButton!
    
    @IBOutlet weak var contestsharebtn: UIButton!
    
    
    @IBOutlet weak var contestname: UILabel!
    
    
    @IBOutlet weak var winnersannpuncement: UIView!
    
    
    @IBOutlet weak var winnersnameview: UIView!
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    @IBOutlet weak var estimatedtimestackview: UIStackView!
    
    
    @IBOutlet weak var datewrapperview: UIView!
    
    @IBOutlet weak var datewrapperviewhieght: NSLayoutConstraint!
    
    @IBOutlet weak var contestpostedin: UITextView!
    
    
    @IBOutlet weak var startdate: UILabel!
    
    @IBOutlet weak var enddate: UILabel!
    
    @IBOutlet weak var timings: UILabel!
    
    @IBOutlet weak var timingsupperhead: UITextView!
    
    var currentevent : strevent?
    var currentpretheme : pretheme?
    var pc  = ""
    var sc = ""
    var winnerlist : [juryorwinner] = []
    
    var timer:Timer?
    var timeLeft = 0
    
    func setupTimer() {
        var tl = self.currentevent?.resulton
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
        var date = dateFormatter.date(from: tl ?? "")
        let today = dateFormatter.date(from: dateFormatter.string(from: Date()))
        var ttday : Date = Date()
        if let d  = date, let t = today {
           
            ttday = t
            
        }
        if let d = date {} else {
            let dateFormatter2 = DateFormatter()
                   dateFormatter2.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                   dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    date = dateFormatter2.date(from: tl ?? "")
        }
        let cal = Calendar.current
        
        let components = cal.dateComponents([Calendar.Component.day], from: ttday  , to: date ?? Date())
        let components2 = cal.dateComponents([Calendar.Component.hour], from: ttday  , to: date ?? Date())
        let components3 = cal.dateComponents([Calendar.Component.minute], from: ttday  , to: date ?? Date())
        let components4 = cal.dateComponents([Calendar.Component.second], from: ttday  , to: date ?? Date())
        
        var passdata = 0
        if let p = components4.second
        {
            if p > 0 {
                passdata = p
            }
            else {
                passdata = p
            }
        }
        
        
        timeLeft =  passdata
        
        
      
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        
        RunLoop.current.add(timer!, forMode: .common)
        self.timer?.fire()
        
        
        //        self.timer?.fire()
        
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func onTimerFires() {
        timeLeft = timeLeft -  1
       
        
        
        
        
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds : self.timeLeft)
        
        if s < 0 {
            self.timings.text = "Contest over"
            self.timer?.invalidate()
            self.timer = nil
        }
        else {
            self.timings.text = "\(h)H \(m)M \(s)S"
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
    
    
    func update2(x : pretheme , p : String , s : String , creatingcontest : Bool)
    {
        pc = p
        sc = s
        self.currentpretheme = x
        self.selectionStyle = .none
        setupextraview()
        
        postvideobtn.layer.cornerRadius = postvideobtn.frame.size.height/2
        contestsharebtn.layer.cornerRadius = contestsharebtn.frame.size.height/2
        contestname.highlightedTextColor = UIColor.clear
        contestname.text  = x.contestname.capitalized
        contestpostedin.text = "Contest posted in \(x.categoryname.capitalized)"
        startdate.text  = "Start Date : \(x.conteststart.components(separatedBy: "T")[0])"
        enddate.text = "End Date : \(x.resulton.components(separatedBy: "T")[0])"
        timings.text = ""
        
        self.postvideobtn.isEnabled = false
        self.contestsharebtn.isEnabled = false
        
        
        
        
    }
    
    
    
    func update(x : strevent , p : String , s : String , b : Bool , c : Bool , isallowed : Bool , timetopublish : Bool , winnerlist : [juryorwinner] , totalparticipants : Int)
    {
        print("At time of update \(x.runningstatus.lowercased()) and \(winnerlist.count)")
        self.interestedpeopple.text = "\(totalparticipants) People Interested"
        if x.runningstatus.lowercased() == "closed" && winnerlist.count > 0 {
        self.winnersannpuncement.clipsToBounds = true
            winnersannpuncement.isHidden = false
        self.winnerlist = winnerlist
        winnersannpuncement.layer.cornerRadius = 10
        winnersnameview.layer.cornerRadius = 25
        collection.delegate = self
        collection.dataSource = self
        var l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.itemSize = CGSize(width: 200, height: 120)
        collection.reloadData()
        collection.collectionViewLayout = l
        collection.reloadData()
        }
        else {
            winnersannpuncement.isHidden = true
        }
       
        pc = p
        sc = s
        self.currentevent = x
        self.selectionStyle = .none
       setupextraview()
        setupTimer()
        postvideobtn.layer.cornerRadius = postvideobtn.frame.size.height/2
         contestsharebtn.layer.cornerRadius = contestsharebtn.frame.size.height/2
        contestname.highlightedTextColor = UIColor.clear
        contestname.text  = x.contestname.capitalized
        contestpostedin.text = "Contest posted in \(x.allowcategory.capitalized)"
        startdate.text  = "Start Date : \(x.conteststart.components(separatedBy: "T")[0])"
        enddate.text = "End Date : \(x.resulton.components(separatedBy: "T")[0])"
        timings.text = ""
        
        JoinedeventsViewController.participatebtnpressedanswer = { a in
            if a {
                self.postvideobtn.setTitle("Post", for: .normal)
            }
        }
      
        JoinedeventsViewController.justuploaded = { a in
            if a {
                self.postvideobtn.setTitle("Already Posted", for: .normal)
                self.contestsharebtn.setTitle("Leave Contest", for: .normal)
                self.postvideobtn.isHidden = false
                self.contestsharebtn.isHidden = false
                self.needtochangejoinedandisallowed!(true)
            }
            }.self
        
        if let aa = x as? strevent {
            
            var userid = UserDefaults.standard.value(forKey: "refid") as! String
            if aa.runningstatus.lowercased() == "close" || x.runningstatus.lowercased() == "closed" {
                self.timingsupperhead.text = "Contest over"
                self.postvideobtn.isHidden = true
                self.contestsharebtn.isHidden = false
                self.contestsharebtn.setTitle("Re-Run Contest", for: .normal)
            }
            else if aa.userid == userid {
                if aa.isactive {
                    self.contestsharebtn.setTitle("Contest Share", for: .normal)
                    self.postvideobtn.setTitle("Invite", for: .normal)
                    self.contestsharebtn.isHidden = false
                    self.postvideobtn.isHidden = true
                }
                else {
                    self.postvideobtn.setTitle("Publish Contest", for: .normal)
                    self.estimatedtimestackview.isHidden = true
                    startdate.text  = "Start Date : \(x.conteststart.components(separatedBy: "T")[0]) | End Date : \(x.resulton.components(separatedBy: "T")[0])"
                    enddate.text = ""
                    datewrapperviewhieght.constant = 60
                    self.contestsharebtn.isHidden = true
                    self.postvideobtn.isHidden = false
                }
                
            }
            else if b == false {
                self.postvideobtn.setTitle("Participate", for: .normal)
                self.postvideobtn.isHidden = false
                self.contestsharebtn.isHidden = true
                
                
            }
            
            else if b == true {
                if isallowed == true {
                    self.postvideobtn.setTitle("Post", for: .normal)
                    self.contestsharebtn.setTitle("Leave Contest", for: .normal)
                    self.postvideobtn.isHidden = false
                    self.contestsharebtn.isHidden = false            }
                else {
                    self.postvideobtn.setTitle("Already Posted", for: .normal)
                     self.contestsharebtn.setTitle("Leave Contest", for: .normal)
                    self.postvideobtn.isHidden = false
                    self.contestsharebtn.isHidden = false
                    
                }
            }
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: 200, height: 120)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.winnerlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winnmodified", for: indexPath) as? WinnersmodifiedCollectionViewCell {
            cell.update(x : self.winnerlist[indexPath.row] , y : self.currentevent)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func setupextraview()
    {
        if let pcc = UIColor(hexString: pc) as? UIColor {
            self.postvideobtn.backgroundColor = pcc
        }
        if let pcc = UIColor(hexString: sc) as? UIColor {
            self.contestsharebtn.backgroundColor = pcc
        }
        
    }
    
    
    @IBAction func postvideopressed(_ sender: Any) {
        self.postpressed!(self.postvideobtn.titleLabel?.text ?? "")
    }
    
    
    
    @IBAction func contestsharebtnpressed(_ sender: Any) {
        self.sharepressed!(self.contestsharebtn.titleLabel?.text ?? "")
    }
    
    
    
}
