//
//  GroupandEventsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

struct streventcover
{
    var a : strevent
    var b : Bool
    var c : Bool
}

class GroupandEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var screentitle: Customlabel!
    var isother = false
    var jurysectionpressed = false
    var sections = ["events","joined groups","groups","joined events"]
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var creategroupupperbutton: UIButton!
    
    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var try1: UIStackView!
    
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    static var cachegroupimage = NSCache<NSString,UIImage>()
    
    var choosensectionforseeall = 0
    var groupscount = 0
    var eventscount = 0

    var receivedgroup : groupevent?
    var receivedevent : strevent?
    var alldata : [streventcover] = []
    var jurydata : [streventcover] = []
    
    static var copygroupdata : [groupevent] = []
    static var copyunpublishedevents : [strevent] = []
    static var copyevents : [strevent] = []
    static var copyjoinedevents : [streventcover] = []
    static var copyclosedcontests : [streventcover] = []
    static var copyjoinedgroups : [groupevent] = []
    static var copyrecommendedcontests : [streventcover] = []
    
    static var copyjuryevents : [streventcover] = []
    static var copyselfjuryevents : [streventcover] = []
    
    var path = CGMutablePath()
          var pathlabel = UILabel()
          let maskLayer = CAShapeLayer()
          var overview : UIView?
          var introcount = 1
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        
        GroupandEventsViewController.copygroupdata  = []
        GroupandEventsViewController.copyunpublishedevents  = []
        GroupandEventsViewController.copyevents  = []
        GroupandEventsViewController.copyjoinedevents = []
        GroupandEventsViewController.copyclosedcontests = []
        GroupandEventsViewController.copyjoinedgroups = []
        GroupandEventsViewController.copyrecommendedcontests = []
        GroupandEventsViewController.copyjuryevents = []
        
        
        
        print("Jury")
        print(self.jurysectionpressed)
        
        if self.jurysectionpressed {
            self.screentitle.text = "Jury"
            sections = ["jury in own","i am jury in"]
            self.creategroupupperbutton.setTitle("Create Contest", for: .normal)
        }
        else if self.isother {
            self.screentitle.text = "Contests"
            sections = ["unpublished contests","events","joined events","closed contests" ,"recommended contests"]
            self.creategroupupperbutton.setTitle("Create Contest", for: .normal)
        }
        else {
            self.screentitle.text = "Groups"
            sections = ["joined groups","groups"]
            self.creategroupupperbutton.setTitle("Create Group", for: .normal)
        }
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        if !InternetCheck.isConnectedToNetwork() {
                   self.present(customalert.showalert(x: "Sorry you are not connected to Internet."), animated: true, completion: nil)
               }
                else {
                   table.reloadData()
                    fetchmasterdata()
               }
        
        setupviews()
        
        var lat = CLLocationDegrees(exactly: 0)
        var longi = CLLocationDegrees(exactly: 0)
        
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
            
        }
        else {
            locationManager.requestWhenInUseAuthorization()

        }
        
        var shallshow = false
        
        if self.jurysectionpressed {
             if let v = UserDefaults.standard.value(forKey: "needtoshowjurydashboardtutorial") as? Bool {
                if v {
                    shallshow = true
                }
            }
        }
        else if isother {
            if let v = UserDefaults.standard.value(forKey: "needtoshowcontestdashboardtutorial") as? Bool {
                if v {
                    shallshow = true
                }
            }
        }
        else {
            if let v = UserDefaults.standard.value(forKey: "needtoshowgroupdashboardtutorial") as? Bool {
                if v {
                    shallshow = true
                }
            }
        }
        
        if shallshow {
        
        overview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
                overview?.backgroundColor = #colorLiteral(red: 0.0264734456, green: 0.0264734456, blue: 0.0264734456, alpha: 0.8351122359)

                let tp = UITapGestureRecognizer(target: self, action: #selector(handleoverviewtap))
                tp.numberOfTouchesRequired = 1
                tp.numberOfTapsRequired = 1
                tp.isEnabled = true
                overview?.addGestureRecognizer(tp)
        self.view.addSubview(overview ?? UIView())
        maskLayer.backgroundColor = UIColor.white.cgColor
                       maskLayer.fillRule = .evenOdd
                       overview?.layer.mask = maskLayer
                       overview?.clipsToBounds = true
                       pathlabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2.4, width: self.view.frame.size.width, height: 90))
                       pathlabel.numberOfLines = 0
                       pathlabel.textAlignment = .center
                       pathlabel.textColor = UIColor.white
                       overview?.addSubview(pathlabel)
         self.bringinintro(intro: self.introcount)
             if self.jurysectionpressed {
                UserDefaults.standard.set(false, forKey: "needtoshowjurydashboardtutorial")
            }
             else if isother {
                UserDefaults.standard.set(false, forKey: "needtoshowcontestdashboardtutorial")
            }
             else {
                 UserDefaults.standard.set(false, forKey: "needtoshowgroupdashboardtutorial")
            }
            
        }

 
    }
    
    
    @objc func handleoverviewtap()
        {
            introcount = introcount +  1
            self.bringinintro(intro: introcount)
        }
     
    func bringinintro(intro : Int)
          {

            if intro == 1 && !self.isother && !self.jurysectionpressed {
                let frame = self.try1.convert(self.creategroupupperbutton.layer.frame, to:self.view)
                  
                self.path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y ))
                self.path.addRoundedRect(in: CGRect(x: frame.origin.x - 2, y: frame.origin.y+2, width: frame.size.width + 4, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)
                self.path.addRect(CGRect(origin: .zero, size: overview?.frame.size ?? CGSize.zero))
                self.maskLayer.path = self.path

                     
                self.pathlabel.text = "Click to create new group. \n\n\n Tap for next suggestion"
                      
              }
            else if intro == 1 && (self.isother || self.jurysectionpressed) {
               
                let frame = self.try1.convert(creategroupupperbutton.layer.frame, to:self.view)
                                
                                    path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y))
                                    path.addRoundedRect(in: CGRect(x: frame.origin.x - 2, y: frame.origin.y+2, width: frame.size.width + 4, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)
                                    path.addRect(CGRect(origin: .zero, size: overview?.frame.size ?? CGSize.zero))
                                    maskLayer.path = path

                                   
                                    pathlabel.text = "Click to create new contest. \n\n\n Tap for next suggestion"
               }
 
              else {
                  self.overview?.isHidden = true
              }
                      
                      
                      

          }
       
    
    
    
    
    func fetchselfjurydata()
    {
        GroupandEventsViewController.copyselfjuryevents = []
        var uid = UserDefaults.standard.value(forKey: "refid") as! String
        let url = "\(Constants.K_baseUrl)\(Constants.selfjury)?userId=\(uid)"
        let params : Dictionary<String,Any> = ["Page": 0,
                                               "PageSize": 10]
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let dd = res["Results"] as?  Dictionary<String,Any> {
                    if let data = dd["Data"] as? [Dictionary<String,Any>] {
                        for each in data {
                            var contestid = 0
                            var contestname = ""
                            var allowcategoryid = 0
                            var allowcategory = ""
                            var organisationallow = false
                            var invitationtypeid = 0
                            var invitationtype = ""
                            var entryallowed = 0
                            var entrytype = ""
                            var entryfee = 0
                            var conteststart = ""
                            var contestlocation = ""
                            var description = ""
                            var resulton = ""
                            var contestprice = ""
                            var contestwinnerpricetypeid = 0
                            var contestpricetype = ""
                            var resulttypeid = 0
                            var resulttype = ""
                            var userid = ""
                            var groupid = 0
                            var createon = ""
                            var isactive = false
                            var status = false
                            var runningstatusid = 0
                            var runningstatus = ""
                            var juries : [juryorwinner] = []
                            var cim  = ""
                            if let cn = each["ContestId"] as? Int {
                                contestid = cn
                            }
                            
                            if let cn = each["ContestName"] as? String {
                                contestname = cn
                            }
                            if let cn = each["AllowCategoryId"] as? Int {
                                allowcategoryid = cn
                            }
                            if let cn = each["AllowCategory"] as? String {
                                allowcategory = cn
                            }
                            if let cn = each["OrganizationAllow"] as? Bool {
                                organisationallow = cn
                            }
                            if let cn = each["InvitationTypeId"] as? Int {
                                invitationtypeid = cn
                            }
                            if let cn = each["InvitationType"] as? String {
                                invitationtype = cn
                            }
                            if let cn = each["EntryAllowed"] as? Int {
                                entryallowed = cn
                            }
                            if let cn = each["EntryType"] as? String {
                                entrytype = cn
                            }
                            if let cn = each["EntryFee"] as? Int {
                                entryfee = cn
                            }
                            if let cn = each["ContestStart"] as? String {
                                conteststart = cn
                            }
                            if let cn = each["ContestLocation"] as? String {
                                contestlocation = cn
                            }
                            if let cn = each["Description"] as? String {
                                description = cn
                            }
                            if let cn = each["ResultOn"] as? String {
                                resulton = cn
                            }
                            if let cn = each["ContestPrice"] as? String {
                                contestprice = cn
                            }
                            if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                                contestwinnerpricetypeid = cn
                            }
                            if let cn = each["ContestWinnerPriceType"] as? String {
                                contestpricetype  = cn
                            }
                            if let cn = each["ResultTypeId"] as? Int {
                                resulttypeid = cn
                            }
                            if let cn = each["ResultType"] as? String {
                                resulttype = cn
                            }
                            if let cn = each["UserId"] as? String {
                                userid = cn
                            }
                            if let cn = each["GroupId"] as? Int {
                                groupid = cn
                            }
                            if let cn = each["CreateOn"] as? String {
                                createon = cn
                            }
                            if let cn = each["IsActive"] as? Bool {
                                isactive = cn
                            }
                            if let cn = each["Status"] as? Bool {
                                status = cn
                            }
                            if let cn = each["RunningStatusId"] as? Int {
                                runningstatusid = cn
                            }
                            if let cn = each["RunningStatus"] as? String {
                                runningstatus = cn
                            }
                            if let cn = each["Juries"] as? [juryorwinner] {
                                juries = cn
                            }
                            if let cfn = each["FileType"] as? String {
                                if cfn == "Video" {
                                    if let cn = each["Thumbnail"] as? String {
                                        cim = cn
                                    }
                                }
                                else {
                                    if let cn = each["ContestImage"] as? String {
                                        cim = cn
                                    }
                                }
                                
                            }
                            else {
                                if let cn = each["ContestImage"] as? String {
                                    cim = cn
                                }
                            }
                            var tandc = ""
                            if let cn = each["TermAndCondition"] as? String {
                                tandc = cn
                            }
                            var noofwinn = 0
                            if let cn = each["NoOfWinner"] as? Int {
                                noofwinn = cn
                            }
                            var joined = false
                            var joinstatus = false
                            
                            if let cn = each["Joined"] as? Bool {
                                joined = cn
                            }
                            
                            if let cn = each["JoinStatus"] as? Bool {
                                joinstatus = cn
                            }
                            var pa = false
                            if let cn = each["ParticipantPostAllow"] as? Bool {
                                pa = cn
                            }
                            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn, participationpostallow: pa)
                            
                            var y = streventcover(a: x, b: joined, c: joinstatus)
                            GroupandEventsViewController.copyselfjuryevents.append(y)
                            
                            
                        }
                        self.table.reloadData()
                    }
                    
                }
            }
        }
    }
    
    
    func fetchmasterdata()
    {
        var lat = CLLocationDegrees(exactly: 0)
        var longi = CLLocationDegrees(exactly: 0)
        
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            if let cl = locationManager.location as? CLLocation {
                if let l = cl.coordinate.latitude as? CLLocationDegrees {
                    lat = l
                }
                if let lo = cl.coordinate.longitude as? CLLocationDegrees {
                    longi = lo
                }
            }
            
            
        }
         if self.isother {
            let url = Constants.K_baseUrl + Constants.contestdashboard
            let r = BaseServiceClass()
            var uid = UserDefaults.standard.value(forKey: "refid") as! String
            let params : Dictionary<String,Any> = ["UserId": "\(uid)",
                                                   "Latitude": lat,
                                                   "Longitude": longi,
                                                   "Distance": 5,
                                                   "ParticipentUserId" : "\(uid)"]
            r.postApiRequest(url: url, parameters: params) { (response, err) in
                if let res = response?.result.value as? Dictionary<String,Any> {
                    if let rr = res["Results"] as? Dictionary<String,Any> {
                        if let cc = rr["CreatedContest"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrangecreatedcontests(data: dt)
                            }
                        }
                        
                        if let cc = rr["UnPublish"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrangecreatedunpublishedcontests(data: dt)
                            }
                        }
                        
                        if let cc = rr["JoinedContest"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                
                                self.arrangejoinedcontest(data: dt)
                            }
                        }
                        
                        if let cc = rr["ImJury"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrangejurycontests(data: dt)
                            }
                        }
                        
                        if let cc = rr["ClosedContest"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrangeclosedcontests(data: dt)
                            }
                        }
                        
                        
                        
                        if let cc = rr["SuggestedContest"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrangesuggestedcontest(data: dt)
                            }
                        }
                        
                        
                        self.table.reloadData()
                    }
                }
            }
        }
         else {
            var uid = UserDefaults.standard.value(forKey: "refid") as! String

            let url = "\(Constants.K_baseUrl)\(Constants.groupdashboard)?userId=\(uid)"
            let r = BaseServiceClass()
            print(url)
            
            r.getApiRequest(url: url, parameters: [:]) { (response, err) in
                if let res = response?.result.value as? Dictionary<String,Any> {
                  
                    if let rr = res["Results"] as? Dictionary<String,Any> {
                        if let cc = rr["CreatedGroup"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrengecreatedgroup(data: dt)
                                print(dt)
                                print("-----------------------------")
                            }
                        }
                        
                        if let cc = rr["JoinedGroup"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrangejoinedgroup(data: dt)
                                print("-----------------------------")
                            }
                        }
                        
                        
                        
                        if let cc = rr["ImJury"] as? Dictionary<String,Any> {
                            if let dt = cc["Data"] as? [Dictionary<String,Any>] {
                                self.arrangejurycontests(data: dt)
                                print("-----------------------------")
                            }
                        }
                        
//                       self.table.reloadData()
                        self.fetchselfjurydata()
                        
                        
                    }
                }
            }

        }
        
    }
    
    func arrengecreatedgroup(data : [Dictionary<String,Any>]) {
                                        for each in data {
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
                                            print(x)
                                            print("------------&&&&&&&&&&----------")
                                            GroupandEventsViewController.copygroupdata.append(x)
        
        
        
                                        }
    }
    
    func arrangejoinedgroup(data : [Dictionary<String,Any>]) {
                                         for each in data {
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
        
                                             GroupandEventsViewController.copyjoinedgroups.append(x)
        
        
        
        //                                     print(each["GroupName"])
                                         }
    }
    
    
    func arrangesuggestedcontest(data : [Dictionary<String,Any>])
    {

        for each in data {
            var contestid = 0
            var contestname = ""
            var allowcategoryid = 0
            var allowcategory = ""
            var organisationallow = false
            var invitationtypeid = 0
            var invitationtype = ""
            var entryallowed = 0
            var entrytype = ""
            var entryfee = 0
            var conteststart = ""
            var contestlocation = ""
            var description = ""
            var resulton = ""
            var contestprice = ""
            var contestwinnerpricetypeid = 0
            var contestpricetype = ""
            var resulttypeid = 0
            var resulttype = ""
            var userid = ""
            var groupid = 0
            var createon = ""
            var isactive = false
            var status = false
            var runningstatusid = 0
            var runningstatus = ""
            var juries : [juryorwinner] = []
            var cim  = ""
            if let cn = each["ContestId"] as? Int {
                contestid = cn
            }
            
            if let cn = each["ContestName"] as? String {
                contestname = cn
            }
            if let cn = each["AllowCategoryId"] as? Int {
                allowcategoryid = cn
            }
            if let cn = each["AllowCategory"] as? String {
                allowcategory = cn
            }
            if let cn = each["OrganizationAllow"] as? Bool {
                organisationallow = cn
            }
            if let cn = each["InvitationTypeId"] as? Int {
                invitationtypeid = cn
            }
            if let cn = each["InvitationType"] as? String {
                invitationtype = cn
            }
            if let cn = each["EntryAllowed"] as? Int {
                entryallowed = cn
            }
            if let cn = each["EntryType"] as? String {
                entrytype = cn
            }
            if let cn = each["EntryFee"] as? Int {
                entryfee = cn
            }
            if let cn = each["ContestStart"] as? String {
                conteststart = cn
            }
            if let cn = each["ContestLocation"] as? String {
                contestlocation = cn
            }
            if let cn = each["Description"] as? String {
                description = cn
            }
            if let cn = each["ResultOn"] as? String {
                resulton = cn
            }
            if let cn = each["ContestPrice"] as? String {
                contestprice = cn
            }
            if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                contestwinnerpricetypeid = cn
            }
            if let cn = each["ContestWinnerPriceType"] as? String {
                contestpricetype  = cn
            }
            if let cn = each["ResultTypeId"] as? Int {
                resulttypeid = cn
            }
            if let cn = each["ResultType"] as? String {
                resulttype = cn
            }
            if let cn = each["UserId"] as? String {
                userid = cn
            }
            if let cn = each["GroupId"] as? Int {
                groupid = cn
            }
            if let cn = each["CreateOn"] as? String {
                createon = cn
            }
            if let cn = each["IsActive"] as? Bool {
                isactive = cn
            }
            if let cn = each["Status"] as? Bool {
                status = cn
            }
            if let cn = each["RunningStatusId"] as? Int {
                runningstatusid = cn
            }
            if let cn = each["RunningStatus"] as? String {
                runningstatus = cn
            }
            if let cn = each["Juries"] as? [juryorwinner] {
                juries = cn
            }
            if let cfn = each["FileType"] as? String {
                if cfn == "Video" {
                    if let cn = each["Thumbnail"] as? String {
                        cim = cn
                    }
                }
                else {
                    if let cn = each["ContestImage"] as? String {
                        cim = cn
                    }
                }
                
            }
            else {
                if let cn = each["ContestImage"] as? String {
                    cim = cn
                }
            }
            var tandc = ""
            if let cn = each["TermAndCondition"] as? String {
                tandc = cn
            }
            var noofwinn = 0
            if let cn = each["NoOfWinner"] as? Int {
                noofwinn = cn
            }
            var joined = false
            var joinstatus = false
            
            if let cn = each["Joined"] as? Bool {
                joined = cn
            }
            
            if let cn = each["JoinStatus"] as? Bool {
                joinstatus = cn
            }
            
            var pa = false
            if let cn = each["ParticipantPostAllow"] as? Bool {
                pa = cn
            }
            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn, participationpostallow: pa)
            
            var y = streventcover(a: x, b: joined, c: joinstatus)
            GroupandEventsViewController.copyrecommendedcontests.append(y)
            
            
        }
        print("count Suggested contest \(GroupandEventsViewController.copyrecommendedcontests.count)")
    }
    
    
    
    
    func arrangeclosedcontests(data : [Dictionary<String,Any>])
    {

        for each in data {
            var contestid = 0
            var contestname = ""
            var allowcategoryid = 0
            var allowcategory = ""
            var organisationallow = false
            var invitationtypeid = 0
            var invitationtype = ""
            var entryallowed = 0
            var entrytype = ""
            var entryfee = 0
            var conteststart = ""
            var contestlocation = ""
            var description = ""
            var resulton = ""
            var contestprice = ""
            var contestwinnerpricetypeid = 0
            var contestpricetype = ""
            var resulttypeid = 0
            var resulttype = ""
            var userid = ""
            var groupid = 0
            var createon = ""
            var isactive = false
            var status = false
            var runningstatusid = 0
            var runningstatus = ""
            var juries : [juryorwinner] = []
            var cim  = ""
            if let cn = each["ContestId"] as? Int {
                contestid = cn
            }
            
            if let cn = each["ContestName"] as? String {
                contestname = cn
            }
            if let cn = each["AllowCategoryId"] as? Int {
                allowcategoryid = cn
            }
            if let cn = each["AllowCategory"] as? String {
                allowcategory = cn
            }
            if let cn = each["OrganizationAllow"] as? Bool {
                organisationallow = cn
            }
            if let cn = each["InvitationTypeId"] as? Int {
                invitationtypeid = cn
            }
            if let cn = each["InvitationType"] as? String {
                invitationtype = cn
            }
            if let cn = each["EntryAllowed"] as? Int {
                entryallowed = cn
            }
            if let cn = each["EntryType"] as? String {
                entrytype = cn
            }
            if let cn = each["EntryFee"] as? Int {
                entryfee = cn
            }
            if let cn = each["ContestStart"] as? String {
                conteststart = cn
            }
            if let cn = each["ContestLocation"] as? String {
                contestlocation = cn
            }
            if let cn = each["Description"] as? String {
                description = cn
            }
            if let cn = each["ResultOn"] as? String {
                resulton = cn
            }
            if let cn = each["ContestPrice"] as? String {
                contestprice = cn
            }
            if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                contestwinnerpricetypeid = cn
            }
            if let cn = each["ContestWinnerPriceType"] as? String {
                contestpricetype  = cn
            }
            if let cn = each["ResultTypeId"] as? Int {
                resulttypeid = cn
            }
            if let cn = each["ResultType"] as? String {
                resulttype = cn
            }
            if let cn = each["UserId"] as? String {
                userid = cn
            }
            if let cn = each["GroupId"] as? Int {
                groupid = cn
            }
            if let cn = each["CreateOn"] as? String {
                createon = cn
            }
            if let cn = each["IsActive"] as? Bool {
                isactive = cn
            }
            if let cn = each["Status"] as? Bool {
                status = cn
            }
            if let cn = each["RunningStatusId"] as? Int {
                runningstatusid = cn
            }
            if let cn = each["RunningStatus"] as? String {
                runningstatus = cn
            }
            if let cn = each["Juries"] as? [juryorwinner] {
                juries = cn
            }
            if let cfn = each["FileType"] as? String {
                if cfn == "Video" {
                    if let cn = each["Thumbnail"] as? String {
                        cim = cn
                    }
                }
                else {
                    if let cn = each["ContestImage"] as? String {
                        cim = cn
                    }
                }
                
            }
            else {
                if let cn = each["ContestImage"] as? String {
                    cim = cn
                }
            }
            var tandc = ""
            if let cn = each["TermAndCondition"] as? String {
                tandc = cn
            }
            var noofwinn = 0
            if let cn = each["NoOfWinner"] as? Int {
                noofwinn = cn
            }
            var joined = false
            var joinstatus = false
            
            if let cn = each["Joined"] as? Bool {
                joined = cn
            }
            
            if let cn = each["JoinStatus"] as? Bool {
                joinstatus = cn
            }
            var pa = false
            if let cn = each["ParticipantPostAllow"] as? Bool {
                pa = cn
            }
            
            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn, participationpostallow: pa)
            
            var y = streventcover(a: x, b: joined, c: joinstatus)
            GroupandEventsViewController.copyclosedcontests.append(y)
            
            
        }
        print("count Suggested contest \(GroupandEventsViewController.copyclosedcontests.count)")
    }
    
    
    
    func arrangejurycontests(data : [Dictionary<String,Any>])
    {
  
        for each in data {
            var contestid = 0
            var contestname = ""
            var allowcategoryid = 0
            var allowcategory = ""
            var organisationallow = false
            var invitationtypeid = 0
            var invitationtype = ""
            var entryallowed = 0
            var entrytype = ""
            var entryfee = 0
            var conteststart = ""
            var contestlocation = ""
            var description = ""
            var resulton = ""
            var contestprice = ""
            var contestwinnerpricetypeid = 0
            var contestpricetype = ""
            var resulttypeid = 0
            var resulttype = ""
            var userid = ""
            var groupid = 0
            var createon = ""
            var isactive = false
            var status = false
            var runningstatusid = 0
            var runningstatus = ""
            var juries : [juryorwinner] = []
            var cim  = ""
            if let cn = each["ContestId"] as? Int {
                contestid = cn
            }
            
            if let cn = each["ContestName"] as? String {
                contestname = cn
            }
            if let cn = each["AllowCategoryId"] as? Int {
                allowcategoryid = cn
            }
            if let cn = each["AllowCategory"] as? String {
                allowcategory = cn
            }
            if let cn = each["OrganizationAllow"] as? Bool {
                organisationallow = cn
            }
            if let cn = each["InvitationTypeId"] as? Int {
                invitationtypeid = cn
            }
            if let cn = each["InvitationType"] as? String {
                invitationtype = cn
            }
            if let cn = each["EntryAllowed"] as? Int {
                entryallowed = cn
            }
            if let cn = each["EntryType"] as? String {
                entrytype = cn
            }
            if let cn = each["EntryFee"] as? Int {
                entryfee = cn
            }
            if let cn = each["ContestStart"] as? String {
                conteststart = cn
            }
            if let cn = each["ContestLocation"] as? String {
                contestlocation = cn
            }
            if let cn = each["Description"] as? String {
                description = cn
            }
            if let cn = each["ResultOn"] as? String {
                resulton = cn
            }
            if let cn = each["ContestPrice"] as? String {
                contestprice = cn
            }
            if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                contestwinnerpricetypeid = cn
            }
            if let cn = each["ContestWinnerPriceType"] as? String {
                contestpricetype  = cn
            }
            if let cn = each["ResultTypeId"] as? Int {
                resulttypeid = cn
            }
            if let cn = each["ResultType"] as? String {
                resulttype = cn
            }
            if let cn = each["UserId"] as? String {
                userid = cn
            }
            if let cn = each["GroupId"] as? Int {
                groupid = cn
            }
            if let cn = each["CreateOn"] as? String {
                createon = cn
            }
            if let cn = each["IsActive"] as? Bool {
                isactive = cn
            }
            if let cn = each["Status"] as? Bool {
                status = cn
            }
            if let cn = each["RunningStatusId"] as? Int {
                runningstatusid = cn
            }
            if let cn = each["RunningStatus"] as? String {
                runningstatus = cn
            }
            if let cn = each["Juries"] as? [juryorwinner] {
                juries = cn
            }
            if let cfn = each["FileType"] as? String {
                if cfn == "Video" {
                    if let cn = each["Thumbnail"] as? String {
                        cim = cn
                    }
                }
                else {
                    if let cn = each["ContestImage"] as? String {
                        cim = cn
                    }
                }
                
            }
            else {
                if let cn = each["ContestImage"] as? String {
                    cim = cn
                }
            }
            var tandc = ""
            if let cn = each["TermAndCondition"] as? String {
                tandc = cn
            }
            var noofwinn = 0
            if let cn = each["NoOfWinner"] as? Int {
                noofwinn = cn
            }
            var joined = false
            var joinstatus = false
            
            if let cn = each["Joined"] as? Bool {
                joined = cn
            }
            
            if let cn = each["JoinStatus"] as? Bool {
                joinstatus = cn
            }
            var pa = false
            if let cn = each["ParticipantPostAllow"] as? Bool {
                pa = cn
            }
            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn, participationpostallow: pa)
            
            var y = streventcover(a: x, b: joined, c: joinstatus)
            GroupandEventsViewController.copyjuryevents.append(y)
            
            
        }
        print("count JURY contest \(GroupandEventsViewController.copyjuryevents.count)")

    }
    
    
    
    func arrangejoinedcontest(data : [Dictionary<String,Any>])
    {
        print("Hurrah I got one")
        print(data)
        for each in data {
            var contestid = 0
            var contestname = ""
            var allowcategoryid = 0
            var allowcategory = ""
            var organisationallow = false
            var invitationtypeid = 0
            var invitationtype = ""
            var entryallowed = 0
            var entrytype = ""
            var entryfee = 0
            var conteststart = ""
            var contestlocation = ""
            var description = ""
            var resulton = ""
            var contestprice = ""
            var contestwinnerpricetypeid = 0
            var contestpricetype = ""
            var resulttypeid = 0
            var resulttype = ""
            var userid = ""
            var groupid = 0
            var createon = ""
            var isactive = false
            var status = false
            var runningstatusid = 0
            var runningstatus = ""
            var juries : [juryorwinner] = []
            var cim  = ""
            var paaa = true
            if let cn = each["ContestId"] as? Int {
                contestid = cn
            }
            if let cn = each["ParticipantPostAllow"] as? Bool {
                paaa = cn
            }
            
            if let cn = each["ContestName"] as? String {
                contestname = cn
            }
            if let cn = each["AllowCategoryId"] as? Int {
                allowcategoryid = cn
            }
            if let cn = each["AllowCategory"] as? String {
                allowcategory = cn
            }
            if let cn = each["OrganizationAllow"] as? Bool {
                organisationallow = cn
            }
            if let cn = each["InvitationTypeId"] as? Int {
                invitationtypeid = cn
            }
            if let cn = each["InvitationType"] as? String {
                invitationtype = cn
            }
            if let cn = each["EntryAllowed"] as? Int {
                entryallowed = cn
            }
            if let cn = each["EntryType"] as? String {
                entrytype = cn
            }
            if let cn = each["EntryFee"] as? Int {
                entryfee = cn
            }
            if let cn = each["ContestStart"] as? String {
                conteststart = cn
            }
            if let cn = each["ContestLocation"] as? String {
                contestlocation = cn
            }
            if let cn = each["Description"] as? String {
                description = cn
            }
            if let cn = each["ResultOn"] as? String {
                resulton = cn
            }
            if let cn = each["ContestPrice"] as? String {
                contestprice = cn
            }
            if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                contestwinnerpricetypeid = cn
            }
            if let cn = each["ContestWinnerPriceType"] as? String {
                contestpricetype  = cn
            }
            if let cn = each["ResultTypeId"] as? Int {
                resulttypeid = cn
            }
            if let cn = each["ResultType"] as? String {
                resulttype = cn
            }
            if let cn = each["UserId"] as? String {
                userid = cn
            }
            if let cn = each["GroupId"] as? Int {
                groupid = cn
            }
            if let cn = each["CreateOn"] as? String {
                createon = cn
            }
            if let cn = each["IsActive"] as? Bool {
                isactive = cn
            }
            if let cn = each["Status"] as? Bool {
                status = cn
            }
            if let cn = each["RunningStatusId"] as? Int {
                runningstatusid = cn
            }
            if let cn = each["RunningStatus"] as? String {
                runningstatus = cn
            }
            if let cn = each["Juries"] as? [juryorwinner] {
                juries = cn
            }
            if let cfn = each["FileType"] as? String {
                if cfn == "Video" {
                    if let cn = each["Thumbnail"] as? String {
                        cim = cn
                    }
                }
                else {
                    if let cn = each["ContestImage"] as? String {
                        cim = cn
                    }
                }
                
            }
            else {
                if let cn = each["ContestImage"] as? String {
                    cim = cn
                }
            }
            var tandc = ""
            if let cn = each["TermAndCondition"] as? String {
                tandc = cn
            }
            var noofwinn = 0
            if let cn = each["NoOfWinner"] as? Int {
                noofwinn = cn
            }
            var joined = false
            var joinstatus = false
            
            if let cn = each["Joined"] as? Bool {
                joined = cn
            }
            
            if let cn = each["JoinStatus"] as? Bool {
                joinstatus = cn
            }
            
       
           
            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn, participationpostallow: paaa)
            
            var y = streventcover(a: x, b: joined, c: joinstatus)
            GroupandEventsViewController.copyjoinedevents.append(y)
            print("PPA \(contestname) \(paaa)")
            
        }
        print("Joined contests......!!!")
        
        print("count joined contest \(GroupandEventsViewController.copyjoinedevents.count)")

    }
    
    
    func arrangecreatedcontests(data : [Dictionary<String,Any>])
    {

        for each in data {
            var contestid = 0
            var contestname = ""
            var allowcategoryid = 0
            var allowcategory = ""
            var organisationallow = false
            var invitationtypeid = 0
            var invitationtype = ""
            var entryallowed = 0
            var entrytype = ""
            var entryfee = 0
            var conteststart = ""
            var contestlocation = ""
            var description = ""
            var resulton = ""
            var contestprice = ""
            var contestwinnerpricetypeid = 0
            var contestpricetype = ""
            var resulttypeid = 0
            var resulttype = ""
            var userid = ""
            var groupid = 0
            var createon = ""
            var isactive = false
            var status = true
            var runningstatusid = 0
            var runningstatus = ""
            var juries : [juryorwinner] = []
            var cim  = ""
            if let cn = each["ContestId"] as? Int {
                contestid = cn
            }
            
            if let cn = each["ContestName"] as? String {
                contestname = cn
            }
            if let cn = each["AllowCategoryId"] as? Int {
                allowcategoryid = cn
            }
            if let cn = each["AllowCategory"] as? String {
                allowcategory = cn
            }
            if let cn = each["OrganizationAllow"] as? Bool {
                organisationallow = cn
            }
            if let cn = each["InvitationTypeId"] as? Int {
                invitationtypeid = cn
            }
            if let cn = each["InvitationType"] as? String {
                invitationtype = cn
            }
            if let cn = each["EntryAllowed"] as? Int {
                entryallowed = cn
            }
            if let cn = each["EntryType"] as? String {
                entrytype = cn
            }
            if let cn = each["EntryFee"] as? Int {
                entryfee = cn
            }
            if let cn = each["ContestStart"] as? String {
                conteststart = cn
            }
            if let cn = each["ContestLocation"] as? String {
                contestlocation = cn
            }
            if let cn = each["Description"] as? String {
                description = cn
            }
            if let cn = each["ResultOn"] as? String {
                resulton = cn
            }
            if let cn = each["ContestPrice"] as? String {
                contestprice = cn
            }
            if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                contestwinnerpricetypeid = cn
            }
            if let cn = each["ContestWinnerPriceType"] as? String {
                contestpricetype  = cn
            }
            if let cn = each["ResultTypeId"] as? Int {
                resulttypeid = cn
            }
            if let cn = each["ResultType"] as? String {
                resulttype = cn
            }
            if let cn = each["UserId"] as? String {
                userid = cn
            }
            if let cn = each["GroupId"] as? Int {
                groupid = cn
            }
            if let cn = each["CreateOn"] as? String {
                createon = cn
            }
            if let cn = each["IsActive"] as? Bool {
                isactive = cn
            }
            if let cn = each["Status"] as? Bool {
                status = cn
            }
            if let cn = each["RunningStatusId"] as? Int {
                runningstatusid = cn
            }
            if let cn = each["RunningStatus"] as? String {
                runningstatus = cn
            }
            if let cn = each["Juries"] as? [juryorwinner] {
                juries = cn
            }
            if let cfn = each["FileType"] as? String {
                if cfn == "Video" {
                    if let cn = each["Thumbnail"] as? String {
                        cim = cn
                    }
                }
                else {
                    if let cn = each["ContestImage"] as? String {
                        cim = cn
                    }
                }
                
            }
            else {
                if let cn = each["ContestImage"] as? String {
                    cim = cn
                }
            }
            var tandc = ""
            if let cn = each["TermAndCondition"] as? String {
                tandc = cn
            }
            var noofwinn = 0
            if let cn = each["NoOfWinner"] as? Int {
                noofwinn = cn
            }
            var pa = false
            if let cn = each["ParticipantPostAllow"] as? Bool {
                pa = cn
            }
            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn, participationpostallow: pa)
            
            
            GroupandEventsViewController.copyevents.append(x)
            
            
        }
        print("count created contest \(GroupandEventsViewController.copyevents.count)")

    }
    
    
    func arrangecreatedunpublishedcontests(data : [Dictionary<String,Any>])
    {

        for each in data {
            var contestid = 0
            var contestname = ""
            var allowcategoryid = 0
            var allowcategory = ""
            var organisationallow = false
            var invitationtypeid = 0
            var invitationtype = ""
            var entryallowed = 0
            var entrytype = ""
            var entryfee = 0
            var conteststart = ""
            var contestlocation = ""
            var description = ""
            var resulton = ""
            var contestprice = ""
            var contestwinnerpricetypeid = 0
            var contestpricetype = ""
            var resulttypeid = 0
            var resulttype = ""
            var userid = ""
            var groupid = 0
            var createon = ""
            var isactive = false
            var status = false
            var runningstatusid = 0
            var runningstatus = ""
            var juries : [juryorwinner] = []
            var cim  = ""
            if let cn = each["ContestId"] as? Int {
                contestid = cn
            }
            
            if let cn = each["ContestName"] as? String {
                contestname = cn
            }
            if let cn = each["AllowCategoryId"] as? Int {
                allowcategoryid = cn
            }
            if let cn = each["AllowCategory"] as? String {
                allowcategory = cn
            }
            if let cn = each["OrganizationAllow"] as? Bool {
                organisationallow = cn
            }
            if let cn = each["InvitationTypeId"] as? Int {
                invitationtypeid = cn
            }
            if let cn = each["InvitationType"] as? String {
                invitationtype = cn
            }
            if let cn = each["EntryAllowed"] as? Int {
                entryallowed = cn
            }
            if let cn = each["EntryType"] as? String {
                entrytype = cn
            }
            if let cn = each["EntryFee"] as? Int {
                entryfee = cn
            }
            if let cn = each["ContestStart"] as? String {
                conteststart = cn
            }
            if let cn = each["ContestLocation"] as? String {
                contestlocation = cn
            }
            if let cn = each["Description"] as? String {
                description = cn
            }
            if let cn = each["ResultOn"] as? String {
                resulton = cn
            }
            if let cn = each["ContestPrice"] as? String {
                contestprice = cn
            }
            if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                contestwinnerpricetypeid = cn
            }
            if let cn = each["ContestWinnerPriceType"] as? String {
                contestpricetype  = cn
            }
            if let cn = each["ResultTypeId"] as? Int {
                resulttypeid = cn
            }
            if let cn = each["ResultType"] as? String {
                resulttype = cn
            }
            if let cn = each["UserId"] as? String {
                userid = cn
            }
            if let cn = each["GroupId"] as? Int {
                groupid = cn
            }
            if let cn = each["CreateOn"] as? String {
                createon = cn
            }
            if let cn = each["IsActive"] as? Bool {
                isactive = cn
            }
            if let cn = each["Status"] as? Bool {
                status = cn
            }
            if let cn = each["RunningStatusId"] as? Int {
                runningstatusid = cn
            }
            if let cn = each["RunningStatus"] as? String {
                runningstatus = cn
            }
            if let cn = each["Juries"] as? [juryorwinner] {
                juries = cn
            }
            if let cfn = each["FileType"] as? String {
                if cfn == "Video" {
                    if let cn = each["Thumbnail"] as? String {
                        cim = cn
                    }
                }
                else {
                    if let cn = each["ContestImage"] as? String {
                        cim = cn
                    }
                }
                
            }
            else {
                if let cn = each["ContestImage"] as? String {
                    cim = cn
                }
            }
            var tandc = ""
            if let cn = each["TermAndCondition"] as? String {
                tandc = cn
            }
            var noofwinn = 0
            if let cn = each["NoOfWinner"] as? Int {
                noofwinn = cn
            }
            var pa = false
            if let cn = each["ParticipantPostAllow"] as? Bool {
                pa = cn
            }
            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn, participationpostallow: pa)
            
            
            GroupandEventsViewController.copyunpublishedevents.append(x)
            
            
        }
        print("count unpublished contest \(GroupandEventsViewController.copyunpublishedevents.count)")
        
    }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupviews()
    {
        self.notificationindicator.layer.cornerRadius = 10
        self.creategroupupperbutton.layer.cornerRadius = 20
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "getable", for: indexPath) as? GroupsandEventsTableViewCell {
            cell.tag = indexPath.section
            cell.updatecell(x: sections[indexPath.section].lowercased(),w:self.view.frame.size.width/2,h:self.table.frame.size.height)
            
            
            cell.createtapped = {a in
                if a  == "group" {
                     self.performSegue(withIdentifier: "creatinggroup", sender: nil)
                }
                else if a == "contest" {
                    self.performSegue(withIdentifier: "creatingnewcontest", sender: nil)
                }
            }
            
            cell.isblannk = { a , b , c in
                print("Hey")
            }
            
            
//            cell.isblannk = {a, b,c in
//                if c == cell.tag {
//                if a {
//                    if b == "group" {
//                        cell.nodataimage.isHidden = false
//                        cell.collection.isHidden = true
//                        cell.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//                    }
//                    else if b == "contest" {
//                        cell.nodataimage.isHidden = false
//                        cell.collection.isHidden = true
//                        cell.nodataimage.image = UIImage(named: "nocontestsplaceholder")
//                    }
//
//                }
//                else {
//                    if b == "group" {
//                        cell.nodataimage.isHidden = true
//                        cell.collection.isHidden = false
//                        cell.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//                    }
//                    else if b == "contest" {
//                        cell.nodataimage.isHidden = true
//                        cell.collection.isHidden = false
//                        cell.nodataimage.image = UIImage(named: "nocontestsplaceholder")
//                    }
//                }
//                }
//            }
            
            
            cell.passalljoinedgroups = {a in
//                self.copyjoinedgroups = a
            }
            cell.passallrecommendedevents = { a in
//                self.copyrecommendedcontests = a
            }
            cell.passallevents = {a in
//                self.copyevents = a
            }
            cell.passalljoinedevents = {a in
//                self.copyjoinedevents = a
            }
            cell.passallgroups = {a in
//                self.copygroupdata = a
            }
            cell.passalljuryevents = {a in
//                self.copyjuryevents = a
            }
            cell.passallunpublishedevents = { a in
//                self.copyunpublishedevents = a
            }
            
            cell.passcounts = {a in
                print("Heyya events count is \(a)")
                self.eventscount = a
              
            }
            cell.selectedgrouppassed = {g in
                print("Received")
                self.receivedgroup = g
                self.performSegue(withIdentifier: "explaingroup", sender: nil)
                print(g)
            }
            cell.selectedeventpassed = {e in
                print("Heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy")
                print(e)
                self.receivedevent = e
                var uid = UserDefaults.standard.value(forKey: "refid") as! String
//                if uid == e.userid {
//                    self.performSegue(withIdentifier: "taketomyevents", sender: nil)
//                }
//                else {
                    self.performSegue(withIdentifier: "taketoothersevent", sender: nil)
//                }
                
            }
            
            cell.selectedjurypassed = {a in
                self.receivedevent = a.a
                self.performSegue(withIdentifier: "juryshowevent", sender: nil)
            }
            
            return cell
        }
        return UITableViewCell()
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
//        return self.view.frame.size.height/3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:30))
        view.backgroundColor = self.view.backgroundColor
        let label = Customlabel(frame: CGRect(x:30, y:5, width:tableView.frame.size.width/1.8, height:25))
           label.font = UIFont(name: "NeusaNextStd-Light", size: 19)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if self.sections[section] == "jury in own" {
            label.font = UIFont(name: "NeusaNextStd-Light", size: 10)
            label.text = "Jury in own contests"
        }
        else if self.sections[section] == "i am jury in" {
            label.font = UIFont(name: "NeusaNextStd-Light", size: 10)
            label.text = "Jury in others contest"
        }
        else if self.sections[section] == "unpublished contests" {
            label.text = "Unpublished contests"
        }
        else if self.sections[section] == "events" {
            label.text = "Contests"
        }
        else if self.sections[section] == "joined events" {
            label.text = "Joined contests"
        }
        else if self.sections[section] == "recommended contests" {
            label.text = "Recommended contests"
        }
        else {
            
            label.text = "\(self.sections[section].capitalized)"
        }
    
           view.addSubview(label)
       
        
        let btn = UIButton(frame: CGRect(x:tableView.frame.size.width/1.65,y:7,width:tableView.frame.size.width/2.5,height: 18))
        btn.setTitle("See all", for: .normal)
        btn.titleLabel?.textAlignment = .right
        btn.tag = section
        btn.addTarget(self, action: #selector(seealltapped), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "NeusaNextStd-Light", size: 12)
        
        btn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        view.addSubview(btn)

           return view
       }
    
    @objc func seealltapped(sender:UIButton) {
        print("Tapped see all for section \(sender.tag)")
        self.choosensectionforseeall = sender.tag
        
        performSegue(withIdentifier: "showseeallcontents", sender: nil)
    }
    
    
    @IBAction func creategrouptapped(_ sender: Any) {
        if !InternetCheck.isConnectedToNetwork() {
            self.present(customalert.showalert(x: "Sorry you are not connected to Internet."), animated: true, completion: nil)
            return
        }
        if CoreDataManager.contactstoserverinprogress {
            self.present(customalert.showalert(x: "Please wait while your contacts are syncing, Try again in sometime."), animated: true, completion: nil)
            return
        }
//        if CoreDataManager.shared.fetchcontactcount() == 0 {
//            DispatchQueue.global(qos: .background).async {
//                CoreDataManager.shared.loadallfromcontacts()
//            }
//            
//        }
        var t =  UIApplication.shared.delegate as? AppDelegate
        t?.requestForAccess(completionHandler: { (ans) in
            if ans {
                if self.isother || self.jurysectionpressed {
                               print("Right place \(GroupandEventsViewController.copyunpublishedevents.count)")
                               if GroupandEventsViewController.copyunpublishedevents.count > 3 {
                                  self.present(customalert.showalert(x: "Please publish or delete your unpublished contests before creating a new contest."), animated: true, completion: nil)
                               }
                               else {
                                self.performSegue(withIdentifier: "creatingnewcontest", sender: nil)
                               }
                           }
                           else {
                    self.performSegue(withIdentifier: "creatinggroup", sender: nil)
                           }
            }
            else {
               let alertController = UIAlertController(title: "Allow Contacts for Show Talent", message: "Please go to Settings and turn on the contacts access to proceed further.", preferredStyle: .alert)
               let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                       return
                   }
                   if UIApplication.shared.canOpenURL(settingsUrl) {
                       UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                    }
               }
               let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
               alertController.addAction(cancelAction)
               alertController.addAction(settingsAction)
                self.present(alertController, animated: true, completion: nil)
            }
                    
        })
            
            
        
           
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let seg = segue.destination as? ModifiedcontestcreateViewController {
            seg.comingwithoutgroup = true
        }
        
        
        if let seg = segue.destination as? MainGroupViewController {
            
            print("Sending Main")
            print(receivedgroup)
            seg.passedgroup2 = self.receivedgroup
        }
        if let s = segue.destination as? SeeAllgeneralViewController {
            
            if self.isother {
                s.modefetch = "contest"
            }
            else {
                s.modefetch = "group"
            }
            
            
            if self.jurysectionpressed {
                if self.choosensectionforseeall == 0 {
                    s.typeoffetch = "juryevents"
                    s.juryevents = GroupandEventsViewController.self.copyselfjuryevents
                }
                else if self.choosensectionforseeall == 1 {
                    s.typeoffetch = "juryeventsothers"
                    s.juryevents = GroupandEventsViewController.copyjuryevents
                }
            }
            else if !self.isother
            {
            
                if self.choosensectionforseeall == 0 {
                    s.typeoffetch = "juryevents"
                    s.juryevents = GroupandEventsViewController.self.copyjuryevents
                }
                else if self.choosensectionforseeall == 1 {
                    s.typeoffetch = "joinedgroups"
                    s.joinedgroups = GroupandEventsViewController.copyjoinedgroups
                }
                else if self.choosensectionforseeall == 2 {
                    s.typeoffetch = "yourgroups"

                    s.yourgroups = GroupandEventsViewController.copygroupdata
                }
            
            }
            else {
                if self.choosensectionforseeall == 0 {
                    s.typeoffetch = "unpublished contests"
                    s.unpublisedcontests = GroupandEventsViewController.copyunpublishedevents
                }
                else if self.choosensectionforseeall == 1 {
                    s.typeoffetch = "juryevents"
                    s.juryevents = GroupandEventsViewController.copyjuryevents
                }
                if self.choosensectionforseeall == 2 {
                    s.typeoffetch = "yourevents"
                    s.yourevents = GroupandEventsViewController.copyevents
                }
                else if self.choosensectionforseeall == 3{
                    s.typeoffetch = "joinedevents"
                    print("Here check for joined events data")
                    print(GroupandEventsViewController.copyjoinedevents)

                    s.joinedevents = GroupandEventsViewController.copyjoinedevents
                }
                else if self.choosensectionforseeall == 4{
                    s.typeoffetch = "joinedevents"
                    print("Here check for joined events data")
                    
                    
                    s.joinedevents = GroupandEventsViewController.copyrecommendedcontests
                }
            }
        }
        
        if let s = segue.destination as? JoinedeventsViewController {
            s.dangeringoingback = false
            print("Received event")
            print(self.receivedevent)
            s.eventid = self.receivedevent?.contestid ?? 0
            
        }
        if let s = segue.destination as? NewEventViewController {
            s.eventid = self.receivedevent?.contestid ?? 0
            s.passbackupdatedevent = { a in
                
            }
        }
        if let s = segue.destination as? JurycontestViewController {
            s.contestid = self.receivedevent?.contestid ?? 0
            s.totalwinners = self.receivedevent?.noofwinners ?? 0
        }
    }
    

}
