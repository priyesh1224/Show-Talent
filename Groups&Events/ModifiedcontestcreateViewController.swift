//
//  ModifiedcontestcreateViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 3/31/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit



struct pretheme
{
    var contestid : Int
    var contestname : String
    var categoryid : Int
    var categoryname : String
    var organisationallow : Bool
    var invitationtypeid : Int
    var invitationtype : String
    var entryallowedid : Int
    var entrytype : String
    var entryfee : Int
    var conteststart : String
    var contestlocation : String
    var description : String
    var resulton : String
    var contestprice : String
    var contestwinnerpricetypeid : Int
    var contestwinnerpricetype : String
    var resultypeid : Int
    var resulttype : String
    var userdid : String
    var groupid : Int
    var groupname : String
    var createon : String
    var isactive : Bool
    var status : Bool
    var runnningstatusid : Int
    var runningstatus : String
    var joined : Bool
    var joinstatus : Bool
    var juries : [juryorwinner]
    var totalparticipant : Int
    var winners : [juryorwinner]
    var contestimage : String
    var creator : juryorwinner
    var totalreview : Int
    var themeid : Int
    var themename : String
    var performancetypeid : Int
    var performancetype : String
    var genderid : Int
    var gendername : String
    var participationpostallow : Bool
    var termsandconditions : String
    var contesttype : String
    var noofwinner : Int
    
    
}



class ModifiedcontestcreateViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    
    
    @IBOutlet weak var winnerwiseallocation: UITextView!
    
    
    @IBOutlet weak var winnerpriceouterview: UIView!
    
    
    @IBOutlet weak var winner1pricesv: UIStackView!
    
    
    @IBOutlet weak var winner2pricesv: UIStackView!
    
    
    @IBOutlet weak var winner3pricesv: UIStackView!
    
    @IBOutlet weak var thirdpriceval: UITextField!
    
    
    @IBOutlet weak var secondpriceval: UITextField!
    
    @IBOutlet weak var firstpriceval: UITextField!
    
    
    
    
    
    @IBOutlet weak var negativespace: NSLayoutConstraint!
    
    @IBOutlet weak var round1: UIView!
    
    
    @IBOutlet weak var round2: UIView!
    
    
    @IBOutlet weak var round3: UIView!
    
    @IBOutlet weak var bod1: UIView!
    
    @IBOutlet weak var contestname: UITextField!
    
    
    @IBOutlet weak var bod2: UIView!
    
    @IBOutlet weak var startdatebtn: UIButton!
    
    @IBOutlet weak var enddatebtn: UIButton!
    
    
    @IBOutlet weak var bod3: UIView!
    
    @IBOutlet weak var contestdescription: UITextView!
    
    
    @IBOutlet weak var bod4: UIView!
    
    @IBOutlet weak var contestlocation: UITextField!
    
    
    
    @IBOutlet weak var bod5: UIView!
    
    
    @IBOutlet weak var contestbelongtocommunity: UITextView!
    
    
    @IBOutlet weak var bod6: UIView!
    
    @IBOutlet weak var contestcategory: UITextView!
    
    
    @IBOutlet weak var bod7: UIView!
    
    @IBOutlet weak var selecttheme: UITextView!
    
    
    @IBOutlet weak var bod8: UIView!
    
    @IBOutlet weak var performancetype: UITextView!
    
    
    @IBOutlet weak var bod9: UIView!
    
    @IBOutlet weak var genderallow: UITextView!
    
    
    @IBOutlet weak var bod10: UIView!
    
    
    @IBOutlet weak var contestentryfees: UITextField!
    
    
    @IBOutlet weak var bod11: UIView!
    
    
    @IBOutlet weak var noofwinners: UITextView!
    
    
    @IBOutlet weak var bod12: UIView!
    
    @IBOutlet weak var invitationtype: UITextView!
    
    
    @IBOutlet weak var bod13: UIView!
    
    
    @IBOutlet weak var contestprice: UITextView!
    
    
    @IBOutlet weak var createbtn: CustomButton!
    
    
    @IBOutlet weak var bod14: UIView!
    
    
    @IBOutlet weak var contestentrytype: UITextView!
    
    
    @IBOutlet weak var bod15: UIView!
    
    
    @IBOutlet weak var contestpriceabsolute: UITextField!
    
    
    @IBOutlet weak var bod16: UIView!
    
    
    @IBOutlet weak var countrybtn: UITextView!
    
    
    
    @IBOutlet weak var bod17: UIView!
    
    
    @IBOutlet weak var statebtn: UITextView!
    
    
    @IBOutlet weak var bod18: UIView!
    
    
    @IBOutlet weak var citybtn: UITextView!
    
    @IBOutlet weak var bodtc: UIView!
    
    @IBOutlet weak var conttandc: UITextField!
    
    @IBOutlet weak var notif: UIView!
    
    
    @IBOutlet weak var svwidth: NSLayoutConstraint!
    
    @IBOutlet weak var svheight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var customview: UIView!
    
    
    @IBOutlet weak var custompicker: UIPickerView!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var okpopup: UIButton!
    
    
    @IBOutlet weak var st: UITextView!
    
    
    @IBOutlet weak var cty: UITextView!
    
    
    @IBOutlet weak var contestbelongtocommunityshow: UITextView!
    
    @IBOutlet weak var contestcategoryshow: UITextView!
    
    @IBOutlet weak var contestthemeshow: UITextView!
    
    @IBOutlet weak var contestperformancetypeshow: UITextView!
    
    
    @IBOutlet weak var contestgenderallowshow: UITextView!
    
    
    @IBOutlet weak var contestentryfeeshow: UITextView!
    
    
    @IBOutlet weak var contestentrytypeshow: UITextView!
    
    
    @IBOutlet weak var contestnoofsinnersshow: UITextView!
    
    
    @IBOutlet weak var invitationtypeshow: UITextView!
    
    
    @IBOutlet weak var contestpriceshow: UITextView!
    
    
    @IBOutlet weak var contestpricetypeshow: UITextView!
    
    
    
    @IBOutlet weak var nextview2: UIButton!
    
    @IBOutlet weak var nextview1: UIButton!
    
    
    
    @IBOutlet weak var rounded3: UIButton!
    
    
    @IBOutlet weak var rounded2: UIButton!
    
    
    @IBOutlet weak var rounded1: UIButton!
    
    
    @IBOutlet weak var upperview1: UIView!
    
    
    @IBOutlet weak var upperview2: UIView!
    
    
    @IBOutlet weak var perfupperspace: NSLayoutConstraint!
    
    @IBOutlet weak var themeupperspace: NSLayoutConstraint!
    
    
    @IBOutlet weak var choosetheme: UILabel!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var ortheme: UILabel!
    
    
    @IBOutlet weak var createmanually: UIButton!
    
    
    var createmode = false
    var categoryselected = ""
    
    var passingevent : strevent?
    
    var params : Dictionary<String,Any> = [:]
    var tempparams : Dictionary<String,Any> = [:]
    
    var currentthemeid = 0
    var ischoosentheme = false
    
    
    var passedevent : strevent?
    var isineditmode = false
    var themeid = 0
    var performancetypeid = 0
    var genderid = 0
    
    var themename = ""
    var performancetypename = ""
    var gendername = ""
    var winnerscount = 0

    
    @IBOutlet weak var upperview3: UIView!
    
    var comingwithoutgroup = false
    
    var eventid = 0
    var eventwhole : strevent?
    var contestwinnertypes : [contestwintypes] = []
    var entrytypes : [entrytype] = []
    var contestwinnerprices : [contestwinnerpricess] = []
    var conteststatus : [conteststatuses] = []
    var invitationtypes : [invitationtypess] = []
    var allcategories : [categorybrief] = []
    var allperformancemodels : [performancetypemodels] = []
    var allgenders : [genders] = []
    var allthemes : [themes] = []
    var eventcreator : juryorwinner?
    var groupid = 0
    var juryid = 0
    var allchoosenfields : Dictionary<String,Any> = [:]
     var alldatainsync : Dictionary<String,Any> = [:]
    var dropdownselectedtype = ""
    
    var allunfilteredthemes : [pretheme] = []
    var allprethemes : [pretheme] = []
    
    
    var allwinnersexistingprices : [pricewinnerwise] = []
    var allmygroups : [groupevent] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.svwidth.constant = self.view.frame.size.width
        self.collection.delegate = self
        self.collection.dataSource = self
        
        paintborder(x: bod1)
        paintborder(x: bod2)
        paintborder(x: bod3)
        paintborder(x: bod4)
        paintborder(x: bod5)
        paintborder(x: bod6)
        paintborder(x: bod7)
        paintborder(x: bod8)
        paintborder(x: bod9)
        paintborder(x: bod10)
        paintborder(x: bod11)
        paintborder(x: bod12)
        paintborder(x: bod13)
        paintborder(x: bod14)
        paintborder(x: bod15)
        paintborder(x: bod16)
        paintborder(x: bod17)
        paintborder(x: bod18)
        paintborder(x: bodtc)
        paintborder(x: winnerpriceouterview)
        
        rounded1.layer.cornerRadius = 15
        rounded2.layer.cornerRadius = 15
        rounded3.layer.cornerRadius = 15
        nextview2.layer.cornerRadius = 30
        nextview1.layer.cornerRadius = 30
        createmanually.layer.cornerRadius = 25
        
        
        var layout = UICollectionViewFlowLayout()
        
        
            
        
                layout.scrollDirection = .horizontal
                layout.itemSize = CGSize(width: 200, height: 140)
                collection.reloadData()
                collection.collectionViewLayout = layout
        
            
        
        
        okpopup.layer.cornerRadius = 25
        if comingwithoutgroup {
            self.contestbelongtocommunityshow.isHidden = false
            self.bod5.isHidden =  false
            self.negativespace.constant = 8
            self.fetchmegroups()
        }
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        createbtn.layer.cornerRadius = 30
        self.customview.isHidden = true
        custompicker.delegate = self
        custompicker.dataSource = self
        self.fetchcategories()
        self.fetchdata()
        
        
        
        upperview1.isHidden = true
        upperview3.isHidden = true
        
        if isineditmode {
            self.choosetheme.isHidden = true
            self.collection.isHidden = true
            self.ortheme.isHidden = true
            self.createmanually.isHidden = true
            self.nextview2.isHidden = false
            self.themeupperspace.constant = 16
            self.contestperformancetypeshow.isHidden = false
            self.contestgenderallowshow.isHidden = false
            bod8.isHidden = false
            bod9.isHidden = false
            self.createbtn.setTitle("Edit", for: .normal)
        }
        else {
            self.choosetheme.isHidden = false
            self.collection.isHidden = false
            self.ortheme.isHidden = false
            self.createmanually.isHidden = false
            self.themeupperspace.constant = -200
            self.nextview2.isHidden = true
            self.contestperformancetypeshow.isHidden = true
            self.contestgenderallowshow.isHidden = true
            bod8.isHidden = true
            bod9.isHidden = true
            self.fetchprethemes()
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    func fetchprethemes()
    {
       var x = strevent(contestid: 1190, contestname: "Golf ", allowcategoryid: 124, allowcategory: "Sports", organisationallow: true, invitationtypeid: 5, invitationtype: "OPEN", entryallowed: 5, entrytype: "IMAGE", entryfee: 1000, conteststart: "2020-04-29T03:48:25.303", contestlocation: "", description: "Test", resulton: "2020-04-29T03:48:25.303", contestprice: "Cash", contestwinnerpricetypeid: 1, contestpricetype: "Amount", resulttypeid: 2, resulttype: "Two Winner", userid: "066af0e3-5394-4a86-9e99-acdeb9879ac5", groupid: 1045, createon: "2020-04-29T03:51:34.63", isactive: true, status: true, runningstatusid: 3, runningstatus: "Running", juries: [], contestimage: "http://thcoreapi.maraekat.com/Upload/Contest/1198/9b3bfdc6-bf34-4925-b77b-99c78f2c718e..jpg", termsandcondition: "")
        
        var url = "http://thcoreapi.maraekat.com/api/v1/Contest/GetContest?contestStatus=0&invitationType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=0&isActive=false&contesttype=TEMPLATE"
        
        var r = BaseServiceClass()
        var params : Dictionary<String,Any> = ["Page": 0,
                                               "PageSize": 10]
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                print(res)
                if let code = res["ResponseStatus"] as? Int {
                    if code == 0 {
                        if let rr = res["Results"] as? Dictionary<String,Any> {
                            if let data = rr["Data"] as? [Dictionary<String,Any>] {
                                for each in data {
                                    var contestid : Int = 0
                                    var contestname : String = ""
                                    var categoryid : Int = 0
                                    var categoryname : String = ""
                                    var organisationallow : Bool = false
                                    var invitationtypeid : Int = 0
                                    var invitationtype : String = ""
                                    var entryallowedid : Int = 0
                                    var entrytype : String = ""
                                    var entryfee : Int = 0
                                    var conteststart : String = ""
                                    var contestlocation : String = ""
                                    var description : String = ""
                                    var resulton : String = ""
                                    var contestprice : String = ""
                                    var contestwinnerpricetypeid : Int = 0
                                    var contestwinnerpricetype : String = ""
                                    var resultypeid : Int = 0
                                    var resulttype : String = ""
                                    var userdid : String = ""
                                    var groupid : Int = 0
                                    var groupname : String = ""
                                    var createon : String = ""
                                    var isactive : Bool = false
                                    var status : Bool = false
                                    var runnningstatusid : Int = 0
                                    var runningstatus : String = ""
                                    var joined : Bool = false
                                    var joinstatus : Bool = false
                                    var juries : [juryorwinner] = []
                                    var totalparticipant : Int = 0
                                    var winners : [juryorwinner] = []
                                    var contestimage : String = ""
                                    var creator : juryorwinner?
                                    var totalreview : Int = 0
                                    var themeid : Int = 0
                                    var themename : String = ""
                                    var performancetypeid : Int = 0
                                    var performancetype : String = ""
                                    var genderid : Int = 0
                                    var gendername : String = ""
                                    var participationpostallow : Bool = false
                                    var termsandconditions : String = ""
                                    var contesttype : String = ""
                                    var noofwinner : Int = 0
                                    
                                    if let r = each["ContestId"] as? Int {
                                        contestid = r
                                    }
                                    if let r = each["ContestName"] as? String {
                                        contestname = r
                                    }
                                    if let r = each["AllowCategoryId"] as? Int {
                                        categoryid = r
                                    }
                                    if let r = each["AllowCategory"] as? String {
                                        categoryname = r
                                    }
                                    if let r = each["OrganizationAllow"] as? Bool {
                                        organisationallow = r
                                    }
                                    if let r = each["InvitationTypeId"] as? Int {
                                        invitationtypeid = r
                                    }
                                    if let r = each["InvitationType"] as? String {
                                       invitationtype  = r
                                    }
                                    if let r = each["EntryAllowed"] as? Int {
                                        entryallowedid = r
                                    }
                                    if let r = each["EntryType"] as? String {
                                        entrytype = r
                                    }
                                    if let r = each["EntryFee"] as? Int {
                                        entryfee = r
                                    }
                                    if let r = each["ContestStart"] as? String {
                                        conteststart = r
                                    }
                                    if let r = each["ContestLocation"] as? String {
                                        contestlocation = r
                                    }
                                    if let r = each["Description"] as? String {
                                        description = r
                                    }
                                    if let r = each["ResultOn"] as? String {
                                        resulton = r
                                    }
                                    if let r = each["ContestPrice"] as? String {
                                        contestprice = r
                                    }
                                    if let r = each["ContestWinnerPriceTypeId"] as? Int {
                                        contestwinnerpricetypeid = r
                                    }
                                    if let r = each["ContestWinnerPriceType"] as? String {
                                        contestwinnerpricetype = r
                                    }
                                    if let r = each["ResultTypeId"] as? Int {
                                        resultypeid = r
                                    }
                                    
                                    if let r = each["ResultType"] as? String {
                                        resulttype = r
                                    }
                                    if let r = each["UserId"] as? String {
                                        userdid = r
                                    }
                                    if let r = each["GroupId"] as? Int {
                                        groupid = r
                                    }
                                    if let r = each["GroupName"] as? String {
                                        groupname = r
                                    }
                                    if let r = each["CreateOn"] as? String {
                                        createon = r
                                    }
                                    if let r = each["IsActive"] as? Bool {
                                        isactive = r
                                    }
                                    if let r = each["Status"] as? Bool {
                                        status = r
                                    }
                                    if let r = each["RunningStatusId"] as? Int {
                                        runnningstatusid = r
                                    }
                                    
                                    if let r = each["RunningStatus"] as? String {
                                        runningstatus = r
                                    }
                                    if let r = each["Joined"] as? Bool {
                                        joined = r
                                    }
                                    if let r = each["JoinStatus"] as? Bool {
                                        joinstatus = r
                                    }
                                    if let r = each["Juries"] as? [Dictionary<String,Any>] {
                                        for each in r {
                                            var id = 0
                                            var userid = ""
                                            var name  = ""
                                            var profile = ""
                                            if let e = each["ID"] as? Int {
                                                id = e
                                            }
                                            if let e = each["UserID"] as? String {
                                                userid = e
                                            }
                                            if let e = each["Name"] as? String {
                                                name = e
                                            }
                                            if let e = each["Profile"] as? String {
                                                profile = ""
                                            }
                                            var x = juryorwinner(id: id, userid: userdid, name: name, profile: profile)
                                            juries.append(x)
                                        }
                                    }
                                    if let r = each["TotalParticipation"] as? Int {
                                        totalparticipant = r
                                    }
                                    if let r = each["Winners"] as? [Dictionary<String,Any>] {
                                        for each in r {
                                            var id = 0
                                            var userid = ""
                                            var name  = ""
                                            var profile = ""
                                            if let e = each["ID"] as? Int {
                                                id = e
                                            }
                                            if let e = each["UserID"] as? String {
                                                userid = e
                                            }
                                            if let e = each["Name"] as? String {
                                                name = e
                                            }
                                            if let e = each["Profile"] as? String {
                                                profile = ""
                                            }
                                            var x = juryorwinner(id: id, userid: userdid, name: name, profile: profile)
                                            winners.append(x)
                                        }
                                    }
                                    if let r = each["ContestImage"] as? String {
                                        contestimage = r
                                    }
                                    
                                    if let r = each["Creator"] as? Dictionary<String,Any> {
                                        var id = 0
                                        var userid = ""
                                        var name  = ""
                                        var profile = ""
                                        if let e = r["ID"] as? Int {
                                            id = e
                                        }
                                        if let e = r["UserID"] as? String {
                                            userid = e
                                        }
                                        if let e = r["Name"] as? String {
                                            name = e
                                        }
                                        if let e = r["Profile"] as? String {
                                            profile = ""
                                        }
                                        creator = juryorwinner(id: id, userid: userdid, name: name, profile: profile)
                                    }
                                    if let r = each["TotalReview"] as? Int {
                                        totalreview = r
                                    }
                                    if let r = each["ThemeId"] as? Int {
                                        themeid = r
                                    }
                                    if let r = each["ThemeName"] as? String {
                                        themename = r
                                    }
                                    if let r = each["PerformanceTypeId"] as? Int {
                                        performancetypeid = r
                                    }
                                    if let r = each["PorformaceType"] as? String {
                                        performancetype = r
                                    }
                                    
                                    if let r = each["Gender"] as? Int {
                                        genderid = r
                                    }
                                    if let r = each["GenderName"] as? String {
                                        gendername = r
                                    }
                                    if let r = each["ParticipantPostAllow"] as? Bool {
                                        participationpostallow = r
                                    }
                                    if let r = each["TermAndCondition"] as? String {
                                        termsandconditions = r
                                    }
                                    if let r = each["ContestType"] as? String {
                                        contesttype = r
                                    }
                                    if let r = each["NoOfWinner"] as? Int {
                                        noofwinner = r
                                    }
                                    
                                    
                                    var x  = pretheme(contestid: contestid, contestname: contestname, categoryid: categoryid, categoryname: categoryname, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowedid: entryallowedid, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestwinnerpricetype: contestwinnerpricetype, resultypeid: resultypeid, resulttype: resulttype, userdid: userdid, groupid: groupid, groupname: groupname, createon: createon, isactive: isactive, status: status, runnningstatusid: runnningstatusid, runningstatus: runningstatus, joined: joined, joinstatus: joinstatus, juries: juries, totalparticipant: totalparticipant, winners: winners, contestimage: contestimage, creator: creator ?? juryorwinner(id: 0, userid: "", name: "", profile: ""), totalreview: totalreview, themeid: themeid, themename: themename, performancetypeid: performancetypeid, performancetype: performancetype, genderid: genderid, gendername: gendername, participationpostallow: participationpostallow, termsandconditions: termsandconditions, contesttype: contesttype, noofwinner: noofwinner)
                                    
                                    self.allprethemes.append(x)
                                    self.allunfilteredthemes.append(x)
                                    
                                }
                                if self.allprethemes.count == 0 {
                                    self.choosetheme.text = "No relevant themes available"
                                }
                                else {
                                    self.choosetheme.text = "Choose Theme"
                                }
                                self.collection.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.allprethemes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pretheme", for: indexPath) as? PrethemefetchCollectionViewCell {
            cell.update(x: self.allprethemes[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.createmode = false
        var d = self.allprethemes[indexPath.row].contestid
        self.themeid = indexPath.row
        self.categoryselected = self.allprethemes[indexPath.row].categoryname.lowercased()
        self.performSegue(withIdentifier: "presenttheme", sender: nil)
    }
    
    
    @IBAction func createmanuallytapped(_ sender: UIButton) {
        print("Creating manually")
        if comingwithoutgroup && self.allmygroups.count == 0 {
            self.fetchmegroups()
        }
        
        if comingwithoutgroup && self.groupid == 0 {
            self.present(customalert.showalert(x: "You need to select group."), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Category"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Category"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Theme"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Theme"), animated: true, completion: nil)
        }
        else {
            self.perfupperspace.constant = -128
            self.contestbelongtocommunityshow.isHidden = false
            self.bod5.isHidden = false
            self.choosetheme.isHidden = true
            self.collection.isHidden = true
            self.ortheme.isHidden = true
            self.createmanually.isHidden = true
            self.nextview2.isHidden = false
            self.contestperformancetypeshow.isHidden = false
            self.contestgenderallowshow.isHidden = false
            bod8.isHidden = false
            bod9.isHidden = false
            bod6.isHidden = true
            bod7.isHidden = true
            contestcategoryshow.isHidden = true
            contestthemeshow.isHidden = true
        }
    }
    
    func prefeedvalues()
    {
        var abstheme = ""
        var absgender = ""
        var absperform = ""
        
        if self.themeid == 1 {
            self.themeid = 6
        }
        
        var th : themes?
        var gn : genders?
        var pt : performancetypemodels?
        
        for each in allgenders {
            if each.id == self.genderid {
                gn = each
                absgender = each.gender
            }
        }
        
        
        print("Theme id is \(self.themeid)")
        print(self.allthemes)
        
        for each in allthemes {
            if each.id == self.themeid {
                th = each
                abstheme = each.theme
                 print("Theme is \(abstheme)")
            }
        }
        
        for each in allperformancemodels {
            if each.id == self.performancetypeid {
                pt = each
                absperform = each.peroformance
            }
        }
        
        var catt : categorybrief?
        for each in allcategories {
            if each.categoryid == self.passedevent?.allowcategoryid {
                catt = each
                
            }
        }
        
        
        var invt : invitationtypess?
        for each in invitationtypes {
            if each.invitation.lowercased() == self.passedevent?.invitationtype.lowercased() {
                invt = each
            }
        }
        
        var envtt : entrytype?
        for each in entrytypes {
            if each.contestentrytype.lowercased() == self.passedevent?.entrytype.lowercased() {
                envtt = each
            }
        }
        
        var wenvtt : contestwinnerpricess?
        for each in contestwinnerprices {
            if each.id == self.passedevent?.contestwinnerpricetypeid {
                wenvtt = each
            }
        }
        
        var wwenvtt : contestwintypes?
        for each in contestwinnertypes {
            if each.contestwintype.lowercased() == self.passedevent?.resulttype.lowercased() {
                wwenvtt = each
            }
        }
        
        var efff = 0
        if let e = self.passedevent?.entryfee as? Int {
            efff = e
        }
        
        var cppp = ""
        if let e = self.passedevent?.contestprice as? String {
            cppp = e
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
        let date = dateFormatter.date(from: passedevent?.resulton ?? "")
        self.allchoosenfields["Contest Result Date"] = date
        let date2 = dateFormatter.date(from: passedevent?.conteststart ?? "")
        self.allchoosenfields["Contest Start Date"] = date2
        
        self.allchoosenfields["Category"] = catt
        
        self.allchoosenfields["Contest Name"] = self.passedevent?.contestname.capitalized
        self.allchoosenfields["Contest Description"] = self.passedevent?.description
        self.allchoosenfields["Contest Location"] = ""
        self.allchoosenfields["Entry Fees"] = "\(efff)"
        self.allchoosenfields["Contest Price"] = "\(cppp.capitalized)"
        self.allchoosenfields["Organisation Allowed"] = false
        self.allchoosenfields["Performance Type"] = pt
        self.allchoosenfields["Gender"] = gn
        self.allchoosenfields["Invitation type"] = invt
        self.allchoosenfields["Entry Type"] = envtt
//        self.allchoosenfields["Contest Start Date"] = self.passedevent?.conteststart
//        self.allchoosenfields["Contest Result Date"] = self.passedevent?.resulton
        self.allchoosenfields["Contest Winner Price Type"] = wenvtt
        self.allchoosenfields["Contest Result Type"] = wwenvtt
        self.allchoosenfields["Contest Theme"] = th
        self.allchoosenfields["Contest Terms & Conditions"] = self.passedevent?.termsandcondition
        
        print("Here is all choosen Fields")
        print(self.allchoosenfields)
        
        
        winnerscount = self.allwinnersexistingprices.count
        
        var allocations : Dictionary<String,String> = [:]
        
        print(self.allwinnersexistingprices)
        
        for e in self.allwinnersexistingprices  {
            
            allocations["\(e.position)"] = "\(e.amount)"
            
            
        }
        print("Allocation")
        print(allocations)
        
        if winnerscount == 0 {
            winner1pricesv.isHidden = true
            winner2pricesv.isHidden = true
            winner3pricesv.isHidden = true
        }
        else if winnerscount == 1 {
            winner1pricesv.isHidden = false
            winner2pricesv.isHidden = true
            winner3pricesv.isHidden = true
            
            firstpriceval.text = allocations["1"]!
        }
        else if winnerscount == 2 {
            winner1pricesv.isHidden = false
            winner2pricesv.isHidden = false
            winner3pricesv.isHidden = true
            firstpriceval.text = allocations["1"]!
            secondpriceval.text = allocations["2"]!
        }
        else {
            winner1pricesv.isHidden = false
            winner2pricesv.isHidden = false
            winner3pricesv.isHidden = false
            firstpriceval.text = allocations["1"]!
            secondpriceval.text = allocations["2"]!
            thirdpriceval.text = allocations["3"]!
        }
        
        
        
        
        self.contestname.text = self.passedevent?.contestname.capitalized
        self.startdatebtn.setTitle(getrequireddate(x:self.passedevent?.conteststart ?? ""), for: .normal)
        self.enddatebtn.setTitle(getrequireddate(x:self.passedevent?.resulton ?? ""), for: .normal)
        self.contestdescription.text = self.passedevent?.description
        self.contestcategory.text = self.passedevent?.allowcategory.capitalized
        self.selecttheme.text = abstheme.capitalized
        self.performancetype.text = absperform.capitalized
        self.genderallow.text = absgender.capitalized
        self.contestentryfees.text = "\(self.passedevent?.entryfee ?? 0)"
        
        self.contestentrytype.text = "\(self.passedevent?.entrytype.capitalized ?? "")"
        self.noofwinners.text = "\(self.passedevent?.resulttype.capitalized ?? "")"
        self.invitationtype.text = "\(self.passedevent?.invitationtype.capitalized ?? "")"
        
        self.contestpriceabsolute.text = "\(self.passedevent?.contestpricetype.capitalized ?? "")"
        self.contestprice.text = "\(self.passedevent?.contestprice.capitalized ?? "")"
        self.conttandc.text = self.passedevent?.termsandcondition ?? ""
        
    }
    
    
    func getrequireddate(x : String) -> String
    {
        var y = x.components(separatedBy: "T")
        var a = y[0]
        var b = y[1]
        var c = b.components(separatedBy: ".")
        var d = c[0]
        return "\(a) \(d)"
    }
    
    
    func bringdatepicker()
    {
        self.datepicker.isHidden = false
        self.custompicker.isHidden = true
        self.customview.isHidden = false
    }
    func bringcustompicker()
    {
        self.datepicker.isHidden = true
        self.custompicker.isHidden = false
        self.customview.isHidden = false
        self.custompicker.reloadAllComponents()
    }
    
    
    
    @IBAction func nextview1pressed(_ sender: Any) {
        
        print(self.allchoosenfields)
        
        if let s  = self.contestname.text {
            if s != "" && s != " " {
                self.allchoosenfields["Contest Name"] = s
            }
        }
        
        if let s  = self.contestdescription.text {
            if s != "" && s != " " {
                self.allchoosenfields["Contest Description"] = s
            }
        }
        
        if let s  = self.contestlocation.text {
            if s != "" && s != " " {
                self.allchoosenfields["Contest Location"] = s
            }
            else {
                self.allchoosenfields["Contest Location"] = ""
            }
        }
        else {
            self.allchoosenfields["Contest Location"] = ""
        }
        var errorcheck = false
        
        if isineditmode {
            print(self.allchoosenfields["Contest Result Date"])
            print(self.allchoosenfields["Contest Start Date"])
           
            if let c = self.allchoosenfields["Contest Result Date"] as? String {
                
            
            if let d = self.allchoosenfields["Contest Start Date"] as? String {
                let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303'"
                            if let date = dateFormatter.date(from: c) as? Date {
                                if let date2 = dateFormatter.date(from: d) as? Date {
                                    print("Check this")
                                    print(date)
                                    print(date2)
                                    if date.timeIntervalSince(date2).isLessThanOrEqualTo(0) {
                                        errorcheck = true
                                    }
                                }
                            }
                
            }
            }

//            if let tl = "\(self.allchoosenfields["Contest Result Date"])" as? String {
//                if let ttl = "\(self.allchoosenfields["Contest Start Date"])" as? String {
//            print(tl)
//            print(ttl)
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
//            if let date = dateFormatter.date(from: tl) as? Date {
//                if let date2 = dateFormatter.date(from: ttl) as? Date {
//                    print(date)
//                    print(date2)
//                    if date.timeIntervalSince(date2).isLessThanOrEqualTo(0) {
//                        errorcheck = true
//                    }
//                }
//            }
//                }}

           
            
        }
        else {
            if let c = self.allchoosenfields["Contest Result Date"] as? Date {
                if let r = self.allchoosenfields["Contest Start Date"] as? Date {
                    print("Time Interval \(c.timeIntervalSince(r))")
                    if c.timeIntervalSince(r).isLessThanOrEqualTo(0) {
                        errorcheck = true
                    }
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        

        
        
        if errorcheck {
            self.present(customalert.showalert(x: "Contest End date should be later to Start Date."), animated: true, completion: nil)
        }

        else if(self.allchoosenfields["Contest Name"] == nil) {
            self.present(customalert.showalert(x: "You need to enter contest name"), animated: true, completion: nil)
        }
        

        else if(self.allchoosenfields["Contest Start Date"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Start Date"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Location"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Location"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Result Date"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Result Date"), animated: true, completion: nil)
        }
        else {
            
            upperview1.isHidden = true
            upperview2.isHidden = true
            upperview3.isHidden = false
            rounded3.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
            rounded3.setTitleColor(UIColor.white, for: .normal)
            
        }
    }
    
    
    func fetchmegroups()
    {
        
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var url = Constants.K_baseUrl + Constants.getmygroups
        var allu = "\(url)?userId=\(userid)"
        let params : Dictionary<String,Any> = ["userId":userid]
        var r = BaseServiceClass()
        r.getApiRequest(url: allu, parameters: params) { (response, error) in
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
                                                                print("------------&&&&&&&&&&----------")
                            self.allmygroups.append(x)
                            
                            
                            
                        }
                       
                       
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    @IBAction func nextviewpressed2(_ sender: Any) {
        
       
   
          if(self.allchoosenfields["Gender"] == nil) {
            self.present(customalert.showalert(x: "You need to enter gender"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Category"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Category"), animated: true, completion: nil)
        }
         else if(self.allchoosenfields["Performance Type"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Performance Type"), animated: true, completion: nil)
         }
        else if(self.allchoosenfields["Contest Theme"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Theme"), animated: true, completion: nil)
        }
         else {
            upperview3.isHidden = true
            upperview1.isHidden = false
            upperview2.isHidden = true
            rounded2.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
            rounded2.setTitleColor(UIColor.white, for: .normal)
            
        }
    }
    
    
    @IBAction func closepopuppressed(_ sender: Any) {
        self.customview.isHidden = true
    }
    
    
    
    @IBAction func okpopuppressed(_ sender: Any) {
        
        var selectedval = ""
        print(dropdownselectedtype)
        
         if self.dropdownselectedtype == "showmegroups" {
            if let groupitem = self.allmygroups[self.custompicker.selectedRow(inComponent: 0)].groupid as? Int{
            print("selected group id \(groupitem)")
            self.groupid = groupitem
            self.alldatainsync[self.dropdownselectedtype] = "\(groupitem)"
            self.contestbelongtocommunity.text = self.allmygroups[self.custompicker.selectedRow(inComponent: 0)].groupname.capitalized
            }
        }

        else if self.dropdownselectedtype == "Entry Type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.entrytypes[self.custompicker.selectedRow(inComponent: 0)]
            
            if let sv = self.entrytypes[self.custompicker.selectedRow(inComponent: 0)] as? entrytype {
                selectedval = sv.contestentrytype
                self.alldatainsync[self.dropdownselectedtype] = selectedval
                self.contestentrytype.text = selectedval.capitalized
            }
            
            
        }
        else if self.dropdownselectedtype == "Invitation type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.invitationtypes[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.invitationtypes[self.custompicker.selectedRow(inComponent: 0)].invitation
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            self.invitationtype.text = selectedval.capitalized
            
        }
        else if self.dropdownselectedtype == "Performance Type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.allperformancemodels[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.allperformancemodels[self.custompicker.selectedRow(inComponent: 0)].peroformance
            self.performancetypename = selectedval.capitalized
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            self.performancetype.text = selectedval.capitalized
            self.performancetypeid = self.allperformancemodels[self.custompicker.selectedRow(inComponent: 0)].id
            
        }
        else if self.dropdownselectedtype == "Gender" {
            self.allchoosenfields[self.dropdownselectedtype] = self.allgenders[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.allgenders[self.custompicker.selectedRow(inComponent: 0)].gender
            gendername = selectedval
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            self.genderallow.text = selectedval.capitalized
            self.genderid = self.allgenders[self.custompicker.selectedRow(inComponent: 0)].id
            
        }
            
        else if self.dropdownselectedtype == "Contest Winner Price Type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.contestwinnerprices[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.contestwinnerprices[self.custompicker.selectedRow(inComponent: 0)].winnerprice
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            self.contestprice.text = selectedval.capitalized
            
        }
        else if self.dropdownselectedtype == "Contest Result Type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.contestwinnertypes[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.contestwinnertypes[self.custompicker.selectedRow(inComponent: 0)].contestwintype
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            self.noofwinners.text = selectedval.capitalized
            self.winnerscount = self.contestwinnertypes[self.custompicker.selectedRow(inComponent: 0)].winner
            
            if winnerscount == 1 {
                winner1pricesv.isHidden = false
                winner2pricesv.isHidden = true
                winner3pricesv.isHidden = true
            }
            else if winnerscount == 2 {
                winner1pricesv.isHidden = false
                winner2pricesv.isHidden = false
                winner3pricesv.isHidden = true
            }
            else {
                winner1pricesv.isHidden = false
                winner2pricesv.isHidden = false
                winner3pricesv.isHidden = false
            }
            
            
           
            
        }
        else if self.dropdownselectedtype == "Category" {
            self.allchoosenfields[self.dropdownselectedtype] = self.allcategories[self.custompicker.selectedRow(inComponent: 0)]
            var tselectedval = self.allcategories[self.custompicker.selectedRow(inComponent: 0)]
            
            allprethemes = []
            for each in self.allunfilteredthemes {
                if each.categoryname.lowercased() == tselectedval.categoryname.lowercased() {
                    allprethemes.append(each)
                }
            }
            if self.allprethemes.count == 0 {
                self.choosetheme.text = "No relevant themes available"
            }
            else {
                self.choosetheme.text = "Choose Theme"
            }
            self.collection.reloadData()
            
            if isineditmode {
                self.alldatainsync[self.dropdownselectedtype] = tselectedval.categoryname
                self.allchoosenfields[self.dropdownselectedtype] = tselectedval.categoryname


            }
            else {
                self.alldatainsync[self.dropdownselectedtype] = tselectedval
                self.allchoosenfields[self.dropdownselectedtype] = tselectedval
            }
            self.contestcategory.text = tselectedval.categoryname.capitalized
            self.fetchthemes()
            
        }
        else if self.dropdownselectedtype == "Contest Theme" {
            
            if allthemes.count > 0 {
                if let th = self.allthemes[self.custompicker.selectedRow(inComponent: 0)] as? themes
                { self.allchoosenfields[self.dropdownselectedtype] = self.allthemes[self.custompicker.selectedRow(inComponent: 0)]
                    selectedval = self.allthemes[self.custompicker.selectedRow(inComponent: 0)].theme
                    themename = selectedval
                    self.alldatainsync[self.dropdownselectedtype] = selectedval
                    self.selecttheme.text = selectedval.capitalized
                    self.themeid = self.allthemes[self.custompicker.selectedRow(inComponent: 0)].id
                    allprethemes = []
                    for each in self.allunfilteredthemes {
                        if each.themename.lowercased() == selectedval.lowercased() {
                            allprethemes.append(each)
                        }
                    }
                    if self.allprethemes.count == 0 {
                        self.choosetheme.text = "No relevant themes available"
                    }
                    else {
                        self.choosetheme.text = "Choose Theme"
                    }
                    self.collection.reloadData()
                    
                    
                }
            }
            
        }
        else if self.dropdownselectedtype == "Contest Start Date" || self.dropdownselectedtype == "Contest Result Date" {
            print("Selected \(self.dropdownselectedtype)")
            self.allchoosenfields[self.dropdownselectedtype] = self.datepicker.date
            selectedval = self.datepicker.date.description.components(separatedBy: "+")[0]
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            if isineditmode {
                self.allchoosenfields[self.dropdownselectedtype] = self.datepicker.date.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303Z'")
            }
            else {
                self.allchoosenfields[self.dropdownselectedtype] = self.datepicker.date
            }
            if self.dropdownselectedtype == "Contest Start Date" {
                self.startdatebtn.setTitle(selectedval, for: .normal)
            }
            else if self.dropdownselectedtype == "Contest Result Date" {
                self.enddatebtn.setTitle(selectedval, for: .normal)
            }
            
        }
        print(self.alldatainsync)
        self.customview.isHidden = true
    }
    
    
    
    
    
    @IBAction func countrybtntapped(_ sender: UIButton) {
    }
    
    
    @IBAction func statebtnpressed(_ sender: Any) {
    }
    
    
    @IBAction func citybtnpressed(_ sender: Any) {
    }
    
    
    
    
    
    @IBAction func startdatetapped(_ sender: UIButton) {
        self.dropdownselectedtype = "Contest Start Date"
        bringdatepicker()
        
    }
    
    
    @IBAction func enddatetapped(_ sender: UIButton) {
        self.dropdownselectedtype = "Contest Result Date"
        bringdatepicker()
    }
    
    
    
    @IBAction func contestbelongtotapped(_ sender: Any) {
        self.dropdownselectedtype = "showmegroups"
        self.bringcustompicker()
    }
    
    
    @IBAction func contestcategorytapped(_ sender: Any) {
        self.dropdownselectedtype = "Category"
        self.bringcustompicker()
    }
    
    
    @IBAction func selectthemetapped(_ sender: Any) {
        self.dropdownselectedtype  = "Contest Theme"
        self.bringcustompicker()
    }
    
    
    @IBAction func performancetypetapped(_ sender: Any) {
        self.dropdownselectedtype  = "Performance Type"
        self.bringcustompicker()
    }
    
    @IBAction func genderallowtapped(_ sender: Any) {
        self.dropdownselectedtype  = "Gender"
        self.bringcustompicker()
    }
    
    
    @IBAction func noofwinnerstapped(_ sender: Any) {
        self.dropdownselectedtype  = "Contest Result Type"
        self.bringcustompicker()
    }
    
    
    @IBAction func invitationtapped(_ sender: Any) {
        self.dropdownselectedtype  = "Invitation type"
        self.bringcustompicker()
    }
    
    
    @IBAction func contestpricetapped(_ sender: Any) {
        self.dropdownselectedtype  = "Contest Winner Price Type"
        self.bringcustompicker()
    }
    
    
    @IBAction func contestentrytypepressed(_ sender: UIButton) {
        self.dropdownselectedtype  = "Entry Type"
        self.bringcustompicker()
    }
    
    
    
    
    func updatetheevent()
    {
        var rsid = 2
        if let idd = self.passedevent?.runningstatusid as? Int {
            rsid = idd
        }
        print("Event id \(self.eventid) and group Id \(self.groupid)")
        print("Here is update stuff")
        print(self.allchoosenfields)
        var newcontestname = ""
        var newcontestdetails = ""
        var newcontestentryfees = -1
        var newcontestprice = ""
        var newtc  = ""
        
        
        
        
        
        var extraparams : [Dictionary<String,Any>] = []
        var winnerpriceerror = ""
        if winnerscount == 0 {
            extraparams = []
        }
        else if winnerscount == 1 {
            if let ffv = Int(self.firstpriceval.text ?? "") as? Int {
                var x : Dictionary<String,Any> = ["Sno" : 1 , "Position" : 1 , "Price" : "\(ffv)"]
                extraparams.append(x)
            }
            else {
                winnerpriceerror = "First winner price should be numeric."
            }
            
        }
        else if winnerscount == 2 {
            if let ffv = Int(self.firstpriceval.text ?? "") as? Int {
                var x : Dictionary<String,Any> = ["Sno" : 1 , "Position" : 1 , "Price" : "\(ffv)"]
                extraparams.append(x)
            }
            else {
                winnerpriceerror = "First winner price should be numeric."
            }
            if let ffv = Int(self.secondpriceval.text ?? "") as? Int {
                var x : Dictionary<String,Any> = ["Sno" : 2 , "Position" : 2 , "Price" : "\(ffv)"]
                extraparams.append(x)
            }
            else {
                winnerpriceerror = "Second winner price should be numeric."
            }
            
        }
        else if winnerscount == 3 {
            if let ffv = Int(self.firstpriceval.text ?? "") as? Int {
                var x : Dictionary<String,Any> = ["Sno" : 1 , "Position" : 1 , "Price" : "\(ffv)"]
                extraparams.append(x)
            }
            else {
                winnerpriceerror = "First winner price should be numeric."
            }
            if let ffv = Int(self.secondpriceval.text ?? "") as? Int {
                var x : Dictionary<String,Any> = ["Sno" : 2 , "Position" : 2 , "Price" : "\(ffv)"]
                extraparams.append(x)
            }
            else {
                winnerpriceerror = "Second winner price should be numeric."
            }
            if let ffv = Int(self.thirdpriceval.text ?? "") as? Int {
                var x : Dictionary<String,Any> = ["Sno" : 3 , "Position" : 3 , "Price" : "\(ffv)"]
                extraparams.append(x)
            }
            else {
                winnerpriceerror = "Third winner price should be numeric."
            }
        }
        
        
        
        if let n = self.conttandc.text as? String {
            newtc = n
        }
        print("\(self.contestname.text) is the name")
        if let n = self.contestname.text as? String{
            newcontestname = n
        }
        if let n = self.contestdescription.text as? String {
            newcontestdetails = n
        }
        if let n = Int(self.contestentryfees.text ?? "-1") as? Int {
            newcontestentryfees = n
        }
        if let n = self.contestpriceabsolute.text as? String {
            newcontestprice = n
        }
        
        
        if winnerpriceerror != "" {
            extraparams = []
            self.present(customalert.showalert(x: "\(winnerpriceerror)"), animated: true, completion: nil)
        }
        else if newcontestname == "" || newcontestname == " " {
            self.present(customalert.showalert(x: "Contest Name can not be blank"), animated: true, completion: nil)
        }
        else if newcontestdetails == "" || newcontestdetails == " " {
            self.present(customalert.showalert(x: "Contest Description can not be blank"), animated: true, completion: nil)
        }
        else if newcontestprice == "" || newcontestprice == " " {
            self.present(customalert.showalert(x: "Contest Price can not be blank"), animated: true, completion: nil)
        }
        else if newcontestentryfees == -1 {
            self.present(customalert.showalert(x: "You need to enter Numeric Contest Entry Fees"), animated: true, completion: nil)
        }
        else {
             var userid = UserDefaults.standard.value(forKey: "refid") as! String
            var reson = ""
            var conton = ""
            
           
            print(self.allchoosenfields["Contest Result Date"])
            print(self.allchoosenfields["Contest Start Date"])
            if let c = self.allchoosenfields["Contest Result Date"] as? Date {
                reson =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303Z'")
            }
            else if let c =  self.allchoosenfields["Contest Result Date"] as? String {
                reson = c
            }
            if reson == "" {
                if let c = self.allchoosenfields["Contest Result Date"] as? Date {
                    reson =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303'")
                    reson = "\(reson)Z"
                }
            }
            if let c = self.allchoosenfields["Contest Start Date"] as? Date {
                conton =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303Z'")
            }
            else if let c =  self.allchoosenfields["Contest Start Date"] as? String {
                conton = c
            }
            if conton == "" {
                if let c = self.allchoosenfields["Contest Start Date"] as? Date {
                conton =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303'")
                conton = "\(conton)Z"
                }
            }
            print("After \(reson)  \(conton)")
            if let cat = self.allchoosenfields["Category"] as? categorybrief {
                if let invt = self.allchoosenfields["Invitation type"] as? invitationtypess {
                    if let et = self.allchoosenfields["Entry Type"] as? entrytype {
                        if let cpt = self.allchoosenfields["Contest Winner Price Type"] as? contestwinnerpricess {
                            if let cwt = self.allchoosenfields["Contest Result Type"] as? contestwintypes {
                                if let cppt = self.allchoosenfields["Performance Type"] as? performancetypemodels {
                                    if let cgn = self.allchoosenfields["Gender"] as? genders {
                                        if let conth = self.allchoosenfields["Contest Theme"] as? themes {
                                            var ttc = ""
                                            
                                            if let tc = self.allchoosenfields["Contest Terms & Conditions"] as? String {
                                                ttc = tc
                                            }
                                            
                                            var params : Dictionary<String,Any> = ["ID": self.eventid,
                                                                                   "ContestName": newcontestname,
                                                                                   "AllowCategoryId": cat.categoryid,
                                                                                   "OrganizationAllow": true,
                                                                                   "InvitationType": invt.id,
                                                                                   "EntryAllowed": et.id,
                                                                                   "EntryFee": newcontestentryfees,
                                                                                   "ContestStart": conton,
                                                                                   "ContestLocation": "",
                                                                                   "Description": newcontestdetails,
                                                                                   "ResultOn": reson,
                                                                                   "ContestPrice": newcontestprice,
                                                                                   "ContestWinnerPriceTypeId": cpt.id,
                                                                                   "ResultTypeId": cwt.id,
                                                                                   "UserId": userid,
                                                                                   "GroupId": self.groupid,
                                                                                   
                                                                                   "IsActive": false,
                                                                                   
                                                                                   "RunningStatusId": rsid,
                                                                                   "PerformanceTypeId": cppt.id,
                                                                                   "Gender": cgn.id,
                                                                                   "ThemeId": conth.id,
                                                                                   "TermAndCondition": "\(newtc)",
                                                                                    "WinnerPrices" : extraparams
                                                                                   ]
                                            
                                            var r = BaseServiceClass()
                                            r.postApiRequest(url: Constants.K_baseUrl + Constants.updatecontest, parameters: params) { (response, err) in
                                                if let results = response?.result.value as? Dictionary<String,Any> {
                                                    print(results)
                                                    if let rsp = results["ResponseStatus"] as? Int {
                                                        print(rsp)
                                                        if rsp == 0 {
                                                            
                                                            
                                                            let alert = UIAlertController(title: "Show Talent", message: "Contest Updated", preferredStyle: UIAlertController.Style.alert)
                                                            alert.addAction(UIAlertAction(title: "Ok", style:.cancel, handler: { (ac) in
                                                                self.performSegue(withIdentifier: "backtozero", sender: nil)
                                                            }))
                                                            self.present(alert, animated: true, completion: nil)
                                                            
                                                           
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            print(params)
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
            
            
            
            
            
            
            

        }

        print(newcontestname)
        print(newcontestdetails)
        print(newcontestentryfees)
        print(newcontestprice)
    }
    
    
    
    
    
    
    @IBAction func createeventtapped(_ sender: UIButton) {
        
        if isineditmode {
            self.updatetheevent()
        }
        else {
            self.createmode = true
            print("Check into this")
            print(self.allchoosenfields)
            
            if let s  = self.contestname.text {
                if s != "" && s != " " {
                    self.allchoosenfields["Contest Name"] = s
                }
            }
            
            if let s  = self.contestdescription.text {
                if s != "" && s != " " {
                    self.allchoosenfields["Contest Description"] = s
                }
            }
            
            if let s  = self.contestlocation.text {
                if s != "" && s != " " {
                    self.allchoosenfields["Contest Location"] = s
                }
            }
            self.allchoosenfields["Entry Fees"] = "0"
            if let s  = self.contestentryfees.text {
                if s != "" && s != " " {
                    self.allchoosenfields["Entry Fees"] = s
                }
            }
            
            if let s  = self.contestpriceabsolute.text {
                if s != "" && s != " " {
                    self.allchoosenfields["Contest Price"] = s
                }
            }
           
            var errorcheck = false
            if let c = self.allchoosenfields["Contest Result Date"] as? Date {
                if let r = self.allchoosenfields["Contest Start Date"] as? Date {
                    if c.timeIntervalSince(r).isLessThanOrEqualTo(0) {
                        errorcheck = true
                    }
                }
            }
           
            
            
            self.allchoosenfields["Organisation Allowed"] = false
            self.allchoosenfields["Invitation type"] = invitationtypess(invitation: "OPEN", isactive: true, addon: "2020-02-17T14:39:12", contestmasters: [], id: 5)
            var ttc = ""
            if let tc = self.conttandc.text as? String {
                ttc = tc
            }
            self.allchoosenfields["Contest Terms & Conditions"] = ttc
            
            
            
            print("Here is all choosen Fields")
            print(self.allchoosenfields)
            var extraparams : [Dictionary<String,Any>] = []
            var winnerpriceerror = ""
            if winnerscount == 0 {
                extraparams = []
            }
            else if winnerscount == 1 {
                if let ffv = Int(self.firstpriceval.text ?? "") as? Int {
                     var x : Dictionary<String,Any> = ["Sno" : 1 , "Position" : 1 , "Price" : "\(ffv)"]
                    extraparams.append(x)
                }
                else {
                    winnerpriceerror = "First winner price should be numeric."
                }
               
            }
            else if winnerscount == 2 {
                if let ffv = Int(self.firstpriceval.text ?? "") as? Int {
                    var x : Dictionary<String,Any> = ["Sno" : 1 , "Position" : 1 , "Price" : "\(ffv)"]
                    extraparams.append(x)
                }
                else {
                    winnerpriceerror = "First winner price should be numeric."
                }
                if let ffv = Int(self.secondpriceval.text ?? "") as? Int {
                    var x : Dictionary<String,Any> = ["Sno" : 2 , "Position" : 2 , "Price" : "\(ffv)"]
                    extraparams.append(x)
                }
                else {
                    winnerpriceerror = "Second winner price should be numeric."
                }
                
            }
            else if winnerscount == 3 {
                if let ffv = Int(self.firstpriceval.text ?? "") as? Int {
                    var x : Dictionary<String,Any> = ["Sno" : 1 , "Position" : 1 , "Price" : "\(ffv)"]
                    extraparams.append(x)
                }
                else {
                    winnerpriceerror = "First winner price should be numeric."
                }
                if let ffv = Int(self.secondpriceval.text ?? "") as? Int {
                    var x : Dictionary<String,Any> = ["Sno" : 2 , "Position" : 2 , "Price" : "\(ffv)"]
                    extraparams.append(x)
                }
                else {
                    winnerpriceerror = "Second winner price should be numeric."
                }
                if let ffv = Int(self.thirdpriceval.text ?? "") as? Int {
                    var x : Dictionary<String,Any> = ["Sno" : 3 , "Position" : 3 , "Price" : "\(ffv)"]
                    extraparams.append(x)
                }
                else {
                    winnerpriceerror = "Third winner price should be numeric."
                }
            }
            
            
            if winnerpriceerror != "" {
                extraparams = []
                 self.present(customalert.showalert(x: "\(winnerpriceerror)"), animated: true, completion: nil)
            }
            else if errorcheck {
                self.present(customalert.showalert(x: "Result date should be later to Start Date."), animated: true, completion: nil)
            }
            
            else if self.groupid == 0 {
                self.present(customalert.showalert(x: "You need to enter contest belong to which group."), animated: true, completion: nil)
            }
                
            else if(self.allchoosenfields["Contest Name"] == nil) {
                self.present(customalert.showalert(x: "You need to enter contest name"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Performance Type"] == nil) {
                self.present(customalert.showalert(x: "You need to enter performance type"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Gender"] == nil) {
                self.present(customalert.showalert(x: "You need to enter gender"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Category"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Category"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Organisation Allowed"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Organisation Allowed"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Invitation type"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Invitation type"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Entry Type"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Entry Type"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Entry Fees"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Entry Fees"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Contest Start Date"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Contest Start Date"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Contest Location"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Contest Location"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Contest Result Date"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Contest Result Date"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Contest Price"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Contest Price"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Contest Winner Price Type"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Contest Winner Price Type"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Contest Result Type"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Contest Result Type"), animated: true, completion: nil)
            }
            else if(self.allchoosenfields["Contest Theme"] == nil) {
                self.present(customalert.showalert(x: "You need to enter Contest Theme"), animated: true, completion: nil)
            }
            
            else {
                
                if let cat = self.allchoosenfields["Category"] as? categorybrief {
                    if let invt = self.allchoosenfields["Invitation type"] as? invitationtypess {
                        if let et = self.allchoosenfields["Entry Type"] as? entrytype {
                            if let cpt = self.allchoosenfields["Contest Winner Price Type"] as? contestwinnerpricess {
                                if let cwt = self.allchoosenfields["Contest Result Type"] as? contestwintypes {
                                    if let cppt = self.allchoosenfields["Performance Type"] as? performancetypemodels {
                                        if let cgn = self.allchoosenfields["Gender"] as? genders {
                                            if let conth = self.allchoosenfields["Contest Theme"] as? themes {
                                                
                                                var contname = ""
                                                var entfee = ""
                                                var contloc = ""
                                                var reson = ""
                                                var contprice = ""
                                                var conton = ""
                                                var contdesc = ""
                                                
                                                var eeeen = 0
                                                
                                                if let c = self.allchoosenfields["Contest Name"] as? String {
                                                    contname = c
                                                }
                                                if let c = self.allchoosenfields["Entry Fees"] as? String {
                                                    entfee = c
                                                }
                                                if let d = Int(entfee) as? Int {
                                                    eeeen = d
                                                }
                                                
                                                if let c = self.allchoosenfields["Contest Location"] as? String {
                                                    contloc = c
                                                }
                                                if let c = self.allchoosenfields["Contest Result Date"] as? Date {
                                                    reson =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303Z'")
                                                }
                                                if let c = self.allchoosenfields["Contest Price"] as? String {
                                                    contprice = c
                                                }
                                                if let c = self.allchoosenfields["Contest Start Date"] as? Date {
                                                    conton =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303Z'")
                                                }
                                                
                                                if let c = self.allchoosenfields["Contest Description"] as? String {
                                                    contdesc = c
                                                }
                                                
                                                
                                                var userid = UserDefaults.standard.value(forKey: "refid") as! String
                                                var params : Dictionary<String,Any> = ["ContestName": contname,"AllowCategoryId":cat.categoryid,"OrganizationAllow":true,"InvitationType":invt.id,"EntryAllowed":et.id,"EntryFee":eeeen,"ContestStart":conton,"ContestLocation":contloc,"Description":contdesc,"ResultOn":reson,"ContestPrice":contprice,"ContestWinnerPriceTypeId":cpt.id,"ResultTypeId":cwt.id,"UserId":userid,"GroupId":self.groupid,"IsActive":true,"Status":true,"RunningStatusId" : 2,"PerformanceTypeId":cppt.id,"Gender":cgn.id,"ThemeId" : conth.id ,"Terms&Conditions" : ttc , "WinnerPrices" : extraparams]
                                                self.params = params
                                                
                                                
                                                var tempparams : Dictionary<String,Any> = ["contest name" : contname, "Category" : cat.categoryname , "invitation type":invt.invitation , "Entry allowed" : et.contestentrytype , "entry fee" : eeeen , "contest start" : conton , "description" : contdesc , "result on":reson,"contest price":contprice,"contest winner price type" : cpt.winnerprice,"result type" : cwt.contestwintype,"performance type" : cppt.peroformance,"gender":cgn.gender,"theme" : conth.theme,"Terms&Conditions" : ttc , "WinnerPrices" : extraparams]
                                                self.tempparams = tempparams
                                                
                                                passingevent = strevent(contestid: 0, contestname: contname, allowcategoryid: cat.categoryid, allowcategory: cat.categoryname, organisationallow: false, invitationtypeid: invt.id, invitationtype: invt.invitation, entryallowed: et.id, entrytype: et.contestentrytype, entryfee: eeeen, conteststart: conton, contestlocation: "", description: contdesc, resulton: reson, contestprice: contprice, contestwinnerpricetypeid: cpt.id, contestpricetype: cpt.winnerprice, resulttypeid: cwt.id, resulttype: cwt.contestwintype, userid: userid, groupid: self.groupid, createon: "", isactive: false, status: false, runningstatusid: 2, runningstatus: "Open", juries: [], contestimage: "", termsandcondition: "\(ttc)")
                                                
                                                
                                                self.performSegue(withIdentifier: "presenttheme", sender: nil)
                                                
                                                print("Final")
                                                print(params)
                                                
                                                //                                            var url = Constants.K_baseUrl + Constants.createcontest
                                                //                                            var r = BaseServiceClass()
                                                //                                            r.postApiRequest(url: url, parameters: params) { (response, err) in
                                                //                                                if let res = response?.result.value as? Dictionary<String,Any> {
                                                //                                                    print(res)
                                                //
                                                //                                                    if let juryid = res["Results"] as? Int {
                                                //                                                        self.juryid = juryid
                                                //                                                    }
                                                //
                                                //                                                    if let resstatus = res["ResponseStatus"] as? Int {
                                                //                                                        if resstatus == 0 {
                                                //                                                            self.present(customalert.showalert(x: "Contest Created"), animated: true) {
                                                //                                                                self.performSegue(withIdentifier: "addjury", sender: nil)
                                                //                                                            }
                                                //                                                        }
                                                //                                                    }
                                                //                                                }
                                                //                                            }
                                                
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                
                
                
                
                
                
                
                
                
                
            }
        }
        
 
        
        
        
    }

    
    
    func fetchthemes()
    {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        print(self.allchoosenfields)
        if self.isineditmode {
            if let ct = self.passedevent?.allowcategoryid as? Int {
                var id = ct
                var url = Constants.K_baseUrl + Constants.getthemes
                var params : Dictionary<String,Any> = ["contestId" : id]
                var r = BaseServiceClass()
                var aurl = "\(url)?categoryId=\(id)"
                r.postApiRequest(url: aurl, parameters: params) { (response, error) in
                    if let res =  response?.result.value as? Dictionary<String,Any> {
                        if let results = res["Results"] as? Dictionary<String,Any> {
                            if let themeees = results["Theme"] as? [Dictionary<String,Any>] {
                                print(themeees)
                                for each in themeees {
                                    var id = 0
                                    var them = ""
                                    if let a = each["Id"] as? Int {
                                        id = a
                                    }
                                    if let t = each["Theme"] as? String {
                                        them = t
                                    }
                                    var xx = themes(id : id , theme : them)
                                    self.allthemes.append(xx)
                                    
                                }
                                self.spinner.isHidden = true
                                print(self.allthemes)
                                self.spinner.stopAnimating()
                                self.custompicker.reloadAllComponents()
                                if self.isineditmode {
                                    self.prefeedvalues()
                                }
                            }
                        }
                    }
                }
            }
        }
        else if let ex = self.allchoosenfields["Category"] as? categorybrief {
            var iid = 0
            if let id = ex.categoryid as? Int {
                iid = id
            }
            var url = Constants.K_baseUrl + Constants.getthemes
            
            var r = BaseServiceClass()
            var aurl = "\(url)?categoryId=\(iid)"
            r.postApiRequest(url: aurl, parameters: [:]) { (response, error) in
                if let res =  response?.result.value as? Dictionary<String,Any> {
                    if let results = res["Results"] as? Dictionary<String,Any> {
                        if let themeees = results["Theme"] as? [Dictionary<String,Any>] {
                            print(themeees)
                            for each in themeees {
                                var id = 0
                                var them = ""
                                if let a = each["Id"] as? Int {
                                    id = a
                                }
                                if let t = each["Theme"] as? String {
                                    them = t
                                }
                                var xx = themes(id : id , theme : them)
                                self.allthemes.append(xx)
                                
                            }
                            self.spinner.isHidden = true
                            print(self.allthemes)
                            self.spinner.stopAnimating()
                            self.custompicker.reloadAllComponents()
                            if self.isineditmode {
                                self.prefeedvalues()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fetchdata()
    {
        var r = BaseServiceClass()
        var url = Constants.K_baseUrl + Constants.getprerequisitecontests
        r.getApiRequest(url: url, parameters: [:]) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let usefuldata = res["Results"] as? Dictionary<String,Any> {
                    if let entrytypes = usefuldata["EntryTypes"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = ""
                            var b = ""
                            var c = false
                            var d : [String] = []
                            var e = 0
                            
                            if let aa = each["ContestEntryType"] as? String {
                                a = aa
                            }
                            if let aa = each["AddOn"] as? String {
                                b = aa
                            }
                            if let aa = each["IsActive"] as? Bool {
                                c = aa
                            }
                            if let aa = each["ContestMasters"] as? [String] {
                                d = aa
                            }
                            if let aa = each["ID"] as? Int {
                                e = aa
                            }
                            var x = entrytype(contestentrytype: a, addon: b, isactive: c, contestmasters: d, id: e)
                            self.entrytypes.append(x)
                        }
                        print(self.entrytypes)
                    }
                    if let entrytypes = usefuldata["ContestWinTypes"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = ""
                            var b = ""
                            var c = false
                            var d : [String] = []
                            var e = 0
                            var f = 0
                            
                            if let aa = each["ContestWinnerType"] as? String {
                                a = aa
                            }
                            if let aa = each["CreateOn"] as? String {
                                b = aa
                            }
                            if let aa = each["IsActive"] as? Bool {
                                c = aa
                            }
                            if let aa = each["ContestMasters"] as? [String] {
                                d = aa
                            }
                            if let aa = each["ID"] as? Int {
                                e = aa
                            }
                            if let aa = each["Winner"] as? Int {
                                f = aa
                            }
                            var x  = contestwintypes(contestwintype: a, createdon: b, isactive: c, contestmasters: d, id: e, winner: f)
                            self.contestwinnertypes.append(x)
                        }
                        print(self.contestwinnertypes)
                    }
                    if let entrytypes = usefuldata["ContestWinnerPrices"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = ""
                            var b = ""
                            var c = false
                            var d : [String] = []
                            var e = 0
                            
                            if let aa = each["WinnerPrice"] as? String {
                                a = aa
                            }
                            if let aa = each["AddOn"] as? String {
                                b = aa
                            }
                            if let aa = each["IsActive"] as? Bool {
                                c = aa
                            }
                            if let aa = each["ContestMasters"] as? [String] {
                                d = aa
                            }
                            if let aa = each["ID"] as? Int {
                                e = aa
                            }
                            
                            var x = contestwinnerpricess(winnerprice: a, addon: b, isactive: c, contestmasters: d, id: e)
                            self.contestwinnerprices.append(x)
                            
                        }
                        print(self.contestwinnerprices)
                    }
                    if let entrytypes = usefuldata["ContestStatuses"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = ""
                            var b = ""
                            var c = false
                            var d : [String] = []
                            var e = 0
                            
                            if let aa = each["ContestRunningStatus"] as? String {
                                a = aa
                            }
                            if let aa = each["AddOn"] as? String {
                                b = aa
                            }
                            if let aa = each["IsActive"] as? Bool {
                                c = aa
                            }
                            if let aa = each["ContestMasters"] as? [String] {
                                d = aa
                            }
                            if let aa = each["ID"] as? Int {
                                e = aa
                            }
                            var x = conteststatuses(contestrunningstatus: a, addon: b, isactive: c, contestmasters: d, id: e)
                            self.conteststatus.append(x)
                        }
                        print(self.conteststatus)
                    }
                    if let entrytypes = usefuldata["InvitationTypes"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = ""
                            var b = ""
                            var c = false
                            var d : [String] = []
                            var e = 0
                            
                            if let aa = each["Invitation"] as? String {
                                a = aa
                            }
                            if let aa = each["AddOn"] as? String {
                                b = aa
                            }
                            if let aa = each["IsActive"] as? Bool {
                                c = aa
                            }
                            if let aa = each["ContestMasters"] as? [String] {
                                d = aa
                            }
                            if let aa = each["ID"] as? Int {
                                e = aa
                            }
                            var x = invitationtypess(invitation: a, isactive: c, addon: b, contestmasters: d, id: e)
                            self.invitationtypes.append(x)
                        }
                        print(self.invitationtypes)
                    }
                    
                    if let entrytypes = usefuldata["PerformanceTypeModels"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = 0
                            var b = ""
                            
                            
                            if let aa = each["Id"] as? Int {
                                a = aa
                            }
                            if let aa = each["Performance"] as? String {
                                b = aa
                            }
                            
                            var x = performancetypemodels(id: a, peroformance: b)
                            self.allperformancemodels.append(x)
                        }
                        print(self.allperformancemodels)
                    }
                    
                    if let entrytypes = usefuldata["Genders"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = 0
                            var b = ""
                            
                            
                            if let aa = each["Id"] as? Int {
                                a = aa
                            }
                            if let aa = each["GenderType"] as? String {
                                b = aa
                            }
                            
                            var x = genders(id: a, gender: b)
                            self.allgenders.append(x)
                        }
                        print(self.allgenders)
                    }
                    
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                if self.isineditmode {
                    self.fetchthemes()
                    
                }
            }
            
            
        }
    }

    
    
    
    func fetchcategories()
    {
        
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        
        var params : Dictionary<String,Any> = [:]
        
        
        
        
        var url = Constants.K_baseUrl + Constants.getCategory
        var r = BaseServiceClass()
        
        
        r.getApiRequest(url: url, parameters: [:]) { (data, error) in
            print("-----------------")
            if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                    if let indv =  inv["Data"] as? [Dictionary<String,AnyObject>] {
                        for eachcat in indv {
                            if let cat = eachcat["CategoryName"] as? String , let catid = eachcat["ID"] as? Int {
                                
                                var x  = categorybrief(categoryid: catid, categoryname: cat)
                                self.allcategories.append(x)
                                
                            }
                        }
                        
                        print(self.allcategories)
                        
                    }
                }
            }
        }
    }

    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if self.dropdownselectedtype == "Entry Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Invitation type" {
            return 1
        }
        else if self.dropdownselectedtype == "Contest Winner Price Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Contest Result Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Category" {
            return 1
        }
        else if self.dropdownselectedtype == "Performance Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Gender" {
            return 1
        }
        else if self.dropdownselectedtype == "Contest Theme" {
            return 1
        }
        else if self.dropdownselectedtype == "showmegroups" {
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        print("Picker View dropdownselectedtype \(self.dropdownselectedtype) \(self.allperformancemodels.count)")
        
        if self.dropdownselectedtype == "Entry Type" {
            return self.entrytypes.count
        }
        else if self.dropdownselectedtype == "Invitation type" {
            return self.invitationtypes.count
        }
        else if self.dropdownselectedtype == "Contest Winner Price Type" {
            return self.contestwinnerprices.count
        }
        else if self.dropdownselectedtype == "Contest Result Type" {
            return self.contestwinnertypes.count
        }
        else if self.dropdownselectedtype == "Category" {
            return self.allcategories.count
        }
        else if self.dropdownselectedtype == "Performance Type" {
            return self.allperformancemodels.count
        }
        else if self.dropdownselectedtype == "Gender" {
            return self.allgenders.count
        }
        else if self.dropdownselectedtype == "Contest Theme" {
            return self.allthemes.count
        }
        else if self.dropdownselectedtype == "showmegroups" {
            return self.allmygroups.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if self.dropdownselectedtype == "Entry Type" {
            return self.entrytypes[row].contestentrytype.capitalized
        }
        else if self.dropdownselectedtype == "Invitation type" {
            return self.invitationtypes[row].invitation.capitalized
        }
        else if self.dropdownselectedtype == "Contest Winner Price Type" {
            return self.contestwinnerprices[row].winnerprice.capitalized
        }
        else if self.dropdownselectedtype == "Contest Result Type" {
            return self.contestwinnertypes[row].contestwintype.capitalized
        }
        else if self.dropdownselectedtype == "Category" {
            return self.allcategories[row].categoryname.capitalized
        }
        else if self.dropdownselectedtype == "Performance Type" {
            return self.allperformancemodels[row].peroformance.capitalized
        }
        else if self.dropdownselectedtype == "Gender" {
            print("Gender : \(self.allgenders[row].gender.capitalized)")
            
            return self.allgenders[row].gender.capitalized
        }
        else if self.dropdownselectedtype == "Contest Theme" {
            return self.allthemes[row].theme.capitalized
        }
        else if self.dropdownselectedtype == "showmegroups" {
            return self.allmygroups[row].groupname.capitalized
        }
        return ""
    }
    
    func paintborder(x : UIView)
    {
        x.layer.borderWidth = 1
        x.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
    }
    
    
    @IBAction func backtapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func rendertheme(x : pretheme)
    {
        print("render")
        print(x)
        if comingwithoutgroup && self.allmygroups.count == 0 {
            self.fetchmegroups()
        }
        
        if comingwithoutgroup && self.allmygroups.count == 0 {
            self.fetchmegroups()
        }
        
        if comingwithoutgroup && self.groupid == 0 {
            self.present(customalert.showalert(x: "You need to select group."), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Category"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Category"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Theme"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Theme"), animated: true, completion: nil)
        }
        else {
        self.perfupperspace.constant = -128
        self.choosetheme.isHidden = true
        self.collection.isHidden = true
        self.ortheme.isHidden = true
        self.createmanually.isHidden = true
        self.nextview2.isHidden = false
        self.contestperformancetypeshow.isHidden = false
        self.contestgenderallowshow.isHidden = false
        bod8.isHidden = false
        bod9.isHidden = false
        bod6.isHidden = true
        bod7.isHidden = true
        contestcategoryshow.isHidden = true
        contestthemeshow.isHidden = true
        self.contestbelongtocommunityshow.isHidden = false
        self.bod5.isHidden = false
            
            
            
        
        
        if let s  = x.contestname as? String {
            if s != "" && s != " " {
                self.allchoosenfields["Contest Name"] = s
            }
        }
        
        if let s  = x.description as? String {
            if s != "" && s != " " {
                self.allchoosenfields["Contest Description"] = s
            }
        }
        
       
        
        if let s  = x.entryfee as? Int {
           
                self.allchoosenfields["Entry Fees"] = s
            
        }
        
        if let s  = x.contestprice as? String {
            if s != "" && s != " " {
                self.allchoosenfields["Contest Price"] = s
            }
        }
            
        self.allchoosenfields["Contest Result Date"] = x.resulton
        self.allchoosenfields["Contest Start Date"] = x.conteststart
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
            let date = dateFormatter.date(from: x.resulton ?? "")
            self.allchoosenfields["Contest Result Date"] = date
            let date2 = dateFormatter.date(from: x.conteststart ?? "")
            self.allchoosenfields["Contest Start Date"] = date2
            
        
            
        var errorcheck = false
        if let c = self.allchoosenfields["Contest Result Date"] as? Date {
            if let r = self.allchoosenfields["Contest Start Date"] as? Date {
                if c.timeIntervalSince(r).isLessThanOrEqualTo(0) {
                    errorcheck = true
                }
            }
        }
            
            
            
            
            
            
        

        
        self.allchoosenfields["Organisation Allowed"] = false
        self.allchoosenfields["Performance Type"] = performancetypemodels(id: 0, peroformance: "")
        
            for var  each in 0 ..< self.allperformancemodels.count {
                if self.allperformancemodels[each].id == x.performancetypeid {
                    self.allchoosenfields["Performance Type"] = self.allperformancemodels[each]
                    self.performancetypename = self.allperformancemodels[each].peroformance
                }
            }
            
            
            
            for var  each in 0 ..< self.allgenders.count {
                if self.allgenders[each].id == x.genderid {
                    self.allchoosenfields["Gender"] = self.allgenders[each]
                    self.gendername = self.allgenders[each].gender
                }
            }
            
        self.allchoosenfields["Category"] = categorybrief(categoryid: x.categoryid, categoryname: x.categoryname)
            for var  each in 0 ..< self.invitationtypes.count {
                if self.invitationtypes[each].id == x.invitationtypeid {
                    self.allchoosenfields["Invitation type"] = self.invitationtypes[each]
                }
            }
            
            print("Entry Type")
            print(entrytypes)
            print(x.entryallowedid)
            
            for var  each in 0 ..< self.entrytypes.count {
                if self.entrytypes[each].id == x.entryallowedid {
                    self.allchoosenfields["Entry Type"] = self.entrytypes[each]
                }
            }
            
            for var  each in 0 ..< self.contestwinnerprices.count {
                if self.contestwinnerprices[each].id == x.contestwinnerpricetypeid {
                    self.allchoosenfields["Contest Winner Price Type"] = self.contestwinnerprices[each]
                }
            }
            
            var find = false
            for var  each in 0 ..< self.contestwinnertypes.count {
                if self.contestwinnertypes[each].id == x.resultypeid {
                    self.allchoosenfields["Contest Result Type"] = self.contestwinnertypes[each]
                    find = true
                    self.winnerscount = self.contestwinnertypes[each].winner
                }
            }
            if find == false {
                winnerscount = 0
            }
            if winnerscount == 0 {
                winner1pricesv.isHidden = true
                winner2pricesv.isHidden = true
                winner3pricesv.isHidden = true
            }
            else if winnerscount == 1 {
                winner1pricesv.isHidden = false
                winner2pricesv.isHidden = true
                winner3pricesv.isHidden = true
            }
            else if winnerscount == 2 {
                winner1pricesv.isHidden = false
                winner2pricesv.isHidden = false
                winner3pricesv.isHidden = true
            }
            else {
                winner1pricesv.isHidden = false
                winner2pricesv.isHidden = false
                winner3pricesv.isHidden = false
            }
            
            for var  each in 0 ..< self.allthemes.count {
                if self.allthemes[each].id == x.themeid {
                    self.allchoosenfields["Contest Theme"] = self.allthemes[each]
                }
            }
            
       
       
        self.allchoosenfields["Contest Location"] = ""
            
            
            
            
 
        
        self.contestentrytype.text = "\(x.entrytype.capitalized)"
        self.invitationtype.text = "\(x.invitationtype.capitalized)"
            self.performancetype.text = "\(x.performancetype.capitalized)"
            self.genderallow.text = "\(x.gendername.capitalized)"
            self.contestprice.text = "\(x.contestprice.capitalized)"
            self.noofwinners.text = "\(x.noofwinner)"
            self.contestcategory.text = "\(x.categoryname.capitalized)"
            self.selecttheme.text = "\(x.themename.capitalized)"
            self.startdatebtn.setTitle("\(Date())", for: .normal)
        self.enddatebtn.setTitle("\(Date())", for: .normal)
            self.contestname.text = "\(x.contestname.capitalized)"
            self.contestdescription.text = "\(x.description)"
            self.contestpriceabsolute.text = "\(x.contestwinnerpricetype.capitalized)"
            self.conttandc.text = "\(x.termsandconditions)"
            
        print(self.allchoosenfields)
        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? GroupsandEventsContactvc {
            seg.mode = "jury"
            seg.passedjuryid = self.juryid
            
        }
        if let seg = segue.destination as? PreviewContestViewController {
            seg.params = self.params
            seg.tempparams = self.tempparams
            
        }
        if let seg = segue.destination as? ThemePreviewViewController {
            seg.createmode = self.createmode
            seg.categoryselected =  self.categoryselected
            seg.tthemename = self.themename
            seg.themeid = self.themeid
            if self.createmode == true {
                print("passing parameters")
                print(self.params)
                print("---------------")
                print(self.tempparams)
                print("---------------")
                print(self.passingevent)
                seg.allwinnersexistingprices = self.allwinnersexistingprices
                seg.params = self.params
                seg.tempparams = self.tempparams
                seg.gotevent = self.passingevent
                seg.performancetypeid = self.performancetypeid
                seg.genderid = self.genderid
                 seg.performancetypename = self.performancetypename
                 seg.gendername = self.gendername
                 seg.winnerscount = self.winnerscount
            }
            else {
                
                seg.gotevent2 = self.allprethemes[self.themeid]
                seg.themeselected = { a in
                    self.rendertheme(x : a)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
