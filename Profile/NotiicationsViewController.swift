//
//  NotiicationsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

struct notifications
{
    var title : String
    var body : String
    var datatype : String
    var contestgroupname : String
    var id : String
    var categoryname : String
    var contestentrytype : String
    var createon : String
    var userid : String
    var icon : String
    var wincount : String = ""
    
}

class NotiicationsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var allnotificationsfetced : [notifications] = []
    
    @IBOutlet weak var plusbuttoncovering: UIView!
    

    @IBOutlet weak var plusbutton: UIButton!
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    var tappedid = ""
    var tappedwincount = ""
    var locked = false
    var furtherallowed = true
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupallviews()
        self.table.delegate = self
        self.table.dataSource = self

        setdummydata(pg : page)
        
    }
    
    
    @IBAction func backpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setdummydata(pg : Int)
    {
        let uid = UserDefaults.standard.value(forKey: "refid") as! String
        let url = "\(Constants.K_baseUrl)\(Constants.getnotifications)?userId=\(uid)"
        let r = BaseServiceClass()
        var param : Dictionary<String,Any> = ["Page": pg,
                                              "PageSize": 10]
        var oldcount = self.allnotificationsfetced.count
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        r.postApiRequest(url: url, parameters: param) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let rr = res["Results"] as? Dictionary<String,Any> {
                    if let data = rr["Data"] as? [Dictionary<String,Any>] {
                        for each in data {
                            var title = ""
                            var body = ""
                            var datatype = ""
                            var contestgroupname = ""
                            var id = ""
                            var categoryname = ""
                            var contestentrytype = ""
                            var createon = ""
                            var userid = ""
                            var icon = ""
                            var wc = ""
                            
                            if let e = each["Title"] as? String {
                                title = e
                            }
                            if let e = each["Body"] as? String {
                                body = e
                            }
                            if let ee = each["Data"] as? Dictionary<String,Any> {
                                
                                if let e = ee["ContestName"] as? String {
                                    contestgroupname = e
                                }
                                else if let e = ee["GroupName"] as? String {
                                    contestgroupname = e
                                }
                                
                                if let e = ee["ID"] as? String {
                                    id = e
                                }
                                if let e = ee["CategoryName"] as? String {
                                    categoryname = e
                                }
                               
                                
                                if let e = ee["ContestEntryType"] as? String {
                                    contestentrytype = e
                                }
                                if let e = ee["NoOfWinner"] as? String {
                                    wc = e
                                }
                            }
                            if let e = each["DataType"] as? String {
                                datatype = e
                            }
                           
                            if let e = each["CreateOn"] as? String {
                                createon = e
                            }
                            if let e = each["UserID"] as? String {
                                userid = e
                            }
                            if let e = each["Icon"] as? String {
                                icon = e
                            }
                            
                            var notif = notifications(title: title, body: body, datatype: datatype, contestgroupname: contestgroupname, id: id, categoryname: categoryname, contestentrytype: contestentrytype, createon: createon, userid: userid, icon: icon , wincount: wc)
                            
                            self.allnotificationsfetced.append(notif)
                            
                        }
                        if self.allnotificationsfetced.count == oldcount {
                            self.furtherallowed = false
                        }
                        print(self.allnotificationsfetced)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.table.reloadData()
                    }
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allnotificationsfetced.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notificationcell", for: indexPath) as? NotificationTableViewCell {
            cell.updatecell(x: self.allnotificationsfetced[indexPath.row])
            cell.selectionStyle = .none

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.table.frame.size.height / 4.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let x = self.allnotificationsfetced[indexPath.row]
        self.tappedid = x.id
        self.tappedwincount = x.wincount
        if x.datatype.lowercased() == "groupmember" {
            performSegue(withIdentifier: "togroups", sender: nil)
        }
        else if x.datatype.lowercased() == "juryadd" {
            performSegue(withIdentifier: "tojurycontests", sender: nil)
        }
        else if x.datatype.lowercased() == "group" {
            performSegue(withIdentifier: "togroups", sender: nil)
        }
        else if x.datatype.lowercased() == "contestinvitation" {
            performSegue(withIdentifier: "tojurycontests", sender: nil)
        }
        else if x.datatype.lowercased() == "nearcontest" {
            performSegue(withIdentifier: "tonearbycontests", sender: nil)
        }
        else if x.datatype.lowercased() == "contestwinner" {
            performSegue(withIdentifier: "tocontests", sender: nil)
        }
        else if x.datatype.lowercased() == "contestpostlike" {
            performSegue(withIdentifier: "tocontests", sender: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           
   
        if indexPath.row == self.allnotificationsfetced.count - 5 && locked == false && self.allnotificationsfetced.count >= 10 && self.furtherallowed == true {
                    locked = true
                    page = page + 1
                    setdummydata(pg: page)
                   
               }
           
        
        if indexPath.row == self.allnotificationsfetced.count - 2 {
                       locked = false
                   }
    }
    
    
    
    
    
    
    func setupallviews()
       {
        self.searchbar.layer.cornerRadius = 35
        self.notificationindicator.layer.cornerRadius = 10
           self.plusbuttoncovering.layer.cornerRadius = 55
               self.plusbutton.layer.cornerRadius = 37
       }
       

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let seg = segue.destination as? JoinedeventsViewController {
            if let t = Int(self.tappedid) as? Int {
                seg.eventid = t
            }
            
            
        }
        if let seg = segue.destination as? MainGroupViewController {
            seg.isseguedevent = true
            if let t = Int(self.tappedid) as? Int {
                seg.seguedeventid = 0
            }
            
            
        }
        if let seg = segue.destination as? JurycontestViewController {
            if let t = Int(self.tappedid) as? Int {
                seg.contestid = t
            }
            if let t = Int(self.tappedwincount) as? Int {
                seg.totalwinners = t
            }
            
        }
        if let seg = segue.destination as? SeeAllgeneralViewController {
            seg.typeoffetch = "recommended contests"
            seg.needtoloadrecommendedevents = true
        }
        
        
    }
    

}
