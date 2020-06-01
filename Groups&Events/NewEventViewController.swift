//
//  NewEventViewController.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit


struct juryorwinner
{
    var id : Int
    var userid : String
    var name : String
    var profile : String
    var price : Int = 0
    var position : Int = 0 
}



class NewEventViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var masteredit: UIButton!
    
    @IBOutlet var editpopup: UIView!
    
    @IBOutlet var edittitle: UILabel!
    
    var passbackuploadedimage : ((_ x : UIImage) -> Void)?
    @IBOutlet var datechooser: UIDatePicker!
    
    @IBOutlet var editdonebtn: CustomButton!
    
    
    @IBOutlet weak var deletecontest: UIButton!
    
    
    @IBOutlet var eventstartbtn: UIButton!
    
    
    @IBOutlet var eventresultbtn: UIButton!
    
    @IBOutlet var eventoaswitch: UISwitch!
    
    
    @IBOutlet var eventresults: Minorlabel!
    
    @IBOutlet var organisationallowed: UITextField!
    
    
    @IBOutlet weak var imagebanner: UIImageView!
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var addphotobtn: UIButton!
    
    @IBOutlet weak var eventname: UILabel!
    
    @IBOutlet weak var eventcreatedby: UILabel!
    
    @IBOutlet weak var eventtimings: UILabel!
    
    @IBOutlet weak var eventlocation: UILabel!
    
    @IBOutlet weak var eventdescription: UITextView!
    @IBOutlet weak var goingcount: UILabel!
    
    @IBOutlet weak var invitedcount: UILabel!
    
    
    @IBOutlet var contestname: UITextField!
    
    @IBOutlet weak var highlighterview: UIView!
    
    @IBOutlet weak var goinginvitedstackview: UIStackView!
    
    @IBOutlet weak var bannerheight: NSLayoutConstraint!
    
    @IBOutlet weak var editbtnoutlet: UILabel!
    
    
    @IBOutlet weak var entryfee: Minorlabel!
    
    @IBOutlet weak var eventstatus: Minorlabel!
    
    
    @IBOutlet weak var allowcategory: Minorlabel!
    
    @IBOutlet weak var entrytype: Minorlabel!
    
    @IBOutlet weak var contestprice: Minorlabel!
    
    @IBOutlet weak var contestwinnerpricetype: Minorlabel!
    
    
    @IBOutlet weak var resulttype: Minorlabel!
    
    
    @IBOutlet weak var eventrunninstatus: Minorlabel!
    
    @IBOutlet weak var stackviewupperspace: NSLayoutConstraint!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    var modifiedstartdate = ""
    var modifiedresultdate = ""
    var currenlychanging = ""
    
    
    var eventid = 40
    var currentevent : strevent?
    var passbackupdatedevent : ((_ event : strevent) -> Void)?
    var joined = false
    
    var imtoshow : UIImage?
    
    var passedevent : event?
    var pc : UIImagePickerController?
    
    var alljuries : [juryorwinner]?
    var allwinners : [juryorwinner]?
    
    var eventcreator : juryorwinner?
    var timetopublish = false
    
    
    @IBOutlet weak var bod1: UIView!
    
    
    @IBOutlet weak var bod2: UIView!
    
    @IBOutlet weak var bod3: UIView!
    
    @IBOutlet weak var bod4: UIView!
    
    
    @IBOutlet weak var contestnameedit: UITextField!
    
    
    @IBOutlet weak var startdateeditbtn: UIButton!
    
    
    @IBOutlet weak var enddateeditbtn: UIButton!
    
    @IBOutlet weak var contestdetailsedit: UITextView!
    
    
    @IBOutlet weak var contestlocation: UITextField!
    
    
    @IBOutlet weak var savedetailsbtn: UIButton!
    
    var timeleft = 0
    
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.editpopup.isHidden = true
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 4300)
        self.scroll.isScrollEnabled = true
        paintborder(x: bod1)
        paintborder(x: bod2)
        paintborder(x: bod3)
        paintborder(x: bod4)
        deletecontest.layer.cornerRadius = 25
        self.savedetailsbtn.layer.cornerRadius = self.savedetailsbtn.frame.size.height/2
        self.scroll.isHidden = true
        
        if let ik = imtoshow as? UIImage {
            self.imagebanner.image = ik
        }
        
        var tl = self.currentevent?.resulton
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
        let date = dateFormatter.date(from: tl ?? "")
        let today = dateFormatter.date(from: dateFormatter.string(from: Date()))
        var ttday : Date = Date()
        if let d  = date, let t = today {
            print("Result Date is \(d)")
            print("Today is \(today)")
            ttday = t
            
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
        
        
        timeleft =  passdata
        var useid = UserDefaults.standard.value(forKey: "refid") as! String
        var owner = false
        if useid == self.passedevent?.createdby{
            owner = true
        }
        
        if timetopublish || timeleft < 0 {
            bod1.isHidden = true
            bod2.isHidden = true
            bod3.isHidden = true
            bod4.isHidden = true
            savedetailsbtn.isHidden = true
            
              deletecontest.isHidden = true
            stackviewupperspace.constant = -520
        }
        
        else {
            
            if owner {
                bod1.isHidden = true
                bod2.isHidden = true
                bod3.isHidden = true
                bod4.isHidden = true
                savedetailsbtn.isHidden = true
                stackviewupperspace.constant = -520
            }
            else {
                deletecontest.setTitle("Leave Contest", for: .normal)
                stackviewupperspace.constant = -450
            }
            
        }
        
    }
    
    func paintborder(x : UIView)
    {
        x.layer.borderWidth = 1
        x.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
    }
    
    
    
    @IBAction func delcontestpressed(_ sender: Any) {
        
      
                let alert = UIAlertController(title: "Delete Contest", message: "Are you sure you want to delete/leave this contest ?", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                    
                    var r  = BaseServiceClass()
                    
                        var uid = UserDefaults.standard.value(forKey: "refid")!
                        var params : Dictionary<String,Any> = ["GroupId" : self.eventid , "UserId" : uid]
                        var url = "\(Constants.K_baseUrl)\(Constants.leavecontest)?contestId=\(self.eventid)&userId=\(uid)"
                    
                    r.postApiRequest(url: url, parameters: [:] ) { (response, err) in
                            if let res = response?.result.value as? Dictionary<String,Any> {
                                print(res)
                                if let code = res["ResponseStatus"] as? Int {
                                    if code == 0 {
                                        let alert2 = UIAlertController(title: "Contest Deleted", message: "", preferredStyle: .actionSheet)
                                        alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                            self.performSegue(withIdentifier: "backtozero", sender: nil)
                                            
                                        }));
                                        self.present(alert2, animated: true, completion: nil)
                                        
                                    }
                                    else {
                                        if let err = res["Error"] as? Dictionary<String,Any> {
                                            if let inner = err["ErrorMessage"] as? String {
                                                self.present(customalert.showalert(x: inner), animated: true, completion: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    
                    
                    
                }));
                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
  
    }
    
    
    
    
    
    @IBAction func changeeventstart(_ sender: UIButton) {
        self.editpopup.isHidden = false
        currenlychanging = "start"
        self.scroll.isHidden = true
    }
    
    
    @IBAction func mastereditbtnpressed(_ sender: UIButton) {
        lookupupdates()
 
  
        
        
    }
    
    
    
    
    
    @IBAction func changeeentresult(_ sender: UIButton) {
        self.editpopup.isHidden = false
        currenlychanging = "result"
        self.scroll.isHidden = true
    }
    
    @IBAction func closeeditpopup(_ sender: UIButton) {
        self.editpopup.isHidden = true
        self.scroll.isHidden = false
    }
    
    
    @IBAction func doneeditpopup(_ sender: UIButton) {
        self.editpopup.isHidden = true
        self.scroll.isHidden = false
        var reson = ""
        if let c = self.datechooser.date as? Date {
             reson =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303Z'")
        }
        if currenlychanging == "start" {
            modifiedstartdate = reson
            startdateeditbtn.setTitle(reson.components(separatedBy: ".")[0], for: .normal)
        }
        else if currenlychanging == "result" {
            modifiedresultdate = reson
            enddateeditbtn.setTitle(reson.components(separatedBy: ".")[0], for: .normal)
        }
    }
    
    
    func lookupupdates()
    {
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        print("\(modifiedstartdate) is the start date")
        
        
        var id = 0
        var oname = ""
        var oloc = ""
        
        if let nm = self.currentevent?.contestlocation as? String {
            oloc = nm
        }
        if let nm = self.currentevent?.contestname as? String {
            oname = nm
        }
        if let iid = self.currentevent?.contestid as? Int {
            id = iid
        }
        id = self.eventid
        var desc = ""
        if let d = self.contestdetailsedit?.text as? String {
            desc = d
        }
        var params : Dictionary<String,Any> = [
        "ID": id,
        "ContestName": "\(oname)",
        "Description": "\(desc)",
        ]
        
        
        
        if self.contestnameedit.text != self.currentevent?.contestname {
            params["ContestName"] = self.contestnameedit.text
            
        }

        
        if self.contestdetailsedit.text != self.currentevent?.description {
            params["Description"] = self.contestdetailsedit.text
            
        }
        
        if self.contestlocation.text != self.currentevent?.contestlocation {
            params["ContestLocation"] = self.contestlocation.text
            
        }
        else {
            params["ContestLocation"] = oloc
        }
        
        if let st = modifiedstartdate as? String {
            if st != "" && st != " " {
                params["ContestStart"] = st
            }
        }
        
        if let st = modifiedresultdate as? String {
            if st != "" && st != " " {
                params["ResultOn"] = st
            }
        }
        
//        if modifiedstartdate != self.currentevent?.conteststart {
//            params["ContestStart"] = modifiedstartdate
//            if let x = modifiedstartdate as? String
//            {
//                var y = modifiedstartdate.components(separatedBy: "T")
//                if let gy = y as? [String] {
//                var z = gy[1].components(separatedBy: ".")
//                    if let gz = z as? [String] {
//                        var c = "\(gy[0]) \(gz[0])"
//
//                    if let d = c as? String{
//                        self.eventtimings.text = "Contest Starts : \(d)"
//
//                    }
//                }
//                }
//
//            }
//
//
//        }
//        if modifiedresultdate != self.currentevent?.resulton {
//            params["ResultOn"] = modifiedresultdate
//            if let x = modifiedresultdate as? String
//            {
//                var y = modifiedresultdate.components(separatedBy: "T")
//                if let gy = y as? [String] {
//                var z = gy[1].components(separatedBy: ".")
//                    if let gz = z as? [String] {
//                        var c = "\(gy[0]) \(gz[0])"
//
//                    if let d = c as? String{
//                        self.eventresults.text = "Contest Results on : \(d)"
//
//                    }
//                }
//                }
//
//            }
//
//        }
        
        self.masteredit.isHidden = true
         self.eventresultbtn.isHidden = true
         self.eventstartbtn.isHidden = true
         self.contestname.isEnabled = false
         self.eventdescription.isEditable = false
        var r = BaseServiceClass()
        r.postApiRequest(url: Constants.K_baseUrl + Constants.updatecontest, parameters: params) { (response, err) in
            if let results = response?.result.value as? Dictionary<String,Any> {
                print(results)
                if let rsp = results["ResponseStatus"] as? Int {
                    print(rsp)
                    if rsp == 0 {
                        self.present(customalert.showalert(x: "Contest Updated !"), animated: true, completion: nil)
                        
                        
                        
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        
                        if let st = self.modifiedstartdate as? String {
                            if st != "" && st != " " {
                                self.currentevent?.conteststart = st
                            }
                        }
                        
                        if let st = self.modifiedresultdate as? String {
                            if st != "" && st != " " {
                                self.currentevent?.resulton = st
                            }
                        }
                        
                        self.currentevent?.contestname  = self.contestnameedit.text ?? ""
                        
                        self.currentevent?.description = self.contestdetailsedit.text
                        
                        self.currentevent?.contestlocation = self.contestlocation.text ?? ""
                        
//                        self.passbackupdatedevent!(self.currentevent!)
                        
                        self.setui()
                        
                        
                    }
                }
            }
        }
        print(params)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        view.addSubview(scroll)

        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 4300)
        self.scroll.isScrollEnabled = true
        
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        
        if let re = self.passedevent as? event {
            self.eventname.text = re.eventname.capitalized
            self.eventcreatedby.text = ""
            self.eventtimings.text = "\(re.time) - \(re.endtime)"
            self.eventdescription.text = "New Event"
        
            
        }
        geteventdata(id: self.eventid)
         pc = UIImagePickerController()
        pc?.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pc?.allowsEditing = true
        pc?.mediaTypes = ["public.image"]
        pc?.sourceType = .photoLibrary
        self.eventdescription.isSelectable = false
        
        self.masteredit.isHidden = true
        self.eventresultbtn.isHidden = true
        self.eventstartbtn.isHidden = true
        self.contestname.isEnabled = false
        self.eventdescription.isEditable = false
        
       
        
    }
    
    func geteventdata(id : Int)
    {
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var url = Constants.K_baseUrl + Constants.getparticularevent
                    var params : Dictionary<String,Any> = ["contestId": id]
                    print(params)
                    var r = BaseServiceClass()
        
                    r.getApiRequest(url: url, parameters: params) { (response, err) in
                        
                        if let resv = response?.result.value as? Dictionary<String,Any> {
                            print(resv)
                            if let resps = resv["ResponseStatus"] as? Int {
                                if resps == 1 {
                                    print("Error")
                                }
                                else {
                                    if let each = resv["Results"] as? Dictionary<String,Any> {
                                        
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
                                        if let cn = each["Creator"] as? Dictionary<String,Any> {
                                            var name = ""
                                            var profile = ""
                                            var userid = ""
                                            if let n = cn["Name"] as? String {
                                                name = n
                                            }
                                            if let n = cn["Profile"] as? String {
                                                profile = n
                                            }
                                            if let n = cn["UserID"] as? String {
                                                userid = n
                                            }
                                            self.eventcreator = juryorwinner(id: 0, userid: userid, name: name, profile: profile)
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
                                        if let jn = each["Joined"] as? Bool {
                                            self.joined = jn
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
                                                
                                        self.currentevent = x
                                          print(x)
                                            
                                        self.setui()
                                        
                                    }
                                }
                            }
                        }
                    }

    }
    
    func setui()
    {
        
        
        self.contestnameedit.text = self.currentevent?.contestname.capitalized
        self.startdateeditbtn.setTitle(self.currentevent?.conteststart.components(separatedBy: ".")[0], for: .normal)
        self.enddateeditbtn.setTitle(self.currentevent?.resulton.components(separatedBy: ".")[0], for: .normal)
        
        self.contestdetailsedit.text = self.currentevent?.description
        self.contestlocation.text  = self.currentevent?.contestlocation.capitalized
        
        
        
        
           var userid = UserDefaults.standard.value(forKey: "refid") as! String
        self.eventname.text = self.currentevent?.contestname.uppercased()
                self.contestname.text = self.currentevent?.contestname.uppercased()
        if let n = self.eventcreator?.name {
            self.eventcreatedby.text = "Created by \(n.capitalized)"
        }
        
       
        
        
        if let url = self.currentevent?.contestimage as? String {
            if url != "" && url != " " {
                self.downloadimage(url: url) { (im) in
                    self.imagebanner.image = im
                }
            }
        }
        if let x = self.currentevent?.conteststart
        {
            modifiedstartdate = self.currentevent?.conteststart ?? ""
            var y = self.currentevent?.conteststart.components(separatedBy: "T")
            if let gy = y as? [String] {
            var z = gy[1].components(separatedBy: ".")
                if let gz = z as? [String] {
                    var c = "\(gy[0]) \(gz[0])"
                
                if let d = c as? String{
                    self.eventtimings.text = "Contest Starts : \(d)"

                }
            }
            }

        }
        if let x = self.currentevent?.resulton
        {
            modifiedresultdate = self.currentevent?.resulton ?? ""
            
            var y = self.currentevent?.resulton.components(separatedBy: "T")
            if let gy = y as? [String] {
            var z = gy[1].components(separatedBy: ".")
                if let gz = z as? [String] {
                    var c = "\(gy[0]) \(gz[0])"
                
                if let d = c as? String{
                    self.eventresults.text = "Contest Ends : \(d)"

                }
            }
            }

        }
        if let ef = self.currentevent?.entryfee {
            self.entryfee.text = "Entry Fee \(ef)"

        }
        if let es = self.currentevent?.invitationtype.capitalized {
            self.eventstatus.text = "\(es) Invitation"

        }
        self.eventdescription.text = self.currentevent?.description.capitalized
        if let t = self.currentevent?.allowcategory.capitalized {
            self.allowcategory.text = "Allowed category : \(t)"
        }
        if let t = self.currentevent?.entrytype.capitalized {
            self.entrytype.text = "Entry type : \(t)"

        }
        if let t = self.currentevent?.contestprice.capitalized {
            self.contestprice.text = "Contest price : \(t)"

        }
        if let t = self.currentevent?.contestpricetype.capitalized {
                    self.contestwinnerpricetype.text = "Winner price type : \(t)"
        }
        if let t = self.currentevent?.resulttype.capitalized {
            self.resulttype.text = "Result type : \(t)"

        }
        if let t  = self.currentevent?.runningstatus.capitalized {
            self.eventrunninstatus.text = "Contest Status : \(t)"
        }

        if userid == self.currentevent?.userid {
//            self.editbtnoutlet.text = "Edit"
        }
        else {
            if self.joined == false {
//                self.editbtnoutlet.text = "Join"
            }
            else {
//                self.editbtnoutlet.text = "Joined"

            }
        }
        
        
        
      
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
    
    
    @IBAction func addphotobtnclicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Upload", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Image", style: .default, handler: { _ in
            
            
               
                    self.pc?.mediaTypes = ["public.image"]
                let alert2 = UIAlertController(title: "Select From", message: nil, preferredStyle: .actionSheet)
                alert2.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                    {
                        self.pc?.sourceType = .camera
                        self.pc?.allowsEditing = true
                        self.present(self.pc!, animated: true, completion: nil)
                        
                    }
                    
                }))
            alert2.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                
                    self.pc?.sourceType = .photoLibrary
                    self.pc?.allowsEditing = true
                    self.present(self.pc!, animated: true, completion: nil)
                    
                
                
            }))
                
                alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert2, animated: true, completion: nil)
            
                
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Video", style: .default, handler: { _ in
            
            self.pc?.mediaTypes = ["public.movie"]
            let alert2 = UIAlertController(title: "Select From", message: nil, preferredStyle: .actionSheet)
            alert2.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
                    self.pc?.sourceType = .camera
                    self.present(self.pc!, animated: true, completion: nil)
                    
                }
                
            }))
            alert2.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                
                self.pc?.sourceType = .photoLibrary
                self.present(self.pc!, animated: true, completion: nil)
                
                
                
            }))
            
            alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert2, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func editeventcliecked(_ sender: UIButton) {
        print("Editing")
        if self.masteredit.isHidden == true {
        self.masteredit.isHidden = false
        self.eventresultbtn.isHidden = false
        self.eventstartbtn.isHidden = false
        self.contestname.isEnabled = true
        self.eventdescription.isEditable = true

        }
        else {
            self.masteredit.isHidden = true
            self.eventresultbtn.isHidden = true
            self.eventstartbtn.isHidden = true
            self.contestname.isEnabled = false
            self.eventdescription.isEditable = false

        }
//        performSegue(withIdentifier: "editmyevent", sender: nil)
    }
    
    func videoSnapshot(filePathLocal:URL) -> UIImage? {
        do
        {
            let asset = AVURLAsset(url: filePathLocal)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at:CMTimeMake(value: Int64(0), timescale: Int32(1)),actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        }
        catch let error as NSError
        {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }

    
    var imgtypes : [String] = []
    var videopath : NSURL?
    var generatedsnapshot : UIImage?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if picker.sourceType == .photoLibrary {
            let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
            if (assetPath.absoluteString?.hasSuffix("JPG"))! {
                print("JPG")
                self.imgtypes.append("jpg")
            }
            else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
                self.imgtypes.append("png")
            }
            else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
                self.imgtypes.append("gif")
            }
            else {
                self.imgtypes.append("unknown")
            }
        }
        else if picker.sourceType == .camera {
            self.imgtypes.append("jpg")
        }
        
        if let mt = info[.mediaType] as? String {
            
            if mt == "public.image" {
                if let image = info[.editedImage] as? UIImage {
                    uploadeventphoto(img : [image])
                    
                }
                
            }
                
            else if mt == "public.movie" {
                if let mediaurl = info[.mediaURL] as? NSURL {
                    print("Got in to movie")
                    if let im = self.videoSnapshot(filePathLocal: mediaurl.absoluteURL!) as? UIImage {
                        generatedsnapshot = im
                    }
                    self.videopath = mediaurl
                    self.uploadvideoforevent()
                }
            }
        }
        self.pc?.dismiss(animated: true, completion: nil)
        
        
        
        
        
        
        
        
