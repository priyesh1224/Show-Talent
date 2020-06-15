//
//  SeeAllgeneralViewController.swift
//  ShowTalent
//
//  Created by maraekat on 02/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreLocation

class SeeAllgeneralViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
 
    
    var gradients = [0:["#F956FF","#6B48FF"],1:["#FF0060","#FF4848"],2:["#5672FF","#005263"],3:["#FF0000","#2A0000"]]

    var typeoffetch = "categories"
    var pagetostart = 1
    var modefetch = "group"
    
    
    
    @IBOutlet weak var screentitle: Customlabel!
    
    var categories : [strcategory] = []
    var trendingdata : [strtrending] = []
    var dashboardevents : [strevent] = []
    
    var yourgroups : [groupevent] = []
    var yourevents : [strevent] = []
    var unpublisedcontests : [strevent] = []
    var joinedevents : [streventcover] = []
    var joinedgroups : [groupevent] = []
    var juryevents : [streventcover] = []
    var recommendedevents : [streventcover] = []
    
    
    var needtoloadrecommendedevents = false
    
    
    @IBOutlet weak var table: UITableView!
    
    
    var tappedcategoryid = 0
    var tappedcategoryname = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.table.reloadData()
        
        print("Type of fetch is \(typeoffetch)")
        
        if typeoffetch == "yourgroups" {
            self.screentitle.text = "Your Groups"

            print(yourgroups)
        }
        else if typeoffetch == "juryevents" {
            self.screentitle.text = "Jury in own contest"

            print(yourgroups)
        }
        else if typeoffetch == "juryeventsothers" {
            self.screentitle.text = "Jury in other's contest"
            
            print(yourgroups)
        }
        else if typeoffetch == "unpublished contests" {
            self.screentitle.text = "Unpublished contests"
            
            print(yourgroups)
        }
        if typeoffetch == "yourevents" || typeoffetch == "dashboardevents" {
            self.screentitle.text = "Your Contests"

            print(yourevents)
        }
        if typeoffetch == "joinedevents" {
            self.screentitle.text = "Joined Contests"

            print("Time for joined events")
            print(joinedevents)
        }
         if self.typeoffetch == "trendingdata" {
            self.screentitle.text = "Trending"

        }
         if typeoffetch == "joinedgroups" {
            self.screentitle.text = "Joined Groups"

        }
        if typeoffetch == "categories" {
            self.screentitle.text = "Categories"
        }
        if typeoffetch == "recommended contests" {
            if needtoloadrecommendedevents {
                self.recommendedeventsummary(pg: 0) { (rs) in
                    if rs {
                        self.table.reloadData()
                    }
                }
                
            }
            self.screentitle.text = "Recommended contests"
        }

       
    }
    
    
    func fetchdata(pg : Int)
    {
        print("Loding for page \(pg)")
        var userid = UserDefaults.standard.value(forKey: "refid") as! String

        var url = ""
        var params : Dictionary<String,Any> = [ : ]
              if self.typeoffetch == "categories" {
                self.table.reloadData()
               }
               else if self.typeoffetch == "trendingdata" {

                self.table.reloadData()
               }
                else if self.typeoffetch == "juryeventsothers" {

                 self.fetchjury(pg: pg)
                }
              else if self.typeoffetch == "juryevents" {
                
                self.fetchjuryself(pg: pg)
              }
               else if self.typeoffetch == "dashboardevents" {

                    url = Constants.K_baseUrl + Constants.getevents
                var addon = "?userid=\(userid)&contestStatus=2&contestType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=-1&isActive=true"
                var allu = "\(url)\(addon)"
                    params = ["Page": pg,"PageSize": 10,"contestStatus":2,"contestType": 0 ,"userid":"\(userid)"]
                    dashboardeventsfetch(url: allu, params: params)
                
                
               }
              else if typeoffetch == "joinedgroups" {

                url = "\(Constants.K_baseUrl)\(Constants.getjoinedgroups)?userid=\(userid)"
                params = ["Page": pg,"PageSize": 10,"userid":"\(userid)"]
                joinedgroupsfetch(url: url, params: params)
              }
               else if self.typeoffetch == "yourgroups" {
                self.screentitle.text = "Groups"

                self.table.reloadData()
               }
              else if typeoffetch == "unpublished contests" {
                url = Constants.K_baseUrl + Constants.getevents
                var addon = "?userid=\(userid)&contestStatus=2&contestType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=-1&isActive=false"
                var allu = "\(url)\(addon)"
                params  = ["Page": pg,"PageSize": 10,"userid":"\(userid)"]
                youreventsfetch(url: allu, params: params)
              }
               else if self.typeoffetch == "yourevents" {

                    url = Constants.K_baseUrl + Constants.getevents
                    var addon = "?userid=\(userid)&contestStatus=2&contestType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=-1&isActive=true"
                      var allu = "\(url)\(addon)"
                    params  = ["Page": pg,"PageSize": 10,"userid":"\(userid)"]
                    youreventsfetch(url: allu, params: params)
               }
               else if self.typeoffetch == "joinedevents" {

               url = Constants.K_baseUrl + Constants.joinedcontests
                var addon = "?userid=\(userid)&contestStatus=2&contestType=0"
                      var allu = "\(url)\(addon)"
                 params = ["userid": userid,"contestStatus" : 2 , "contestType" : 0,"Page": pg,
                "PageSize": 10]
                joinedeventsfetch(url: allu, params: params)
               }
        
        
        
        
    }
    
    
    
    func fetchjuryself(pg : Int)
    {
        var uid = UserDefaults.standard.value(forKey: "refid") as! String
        let url = "\(Constants.K_baseUrl)\(Constants.selfjury)?userId=\(uid)"
        let params : Dictionary<String,Any> = ["Page": pg,
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
                            self.juryevents.append(y)
                            
                            
                        }
                        self.table.reloadData()
                    }
                    
                }
            }
        }
    }
    
    
    func joinedgroupsfetch(url : String, params : Dictionary<String,Any>)
    {
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, error) in
            if let dv = response?.result.value as? Dictionary<String,AnyObject> {
               print(dv)
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
                            print(x)
                            print("----------------------")
                            self.joinedgroups.append(x)
                            
                            
                            
                        }
                        self.table.reloadData()
                    }
                }
            }
        }
    }
    
    
    func youreventsfetch(url : String,params : Dictionary<String,Any>)
    {
                    var r = BaseServiceClass()
                    r.postApiRequest(url: url, parameters: params) { (response, err) in
                        if let resv = response?.result.value as? Dictionary<String,Any> {
                            if let resps = resv["ResponseStatus"] as? Int {
                                if resps == 1 {
                                    print("Error")
                                }
                                else {
                                    if let results = resv["Results"] as? Dictionary<String,Any> {
                                        if let tc = results["Total"] as? Int {
                                        }
                                        if let data = results["Data"] as? [Dictionary<String,Any>] {
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
                                                var cim = ""
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
                                                if let cn = each["ContestImage"] as? String {
                                                    cim = cn
                                                }
                                                var tandc = ""
                                                if let cn = each["TermAndCondition"] as? String {
                                                    tandc = cn
                                                }
                                                var noofwinn = 0
                                                if let cn = each["NoOfWinner"] as? Int {
                                                    noofwinn = cn
                                                }
                                                
                                                var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                                                
                                                self.yourevents.append(x)
                                                
                                          
                                            }
                                            self.table.reloadData()
                   
                                        }
                                    }
                                }
                            }
                        }
                    }

        
    }
    
    
    func joinedeventsfetch(url : String,params : Dictionary<String,Any>)
    {
          let r = BaseServiceClass()
          r.postApiRequest(url: url, parameters: params) { (response, err) in
              if let res = response?.result.value as? Dictionary<String,Any> {
                  if let inner = res["Results"] as? Dictionary<String,Any> {
                      if let ea = inner["Data"] as? [Dictionary<String,Any>] {
                          print("%%%%%%%%%%%%%%%%%%%%%%")

                          print(ea)
                          print("%%%%%%%%%%%%%%%%%%%%%%")
                          for each in ea {
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
                                                var cim = ""
                              
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
                                                  var joined = false
                                                  var joinstatus = false
                                                 
                                                 if let cn = each["Joined"] as? Bool {
                                                     joined = cn
                                                 }
                                                 
                                                 if let cn = each["JoinStatus"] as? Bool {
                                                     joinstatus = cn
                                                 }
                            if let cn = each["ContestImage"] as? String {
                                cim = cn
                            }
                            var tandc = ""
                            if let cn = each["TermAndCondition"] as? String {
                                tandc = cn
                            }
                            var noofwinn = 0
                            if let cn = each["NoOfWinner"] as? Int {
                                noofwinn = cn
                            }
                                                 
                            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                                              
                                                  var y = streventcover(a: x, b: joined, c: joinstatus)
                                                 
                                                 print(x)
                                                  self.joinedevents.append(y)
                          }
                        self.table.reloadData()
                      }
                     
        
                      
                  }
              }
          }

    }
    
    
    
    
    func fetchjury(pg : Int)
    {
           var userid = UserDefaults.standard.value(forKey: "refid") as! String
           var uuid = UserDefaults.standard.value(forKey: "refid") as! String
           var url = "\(Constants.K_baseUrl)\(Constants.iamjury)?userId=\(userid)"
           var params : Dictionary<String,Any> = ["userid": userid,"Page": pg,
           "PageSize": 10]
  
           let r = BaseServiceClass()
           r.postApiRequest(url: url, parameters: params) { (response, err) in
               if let res = response?.result.value as? Dictionary<String,Any> {
                print(res)
                   if let inner = res["Results"] as? Dictionary<String,Any> {
                       if let ea = inner["Data"] as? [Dictionary<String,Any>] {
                           print("%%%%%%%%%%%%%%%%%%%%%%")
                            print(ea)
                           
                           print("%%%%%%%%%%%%%%%%%%%%%%")
                           for each in ea {
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
                                                   var cim = ""
                               
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
                                                   if let cn = each["ContestImage"] as? String {
                                                       cim = cn
                                                   }
                                                  if let cn = each["Juries"] as? [juryorwinner] {
                                                      juries = cn
                                                  }
                                                   var joined = false
                                                   var joinstatus = false
                                                  
                                                  if let cn = each["Joined"] as? Bool {
                                                      joined = cn
                                                  }
                                                  
                                                  if let cn = each["JoinStatus"] as? Bool {
                                                      joinstatus = cn
                                                  }
                            var tandc = ""
                            if let cn = each["TermAndCondition"] as? String {
                                tandc = cn
                            }
                            var noofwinn = 0
                            if let cn = each["NoOfWinner"] as? Int {
                                noofwinn = cn
                            }
                                                  
                            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                                               
                                                   var y = streventcover(a: x, b: joined, c: joinstatus)
                                                  
                              
                            self.juryevents.append(y)
                               
                           }
                        print(self.juryevents)
                       }
                      
         
                       
                   }
               }
           }
    }
    
     typealias progressindata = ((_ done : Bool) -> Void)
    func recommendedeventsummary(pg : Int ,done : @escaping progressindata)
    {
        
        var lat = CLLocationDegrees(exactly: 0)
        var longi = CLLocationDegrees(exactly: 0)
        var locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            if let lcc = currentLoc {
                if let l = currentLoc.coordinate.latitude as? CLLocationDegrees {
                    lat = l
                }
                if let lo = currentLoc.coordinate.longitude as? CLLocationDegrees {
                    longi = lo
                }
            }
        }
        
        
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var uuid = UserDefaults.standard.value(forKey: "refid") as! String
        var url = Constants.K_baseUrl + Constants.recommendedcontests
        var params : Dictionary<String,Any> = ["Page": pg,
                                               "PageSize": 10]
        var addon = "?latitude=\(lat)&longitude=\(longi)&distance=5"
        var allu = "\(url)\(addon)"
        let r = BaseServiceClass()
        r.postApiRequest(url: allu, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let inner = res["Results"] as? Dictionary<String,Any> {
                    if let ea = inner["Data"] as? [Dictionary<String,Any>] {
                        print("%%%%%%%%%%%%%%%%%%%%%%")
                        
                        
                        print("%%%%%%%%%%%%%%%%%%%%%%")
                        for each in ea {
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
                            var cim = ""
                            
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
                            
                            if let cn = each["Juries"] as? [juryorwinner] {
                                juries = cn
                            }
                            var joined = false
                            var joinstatus = false
                            
                            if let cn = each["Joined"] as? Bool {
                                joined = cn
                            }
                            
                            if let cn = each["JoinStatus"] as? Bool {
                                joinstatus = cn
                            }
                            var tandc = ""
                            if let cn = each["TermAndCondition"] as? String {
                                tandc = cn
                            }
                            var noofwinn = 0
                            if let cn = each["NoOfWinner"] as? Int {
                                noofwinn = cn
                            }
                            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                            
                            var y = streventcover(a: x, b: joined, c: joinstatus)
                            
                            if userid != uuid {
                                self.recommendedevents.append(y)
                            }
                        }
                        
                        done(true)
                    }
                    else {
                        done(false)
                    }
                    
                    
                    
                }
                else {
                    done(false)
                }
            }
            else {
                done(false)
            }
        }
    }

    
    
    
    func dashboardeventsfetch(url : String,params : Dictionary<String,Any>)
    {
        var r = BaseServiceClass()
                r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let resv = response?.result.value as? Dictionary<String,Any> {
                if let resps = resv["ResponseStatus"] as? Int {
                    if resps == 1 {
                        print("Error")
                    }
                    else {
                        if let results = resv["Results"] as? Dictionary<String,Any> {
                            if let tc = results["Total"] as? Int {
                            }
                            if let data = results["Data"] as? [Dictionary<String,Any>] {
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
                                    var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                                    
                                    self.dashboardevents.append(x)
                              
                                }
                                self.table.reloadData()
                            }
                        }
                    }
                }
            }
        }


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.typeoffetch == "categories" {
            return self.categories.count
        }
        else if self.typeoffetch == "juryevents" || self.typeoffetch == "juryeventsothers" {
            return self.juryevents.count
        }
        else if self.typeoffetch == "trendingdata" {
            return self.trendingdata.count
        }
        else if typeoffetch == "unpublished contests" {
            return self.unpublisedcontests.count
        }
        else if self.typeoffetch == "dashboardevents" {
            return self.dashboardevents.count
        }
        else if self.typeoffetch == "yourgroups" {
            return self.yourgroups.count
        }
        else if self.typeoffetch == "yourevents" {
            return self.yourevents.count
        }
        else if self.typeoffetch == "joinedevents" {
            return self.joinedevents.count
        }
        else if self.typeoffetch == "joinedgroups" {
            return self.joinedgroups.count
        }
        else if typeoffetch == "recommended contests" {
            return self.recommendedevents.count
        }
        return 10
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.typeoffetch == "categories" {
                  return 220
        }
        return 320
    }
    
     func hexStringToUIColor (hex:String) -> UIColor {
         var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

         if (cString.hasPrefix("#")) {
             cString.remove(at: cString.startIndex)
         }

         if ((cString.count) != 6) {
             return UIColor.gray
         }

         var rgbValue:UInt64 = 0
         Scanner(string: cString).scanHexInt64(&rgbValue)

         return UIColor(
             red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
             green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
             blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
             alpha: CGFloat(1.0)
         )
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "seeallcell", for: indexPath) as? SeeAllgeneralTableViewCell {
            var fc = self.gradients[indexPath.row%4]![0]
            var sc = self.gradients[indexPath.row%4]![1]
            if self.typeoffetch == "categories" {
                cell.updatecell(x: self.categories[indexPath.row],a:hexStringToUIColor(hex: fc),b:hexStringToUIColor(hex: sc))
            }
            else if self.typeoffetch == "juryevents" || self.typeoffetch == "juryeventsothers" {
                cell.updatecell5(x: self.juryevents[indexPath.row])
            }
            else if self.typeoffetch == "trendingdata" {
                cell.updatecell2(x: self.trendingdata[indexPath.row] , number : indexPath.row)
            }
            else if self.typeoffetch == "dashboardevents" {
                cell.updatecell3(x: self.dashboardevents[indexPath.row], number : indexPath.row)
            }
            else if self.typeoffetch == "yourgroups" {
                cell.updatecell4(x: self.yourgroups[indexPath.row])
            }
            else if typeoffetch == "unpublished contests" {
                cell.updatecell3(x: self.unpublisedcontests[indexPath.row], number : indexPath.row)
            }
            else if self.typeoffetch == "yourevents" {
                cell.updatecell3(x: self.yourevents[indexPath.row], number : indexPath.row)
            }
            else if self.typeoffetch == "joinedevents" {
                cell.updatecell5(x: self.joinedevents[indexPath.row])
            }
            else if self.typeoffetch == "joinedgroups" {
                cell.updatecell4(x: self.joinedgroups[indexPath.row])
            }
            else if typeoffetch == "recommended contests" {
                cell.updatecell5(x: self.recommendedevents[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.typeoffetch == "categories" {
            self.tappedcategoryid = self.categories[indexPath.row].id
            self.tappedcategoryname = self.categories[indexPath.row].categoryName
            
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
                
                
                performSegue(withIdentifier: "descategory", sender: nil)
            }
        
            
        }
        else if self.typeoffetch == "trendingdata" {
            self.tappedcategoryid = self.trendingdata[indexPath.row].activityid
            
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            performSegue(withIdentifier: "desctrending", sender: nil)
            }
        }
        else if self.typeoffetch == "juryevents" || self.typeoffetch == "juryeventsothers" {
            self.tappedcategoryid = self.juryevents[indexPath.row].a.contestid
            
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            performSegue(withIdentifier: "exjuryevent", sender: nil)
            }
        }
        else if self.typeoffetch == "dashboardevents" || self.typeoffetch == "yourevents" || self.typeoffetch == "joinedevents" || self.typeoffetch == "unpublished contests" || self.typeoffetch == "recommended contests" {
            if self.typeoffetch == "dashboardevents" {
                self.tappedcategoryid = self.dashboardevents[indexPath.row].contestid
            }
            else if typeoffetch == "unpublished contests" {
                 self.tappedcategoryid = self.unpublisedcontests[indexPath.row].contestid
            }
            else if self.typeoffetch == "yourevents" {
                self.tappedcategoryid = self.yourevents[indexPath.row].contestid
            }
            else if self.typeoffetch == "joinedevents" {
                self.tappedcategoryid = self.joinedevents[indexPath.row].a.contestid
            }
            else if typeoffetch == "recommended contests" {
                self.tappedcategoryid = self.recommendedevents[indexPath.row].a.contestid
            }
            
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            performSegue(withIdentifier: "desceventt", sender: nil)
            }
        }
        else if self.typeoffetch == "joinedgroups" || self.typeoffetch == "yourgroups" {
            if self.typeoffetch == "joinedgroups" {
                self.tappedcategoryid = self.joinedgroups[indexPath.row].groupid
            }
            else {
                self.tappedcategoryid = self.yourgroups[indexPath.row].groupid
            }
            
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            performSegue(withIdentifier: "descgroupp", sender: nil)
            }
        }
        
    }
    
    var locked = true
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.typeoffetch == "categories" {
            if indexPath.row == self.categories.count - 5 && locked == false && self.categories.count >= 10 {
                
            }
        }
        else if self.typeoffetch == "trendingdata" {
            if indexPath.row == self.trendingdata.count - 5 && locked == false && self.trendingdata.count >= 10 {

            }
        }
            else if self.typeoffetch == "juryevents" || self.typeoffetch == "juryeventsothers" {
              
                if indexPath.row == self.juryevents.count - 5 && locked == false && self.juryevents.count >= 10 {
                    if self.juryevents.count < (self.pagetostart - 1) * 10 {
                        return
                    }
                    locked = true
                    if self.typeoffetch == "juryevents" {
                    self.fetchdata(pg: self.pagetostart)
                    }
                    else if self.typeoffetch == "juryeventsothers" {
                        
                    }
                    self.pagetostart = self.pagetostart + 1
                }
            }
        else if self.typeoffetch == "dashboardevents" {
            print("\(indexPath.row) \(self.dashboardevents.count) \(locked) \(self.dashboardevents.count)")
            if indexPath.row == self.dashboardevents.count - 5 && locked == false && self.dashboardevents.count >= 10 {
                if self.dashboardevents.count < (self.pagetostart - 1) * 10 {
                    return
                }
                locked = true

                self.fetchdata(pg: self.pagetostart)
                self.pagetostart = self.pagetostart + 1
            }
        }
            else if self.typeoffetch == "joinedgroups" {
                if indexPath.row == self.joinedgroups.count - 5 && locked == false && self.joinedgroups.count >= 10 {
                    if self.joinedgroups.count < (self.pagetostart - 1) * 10 {
                        return
                    }
                    locked = true

                    self.fetchdata(pg: self.pagetostart)
                    self.pagetostart = self.pagetostart + 1
                }
            }
        else if self.typeoffetch == "yourgroups" {
            if indexPath.row == self.yourgroups.count - 5 && locked == false && self.yourgroups.count >= 10 {

            }
        }
        else if self.typeoffetch == "unpublished contests" {
            if indexPath.row == self.yourevents.count - 5 && locked == false && self.yourevents.count >= 10 {
                if self.yourevents.count < (self.pagetostart - 1) * 10 {
                    return
                }
                locked = true
                
                self.fetchdata(pg: self.pagetostart)
                self.pagetostart = self.pagetostart + 1
            }
        }
        else if self.typeoffetch == "yourevents" {
            print("\(indexPath.row) \(self.yourevents.count - 5) \(locked) \(self.yourevents.count)")

            if indexPath.row == self.yourevents.count - 5 && locked == false && self.yourevents.count >= 10 {
                if self.yourevents.count < (self.pagetostart - 1) * 10 {
                    return
                }
                locked = true

                self.fetchdata(pg: self.pagetostart)
                self.pagetostart = self.pagetostart + 1
            }
        }
        else if self.typeoffetch == "joinedevents" {
            if indexPath.row == self.joinedevents.count - 5 && locked == false && self.joinedevents.count >= 10 {
                if self.joinedevents.count < (self.pagetostart - 1) * 10 {
                    return
                }
                locked = true
                self.fetchdata(pg: self.pagetostart)
                self.pagetostart = self.pagetostart + 1
            }
        }
        else if typeoffetch == "recommended contests" {
            if indexPath.row == self.recommendedevents.count - 5 && locked == false && self.recommendedevents.count >= 10 {
                if self.recommendedevents.count < (self.pagetostart - 1) * 10 {
                    return
                }
                locked = true
                self.recommendedeventsummary(pg: self.pagetostart) { (res) in
                    if res {
                        self.pagetostart = self.pagetostart + 1
                        self.table.reloadData()
                    }
                }
                
            }
        }
        
        print("Cell goes off screen \(indexPath.row)")
        if self.typeoffetch == "categories" {
            if indexPath.row == self.categories.count - 2 {
                locked = false
            }
        }
        else if self.typeoffetch == "trendingdata" {
            if indexPath.row == self.trendingdata.count - 2 {
                locked = false

            }
        }
        else if self.typeoffetch == "dashboardevents" {
            if indexPath.row == self.dashboardevents.count - 2 {
                locked = false

            }
        }
        else if self.typeoffetch == "yourgroups" {
            if indexPath.row == self.yourgroups.count - 2 {
                locked = false

            }
        }
        else if self.typeoffetch == "unpublished contests" {
            if indexPath.row == self.unpublisedcontests.count - 2 {
                locked = false
                
            }
        }
        else if self.typeoffetch == "yourevents" {
            if indexPath.row == self.yourevents.count - 2 {
                locked = false

            }
        }
            else if self.typeoffetch == "joinedgroups" {
                       if indexPath.row == self.joinedgroups.count - 2 {
                           locked = false

                       }
                   }
        else if self.typeoffetch == "juryevents" || self.typeoffetch == "juryeventsothers" {
            if indexPath.row == self.juryevents.count - 2 {
                locked = false

            }
        }
        else if typeoffetch == "recommended contests" {
            if indexPath.row == self.recommendedevents.count - 2 {
                locked = false
                
            }
        }
        
        
    }
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg  = segue.destination as? CategorywisecontestsViewController {
            seg.hideit = false
            seg.categoryid = self.tappedcategoryid ?? 0
            seg.categoryname = self.tappedcategoryname.lowercased() ?? ""
        }
        if let seg = segue.destination as? IndividualpostViewController {
            seg.activityid = self.tappedcategoryid
        }
        if let seg = segue.destination as? JurycontestViewController {
            seg.contestid = self.tappedcategoryid
        }
        if let seg = segue.destination as? JoinedeventsViewController {
            seg.eventid = self.tappedcategoryid
        }
        if let seg = segue.destination as? MainGroupViewController {
            seg.isseguedevent = true
            seg.seguedeventid = self.tappedcategoryid
        }
    }
    
    
    
}
