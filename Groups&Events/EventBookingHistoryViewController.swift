//
//  EventBookingHistoryViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/28/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


struct bookedevent
{
    var id : Int
    var eventid : Int
    var userid : String
    var firstname : String
    var lastname : String
    var email : String
    var mobile : String
    var countrycode : String
    var bookon : String
    var location : String
    var noofpeople : Int
    var events : languagewiseevent
}

class EventBookingHistoryViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    @IBOutlet weak var nodatawarning: Customlabel!
    
    var bookedevents : [bookedevent] = []
    var tappedevent : bookedevent?
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    var page = 0
    var datalocked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nodatawarning.isHidden = true
        notificationindicator.layer.cornerRadius = 10
        table.delegate = self
        table.dataSource = self
        self.fetchdata(pg: self.page)
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func fetchdata(pg : Int)
    {
        var uid = UserDefaults.standard.value(forKey: "refid") as! String
//        var url = "\(Constants.K_baseUrl)\(Constants.getbookedevents)?userId=\(uid)"
var url = "http://thcoreapi.maraekat.com/api/v1/EventPublisher/GetEventBookingList?userId=066af0e3-5394-4a86-9e99-acdeb9879ac5"
        var r = BaseServiceClass()
        var params : Dictionary<String,Any> = ["Page": pg,"PageSize": 10]
        print(url)
        print(params)
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                print(res)
                if let dd = res["Results"] as? Dictionary<String,Any> {
                    if let data = dd["Data"] as? [Dictionary<String,Any>] {
                        for each in data {
                            var id = 0
                            var eventid = 0
                            var userid = ""
                            var fn = ""
                            var ln = ""
                            var em = ""
                            var mob = ""
                            var countrycode = ""
                            var bookon = ""
                            var location = ""
                            var noofpeople = 0
                            
                            if let i = each["Id"] as? Int {
                                id = i
                            }
                            if let i = each["EventId"] as? Int {
                                eventid = i
                            }
                            if let i = each["UserId"] as? String {
                                userid = i
                            }
                            if let i = each["FirstName"] as? String {
                                fn = i
                            }
                            if let i = each["Lastname"] as? String {
                                ln = i
                            }
                            if let i = each["Email"] as? String{
                                em = i
                            }
                            if let i = each["Mobile"] as? String {
                                mob = i
                            }
                            if let i = each["CountryCode"] as? String {
                                countrycode = i
                            }
                            if let i = each["BookOn"] as? String {
                                bookon = i
                            }
                            if let i = each["Location"] as? String {
                                location = i
                            }
                            if let i = each["NoOfPeople"] as? Int {
                                noofpeople = i
                            }
                            
                            var x : languagewiseevent?
                            if let lan = each["Events"] as? Dictionary<String,Any> {
                                var about = ""
                                var add1 = ""
                                var add2 = ""
                                var agelimit = ""
                                var artist = ""
                                var category = ""
                                var city = ""
                                var createdby = ""
                                var createon = ""
                                var eventtime = ""
                                var eventtype = ""
                                var fee = 0
                                var fromdate = ""
                                var heading  = ""
                                var id = 0
                                var imagepath = ""
                                var isactive = 0
                                var language = ""
                                var refcategory = 0
                                var reflanguage = 0
                                var termsandcondtns = ""
                                var thumbnail = ""
                                var todate = ""
                                
                                if let a = lan["About"] as? String {
                                    about = a
                                }
                                if let a = lan["Address1"] as? String {
                                    add1 = a
                                }
                                if let a = lan["Address2"] as? String {
                                    add2 = a
                                }
                                if let a = lan["AgeLimit"] as? String {
                                    agelimit = a
                                }
                                if let a = lan["Artist"] as? String {
                                    artist = a
                                }
                                if let a = lan["Category"] as? String {
                                    category = a
                                }
                                if let a = lan["City"] as? String {
                                    city = a
                                }
                                if let a = lan["CreateBy"] as? String {
                                    createdby = a
                                }
                                if let a = lan["CreateOn"] as? String {
                                    createon = a
                                }
                                if let a = lan["EventTime"] as? String {
                                    eventtime = a
                                }
                                if let a = lan["EventType"] as? String {
                                    eventtype = a
                                }
                                if let a = lan["Fee"] as? Int {
                                    fee = a
                                }
                                if let a = lan["FromDate"] as? String {
                                    fromdate = a
                                }
                                if let a = lan["Heading"] as? String {
                                    heading = a
                                }
                                if let a = lan["ID"] as? Int {
                                    id = a
                                }
                                if let a = lan["ImagePath"] as? String {
                                    imagepath = a
                                }
                                if let a = lan["IsActive"] as? Int {
                                    isactive = a
                                }
                                if let a = lan["Language"] as? String {
                                    language = a
                                }
                                if let a = lan["RefCategory"] as? Int {
                                    refcategory = a
                                }
                                if let a = lan["RefLanguage"] as? Int {
                                    reflanguage = a
                                }
                                if let a = lan["TermCondition"] as? String {
                                    termsandcondtns = a
                                }
                                if let a = lan["Thumbnail"] as? String {
                                    thumbnail = a
                                }
                                if let a = lan["ToDate"] as? String {
                                    todate = a
                                }
                                
                                
                                 x  = languagewiseevent(about: about, address1: add1, address2: add2, agelimit: agelimit, artist: artist, category: category, city: city, createby: createdby, createon: createon, eventtime: eventtime, eventtype: eventtype, fee: fee, fromdate: fromdate, heading: heading, id: id, imagepath: imagepath, isactive: isactive, langauge: language, refcategory: refcategory, reflanguage: reflanguage, termsandconditions: termsandcondtns, thumbnail: thumbnail, todate: todate)
                            }
                            
                            
                            var yy = bookedevent(id: id, eventid: eventid, userid: userid, firstname: fn, lastname: ln, email: em, mobile: mob, countrycode: countrycode, bookon: bookon, location: location, noofpeople: noofpeople, events: x!)
                            self.bookedevents.append(yy)
                            
                            
                            
                            
                        }
                        
                        if self.bookedevents.count == 0 {
                            self.nodatawarning.isHidden = false
                        }
                        else {
                            self.nodatawarning.isHidden = true

                        }
                        self.table.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookedevents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventbooking", for: indexPath) as? EventBookingHistoryTableViewCell {
            cell.update(x : self.bookedevents[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tappedevent = self.bookedevents[indexPath.row]
        self.performSegue(withIdentifier: "descevent", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.bookedevents.count - 3 && datalocked == false && self.bookedevents.count >= 10 {
            page = page + 1
            self.fetchdata(pg: page)
            datalocked = true
        }
        if indexPath.row == self.bookedevents.count {
            datalocked = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? CustomeventinfoViewController {
            seg.gotevent = self.tappedevent?.events
            seg.alreadybooked = true
        }
    }

}
