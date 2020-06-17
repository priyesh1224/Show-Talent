//
//  CategorywiseeventsTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 28/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class CategorywiseeventsTableViewCell: UITableViewCell {

    @IBOutlet weak var userprofileimage: UIImageView!
    
    @IBOutlet weak var eventname: Customlabel!
    
    @IBOutlet weak var eventpostedin: UITextView!
    
    
    @IBOutlet weak var eventimage: UIImageView!
    
    @IBOutlet weak var knowmorebtn: UIButton!
    
    var currentevent: customstrevent?
    var currentshare : grouppost?
    
    @IBOutlet weak var startenddate: UILabel!
    
    @IBOutlet weak var reviewsbtn: UIButton!
    
    var sendbackdata : ((_ c : customstrevent) -> ())?
    var sendbackdata2 : ((_ c : grouppost) -> ())?
    
    @IBOutlet weak var participatebtn: UIButton!
    
    @IBOutlet weak var interestedpeople: UILabel!
    
    
    @IBOutlet weak var sv: UIStackView!
    var timer:Timer?
    var timeLeft = 0
    
    var mode = ""
    
    @IBOutlet weak var timelabelupper: UITextView!
    @IBOutlet weak var timeLabel: UITextView!
    
    func setupTimer() {
        var tl = self.currentevent?.x.resulton
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
        print(date)
        print(ttday)
        let cal = Calendar.current
        
        let components = cal.dateComponents([Calendar.Component.day], from: ttday  , to: date ?? Date())
        let components2 = cal.dateComponents([Calendar.Component.hour], from: ttday  , to: date ?? Date())
        let components3 = cal.dateComponents([Calendar.Component.minute], from: ttday  , to: date ?? Date())
        let components4 = cal.dateComponents([Calendar.Component.second], from: ttday  , to: date ?? Date())
        
        var passdata = 0
        print("passdata is \(components.day) \(components2.hour) \(components3.minute)  \(components4.second)")
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
            self.timeLabel.text = "Contest over"
        }
        else {
            self.timeLabel.text = "\(h)H \(m)M \(s)S"
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

    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
        timer = nil
    }
    
    
    deinit {
         timer?.invalidate()
         timer = nil
    }
    
    func updatecell2(x : grouppost)
    {
        self.eventimage.clipsToBounds = true

        mode = x.posttype.lowercased()
        self.knowmorebtn.isHidden = true
//        reviewsbtn.isHidden = true
//        reviewsbtn.setTitle("", for: .normal)
        sv.isHidden = true
        self.participatebtn.layer.cornerRadius = 15
        self.participatebtn.layer.borderColor = UIColor.white.cgColor
        self.participatebtn.layer.borderWidth = 2
        self.participatebtn.isEnabled = true
        var st = ""
       
        self.knowmorebtn.setTitle(st, for: .normal)
        
        self.currentshare = x
        self.selectionStyle = .none
        self.userprofileimage.layer.cornerRadius = self.userprofileimage.frame.size.height/2
        self.userprofileimage.clipsToBounds = true
        self.eventimage.layer.cornerRadius = 10
        self.knowmorebtn.layer.cornerRadius = 15
        
        self.eventname.text = x.contestname.capitalized
        self.eventpostedin.text = ""
        
        self.downloadimage(url: x.profileimage) { (im) in
            if let iim = im as? UIImage {
                self.userprofileimage.image = iim
            }
        }
        
        self.downloadimage(url: x.contestimage) { (im) in
            if let iim = im as? UIImage {
                self.eventimage.image = iim
            }
        }
        
        
        var usefuldate = ""
        var usefuldate2 = ""
        var usefultime = ""
        var sd = ""
        var sm = ""
        var ed = ""
        var em = ""
        var smon = ""
        var emon = ""
        var d = x.createon
        if d != "" && d != " " {
            var arr = d.components(separatedBy: "T")
            if arr.count == 2 {
                usefuldate = arr[0]
                var tem = usefuldate.components(separatedBy: "-")
                sm = tem[1]
                sd = tem[2]
                
            }
            else if d.count == 10 {
                usefuldate = d
                var tem = usefuldate.components(separatedBy: "-")
                sm = tem[1]
                sd = tem[2]
            }
        }
//        d = x.x.resulton
//        if d != "" && d != " " {
//            var arr = d.components(separatedBy: "T")
//            if arr.count == 2 {
//                usefuldate2 = arr[0]
//                var tem = usefuldate2.components(separatedBy: "-")
//                em = tem[1]
//                ed = tem[2]
//            }
//            else if d.count == 10 {
//                usefuldate2 = d
//                var tem = usefuldate2.components(separatedBy: "-")
//                em = tem[1]
//                ed = tem[2]
//            }
//        }
        
        if sm == "1" || sm == "01"
        {
            smon = "Jan"
        }
        else if sm == "2" || sm == "02"
        {
            smon = "Feb"
        }
        else if sm == "3" || sm == "03"
        {
            smon = "Mar"
        }
        else if sm == "4" || sm == "04"
        {
            smon = "Apr"
        }
        else if sm == "5" || sm == "05"
        {
            smon = "May"
        }
        else if sm == "6" || sm == "06"
        {
            smon = "Jun"
        }
        else if sm == "7" || sm == "07"
        {
            smon = "Jul"
        }
        else if sm == "8" || sm == "08"
        {
            smon = "Aug"
        }
        else if sm == "9" || sm == "09"
        {
            smon = "Sep"
        }
        else if sm == "10" || sm == "10"
        {
            smon = "Oct"
        }
        else if sm == "11" || sm == "11"
        {
            smon = "Nov"
        }
        else if sm == "12" || sm == "12"
        {
            smon = "Dec"
        }
        
        
        if em == "1" || em == "01"
        {
            emon = "Jan"
        }
        else if em == "2" || em == "02"
        {
            emon = "Feb"
        }
        else if em == "3" || em == "03"
        {
            emon = "Mar"
        }
        else if em == "4" || em == "04"
        {
            emon = "Apr"
        }
        else if em == "5" || em == "05"
        {
            emon = "May"
        }
        else if em == "6" || em == "06"
        {
            emon = "Jun"
        }
        else if em == "7" || em == "07"
        {
            emon = "Jul"
        }
        else if em == "8" || em == "08"
        {
            emon = "Aug"
        }
        else if em == "9" || em == "09"
        {
            emon = "Sep"
        }
        else if em == "10" || em == "10"
        {
            emon = "Oct"
        }
        else if em == "11" || em == "11"
        {
            emon = "Nov"
        }
        else if em == "12" || em == "12"
        {
            emon = "Dec"
        }
        
        self.startenddate.text = "\(sd) \(smon)"
    }
    
    
    
    
    func updatecell(x : customstrevent)
    {
        self.eventimage.clipsToBounds = true
        self.participatebtn.layer.cornerRadius = 15
        self.participatebtn.layer.borderColor = UIColor.white.cgColor
        self.participatebtn.layer.borderWidth = 2
        self.participatebtn.isEnabled = false
        var st = ""
        if x.x.entryfee == 0 {
            st = "Free Entry"
        }
        else {
            st = "Entry Fee : \(x.x.entryfee)"
        }
        self.knowmorebtn.setTitle(st, for: .normal)
        
        self.currentevent = x
        if x.x.runningstatus.lowercased() == "closed" {
            self.timeLabel.text = ""
            self.timelabelupper.text = "Contest closed"
        }
        else {
            self.timelabelupper.text = "Contest Ends in :"
            setupTimer()
        }
        
        self.selectionStyle = .none
        self.userprofileimage.layer.cornerRadius = 27
        self.eventimage.layer.cornerRadius = 10
        self.knowmorebtn.layer.cornerRadius = 15
        
        self.eventname.text = x.x.contestname.capitalized
        self.eventpostedin.text = "Created by \(x.creatorname.capitalized)"
        
        self.downloadimage(url: x.creatorprofileimage) { (im) in
            if let iim = im as? UIImage {
                self.userprofileimage.image = iim
            }
        }
        
        self.downloadimage(url: x.contestimage) { (im) in
            if let iim = im as? UIImage {
                self.eventimage.image = iim
            }
        }
        
      
        self.interestedpeople.text = "\(x.totalparticipants) People Interested"
        var usefuldate = ""
        var usefuldate2 = ""
               var usefultime = ""
        var sd = ""
        var sm = ""
        var ed = ""
        var em = ""
        var smon = ""
        var emon = ""
        var d = x.x.conteststart
                   if d != "" && d != " " {
                       var arr = d.components(separatedBy: "T")
                       if arr.count == 2 {
                           usefuldate = arr[0]
                        var tem = usefuldate.components(separatedBy: "-")
                        sm = tem[1]
                        sd = tem[2]
                        
                       }
                       else if d.count == 10 {
                           usefuldate = d
                        var tem = usefuldate.components(separatedBy: "-")
                        sm = tem[1]
                        sd = tem[2]
                       }
                   }
        d = x.x.resulton
        if d != "" && d != " " {
            var arr = d.components(separatedBy: "T")
            if arr.count == 2 {
                usefuldate2 = arr[0]
                var tem = usefuldate2.components(separatedBy: "-")
                em = tem[1]
                ed = tem[2]
            }
            else if d.count == 10 {
                usefuldate2 = d
                var tem = usefuldate2.components(separatedBy: "-")
                em = tem[1]
                ed = tem[2]
            }
        }
        
        if sm == "1" || sm == "01"
        {
            smon = "Jan"
        }
        else if sm == "2" || sm == "02"
        {
            smon = "Feb"
        }
        else if sm == "3" || sm == "03"
        {
            smon = "Mar"
        }
        else if sm == "4" || sm == "04"
        {
            smon = "Apr"
        }
        else if sm == "5" || sm == "05"
        {
            smon = "May"
        }
        else if sm == "6" || sm == "06"
        {
            smon = "Jun"
        }
        else if sm == "7" || sm == "07"
        {
            smon = "Jul"
        }
        else if sm == "8" || sm == "08"
        {
            smon = "Aug"
        }
        else if sm == "9" || sm == "09"
        {
            smon = "Sep"
        }
        else if sm == "10" || sm == "10"
        {
            smon = "Oct"
        }
        else if sm == "11" || sm == "11"
        {
            smon = "Nov"
        }
        else if sm == "12" || sm == "12"
        {
            smon = "Dec"
        }
        
        
        if em == "1" || em == "01"
        {
            emon = "Jan"
        }
        else if em == "2" || em == "02"
        {
            emon = "Feb"
        }
        else if em == "3" || em == "03"
        {
            emon = "Mar"
        }
        else if em == "4" || em == "04"
        {
            emon = "Apr"
        }
        else if em == "5" || em == "05"
        {
            emon = "May"
        }
        else if em == "6" || em == "06"
        {
            emon = "Jun"
        }
        else if em == "7" || em == "07"
        {
            emon = "Jul"
        }
        else if em == "8" || em == "08"
        {
            emon = "Aug"
        }
        else if em == "9" || em == "09"
        {
            emon = "Sep"
        }
        else if em == "10" || em == "10"
        {
            emon = "Oct"
        }
        else if em == "11" || em == "11"
        {
            emon = "Nov"
        }
        else if em == "12" || em == "12"
        {
            emon = "Dec"
        }
        
        self.startenddate.text = "\(sd) \(smon)  - \(ed) \(emon)"
        
        
        
    }
    
    
    @IBAction func knowmorepressed(_ sender: UIButton) {
        if let c = self.currentevent {
            self.sendbackdata!(c)
        }
        
    }
    
    @IBAction func participatebtnclicked(_ sender: UIButton) {
        
        
        if mode  == "share" {
            print("Entered share")
            if let c = self.currentshare as? grouppost {
                print("hey")
                self.sendbackdata2!(c)
            }
        }
        else {
            if let c = self.currentevent as? customstrevent {
                self.sendbackdata!(c)
            }
        }
        
        
        
        
    }
    
    @IBAction func reviewsbtnpressed(_ sender: UIButton) {
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



extension Date {
    
    func years(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }
    
    func months(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    func hours(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }
    
    func minutes(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
    }
    
    func seconds(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }
    
}
