//
//  CategorywisecontestsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 28/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


struct customstrevent
{
    var x : strevent
    var joined : Bool
    var joinedstatus : Bool
    var winners : [String]
    var creatoruserid : String
    var creatorname : String
    var creatorprofileimage : String
    var contestimage : String
    var reviews : Int
    var totalparticipants : Int
    var themename : String
    var allowedtopost : Bool
    
}

class CategorywisecontestsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var allcategorywiseevents : [customstrevent] = []
    var allcategorywiseclosedevents : [customstrevent] = []
    
    
    var selectedrightvalues : Dictionary<String,[String]>?
    
    @IBOutlet weak var screentitle: Customlabel!
    
    @IBOutlet weak var segmentcontroll: UISegmentedControl!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var nodatawarning: UILabel!
    
    var isdataavailable = true
    
    var hideit = true
    
    var fetchlock = true
    @IBOutlet var backbtn: UIButton!
    
    @IBOutlet weak var table: UITableView!
    var categoryid = 124
    var categoryname = "all"
    
    var eventidtobepassed = 0
    var eventtobepassed : customstrevent?
    var page = 0
    var closedpage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        spinner.isHidden = false
        nodatawarning.isHidden = true
        if self.hideit == true {
            self.backbtn.isHidden = true
            
        }
        else {
            self.backbtn.isHidden = false
        }
        if self.categoryname == "all" {
            self.screentitle.text = "Contests"
        }
        else {
            self.screentitle.text = self.categoryname.capitalized
        }
        table.delegate = self
        table.dataSource = self
        
        if !InternetCheck.isConnectedToNetwork() {
                   self.present(customalert.showalert(x: "Sorry you are not connected to internet."), animated: true, completion: nil)
                      }
                      else {
                      if let u =  UserDefaults.standard.value(forKey: "refid") as? String {
                      self.fetchdata(pg : self.page)
                      }
                      }
        

    }
    
    
    @IBAction func segmentchanged(_ sender: Any) {
         if InternetCheck.isConnectedToNetwork() {
        if self.segmentcontroll.selectedSegmentIndex == 0 {
            if self.allcategorywiseevents.count == 0 {
                self.nodatawarning.isHidden = false
                self.fetchdata(pg: 0)
            }
            else {
                self.nodatawarning.isHidden = true
                self.table.reloadData()
            }
        }
        else {
            if self.allcategorywiseclosedevents.count == 0 {
                self.nodatawarning.isHidden = false
                self.fetchdata(pg: 0)
            }
            else {
                self.nodatawarning.isHidden = true
                self.table.reloadData()
            }
        }
        }
        
    }
    
    
    
    
    
    @IBAction func filterspressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showfilters", sender: nil)
    }
    
    
    
    func fetchdata(pg : Int)
    {
        var oldcount = 0
        if pg == 0 && self.segmentcontroll.selectedSegmentIndex == 0 {
            allcategorywiseevents = []
        }
        if pg == 0 && self.segmentcontroll.selectedSegmentIndex == 1 {
            allcategorywiseclosedevents = []
        }
        
        if self.segmentcontroll.selectedSegmentIndex == 0 {
            oldcount = allcategorywiseevents.count
        }
        else if self.segmentcontroll.selectedSegmentIndex == 1 {
            oldcount = allcategorywiseclosedevents.count
        }
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        let r = BaseServiceClass()
        var url  = "\(Constants.K_baseUrl)\( Constants.getcontestcategorywise)?contestStatus=2&invitationType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=0&isActive=true"
        var params : Dictionary<String,Any> = [ :]
        var conteststatus = 2
        if self.segmentcontroll.selectedSegmentIndex == 0 {
            conteststatus = 2
        }
        else {
           conteststatus = 1
        }

        
        
        if self.categoryname != "all"
        {
                     params = [  "Page": pg,"PageSize": 10,"userid" : userid , "contestStatus" : 2, "contestType" : 0 , "categoryId" : self.categoryid]
            url  = "\(Constants.K_baseUrl)\( Constants.getcontestcategorywise)?contestStatus=\(conteststatus)&invitationType=0&categoryId=\(self.categoryid)&contestTheme=0&performanceId=0&gender=0&entryfeetype=0&isActive=true"
        }
        else {
                     params = [  "Page": pg,"PageSize": 10, "contestStatus" : 2, "contestType" : 0 ]
            url  = "\(Constants.K_baseUrl)\( Constants.getcontestcategorywise)?contestStatus=\(conteststatus)&invitationType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=0&isActive=true"
        }
        
        
        
       
        print(url)
        print(params)
        self.segmentcontroll.isEnabled = false
        spinner.startAnimating()
        spinner.isHidden = false
        nodatawarning.isHidden = true
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let resd = res["Results"] as? Dictionary<String,Any> {
                    if let data = resd["Data"] as? [Dictionary<String,Any>] {
                        for each in data  {
                            print(each)
                            print("----------------------------------------")
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
                            
                            var joined = false
                            var joinedstatus = false
                            var winners : [String] = []
                            var creatorid = ""
                            var creatorname = ""
                            var creatorimage = ""
                            var contestimage = ""
                            
                            
                            var thmname = ""
                            var reviews = 0
                            var participants = 0
                            var allowedtopost = false
                            if let cn = each["ThemeName"] as? String {
                                thmname = cn
                            }
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
                            if let cn = each["Joined"] as? Bool {
                                joined = cn
                            }
                            if let cn = each["JoinStatus"] as? Bool {
                                joinedstatus = cn
                            }
                            if let cfn = each["FileType"] as? String {
                                if cfn == "Video" {
                                    if let cn = each["Thumbnail"] as? String {
                                        contestimage = cn
                                    }
                                }
                                else {
                                    if let cn = each["ContestImage"] as? String {
                                        contestimage = cn
                                    }
                                }
                                
                            }
                            else {
                                if let cn = each["ContestImage"] as? String {
                                    contestimage = cn
                                }
                            }
                            if let cn = each["Creator"] as? Dictionary<String,Any> {
                                if let cid = cn["UserID"] as? String {
                                    creatorid = cid
                                }
                                if let cname = cn["Name"] as? String {
                                    creatorname = cname
                                }
                                if let cprof = cn["Profile"] as? String {
                                    creatorimage = cprof
                                }
                            }
                            
                            if let cn = each["TotalReview"] as? Int
                            {
                                reviews = cn
                            }
                            if let cn = each["TotalParticipation"] as? Int
                            {
                                participants = cn
                            }
                            if let cn = each["ParticipantPostAllow"] as? Bool
                            {
                                allowedtopost = cn
                            }
                            var tandc = ""
                            if let cn = each["TermAndCondition"] as? String {
                                tandc = cn
                            }
                            var noofwinn = 0
                            if let cn = each["NoOfWinner"] as? Int {
                                runningstatusid = cn
                            }

                            if self.categoryname == allowcategory.lowercased() || self.categoryname == "all" {
                                var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: contestimage, termsandcondition: tandc, noofwinners: noofwinn)
                                
                                var y = customstrevent(x: x, joined: joined, joinedstatus: joinedstatus, winners: [], creatoruserid: creatorid, creatorname: creatorname, creatorprofileimage: creatorimage, contestimage: contestimage, reviews: reviews, totalparticipants: participants, themename: thmname, allowedtopost: allowedtopost)
                                if self.segmentcontroll.selectedSegmentIndex == 1 {
                                    self.allcategorywiseclosedevents.append(y)
                                }
                                else {
                                    self.allcategorywiseevents.append(y)
                                }
                            }
                            
                        }
                        if self.segmentcontroll.selectedSegmentIndex == 0 {
                            if oldcount == self.allcategorywiseevents.count {
                                self.isdataavailable = false
                            }
                        }
                        else if self.segmentcontroll.selectedSegmentIndex == 1 {
                            if oldcount == self.allcategorywiseclosedevents.count {
                                self.isdataavailable = false
                            }
                        }
                    }
                    if self.segmentcontroll.selectedSegmentIndex == 1 {
                        if self.allcategorywiseclosedevents.count == 0 {
                            self.spinner.stopAnimating()
                            self.spinner.isHidden = true
                            self.nodatawarning.isHidden = false
                        }
                        else {
                            self.spinner.stopAnimating()
                            self.spinner.isHidden = true
                            self.nodatawarning.isHidden = true
                        }
                    }
                    else {
                        if self.allcategorywiseevents.count == 0 {
                            self.spinner.stopAnimating()
                            self.spinner.isHidden = true
                            self.nodatawarning.isHidden = false
                        }
                        else {
                            self.spinner.stopAnimating()
                            self.spinner.isHidden = true
                            self.nodatawarning.isHidden = true
                        }
                    }

                    self.segmentcontroll.isEnabled = true
                    self.table.reloadData()
                }
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.segmentcontroll.selectedSegmentIndex == 1 {
           return self.allcategorywiseclosedevents.count
        }
        else {
           return self.allcategorywiseevents.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "categorywisecontest", for: indexPath) as? CategorywiseeventsTableViewCell {
            cell.sendbackdata = {a in
                self.eventidtobepassed = a.x.contestid
                self.performSegue(withIdentifier: "detailevent", sender: nil)
            }
            if self.segmentcontroll.selectedSegmentIndex == 1 {
                cell.updatecell(x : self.allcategorywiseclosedevents[indexPath.row])
            }
            else {
                cell.updatecell(x : self.allcategorywiseevents[indexPath.row])
            }
            
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Coming \(indexPath.row)")
        if isdataavailable {
            if fetchlock == true {
                if self.segmentcontroll.selectedSegmentIndex == 0 && indexPath.row == self.allcategorywiseevents.count - 1 && self.allcategorywiseevents.count >= 10 {
                    fetchlock = false
                }
                else if self.segmentcontroll.selectedSegmentIndex == 1 && indexPath.row == self.allcategorywiseclosedevents.count - 1  && self.allcategorywiseclosedevents.count >= 10{
                    fetchlock = false
                }
            }
            else {
                if self.segmentcontroll.selectedSegmentIndex == 0 && indexPath.row == self.allcategorywiseevents.count - 4 {
                    self.page = self.page + 1
                    fetchlock = true
                    self.fetchdata(pg: page)
                }
                else if self.segmentcontroll.selectedSegmentIndex == 1 && indexPath.row == self.allcategorywiseclosedevents.count - 4 {
                    self.page = self.page + 1
                    fetchlock = true
                    self.fetchdata(pg: page)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if self.segmentcontroll.selectedSegmentIndex == 1 {
            self.eventidtobepassed = self.allcategorywiseclosedevents[indexPath.row].x.contestid
            self.eventtobepassed = self.allcategorywiseclosedevents[indexPath.row]
        }
         else {
            self.eventidtobepassed = self.allcategorywiseevents[indexPath.row].x.contestid
            self.eventtobepassed = self.allcategorywiseevents[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "detailevent", sender: nil)
    }

    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? JoinedeventsViewController {
            seg.eventid = self.eventidtobepassed
            seg.categoryselected = self.eventtobepassed?.x.allowcategory.lowercased() ?? ""
            seg.tthemename = self.eventtobepassed?.themename.lowercased() ?? ""
            
        }
        if let seg = segue.destination as? FilterscreenViewController {
            seg.takebackfilters = {a in
                print("Hola")
                self.selectedrightvalues = a
            }
            if let s = self.selectedrightvalues {
                            seg.selectedrightvalues = s
            }

        }
    }
    

}
