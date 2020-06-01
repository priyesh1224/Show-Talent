//
//  ContestshareonViewController.swift
//  ShowTalent
//
//  Created by apple on 3/20/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreData

class ContestshareonViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    
    
    @IBOutlet weak var sharebtn: CustomButton!
    
    @IBOutlet var notificationindicator: UIView!
    
    
    @IBOutlet var table: UITableView!
    
    
    var datafromapi : [apicontestsharedon] = []
    
    var mygroups : [groupevent] = []
    var joinedgroups : [groupevent] = []
    
    var shareon : [groupevent] = []
    
    var eventid = 1228
    var eventimage = ""
    var eventname = ""
    
    @IBOutlet weak var contestshare: Customlabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationindicator.layer.cornerRadius = 10
        self.table.delegate = self
        self.table.dataSource = self
        self.contestshare.text = self.eventname.capitalized
        self.sharebtn.layer.cornerRadius = 25
        print("Data From CoreData")
         datafromapi = CoreDataManager.shared.readfromcoredata()
        
        
        
        self.fetchowngroups { (st) in
            if st {
                self.fetchjoinedgroups { (ss) in
                    if ss {
                        self.table.reloadData()
                        print(self.mygroups)
                        print("--------------")
                        print(self.joinedgroups)
                    }
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func sharebtnpressed(_ sender: Any) {
        
        var groups : [Int] = []
        for each in self.shareon {
            groups.append(each.groupid)
        }
        var params : Dictionary<String,Any> = ["ContestId" : self.eventid , "GroupId" : groups]
        print(params)
        var url = Constants.K_baseUrl + Constants.shareamonggroups
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                print(res)
                if let code = res["ResponseStatus"] as? Int {
                    if code == 0 {
                        let alert2 = UIAlertController(title: "Contest Shared", message: "", preferredStyle: .actionSheet)
                        alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            CoreDataManager.shared.notifycoredataaboutshare(shareon: self.shareon , cid : self.eventid)
                            self.dismiss(animated: true, completion: nil)
                            
                        }));
                        self.present(alert2, animated: true, completion: nil)
                    }
                }
            }
        }
        
        
    }
    
    
    
    
    typealias progressindata = ((_ done : Bool) -> Void)
    
    
    func fetchjoinedgroups(done : @escaping progressindata)
    {
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var url = "\(Constants.K_baseUrl)\(Constants.getjoinedgroups)?userid=\(userid)"
             var r = BaseServiceClass()
        var params : Dictionary<String,Any> = ["Page": 0,"PageSize": 10,"userid":"\(userid)"]
        
                         r.postApiRequest(url: url, parameters: params) { (response, error) in
                             if let dv = response?.result.value as? Dictionary<String,AnyObject> {
        //                        print(dv)
                                 if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                                     if let invv =  inv["Data"] as? [Dictionary<String,AnyObject>] {
                                         for each in invv {
                                            var gn = ""
                                            var gid = 0
                                            var gim = ""
                                            var ref = 0
                                            var grpbel = ""
                                            var createdon = ""
                                            var youare = ""
                                            var othbelong = ""
                                            var part = 0
                                            var isverify = false
                                            var refuid = ""
                                            var memb : [groupparticipant] = []
                                            if let g = each["GroupName"] as? String {
                                                gn = g
                                            }
                                            if let g = each["GroupImage"] as? String {
                                                gim = g
                                            }
                                            if let g = each["GroupBelong"] as? String {
                                                grpbel = g
                                            }
                                            else if let g = each["BelongTo"] as? String {
                                                grpbel = g
                                            }
                                            if let g = each["CreatedOn"] as? String {
                                                createdon = g
                                            }
                                            if let g = each["YouAre"] as? String {
                                                youare = g
                                            }
                                            if let g = each["OtherBelong"] as? String {
                                                othbelong = g
                                            }
                                            if let g = each["GroupID"] as? Int {
                                                gid = g
                                            }
                                            if let g = each["Ref_BelongGroup"] as? Int {
                                                ref = g
                                            }
                                            if let g = each["TotalMembers"] as? Int {
                                                part = g
                                            }
                                            if let g = each["IsVerify"] as? Bool {
                                                isverify = g
                                            }
                                            if let g = each["Ref_UserId"] as? String {
                                                refuid = g
                                            }
                                            if let g = each["Members"] as? [Dictionary<String,Any>] {
                                                for mem in g {
                                                    var id = 0
                                                    var name = ""
                                                    var pim = ""
                                                    var uid = ""
                                                    var countrycode = ""
                                                    var mobile = ""
                                                    if let f = mem["ID"] as? Int {
                                                        id = f
                                                    }
                                                    if let f = mem["Name"] as? String {
                                                        name = f
                                                    }
                                                    if let f = mem["ProfileImage"] as? String {
                                                        pim = f
                                                    }
                                                    if let f = mem["UserId"] as? String {
                                                        uid = f
                                                    }
                                                    if let f = mem["CountryCode"] as? String {
                                                        countrycode = f
                                                    }
                                                    if let f = mem["Mobile"] as? String {
                                                        mobile = f
                                                    }
                                                    var gm = groupparticipant(id: id, name: name, profileimage: pim, userid: uid, countrycode: countrycode, mobile: mobile)
                                                    memb.append(gm)
                                                }
                                            }
                                            var x = groupevent(groupid: gid, ref_belongto: ref, group_belong: grpbel, groupimage: gim, createdon: createdon, youare: youare, groupname: gn, groupparticipation: part, isverify: isverify , refuserid: refuid , members: memb)
                        
                                             self.joinedgroups.append(x)
                                             
                                             
                                             
        //                                     print(each["GroupName"])
                                         }
                                        for var k in 0 ..< self.joinedgroups.count {
                                            for a in 0 ..< self.datafromapi.count {
                                                print("Indexess \(k) and \(a)")
                                                if k < self.joinedgroups.count && a < self.datafromapi.count {
                                                    if self.joinedgroups[k].groupid == self.datafromapi[a].groupid && self.eventid == self.datafromapi[a].contestid {
                                                        var timediff = Date().timeIntervalSince(self.datafromapi[a].date)
                                                        print("Time Interval is \(timediff) sd \(Date()) and shared date \(self.datafromapi[a].date)")
                                                        if timediff < (24 * 60 * 60) {
                                                            self.joinedgroups.remove(at: k)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                         done(true)
                                     }
                                 }
                             }
                         }

    }
    
    
    
    
    
    func fetchowngroups(done : @escaping progressindata)
    {
        
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        let params : Dictionary<String,Any> = ["userId":userid]
                        var url = Constants.K_baseUrl + Constants.getmygroups
                        var allu = "\(url)?userId=\(userid)"
                        var r = BaseServiceClass()
                        r.getApiRequest(url: allu, parameters: params) { (response, error) in
                            if let dv = response?.result.value as? Dictionary<String,AnyObject> {
                                if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                                    if let invv =  inv["Data"] as? [Dictionary<String,AnyObject>] {
                                        for each in invv {
                                            var gn = ""
                                            var gid = 0
                                            var gim = ""
                                            var ref = 0
                                            var grpbel = ""
                                            var createdon = ""
                                            var youare = ""
                                            var othbelong = ""
                                            var part = 0
                                            var isverify = false
                                            var refuid = ""
                                            var memb : [groupparticipant] = []
                                            if let g = each["GroupName"] as? String {
                                                gn = g
                                            }
                                            if let g = each["GroupImage"] as? String {
                                                gim = g
                                            }
                                            if let g = each["GroupBelong"] as? String {
                                                grpbel = g
                                            }
                                            else if let g = each["BelongTo"] as? String {
                                                grpbel = g
                                            }
                                            if let g = each["CreatedOn"] as? String {
                                                createdon = g
                                            }
                                            if let g = each["YouAre"] as? String {
                                                youare = g
                                            }
                                            if let g = each["OtherBelong"] as? String {
                                                othbelong = g
                                            }
                                            if let g = each["GroupID"] as? Int {
                                                gid = g
                                            }
                                            if let g = each["Ref_BelongGroup"] as? Int {
                                                ref = g
                                            }
                                            if let g = each["TotalMembers"] as? Int {
                                                part = g
                                            }
                                            if let g = each["IsVerify"] as? Bool {
                                                isverify = g
                                            }
                                            if let g = each["Ref_UserId"] as? String {
                                                refuid = g
                                            }
                                            if let g = each["Members"] as? [Dictionary<String,Any>] {
                                                for mem in g {
                                                    var id = 0
                                                    var name = ""
                                                    var pim = ""
                                                    var uid = ""
                                                    var countrycode = ""
                                                    var mobile = ""
                                                    if let f = mem["ID"] as? Int {
                                                        id = f
                                                    }
                                                    if let f = mem["Name"] as? String {
                                                        name = f
                                                    }
                                                    if let f = mem["ProfileImage"] as? String {
                                                        pim = f
                                                    }
                                                    if let f = mem["UserId"] as? String {
                                                        uid = f
                                                    }
                                                    if let f = mem["CountryCode"] as? String {
                                                        countrycode = f
                                                    }
                                                    if let f = mem["Mobile"] as? String {
                                                        mobile = f
                                                    }
                                                    var gm = groupparticipant(id: id, name: name, profileimage: pim, userid: uid, countrycode: countrycode, mobile: mobile)
                                                    memb.append(gm)
                                                }
                                            }
                                            
                                            var x = groupevent(groupid: gid, ref_belongto: ref, group_belong: grpbel, groupimage: gim, createdon: createdon, youare: youare, groupname: gn, groupparticipation: part, isverify: isverify , refuserid: refuid , members: memb)
        //                                    print(x)
        //                                    print("------------&&&&&&&&&&----------")
                                            self.mygroups.append(x)
                                            
                                            
                                            
                                        }
                                        for var k in 0 ..< self.mygroups.count {
                                            for a in 0 ..< self.datafromapi.count {
                                                 if k < self.mygroups.count && a < self.datafromapi.count {
                                                if self.mygroups[k].groupid == self.datafromapi[a].groupid && self.eventid == self.datafromapi[a].contestid{
                                                    var timediff = Date().timeIntervalSince(self.datafromapi[a].date)
                                                    if timediff < (24 * 60 * 60) {
                                                        self.mygroups.remove(at: k)
                                                    }
                                                }
                                                }
                                            }
                                        }
                                        done(true)
                                
                                    }
                                }
                            }
                        }
    }
    
    
    
    
   
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return mygroups.count
        }
        else if section == 2 {
            return joinedgroups.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "uppercontestshare", for: indexPath) as? ContestshareupperTableViewCell {
                cell.update(x : self.eventname , y : "100" , ima : self.eventimage)
                return cell
            }
            
        }
        else {
            if let cell  = tableView.dequeueReusableCell(withIdentifier: "lowercontestshare", for: indexPath) as? ContestsharebottonTableViewCell {
                if indexPath.section == 1 {
                    cell.update(x : self.mygroups[indexPath.row])
                }
                else {
                    cell.update(x : self.joinedgroups[indexPath.row])
                }
                
                
                
                cell.sharebtnpressed = { a in
                    var found = false
                    for var k in 0 ..< self.shareon.count {
                        if self.shareon[k].groupid == a.groupid {
                            self.shareon.remove(at: k)
                            cell.sharebtn.contentMode = .scaleAspectFit
                            cell.sharebtn.setImage(nil, for: .normal)
                            found = true
                            break
                        }
                    }
                    if found == false {
                        cell.sharebtn.setImage(#imageLiteral(resourceName: "check-solid"), for: .normal)
                        cell.sharebtn.contentMode = .scaleAspectFit
                        self.shareon.append(a)
                    }
                }
                
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.frame.size.height/3.5
        }
        else {
            return 70
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        else if section == 1 {
            return "Own Groups"
        }
        else {
            return "Other Groups"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 40
    }
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