//        if let image = info[.editedImage] as? UIImage {
//          self.imagebanner.image = image
//        if picker.sourceType == .photoLibrary {
//                   let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
//                         if (assetPath.absoluteString?.hasSuffix("JPG"))! {
//                             print("JPG")
//                             self.imgtypes.append("jpg")
//                         }
//                         else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
//                             self.imgtypes.append("png")
//                             }
//                         else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
//                             self.imgtypes.append("gif")
//                         }
//                         else {
//                             self.imgtypes.append("unknown")
//                         }
//               }
//               else if picker.sourceType == .camera {
//                   self.imgtypes.append("jpg")
//               }
//            uploadeventphoto(img : [image])
//           self.dismiss(animated: true, completion: nil)
//            self.addphotobtn.setTitle("Change Photo", for: .normal)
//
//        }
//        else
//        {
//            print("Upload failed")
//        }
        
        
    }
    
    
    func uploadvideoforevent()
    {
        let request = VideoUploadRequest()
        
        request.sendprogress = {a in
            DispatchQueue.main.async {
                self.addphotobtn.setTitle("\(Int(a.fractionCompleted * 100)) % completed", for: .normal)
            }
            
        }
        
       
        
        
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var params : Dictionary<String,Any> = ["ContestId" : eventid , "filetype" : "Video"]
        
        
        
        
        var movieData: NSData?
        do {
            movieData = try NSData(contentsOfFile: ((videopath?.relativePath!)!), options: NSData.ReadingOptions.alwaysMapped)
        } catch _ {
            movieData = nil
            return
        }
        print(movieData)
        //        DispatchQueue.global(qos: .background).async {
        request.uploadVideo(imagesdata: movieData , params: params , url : Constants.K_baseUrl + Constants.addcontestimage) {  (response, err) in
            print(response?.result.value)
            if response != nil{
                if let i = self.videoSnapshot(filePathLocal: self.videopath as! URL) as? UIImage {
                    self.imagebanner.image = i
                }
                print("Video Uploaded Sucessfully")
                
            }
                
            else
            {
                print("Some thing went wrong please try again!")
            }
            
        }
        //        }
        
        
    }

    
    
    func uploadeventphoto(img : [UIImage])
    {
        var eventid = 0
        if let i = self.currentevent?.contestid as? Int {
            eventid = i
        }
        
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        var params : Dictionary<String,Any> = ["ContestId" : eventid , "filetype" : "Image"]
        
        
        print(params)
        print(eventid)
        print(img)
        var url = Constants.K_baseUrl + Constants.addcontestimage
        print(url)
        var r = ImageUploadRequest()
        r.sendprogress = { a in
                   print(a.fractionCompleted)
        }
   
        r.uploadImage(imagesdata:img, params: params, url: url, extensiontype: self.imgtypes) { (res, err) in
            print(res)
            print("Shoud set image")
            self.imagebanner.image = img[0]
            self.passbackuploadedimage!(img[0])
            self.dismiss(animated: true, completion: nil)
       
        }
        
    }
    
    
    func setupview()
    {
        
    // test comment
        self.bannerheight.constant = self.view.frame.size.height/5
    self.notificationindicator.layer.cornerRadius = 10
         highlighterview.layer.masksToBounds = false
        highlighterview.layer.shadowColor = UIColor.lightGray.cgColor
        highlighterview.backgroundColor = UIColor.white
        highlighterview.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        highlighterview.layer.shadowOpacity = 0.5
        
         goinginvitedstackview.layer.masksToBounds = false
        goinginvitedstackview.layer.shadowColor = UIColor.lightGray.cgColor
        goinginvitedstackview.backgroundColor = UIColor.white
        goinginvitedstackview.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        goinginvitedstackview.layer.shadowOpacity = 0.5
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? EventDetailsfeedViewController {
            seg.isineditmode = true
            seg.eventid = self.eventid
            seg.eventwhole = self.currentevent
            seg.isnewevent = true
        }
        
//        if let seg = segue.destination as? ModifiedcontestcreateViewController {
//            seg.isineditmode = true
//            seg.eventid = self.eventid
//            seg.eventwhole = self.currentevent
//            seg.isnewevent = true
//        }
       
        
        
    }

}



