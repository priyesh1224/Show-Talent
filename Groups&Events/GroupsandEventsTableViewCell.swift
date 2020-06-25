//
//  GroupsandEventsTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreLocation


struct groupparticipant
{
    var id : Int
    var name : String
    var profileimage : String
    var userid : String
    var countrycode : String
    var mobile : String
}

struct groupevent {
    var groupid : Int
    var ref_belongto : Int
    var group_belong : String
    var groupimage : String
    var createdon : String
    var youare : String
    var groupname : String
    var groupparticipation : Int
    var isverify : Bool
    var refuserid : String
    var members : [groupparticipant]
}


class GroupsandEventsTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var selectedgrouppassed : ((_ group : groupevent) -> ())?
    var selectedeventpassed : ((_ event : strevent) -> ())?
    var selectedjurypassed : ((_ event : streventcover) -> ())?
    var neededdata : [groupevent] = []
    var joinedeventsdata : [streventcover] = []
    var unpublishedevents : [strevent] = []
    var recommendedevents : [streventcover] = []
    var closedcontestes : [streventcover] = []
    var joinedgroups : [groupevent] = []
    var title = ""
    var currentwidth : CGFloat = 10
    var currentheight : CGFloat = 10
    var createtapped : ((_ x : String) -> Void)?
    var alleventsdata : [strevent] = []
    var alljurydata : [streventcover] = []
    var allselfjurydata : [streventcover] = []
    var passcounts : ((_ count : Int) -> ())?
    
    var isblannk : ((_ count : Bool , _ x : String , _ z : Int) -> ())?
    var passallgroups : ((_ count : [groupevent]) -> ())?
    var passallevents : ((_ count : [strevent]) -> ())?
    var passalljoinedevents : ((_ count : [streventcover]) -> ())?
    var passallunpublishedevents : ((_ count : [strevent]) -> ())?
    var passallrecommendedevents : ((_ count : [streventcover]) -> ())?
     var passalljoinedgroups : ((_ count : [groupevent]) -> ())?
    var passalljuryevents : ((_ count : [streventcover]) -> ())?
    var layout : UICollectionViewFlowLayout?
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var nodataimage: UIImageView!
    
    
    @IBOutlet weak var nodataview: UIView!
    
    @IBOutlet weak var nodataunderline: UITextView!
    
    
    @IBOutlet weak var nodatacreatebtn: UIButton!
    
    func updatecell(x:String,w:CGFloat,h:CGFloat) {
    
        self.selectionStyle = .none
        
        

        self.title = x
        self.currentwidth = 200
        self.currentheight = 180
        collection.delegate = self
        collection.dataSource = self
        collection.delegate = collection.dataSource as! UICollectionViewDelegate
        fetchdata(x: x)
        collection.clipsToBounds = true
        layout = UICollectionViewFlowLayout()
        self.nodataview.layer.cornerRadius = 10
        self.nodataview.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        self.nodataview.layer.borderWidth = 2
        self.nodatacreatebtn.layer.cornerRadius = 5
        self.nodatacreatebtn.layer.borderColor = #colorLiteral(red: 0.314635545, green: 0.4224303961, blue: 0.762909472, alpha: 1)
        self.nodatacreatebtn.layer.borderWidth = 1
        if w != 0 {
            
            if let l = layout {
                l.scrollDirection = .horizontal
                l.itemSize = CGSize(width: 200, height: 178)
                collection.reloadData()
                collection.collectionViewLayout = l
            }
            
        }
        
//        self.collection.reloadData()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("Reuse called for \(self.tag)")
//        self.collection.reloadData()
//        if self.title.lowercased() == "groups" {
//            if neededdata.count == 0 {
//                self.nodataimage.isHidden = false
//                self.collection.isHidden = true
//                self.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//            }
//            else {
//                self.nodataimage.isHidden = true
//                self.collection.isHidden = false
//            }
//
//        }
//        else if self.title.lowercased() == "i am jury in" && self.tag == 1 {
//            if alljurydata.count == 0 {
//                self.nodataimage.isHidden = false
//                self.collection.isHidden = true
//                self.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//            }
//            else {
//                self.nodataimage.isHidden = true
//                self.collection.isHidden = false
//            }
//        }
//        else if self.title.lowercased() == "joined groups" {
//            if joinedgroups.count == 0 {
//                self.nodataimage.isHidden = false
//                self.collection.isHidden = true
//                self.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//            }
//            else {
//                self.nodataimage.isHidden = true
//                self.collection.isHidden = false
//            }        }
//        else if self.title.lowercased() == "joined events" && self.tag == 3 {
//            if joinedeventsdata.count == 0 {
//                self.nodataimage.isHidden = false
//                self.collection.isHidden = true
//                self.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//            }
//            else {
//                self.nodataimage.isHidden = true
//                self.collection.isHidden = false
//            }        }
//        else if self.title.lowercased() == "unpublished contests" && self.tag == 0 {
//            if unpublishedevents.count == 0 {
//                self.nodataimage.isHidden = false
//                self.collection.isHidden = true
//                self.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//            }
//            else {
//                self.nodataimage.isHidden = true
//                self.collection.isHidden = false
//            }        }
//        else if self.title.lowercased() == "events" && self.tag == 2 {
//            if alleventsdata.count == 0 {
//                self.nodataimage.isHidden = false
//                self.collection.isHidden = true
//                self.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//            }
//            else {
//                self.nodataimage.isHidden = true
//                self.collection.isHidden = false
//            }        }
//        else if self.title.lowercased() == "recommended contests" && self.tag == 4 {
//            if recommendedevents.count == 0 {
//                self.nodataimage.isHidden = false
//                self.collection.isHidden = true
//                self.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//            }
//            else {
//                self.nodataimage.isHidden = true
//                self.collection.isHidden = false
//            }        }
    }
    
    func fetchdata(x:String)
    {
        
        if x == "jury in own"{
            self.allselfjurydata = GroupandEventsViewController.copyselfjuryevents
            if self.allselfjurydata.count == 0{
                self.isblannk?(true , "contest" , self.tag)
            }
            else {
                self.isblannk?(false , "contest", self.tag)
            }
        }
        
        if x == "joined events"{
            self.joinedeventsdata = GroupandEventsViewController.copyjoinedevents
            if self.joinedeventsdata.count == 0{
                self.isblannk?(true , "contest" , self.tag)
            }
            else {
                self.isblannk?(false , "contest", self.tag)
            }
        }
        if x == "unpublished contests" {
            self.unpublishedevents = GroupandEventsViewController.copyunpublishedevents
            if self.unpublishedevents.count == 0{
                print(self.tag)
                self.isblannk?(true , "contest" , self.tag)
            }
            else {
                self.isblannk?(false , "contest", self.tag)
            }
        }
        if x == "i am jury in"  {
            self.alljurydata = GroupandEventsViewController.copyjuryevents
            if self.alljurydata.count == 0{
                self.isblannk?(true , "contest" , self.tag)
            }
            else {
                self.isblannk?(false , "contest", self.tag)
            }
        }
        if x == "joined groups" {
            self.joinedgroups = GroupandEventsViewController.copyjoinedgroups
            if self.joinedgroups.count == 0{
                self.isblannk?(true , "group" , self.tag)
            }
            else {
                self.isblannk?(false , "group", self.tag)
            }
        }
        if x == "groups"  {
            self.neededdata = GroupandEventsViewController.copygroupdata
            if self.neededdata.count == 0{
                self.isblannk?(true , "group" , self.tag)
            }
            else {
                self.isblannk?(false , "group", self.tag)
            }
        }
        if x == "events" {
            self.alleventsdata = GroupandEventsViewController.copyevents
            if self.alleventsdata.count == 0{
                self.isblannk?(true , "contest" , self.tag)
            }
            else {
                self.isblannk?(false , "contest", self.tag)
            }
        }
        if x == "recommended contests" {
            self.recommendedevents = GroupandEventsViewController.copyrecommendedcontests
            if self.recommendedevents.count == 0{
                self.isblannk?(true , "contest" , self.tag)
            }
            else {
                self.isblannk?(false , "contest", self.tag)
            }
        }
       
        if x == "closed contests" {
            self.closedcontestes = GroupandEventsViewController.copyclosedcontests
            if self.closedcontestes.count == 0{
                self.isblannk?(true , "contest" , self.tag)
            }
            else {
                self.isblannk?(false , "contest", self.tag)
            }
        }
        
        print("My joined event length \(joinedeventsdata.count)")
        print("My unpublished event length \(unpublishedevents.count)")
        print("My jury data length \(alljurydata.count)")
        print("My joined group length \(joinedgroups.count)")
        print("My neededdata length \(neededdata.count)")
        print("My alleventdata length \(alleventsdata.count)")
        print("My closedcontests length \(closedcontestes.count)")
        self.collection.reloadData()
        
        
        
        
        
        
        
//        if x == "joined events" && joinedeventsdata.count > 0{
//               return
//           }
//        if x == "unpublished contests" && unpublishedevents.count > 0 {
//            return
//        }
//        if x == "i am jury in" && alljurydata.count > 0 {
//            return
//        }
//           if x == "joined groups" && joinedgroups.count > 0 {
//               return
//           }
//           if x == "groups" && neededdata.count > 0 {
//               return
//           }
//           if x == "events" && alleventsdata.count > 0 {
//               return
//           }
//        if x == "recommended contests" && recommendedevents.count > 0 {
//            return
//        }
//
//        let userid = UserDefaults.standard.value(forKey: "refid") as! String
//        let params : Dictionary<String,Any> = ["userId":userid]
//
//
//
//        if x == "unpublished contests" {
//            var userid = UserDefaults.standard.value(forKey: "refid") as! String
//            var url = Constants.K_baseUrl + Constants.getevents
//            var addon = "?userid=\(userid)&contestStatus=2&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=0&isActive=false"
//            var allu = "\(url)\(addon)"
//            var params : Dictionary<String,Any> = ["Page": 0,"PageSize": 10]
//            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
//            print(allu)
//            print(params)
//            var r = BaseServiceClass()
//            r.postApiRequest(url: allu, parameters: params) { (response, err) in
//                if let resv = response?.result.value as? Dictionary<String,Any> {
//                    if let resps = resv["ResponseStatus"] as? Int {
//                        if resps == 1 {
//                            print("Error")
//                        }
//                        else {
//                            if let results = resv["Results"] as? Dictionary<String,Any> {
//                                if let tc = results["Total"] as? Int {
//                                    //                                    self.categorycount.setTitle("See all \(tc)", for: .normal)
//                                    self.passcounts!(tc)
//                                }
//                                if let data = results["Data"] as? [Dictionary<String,Any>] {
//                                    print("Response from server")
//                                    print(data)
//                                    for each in data {
//                                        var contestid = 0
//                                        var contestname = ""
//                                        var allowcategoryid = 0
//                                        var allowcategory = ""
//                                        var organisationallow = false
//                                        var invitationtypeid = 0
//                                        var invitationtype = ""
//                                        var entryallowed = 0
//                                        var entrytype = ""
//                                        var entryfee = 0
//                                        var conteststart = ""
//                                        var contestlocation = ""
//                                        var description = ""
//                                        var resulton = ""
//                                        var contestprice = ""
//                                        var contestwinnerpricetypeid = 0
//                                        var contestpricetype = ""
//                                        var resulttypeid = 0
//                                        var resulttype = ""
//                                        var userid = ""
//                                        var groupid = 0
//                                        var createon = ""
//                                        var isactive = false
//                                        var status = false
//                                        var runningstatusid = 0
//                                        var runningstatus = ""
//                                        var juries : [juryorwinner] = []
//                                        var cim  = ""
//                                        if let cn = each["ContestId"] as? Int {
//                                            contestid = cn
//                                        }
//
//                                        if let cn = each["ContestName"] as? String {
//                                            contestname = cn
//                                        }
//                                        if let cn = each["AllowCategoryId"] as? Int {
//                                            allowcategoryid = cn
//                                        }
//                                        if let cn = each["AllowCategory"] as? String {
//                                            allowcategory = cn
//                                        }
//                                        if let cn = each["OrganizationAllow"] as? Bool {
//                                            organisationallow = cn
//                                        }
//                                        if let cn = each["InvitationTypeId"] as? Int {
//                                            invitationtypeid = cn
//                                        }
//                                        if let cn = each["InvitationType"] as? String {
//                                            invitationtype = cn
//                                        }
//                                        if let cn = each["EntryAllowed"] as? Int {
//                                            entryallowed = cn
//                                        }
//                                        if let cn = each["EntryType"] as? String {
//                                            entrytype = cn
//                                        }
//                                        if let cn = each["EntryFee"] as? Int {
//                                            entryfee = cn
//                                        }
//                                        if let cn = each["ContestStart"] as? String {
//                                            conteststart = cn
//                                        }
//                                        if let cn = each["ContestLocation"] as? String {
//                                            contestlocation = cn
//                                        }
//                                        if let cn = each["Description"] as? String {
//                                            description = cn
//                                        }
//                                        if let cn = each["ResultOn"] as? String {
//                                            resulton = cn
//                                        }
//                                        if let cn = each["ContestPrice"] as? String {
//                                            contestprice = cn
//                                        }
//                                        if let cn = each["ContestWinnerPriceTypeId"] as? Int {
//                                            contestwinnerpricetypeid = cn
//                                        }
//                                        if let cn = each["ContestWinnerPriceType"] as? String {
//                                            contestpricetype  = cn
//                                        }
//                                        if let cn = each["ResultTypeId"] as? Int {
//                                            resulttypeid = cn
//                                        }
//                                        if let cn = each["ResultType"] as? String {
//                                            resulttype = cn
//                                        }
//                                        if let cn = each["UserId"] as? String {
//                                            userid = cn
//                                        }
//                                        if let cn = each["GroupId"] as? Int {
//                                            groupid = cn
//                                        }
//                                        if let cn = each["CreateOn"] as? String {
//                                            createon = cn
//                                        }
//                                        if let cn = each["IsActive"] as? Bool {
//                                            isactive = cn
//                                        }
//                                        if let cn = each["Status"] as? Bool {
//                                            status = cn
//                                        }
//                                        if let cn = each["RunningStatusId"] as? Int {
//                                            runningstatusid = cn
//                                        }
//                                        if let cn = each["RunningStatus"] as? String {
//                                            runningstatus = cn
//                                        }
//                                        if let cn = each["Juries"] as? [juryorwinner] {
//                                            juries = cn
//                                        }
//                                        if let cfn = each["FileType"] as? String {
//                                            if cfn == "Video" {
//                                                if let cn = each["Thumbnail"] as? String {
//                                                    cim = cn
//                                                }
//                                            }
//                                            else {
//                                                if let cn = each["ContestImage"] as? String {
//                                                    cim = cn
//                                                }
//                                            }
//
//                                        }
//                                        else {
//                                            if let cn = each["ContestImage"] as? String {
//                                                cim = cn
//                                            }
//                                        }
//
//                                        var tandc = ""
//                                        if let cn = each["TermAndCondition"] as? String {
//                                            tandc = cn
//                                        }
//                                        var noofwinn = 0
//                                        if let cn = each["NoOfWinner"] as? Int {
//                                            noofwinn = cn
//                                        }
//                                        var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
//
//
//                                        self.unpublishedevents.append(x)
//
//
//                                    }
//                                    print("Holaaaa")
//                                    if self.unpublishedevents.count == 0{
//                                        self.isblannk!(true , "contest" , self.tag)
//                                    }
//                                    else {
//                                        self.isblannk!(false , "contest", self.tag)
//                                    }
//                                    self.passallunpublishedevents!(self.unpublishedevents)
//                                    self.collection.reloadData()
//
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//        else if x == "recommended contests" {
//            self.recommendedeventsummary(pg: 0, done: { (rd) in
//                if rd {
//                    self.passallrecommendedevents!(self.recommendedevents)
//                    self.collection.reloadData()
//
//                    if self.recommendedevents.count == 0{
//                        self.isblannk!(true , "contest", self.tag)
//                    }
//                    else {
//                        self.isblannk!(false , "contest", self.tag)
//                    }
//
//                }
//                else {
//                    self.isblannk!(true , "contest", self.tag)
//                }
//            })
//        }
//        else if x == "joined events" {
//            self.eventsummary { (rd) in
//                if rd {
//                    self.passalljoinedevents!(self.joinedeventsdata)
//                    self.collection.reloadData()
//
//                    if self.joinedeventsdata.count == 0{
//                        self.isblannk!(true , "contest", self.tag)
//                    }
//                    else {
//                         self.isblannk!(false , "contest", self.tag)
//                    }
//
//                }
//            }
//        }
//        else if x == "i am jury in"
//        {
//            self.juryeventsummary { (rd) in
//                if rd {
//                    self.passalljuryevents!(self.alljurydata)
//                    self.collection.reloadData()
//
//                    if self.alljurydata.count == 0{
//                        self.isblannk!(true , "", self.tag)
//                    }
//                    else {
//                        self.isblannk!(false , "", self.tag)
//                    }
//
//                }
//            }
//        }
//
//
//
//        else if x == "joined groups" {
//            var url = "\(Constants.K_baseUrl)\(Constants.getjoinedgroups)?userid=\(userid)"
//                 var r = BaseServiceClass()
//            var params : Dictionary<String,Any> = ["Page": 0,"PageSize": 10,"userid":"\(userid)"]
////            print(url)
////            print(params)
//                 r.postApiRequest(url: url, parameters: params) { (response, error) in
//                     if let dv = response?.result.value as? Dictionary<String,AnyObject> {
////                        print(dv)
//                         if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
//                             if let invv =  inv["Data"] as? [Dictionary<String,AnyObject>] {
//                                 for each in invv {
//                                     var gn = ""
//                                     var gid = 0
//                                     var gim = ""
//                                     var ref = 0
//                                     var grpbel = ""
//                                     var createdon = ""
//                                     var youare = ""
//                                     var othbelong = ""
//                                     var part = 0
//                                    var isverify = false
//                                    var refuid = ""
//                                    var memb : [groupparticipant] = []
//                                     if let g = each["GroupName"] as? String {
//                                         gn = g
//                                     }
//                                     if let g = each["GroupImage"] as? String {
//                                         gim = g
//                                     }
//                                     if let g = each["GroupBelong"] as? String {
//                                         grpbel = g
//                                     }
//                                     else if let g = each["BelongTo"] as? String {
//                                        grpbel = g
//                                    }
//                                     if let g = each["CreatedOn"] as? String {
//                                         createdon = g
//                                     }
//                                     if let g = each["YouAre"] as? String {
//                                         youare = g
//                                     }
//                                     if let g = each["OtherBelong"] as? String {
//                                         othbelong = g
//                                     }
//                                     if let g = each["GroupID"] as? Int {
//                                         gid = g
//                                     }
//                                     if let g = each["Ref_BelongGroup"] as? Int {
//                                         ref = g
//                                     }
//                                    if let g = each["TotalMembers"] as? Int {
//                                            part = g
//                                        }
//                                    if let g = each["IsVerify"] as? Bool {
//                                        isverify = g
//                                    }
//                                    if let g = each["Ref_UserId"] as? String {
//                                        refuid = g
//                                    }
//                                    if let g = each["Members"] as? [Dictionary<String,Any>] {
//                                        for mem in g {
//                                            var id = 0
//                                            var name = ""
//                                            var pim = ""
//                                            var uid = ""
//                                            var countrycode = ""
//                                            var mobile = ""
//                                            if let f = mem["ID"] as? Int {
//                                                id = f
//                                            }
//                                            if let f = mem["Name"] as? String {
//                                                name = f
//                                            }
//                                            if let f = mem["ProfileImage"] as? String {
//                                                pim = f
//                                            }
//                                            if let f = mem["UserId"] as? String {
//                                                uid = f
//                                            }
//                                            if let f = mem["CountryCode"] as? String {
//                                                countrycode = f
//                                            }
//                                            if let f = mem["Mobile"] as? String {
//                                                mobile = f
//                                            }
//                                            var gm = groupparticipant(id: id, name: name, profileimage: pim, userid: uid, countrycode: countrycode, mobile: mobile)
//                                            memb.append(gm)
//                                        }
//                                    }
//                                    var x = groupevent(groupid: gid, ref_belongto: ref, group_belong: grpbel, groupimage: gim, createdon: createdon, youare: youare, groupname: gn, groupparticipation: part, isverify: isverify , refuserid: refuid , members: memb)
//
//                                     self.joinedgroups.append(x)
//
//
//
////                                     print(each["GroupName"])
//                                 }
//                                if self.joinedgroups.count == 0{
//                                    self.isblannk!(true , "group", self.tag)
//                                }
//                                else {
//                                    self.isblannk!(false , "group" , self.tag)
//                                }
//                                 self.passalljoinedgroups!(self.joinedgroups)
//                                 self.collection.reloadData()
//                             }
//                         }
//                     }
//                 }
//        }
//        else if x == "groups"
//        {
//
//                var url = Constants.K_baseUrl + Constants.getmygroups
//                var allu = "\(url)?userId=\(userid)"
//                var r = BaseServiceClass()
//                r.getApiRequest(url: allu, parameters: params) { (response, error) in
//                    if let dv = response?.result.value as? Dictionary<String,AnyObject> {
//                        if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
//                            if let invv =  inv["Data"] as? [Dictionary<String,AnyObject>] {
//                                for each in invv {
//                                    var gn = ""
//                                    var gid = 0
//                                    var gim = ""
//                                    var ref = 0
//                                    var grpbel = ""
//                                    var createdon = ""
//                                    var youare = ""
//                                    var othbelong = ""
//                                    var part = 0
//                                    var isverify = false
//                                    var refuid = ""
//                                    var memb : [groupparticipant] = []
//                                    if let g = each["GroupName"] as? String {
//                                        gn = g
//                                    }
//                                    if let g = each["GroupImage"] as? String {
//                                        gim = g
//                                    }
//                                    if let g = each["GroupBelong"] as? String {
//                                        grpbel = g
//                                    }
//                                    else if let g = each["BelongTo"] as? String {
//                                        grpbel = g
//                                    }
//                                    if let g = each["CreatedOn"] as? String {
//                                        createdon = g
//                                    }
//                                    if let g = each["YouAre"] as? String {
//                                        youare = g
//                                    }
//                                    if let g = each["OtherBelong"] as? String {
//                                        othbelong = g
//                                    }
//                                    if let g = each["GroupID"] as? Int {
//                                        gid = g
//                                    }
//                                    if let g = each["Ref_BelongGroup"] as? Int {
//                                        ref = g
//                                    }
//                                    if let g = each["TotalMembers"] as? Int {
//                                        part = g
//                                    }
//                                    if let g = each["IsVerify"] as? Bool {
//                                        isverify = g
//                                    }
//                                    if let g = each["Ref_UserId"] as? String {
//                                        refuid = g
//                                    }
//                                    if let g = each["Members"] as? [Dictionary<String,Any>] {
//                                        for mem in g {
//                                            var id = 0
//                                            var name = ""
//                                            var pim = ""
//                                            var uid = ""
//                                            var countrycode = ""
//                                            var mobile = ""
//                                            if let f = mem["ID"] as? Int {
//                                                id = f
//                                            }
//                                            if let f = mem["Name"] as? String {
//                                                name = f
//                                            }
//                                            if let f = mem["ProfileImage"] as? String {
//                                                pim = f
//                                            }
//                                            if let f = mem["UserId"] as? String {
//                                                uid = f
//                                            }
//                                            if let f = mem["CountryCode"] as? String {
//                                                countrycode = f
//                                            }
//                                            if let f = mem["Mobile"] as? String {
//                                                mobile = f
//                                            }
//                                            var gm = groupparticipant(id: id, name: name, profileimage: pim, userid: uid, countrycode: countrycode, mobile: mobile)
//                                            memb.append(gm)
//                                        }
//                                    }
//
//                                    var x = groupevent(groupid: gid, ref_belongto: ref, group_belong: grpbel, groupimage: gim, createdon: createdon, youare: youare, groupname: gn, groupparticipation: part, isverify: isverify , refuserid: refuid , members: memb)
//                                    print(x)
//                                    print("------------&&&&&&&&&&----------")
//                                    self.neededdata.append(x)
//
//
//
//                                }
//                                if self.neededdata.count == 0{
//                                    self.isblannk!(true , "group", self.tag)
//                                }
//                                else {
//                                    self.isblannk!(false , "group", self.tag)
//                                }
//                                self.passallgroups!(self.neededdata)
//                                self.collection.reloadData()
//                            }
//                        }
//                    }
//                }
//        }
//
//
//
//
//
//     if x == "events" {
//
//        print("St start")
//                                      print(self.alleventsdata)
//        print("Event check")
//                    var userid = UserDefaults.standard.value(forKey: "refid") as! String
//            var url = Constants.K_baseUrl + Constants.getevents
//            var addon = "?userid=\(userid)&contestStatus=2&invitationType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=0&isActive=true"
//        var allu = "\(url)\(addon)"
//        var params : Dictionary<String,Any> = ["Page": 0,"PageSize": 10,"userid":"\(userid)", "contestStatus" : 2 , "contestType" : 0]
//        print(params)
//            var r = BaseServiceClass()
//            r.postApiRequest(url: allu, parameters: params) { (response, err) in
//                if let resv = response?.result.value as? Dictionary<String,Any> {
//                    if let resps = resv["ResponseStatus"] as? Int {
//                        if resps == 1 {
//                            print("Error")
//                        }
//                        else {
//                            if let results = resv["Results"] as? Dictionary<String,Any> {
//                                if let tc = results["Total"] as? Int {
////                                    self.categorycount.setTitle("See all \(tc)", for: .normal)
//                                    self.passcounts!(tc)
//                                }
//                                if let data = results["Data"] as? [Dictionary<String,Any>] {
//                                    print("Response from server")
//                                    print(data)
//                                    for each in data {
//                                        var contestid = 0
//                                        var contestname = ""
//                                        var allowcategoryid = 0
//                                        var allowcategory = ""
//                                        var organisationallow = false
//                                        var invitationtypeid = 0
//                                        var invitationtype = ""
//                                        var entryallowed = 0
//                                        var entrytype = ""
//                                        var entryfee = 0
//                                        var conteststart = ""
//                                        var contestlocation = ""
//                                        var description = ""
//                                        var resulton = ""
//                                        var contestprice = ""
//                                        var contestwinnerpricetypeid = 0
//                                        var contestpricetype = ""
//                                        var resulttypeid = 0
//                                        var resulttype = ""
//                                        var userid = ""
//                                        var groupid = 0
//                                        var createon = ""
//                                        var isactive = false
//                                        var status = false
//                                        var runningstatusid = 0
//                                        var runningstatus = ""
//                                        var juries : [juryorwinner] = []
//                                        var cim  = ""
//                                        if let cn = each["ContestId"] as? Int {
//                                            contestid = cn
//                                        }
//
//                                        if let cn = each["ContestName"] as? String {
//                                            contestname = cn
//                                        }
//                                        if let cn = each["AllowCategoryId"] as? Int {
//                                            allowcategoryid = cn
//                                        }
//                                        if let cn = each["AllowCategory"] as? String {
//                                            allowcategory = cn
//                                        }
//                                        if let cn = each["OrganizationAllow"] as? Bool {
//                                            organisationallow = cn
//                                        }
//                                        if let cn = each["InvitationTypeId"] as? Int {
//                                            invitationtypeid = cn
//                                        }
//                                        if let cn = each["InvitationType"] as? String {
//                                            invitationtype = cn
//                                        }
//                                        if let cn = each["EntryAllowed"] as? Int {
//                                            entryallowed = cn
//                                        }
//                                        if let cn = each["EntryType"] as? String {
//                                            entrytype = cn
//                                        }
//                                        if let cn = each["EntryFee"] as? Int {
//                                            entryfee = cn
//                                        }
//                                        if let cn = each["ContestStart"] as? String {
//                                            conteststart = cn
//                                        }
//                                        if let cn = each["ContestLocation"] as? String {
//                                            contestlocation = cn
//                                        }
//                                        if let cn = each["Description"] as? String {
//                                            description = cn
//                                        }
//                                        if let cn = each["ResultOn"] as? String {
//                                            resulton = cn
//                                        }
//                                        if let cn = each["ContestPrice"] as? String {
//                                            contestprice = cn
//                                        }
//                                        if let cn = each["ContestWinnerPriceTypeId"] as? Int {
//                                            contestwinnerpricetypeid = cn
//                                        }
//                                        if let cn = each["ContestWinnerPriceType"] as? String {
//                                          contestpricetype  = cn
//                                        }
//                                        if let cn = each["ResultTypeId"] as? Int {
//                                            resulttypeid = cn
//                                        }
//                                        if let cn = each["ResultType"] as? String {
//                                            resulttype = cn
//                                        }
//                                        if let cn = each["UserId"] as? String {
//                                            userid = cn
//                                        }
//                                        if let cn = each["GroupId"] as? Int {
//                                            groupid = cn
//                                        }
//                                        if let cn = each["CreateOn"] as? String {
//                                            createon = cn
//                                        }
//                                        if let cn = each["IsActive"] as? Bool {
//                                            isactive = cn
//                                        }
//                                        if let cn = each["Status"] as? Bool {
//                                            status = cn
//                                        }
//                                        if let cn = each["RunningStatusId"] as? Int {
//                                            runningstatusid = cn
//                                        }
//                                        if let cn = each["RunningStatus"] as? String {
//                                            runningstatus = cn
//                                        }
//                                        if let cn = each["Juries"] as? [juryorwinner] {
//                                            juries = cn
//                                        }
//                                        if let cfn = each["FileType"] as? String {
//                                            if cfn == "Video" {
//                                                if let cn = each["Thumbnail"] as? String {
//                                                    cim = cn
//                                                }
//                                            }
//                                            else {
//                                                if let cn = each["ContestImage"] as? String {
//                                                    cim = cn
//                                                }
//                                            }
//
//                                        }
//                                        else {
//                                            if let cn = each["ContestImage"] as? String {
//                                                cim = cn
//                                            }
//                                        }
//                                        var tandc = ""
//                                        if let cn = each["TermAndCondition"] as? String {
//                                            tandc = cn
//                                        }
//                                        var noofwinn = 0
//                                        if let cn = each["NoOfWinner"] as? Int {
//                                            noofwinn = cn
//                                        }
//
//                                        var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
//
//
//                                        self.alleventsdata.append(x)
//
//
//                                    }
//                                    print("Holaaaa")
//                                    print(self.alleventsdata)
//                                    if self.alleventsdata.count == 0{
//                                        self.isblannk!(true , "contest", self.tag)
//                                    }
//                                    else {
//                                        self.isblannk!(false , "contest", self.tag)
//                                    }
//                                    self.passallevents!(self.alleventsdata)
//                                    self.collection.reloadData()
//
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//
//        }
    }
    
    
    typealias progressindata = ((_ done : Bool) -> Void)
    
    func eventsummary(done : @escaping progressindata)
    {
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var uuid = UserDefaults.standard.value(forKey: "refid") as! String
        var url = Constants.K_baseUrl + Constants.joinedcontests
        var params : Dictionary<String,Any> = ["userid": userid,"contestStatus" : 2 , "contestType" : 0,"Page": 0,
        "PageSize": 10]
        var addon = "?userid=\(userid)&contestStatus=2&contestType=0"
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
                                self.joinedeventsdata.append(y)
                            }
                        }
                        print("Joined events count \(self.joinedeventsdata.count)")
                        done(true)
                    }
                   
      
                    
                }
            }
        }
    }
    
    
    
    
    
    
    
    
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
    
    
    
    
    
    
    func juryeventsummary(done : @escaping progressindata)
       {
           var userid = UserDefaults.standard.value(forKey: "refid") as! String
           var uuid = UserDefaults.standard.value(forKey: "refid") as! String
           var url = "\(Constants.K_baseUrl)\(Constants.iamjury)?userId=\(userid)"
           var params : Dictionary<String,Any> = ["userid": userid,"Page": 0,
           "PageSize": 10]
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        print(params)
        print(url)
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
                                                  
                              
                                   self.alljurydata.append(y)
                               
                           }
                        print(self.alljurydata)
                           done(true)
                       }
                      
         
                       
                   }
               }
           }
       }
    
    
    
    @IBAction func nodatabtntapped(_ sender: Any) {
        if self.nodatacreatebtn.titleLabel?.text?.lowercased() == "create group" {
            self.createtapped!("group")
        }
        else if self.nodatacreatebtn.titleLabel?.text?.lowercased() == "create contest" {
             self.createtapped!("contest")
        }

    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.title.lowercased() == "groups" {
            if neededdata.count == 0 {
            self.nodataview.isHidden = false
            self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic group."
                self.nodatacreatebtn.setTitle("Create Group", for: .normal)
            self.nodataimage.image = UIImage(named: "mgroup")
            }
            else {
                self.nodataview.isHidden = true
                self.collection.isHidden = false
            }
            return neededdata.count

        }
        else if self.title.lowercased() == "closed contests" {
            if closedcontestes.count == 0 {
                self.nodataview.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic contest."
                self.nodatacreatebtn.setTitle("Create Contest", for: .normal)
                self.nodataimage.image = UIImage(named: "mcontest")
            }
            else {
                self.nodataview.isHidden = true
                self.collection.isHidden = false
            }
            return closedcontestes.count
            
        }
        else if self.title.lowercased() == "jury in own" {
            if allselfjurydata.count == 0 {
                self.nodataview.isHidden = false
                self.nodataimage.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic contest."
                self.nodatacreatebtn.setTitle("Create Contest", for: .normal)
                self.nodataimage.image = UIImage(named: "mcontest")
            }
            else {
                self.nodataview.isHidden = true
                self.nodataimage.isHidden = true
                self.collection.isHidden = false
            }
            return allselfjurydata.count
        }
        else if self.title.lowercased() == "i am jury in" {
            if alljurydata.count == 0 {
                self.nodataview.isHidden = false
                self.nodataimage.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic contest."
                self.nodatacreatebtn.setTitle("Create Contest", for: .normal)
                self.nodataimage.image = UIImage(named: "mcontest")
            }
            else {
                self.nodataview.isHidden = true
                self.nodataimage.isHidden = true
                self.collection.isHidden = false
            }
                return alljurydata.count

            }
        else if self.title.lowercased() == "joined groups" {
            if joinedgroups.count == 0 {
                self.nodataview.isHidden = false
                self.nodataimage.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic group."
                self.nodatacreatebtn.setTitle("Create Group", for: .normal)
                self.nodataimage.image = UIImage(named: "mgroup")
            }
            else {
                self.nodataview.isHidden = true
                self.nodataimage.isHidden = true
                self.collection.isHidden = false
            }
            return joinedgroups.count
        }
        else if self.title.lowercased() == "joined events" {
            if joinedeventsdata.count == 0 {
                self.nodataview.isHidden = false
                self.nodataimage.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic contest."
                self.nodatacreatebtn.setTitle("Create Contest", for: .normal)
                self.nodataimage.image = UIImage(named: "mcontest")
            }
            else {
                self.nodataview.isHidden = true
                self.nodataimage.isHidden = true
                self.collection.isHidden = false
            }
            return joinedeventsdata.count
        }
        else if self.title.lowercased() == "unpublished contests" {
            if unpublishedevents.count == 0 {
                self.nodataview.isHidden = false
                self.nodataimage.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic contest."
                self.nodatacreatebtn.setTitle("Create Contest", for: .normal)
                self.nodataimage.image = UIImage(named: "mcontest")
            }
            else {
                self.nodataview.isHidden = true
                self.nodataimage.isHidden = true
                self.collection.isHidden = false
            }
            return self.unpublishedevents.count
        }
        else if self.title.lowercased() == "events" {
            if alleventsdata.count == 0 {
                self.nodataview.isHidden = false
                self.nodataimage.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic contest."
                self.nodatacreatebtn.setTitle("Create Contest", for: .normal)
                self.nodataimage.image = UIImage(named: "mcontest")
            }
            else {
                self.nodataview.isHidden = true
                self.nodataimage.isHidden = true
                self.collection.isHidden = false
            }
            return alleventsdata.count
        }
        else if self.title.lowercased() == "recommended contests" {
            if recommendedevents.count == 0 {
                self.nodataview.isHidden = false
                self.nodataimage.isHidden = false
                self.collection.isHidden = true
                self.nodataunderline.text = "Create your fantastic contest."
                self.nodatacreatebtn.setTitle("Create Contest", for: .normal)
                self.nodataimage.image = UIImage(named: "mcontest")
            }
            else {
                self.nodataview.isHidden = true
                self.nodataimage.isHidden = true
                self.collection.isHidden = false
            }
            return recommendedevents.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gecollection", for: indexPath) as? GroupsandEventsCollectionViewCell {
            if self.title.lowercased() == "groups"
            {
                cell.updatecell(item:neededdata[indexPath.row], type: title.lowercased())
            }
            else if self.title.lowercased() == "closed contests" {
                 cell.updatecell3(item:closedcontestes[indexPath.row], type: title.lowercased())
            }
             else if self.title.lowercased() == "joined groups"
                {
                    cell.updatecell(item: joinedgroups[indexPath.row], type: title.lowercased())
                }
            else if self.title.lowercased() == "joined events" {
                cell.updatecell3(item:joinedeventsdata[indexPath.row], type: title.lowercased())

            }
            else if self.title.lowercased() == "unpublished contests" {
                cell.updatecell2(item:unpublishedevents[indexPath.row], type: title.lowercased())
                
            }
            else if self.title.lowercased() == "recommended contests" {
                 cell.updatecell3(item:recommendedevents[indexPath.row], type: title.lowercased())
            }
            else if self.title.lowercased() == "jury in own" {
                cell.updatecell3(item:allselfjurydata[indexPath.row], type: title.lowercased())
            }
                else if self.title.lowercased() == "i am jury in"
                {
                
                    cell.updatecell3(item:alljurydata[indexPath.row], type: title.lowercased())

                }
            else if self.title.lowercased() == "events"
            {
                print("page going for update")
                cell.updatecell2(item:alleventsdata[indexPath.row], type: title.lowercased())

            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.title == "groups"
        {
            print("needed data")
            print(self.neededdata[indexPath.row])
            self.selectedgrouppassed!(self.neededdata[indexPath.row])
        }
        else if self.title.lowercased() == "closed contests" {
            self.selectedeventpassed!(self.closedcontestes[indexPath.row].a)
        }
        else if self.title == "joined groups" {
            self.selectedgrouppassed!(self.joinedgroups[indexPath.row])
        }
        else if self.title.lowercased() == "jury in own" {
            self.selectedjurypassed!(self.allselfjurydata[indexPath.row])
        }
            else if self.title == "i am jury in" {
                self.selectedjurypassed!(self.alljurydata[indexPath.row])
            }
        else if self.title == "events" {
            self.selectedeventpassed!(self.alleventsdata[indexPath.row])
        }
        else if self.title == "unpublished contests" {
            self.selectedeventpassed!(self.unpublishedevents[indexPath.row])
        }
        else if self.title == "joined events" {
            self.selectedeventpassed!(self.joinedeventsdata[indexPath.row].a)
        }
        else if self.title.lowercased() == "recommended contests" {
            self.selectedeventpassed!(self.recommendedevents[indexPath.row].a)
        }
    }
    
   
    
}
