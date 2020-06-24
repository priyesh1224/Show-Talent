//
//  JoinedeventinformationTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 22/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class JoinedeventinformationTableViewCell: UITableViewCell , UITableViewDelegate , UITableViewDataSource {
 
 var publishcontest : ((_ pressed : Bool) -> ())?
var reruncontest : ((_ pressed : Bool) -> ())?
var leftcontest : ((_ pressed : Bool) -> ())?
   var participatebtnpressed : ((_ pressed : Bool) -> ())?
    var taketoedit : ((_ pressed : Bool,_ id : Int) -> ())?
    var taketocontestshare : ((_ pressed : Bool,_ id : Int) -> ())?
    var taketocontestpost : ((_ pressed : Bool,_ id : Int) -> ())?
    var publisheddone : ((_ x : Bool) -> ())?
    
    @IBOutlet var winnerspopupheight: NSLayoutConstraint!
    
    @IBOutlet var winnerspopup: UIView!
    
    @IBOutlet var winnerstableview: UITableView!
    
    var currentevent : strevent?
    @IBOutlet weak var eventname: UITextView!
    
    @IBOutlet weak var eventpostedin: UITextView!
    
    
    @IBOutlet weak var participatebutton: UIButton!
    
    @IBOutlet weak var peopleinterestedin: UITextView!
    
    @IBOutlet weak var reviews: UIButton!
    
    @IBOutlet weak var startdateenddate: UITextView!
    
    
    @IBOutlet weak var eventdescription: UITextView!
    
    var allwinns : [juryorwinner] = []
    
    var totalparticipants = 0
    
    var currenttimetopublish = false
    
    
    @IBOutlet weak var leavecontest: UIButton!
    
    @IBOutlet weak var contesttimer: UILabel!
    
    
    @IBOutlet weak var contestprice: UITextView!
    
    
    @IBOutlet weak var noofwinners: UITextView!
    
    
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
            print("Result Date is \(d)")
            print("Today is \(today)")
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
        
        
        print("Started very begining with \(timeLeft)")
        
        
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
        print("Started with \(self.timeLeft)")
        
        
        
        
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds : self.timeLeft)
        
        if s < 0 {
            self.contesttimer.text = "Contest over"
            self.timer?.invalidate()
            self.timer = nil
        }
        else {
            self.contesttimer.text = "\(h)H \(m)M \(s)S"
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
    
    
    @IBAction func participatepressed(_ sender: UIButton) {
        
        if let tit = self.participatebutton.titleLabel?.text as? String {
            if tit == "Contest Closed" {
            }
            if tit == "Contest Share" {
                self.taketocontestshare!(true,currentevent!.contestid)
            }
            else if tit == "Participate" {
                       self.participatebtnpressed!(true)
                       JoinedeventsViewController.participatebtnpressedanswer = {a in
                           if a {
                               self.participatebutton.setTitle("Request sent", for: .normal)
                           }
                       }
                   }
            else if tit == "Post" {
                
                self.taketocontestpost!(true,self.currentevent?.contestid ?? 0)
            }
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func leavecontestpressed(_ sender: Any) {
         let tit = self.participatebutton.titleLabel?.text as? String
            
        
        if tit == "Re-Run Contest" {
            
        }
        else if currenttimetopublish {
            self.publishcontest!(true)
        }
        else {
            self.leftcontest!(true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10 {
            return self.allwinns.count
        }
        return 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 10 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "winnclosed", for: indexPath) as? ShowwinnerafterclosedTableViewCell {
                cell.updatecell(x: self.allwinns[indexPath.row], p: (indexPath.row + 1), price: "\(self.currentevent?.contestprice ?? "") \(self.currentevent?.contestpricetype ?? "")")
                return cell
            }
        }
        return UITableViewCell()
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Winners"
    }
    
    @IBAction func reviewspressed(_ sender: UIButton) {
    }
    
    
    func updatecell(x:strevent,b : Bool, c : Bool , conimage : String , allwinners : [juryorwinner] , participants : Int , isllowed : Bool , timetopublish : Bool) {
        
        self.currentevent = x
        setupTimer()
        self.currenttimetopublish = timetopublish
        leavecontest.layer.cornerRadius = 25
        self.contestprice.text = x.contestprice.capitalized
        self.noofwinners.text = x.resulttype.capitalized
        self.participatebutton.isHidden = false
        self.allwinns = allwinners
        print("Hey")
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%")
        print(allwinners)
        winnerstableview.delegate = self as! UITableViewDelegate
        winnerstableview.dataSource = self as! UITableViewDataSource
        winnerspopup.layer.cornerRadius = 10
        winnerspopupheight.constant = CGFloat(allwinners.count * 40) + 100
        if allwinners.count == 0 {
            self.winnerspopup.isHidden = true
            self.winnerstableview.reloadData()
        }
        else {
            self.winnerspopup.isHidden = false
        }
        
        self.publisheddone = {a in
            if a {
                if timetopublish {
                    self.leavecontest.isHidden = true
                }
            }
        }
        
        
        self.selectionStyle = .none
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        if x.runningstatus.lowercased() == "close" || x.runningstatus.lowercased() == "closed" {
            self.participatebutton.setTitle("Contest Closed", for: .normal)
            self.leavecontest.setTitle("Re-Run Contest", for: .normal)
            self.leavecontest.isHidden = false
            self.participatebutton.isHidden = false
            self.participatebutton.backgroundColor = UIColor.clear
            self.participatebutton.setTitleColor(UIColor.red, for: .normal)
        }
        else if x.userid == userid {
            self.participatebutton.setTitle("Contest Share", for: .normal)
            self.leavecontest.isHidden = true
            self.participatebutton.backgroundColor = UIColor.red
            self.participatebutton.isHidden = false

        }
        else if b == false && c == false {
            self.participatebutton.setTitle("Participate", for: .normal)
            self.leavecontest.isHidden = true
            self.participatebutton.isHidden = false
            self.participatebutton.backgroundColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)


        }
        else if (b == false && c == true) || (b == true && c == false) {
            self.participatebutton.isHidden = true
            self.leavecontest.isHidden = true

        }
        else if b == true && c == true {
            if isllowed == true {
            self.participatebutton.setTitle("Post", for: .normal)
                self.participatebutton.isEnabled = true
            }
            else {
                self.participatebutton.setTitle("Already Posted", for: .normal)
                self.participatebutton.isEnabled = false

            }
            self.leavecontest.isHidden = false
            self.participatebutton.isHidden = false
            self.participatebutton.backgroundColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)



        }
        
        print("Time to publish is \(timetopublish)")
        
        if timetopublish == true {
            self.leavecontest.isHidden = false
            self.leavecontest.setTitle("Publish Contest", for: .normal)
        }
        
        
        var usefuldate = ""
        var usefultime = ""
        var d = x.conteststart
            if d != "" && d != " " {
                var arr = d.components(separatedBy: "T")
                if arr.count == 2 {
                    usefuldate = arr[0]
                    usefultime = arr[1]
                }
                else if d.count == 10 {
                    usefuldate = d
                }
            }
        
      
        if usefuldate != "" {
            var darr = usefultime.components(separatedBy: ".")
            usefultime = darr[0]
            
        }
        
        var usefuldate1 = ""
          var usefultime1 = ""
           d = x.resulton
              if d != "" && d != " " {
                  var arr = d.components(separatedBy: "T")
                  if arr.count == 2 {
                      usefuldate1 = arr[0]
                      usefultime1 = arr[1]
                  }
                  else if d.count == 10 {
                      usefuldate1 = d
                  }
              }
          
        
          if usefuldate1 != "" {
              var darr = usefultime1.components(separatedBy: ".")
              usefultime1 = darr[0]
              
          }
        var wholedate = ""
        self.selectionStyle = .none
        self.participatebutton.layer.cornerRadius = 20
        self.eventname.text = x.contestname.capitalized
        self.eventpostedin.text = "Posted in \(x.allowcategory)"
        self.peopleinterestedin.text = "\(participants) people interested"
        self.startdateenddate.text = "Start date : \(usefuldate) \(usefultime) , End date : \(usefuldate1) \(usefultime1)"
        self.eventdescription.text = x.description.capitalized
        
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
