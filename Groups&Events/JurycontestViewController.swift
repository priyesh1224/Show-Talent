//
//  JurycontestViewController.swift
//  ShowTalent
//
//  Created by maraekat on 05/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class JurycontestViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
 
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var outercover: UIView!
    
    @IBOutlet weak var winnerspopup: UIView!
    
    @IBOutlet weak var winnertableview: UITableView!
    
    @IBOutlet weak var winnerpopupheight: NSLayoutConstraint!
    
    @IBOutlet weak var cancelbtn: UIButton!
    
    @IBOutlet weak var confirmbtn: UIButton!
    
    
    @IBOutlet weak var nopostsavailable: Customlabel!
    
    
    
    @IBOutlet weak var popupheading: UILabel!
    static var currentshowingrank = 1
    
    var rankallocatedfeeds : Dictionary<Int,feeds>  = [:]
    
    var loadthisvideo = false
    
    var joined = false
    var eventcreator : juryorwinner?
    var currentevent : strevent?
    
    var selectedsection = "contestdetails"
    
    var contestid = 25
    var postid = 0
    var allfeeds : [feeds] = []
    
    var winningfeeds : [feeds] = []
    var tappedfeed : feeds?
    var totalwinners = 2
    var totalparticipants = 0
    var videoallowed = false
    @IBOutlet weak var submitbtn: UIButton!
    
   static var allowedfurtherselection : Bool = true
    
    @IBOutlet weak var screentitle: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    
    var alreadypostedwinners : [juryorwinner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nopostsavailable.isHidden = true
        self.popupheading.text = "Please tap on position \(JurycontestViewController.currentshowingrank)"
        table.delegate = self
        table.dataSource = self
        winnertableview.delegate = self
        winnertableview.dataSource = self
        self.confirmbtn.isEnabled = false
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        self.geteventdata(id: self.contestid)
        self.outercover.isHidden = true
        self.submitbtn.isEnabled = false
        self.submitbtn.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
        self.winnerspopup.layer.cornerRadius = 20
        self.cancelbtn.layer.cornerRadius = self.cancelbtn.frame.size.height/2
        self.confirmbtn.layer.cornerRadius = self.confirmbtn.frame.size.height/2


       
    }
    
    
    @IBAction func backpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelwinnerpopup(_ sender: Any) {
        self.rankallocatedfeeds.removeAll()
        self.winnertableview.reloadData()
        self.table.reloadData()
        self.outercover.isHidden = true
    }
    
    
    @IBAction func confirmwinnerpopup(_ sender: Any) {
        if let endingdata = self.currentevent?.resulton as? String {
            var tl = self.currentevent?.resulton
            var t2 = self.currentevent?.conteststart
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303'"
            let date = dateFormatter.date(from: endingdata)
            let date2 = dateFormatter.date(from: t2 ?? "")
            let interval = date?.timeIntervalSince(Date())
            if interval?.isLess(than: 0) ?? false {
                var url = Constants.K_baseUrl + Constants.addwinner
                var params : [Dictionary<String,Any>] = []
                for each in self.rankallocatedfeeds {
                    params.append(["ContestID" : self.contestid , "WinnerUserId" : each.value.userid ,"Position" : each.key])
                    
                }
                print(url)
                print(params)
                
                
                var request = URLRequest(url: try! url.asURL())
                request.httpMethod = "POST"
                request.setValue("Bearer \(UserDefaults.standard.value(forKey: "token") as! String)",
                    forHTTPHeaderField: "Authorization")
                
                print("Bearer \(UserDefaults.standard.value(forKey: "token") as! String)")
                
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                request.httpBody = try! JSONSerialization.data(withJSONObject: params)
                
                
                Alamofire.request(request).responseJSON { response in
                    if let r = response.result.value as? Dictionary<String,Any> {
                        print(r)
                        if let s  = r["ResponseStatus"] as? Int {
                            if s == 0 {
                                let alertController = UIAlertController(title: "Winners Added", message: "Winners of the contest are added", preferredStyle: UIAlertController.Style.alert)
                                let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
                                    self.performSegue(withIdentifier: "backtozero", sender: nil)
                                }
                                alertController.addAction(dismissAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        
                    }
                    
                    
                    
                }
            }
            else {
                self.present(customalert.showalert(x: "You can not post winners until contest is over."), animated: true, completion: nil)
            }
        }

        
    }
    
    @IBAction func submitwinnerstapped(_ sender: UIButton) {
        self.outercover.isHidden = false
    }
    
    func geteventdata(id : Int)
    {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
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
                                                var existingwinners : [juryorwinner] = []
                                        
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
                                        if let cn = each["TotalParticipation"] as? Int {
                                            self.totalparticipants = cn
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
                                        
                                        if let wn = each["Winners"] as? [Dictionary<String,Any>]{
                                            for each in wn {
                                                var a = 0
                                                var b = ""
                                                var c = ""
                                                var d = ""
                                                
                                                if let g = each["ID"] as? Int {
                                                    a = g
                                                }
                                                if let g = each["Name"] as? String {
                                                    b = g
                                                }
                                                if let g = each["Profile"] as? String {
                                                    c = g
                                                }
                                                if let g = each["UserId"] as? String {
                                                    d = g
                                                }
                                                
                                                var xx = juryorwinner(id: a, userid: d, name: b, profile: c)
                                                self.alreadypostedwinners.append(xx)
                                                
                                            }
                                        }
                                                
                                        var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                                                
                                        self.currentevent = x
                                        self.screentitle.text = contestname.capitalized
                                          print(x)
                                        self.spinner.isHidden = true
                                        self.spinner.stopAnimating()
                                        if self.alreadypostedwinners.count > 0 {
                                            self.submitbtn.isHidden = true
                                        }
                                        self.table.reloadData()
                                    }
                                }
                            }
                        }
                    }

    }
    
    
    
    
    
    
    typealias progressindata = ((_ done : Bool) -> Void)
     
     
     
     func fetchfeeds(d : @escaping progressindata)
     {
         let url = "\(Constants.K_baseUrl)\(Constants.contestfeeds)?contestId=\(self.contestid)"
         
         let useid = UserDefaults.standard.value(forKey: "refid") as! String
         var params : Dictionary<String,Any> = [  "Page": 0,"PageSize": 10]
         print(url)
         print(params)
         let r = BaseServiceClass()
         r.postApiRequest(url: url, parameters: params) { (response, err) in
             if let res = response?.result.value as? Dictionary<String, Any> {
                 print(res)
                 if let data = res["Results"] as? [Dictionary<String,Any>] {
                     for each in data {
                         print(each)
                         print("--------------------")
                         var id  = ""
                            var profileimg  = ""
                            var profilename  = ""
                            var thumbnail  = ""
                            var acticityid  = 0
                            var userid  = ""
                            var activitypath  = ""
                            var type = ""
                            var category = ""
                            var views = 0
                            var likes = 0
                            var title = ""
                            var description = ""
                            var publishedon = ""
                            var categoryid = 0
                            var contestid = 0
                        var totalreview = 0
                             var lbyme = false
                        var cmmmt : [comment] = []

                         if let p = each["Id"] as? String {
                             profileimg = p
                         }
                        if let p = each["TotalReview"] as? Int {
                            totalreview = p
                        }
                         if let p = each["ProfileImg"] as? String {
                             profileimg = p
                         }
                         if let p = each["ProfileName"] as? String {
                             profilename = p
                         }
                         if let p = each["thumbnail"] as? String {
                             thumbnail = p
                         }
                         if let p = each["ActivityId"] as? Int {
                             acticityid = p
                         }
                         if let p = each["UserId"] as? String {
                             userid = p
                         }
                         if let p = each["ActivityPath"] as? String {
                             activitypath = p
                         }
                        if let p = each["comments"] as? [Dictionary<String,Any>] {
                            for each in p {
                                var id = ""
                                var cid = 0
                                var  aid = 0
                                var pname = ""
                                var pimage = ""
                                var uid = ""
                                var ucomment = ""
                                var ondate = ""
                                var replycomm : [comment] = []
                                if let s =  each["Id"] as? String {
                                    id = s
                                }
                                if let s =  each["CommentId"] as? Int {
                                    cid = s
                                }
                                if let s =  each["ActivityId"] as? Int {
                                    aid = s
                                }
                                if let s =  each["ProfileName"] as? String {
                                    pname = s
                                }
                                if let s =  each["ProfileImage"] as? String {
                                    pimage = s
                                }
                                if let s =  each["UserID"]  as? String {
                                    uid = s
                                }
                                if let s =  each["UserComment"] as? String {
                                    ucomment = s
                                }
                                if let s =  each["Ondate"] as? String {
                                    ondate = s
                                }
                                if let s =  each["ReplyComments"] as? [Dictionary<String,Any>] {
                                    for each in s {
                                        var id = ""
                                        var cid = 0
                                        var  aid = 0
                                        var pname = ""
                                        var pimage = ""
                                        var uid = ""
                                        var ucomment = ""
                                        var ondate = ""
                                        var replycomm : [comment] = []
                                        if let s =  each["Id"] as? String {
                                            id = s
                                        }
                                        if let s =  each["CommentId"] as? Int {
                                            cid = s
                                        }
                                        if let s =  each["ActivityId"] as? Int {
                                            aid = s
                                        }
                                        if let s =  each["ProfileName"] as? String {
                                            pname = s
                                        }
                                        if let s =  each["ProfileImage"] as? String {
                                            pimage = s
                                        }
                                        if let s =  each["UserID"] as? String {
                                            uid = s
                                        }
                                        if let s =  each["UserComment"] as? String {
                                            ucomment = s
                                        }
                                        if let s =  each["Ondate"] as? String {
                                            ondate = s
                                        }
                                        if let s =  each["ReplyComments"] as? [Dictionary<String,Any>] {
                                            
                                            
                                        }
                                        var cm = comment(id: id, comentid: cid, activityid: aid, profilename: pname, profileimage: pimage, userid: uid, usercomment: ucomment, ondate: ondate, replycomments: [] , status: "reply")
                                        replycomm.append(cm)
                                        
                                    }

                                    
                                }
                                var cm = comment(id: id, comentid: cid, activityid: aid, profilename: pname, profileimage: pimage, userid: uid, usercomment: ucomment, ondate: ondate, replycomments: replycomm, status: "main")
                                cmmmt.append(cm)
                                
                            }
                        }
                        
                        
                         if let p = each["Type"] as? String {
                                 type = p
                             }
                             if let p = each["Category"] as? String {
                                 category = p
                             }
                             if let p = each["View"] as? Int {
                                 views = p
                             }
                             if let p = each["Like"] as? Int {
                                 likes = p
                             }
                             if let p = each["Title"] as? String {
                                 title = p
                             }
                             if let p = each["Description"] as? String {
                                 description = p
                             }
                             if let p = each["PublishOn"] as? String {
                                 publishedon = p
                             }
                         if let p = each["CategoryId"] as? Int {
                                    categoryid = p
                                }
                                if let p = each["ContestId"] as? Int {
                                    contestid = p
                                }
                         
                         var liketobepassed : [like] = []
                         var currstatus = false
                         
                         if let likedbyme = each["LikeByMe"] as? [Dictionary<String,AnyObject>] {
                             for eachcom in likedbyme {
                                 var cmactids = 0
                                 var cmuserids = ""
                                 var cmmidd = 0
                                 var cmmondateee = ""
                                 var idd = ""
                                 var cmmprofnamee = ""
                                 var cmmprofimagee = ""

                                 var cmmuidd = ""
                                 if let cmactid = eachcom["ActivityId"] as? Int {
                                     cmactids = cmactid
                                 }
                                 
                                 if let cmuserid = eachcom["UserID"] as? String {
                                     if userid == cmuserid {
                                         currstatus = true
                                     }
                                     
                                      cmuserids = cmuserid
                                  }
                                 if let cmmiddd = eachcom["Id"] as? String {
                                      idd = cmmiddd
                                  }
                                 if let cmmondatee = eachcom["Ondate"] as? String {
                                      cmmondateee = cmmondatee
                                  }

                                 if let cmmprofname = eachcom["ProfilName"] as? String {
                                      cmmprofnamee = cmmprofname
                                  }
                                 if let cmmprofimage = eachcom["ProfileImage"] as? String {
                                      cmmprofimagee = cmmprofimage
                                  }

                                 var xc = like(activityid: cmactids, id: idd, ondate: cmmondateee, profilename: cmmprofnamee, profileimage: cmmprofimagee, userid: cmuserids)
                                 
                                 
                                 
                                 
                                 liketobepassed.append(xc)
                                 
                                 
                                 
                             }
                         }

                         
                        
                         
                        var x = feeds(id: id, profileimg: profileimg, profilename: profilename, thumbnail: thumbnail, acticityid: acticityid, userid: userid, activitypath: activitypath, type: type, category: category, views: views, likes: likes, title: title, description: description, publishedon: publishedon, categoryid: categoryid, contestid: contestid, likedbyme: currstatus, likebyme: liketobepassed, comments: cmmmt , totalreview: totalreview)
                         self.allfeeds.append(x)
                         
                         
                         
                         
                     }
                    if self.allfeeds.count == 0 {
                        self.nopostsavailable.isHidden = false
                    }
                    else {
                        self.nopostsavailable.isHidden = true
                    }
                     d(true)
                 }
             }
         }
     }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 5 {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 5 {
            return self.winningfeeds.count
        }
        if section == 0 {
            return 1
        }
        else if section == 1  {
            if self.selectedsection == "participantsvideos" {
                return 0
            }
            return 1
        }
        else {
            if self.selectedsection == "contestdetails" {
                return 0
            }
            return self.allfeeds.count
        }
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 5 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "winnerjury", for: indexPath) as? WinnerjuryTableViewCell {
                cell.takebackrankedfeed = {a,b in
                    self.rankallocatedfeeds[a] = b
                    print(self.rankallocatedfeeds)
                    print(self.currentevent?.noofwinners)
                    print(self.rankallocatedfeeds.count)
                    if let t = self.currentevent?.noofwinners as? Int {
                        if self.rankallocatedfeeds.count == t {
                            self.confirmbtn.isEnabled = true
                            self.popupheading.text = "Tap on confirm to submit winners."
                        }
                        else {
                            self.confirmbtn.isEnabled = false
                        }
                    }
                   
                }
                cell.updatecell(x : self.winningfeeds[indexPath.row] , y : indexPath.row , z : self.currentevent?.contestprice ?? "" , a : self.currentevent?.noofwinners ?? 0 , b : self.rankallocatedfeeds.count)
                return cell
            }
        }
        
        
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "juryone", for: indexPath) as? JuryContestoneTableViewCell {
                cell.passbacktapped = { a in
                    self.selectedsection = a
                    self.table.reloadData()
                    self.nopostsavailable.isHidden = true
                    if a == "participantsvideos" {
                        if self.winningfeeds.count > 0 {
                            self.nopostsavailable.isHidden = false
                        }
                        else {
                            if self.allfeeds.count == 0 {
                                
                                self.fetchfeeds { (st) in
                                    if st {
                                        self.table.reloadData()
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
                if let e  = self.currentevent as? strevent {
                    cell.updatecell(x : e )
                }
                
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "jurytwo", for: indexPath) as? JurycontesttwoTableViewCell {
                cell.selectionStyle = .none
                if let e  = self.currentevent as? strevent {
                    cell.update(x : e, y : self.totalparticipants)
                }
                return cell
            }
        }
        else {
            
            var makevideoefetch = false
            if indexPath.row == 0 || self.videoallowed == true {
                makevideoefetch = true
            }
            if indexPath.row == allfeeds.count {
                self.videoallowed = true
            }
            
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "jurythree", for: indexPath) as? JurycontestthreeTableViewCell {
                cell.passwinner = {a in
                    if self.winningfeeds.count < self.totalwinners {
                        self.winningfeeds.append(a)
                    }
                    if self.winningfeeds.count == self.totalwinners {
                        self.submitbtn.isEnabled = true
                        self.submitbtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                        JurycontestViewController.allowedfurtherselection = false
                        self.winnerpopupheight.constant = CGFloat(150 + ( self.winningfeeds.count * 60 ))
                        self.winnertableview.reloadData()
                        self.outercover.isHidden = false
                        
                    }
                    print("Winning feeds count \(self.winningfeeds.count)")
                   
                }
                
                
                
                cell.sendclickedevent = { a,b,c in
                    self.postid = b
                    self.tappedfeed = c
                    if a == "comment"
                    {
                        self.performSegue(withIdentifier: "jurycomments", sender: nil)
                    }
                    else if a == "review"
                    {
                        self.performSegue(withIdentifier: "juryreviews", sender: nil)
                    }
                }
                
                
                
                
                
                cell.removewinner = { a in
                    for var k in 0 ..< self.winningfeeds.count {
                        if self.winningfeeds[k].acticityid == a.acticityid {
                            self.winningfeeds.remove(at: k)
                            
                            break
                        }
                    }
                    if self.winningfeeds.count != self.totalwinners {
                        self.submitbtn.isEnabled = false
                        self.submitbtn.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
                        JurycontestViewController.allowedfurtherselection = true
                    }
                    else {
                        self.submitbtn.isEnabled = true
                        self.submitbtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                        JurycontestViewController.allowedfurtherselection = false
                    }
                    print(self.winningfeeds)
                }
                var shouldcheck = false
                for var k in 0 ..< self.winningfeeds.count {
                    if self.winningfeeds[k].acticityid == self.allfeeds[indexPath.row].acticityid {
                        shouldcheck = true
                        
                        break
                    }
                }
                
                var furtherselectionallowed = self.alreadypostedwinners.count
                
                
                if loadthisvideo == false && indexPath.row != 0{
                    makevideoefetch = false
                }
                
                cell.updatecell(x: self.allfeeds[indexPath.row],y : shouldcheck , z : furtherselectionallowed , w : makevideoefetch)
                print("Survived Error")
                return cell
            }
        }
        return UITableViewCell()
     }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        print("Tag of table view is \(tableView.tag)")
        if tableView.tag == 5 {
            return 50
        }
        if indexPath.section == 0 {
            return 300
        }
        else if indexPath.section == 1 {
            return 420
        }
        else {
            return self.view.frame.size.height * 0.7
        }
        return 280
    }
    
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Me removed \(indexPath.row)")
        if let cell = tableView.cellForRow(at: indexPath) as? JurycontestthreeTableViewCell {
            if let p = cell.player  {
                p.isMuted = true
                p.pause()
            }

        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if let cell = tableView.cellForRow(at: indexPath) as? JurycontestthreeTableViewCell {
            print("Yo")
            if let p = cell.player  {
               print("hey")
                p.play()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.rankallocatedfeeds.count < self.currentevent?.noofwinners ?? 0 {
        
        if let cell = tableView.cellForRow(at: indexPath) as? WinnerjuryTableViewCell {
            cell.assingrank()
            JurycontestViewController.currentshowingrank = JurycontestViewController.currentshowingrank + 1
            if self.rankallocatedfeeds.count == self.currentevent?.noofwinners ?? 0 {
                self.popupheading.text = "Tap on confirm to submit results"

            }
            else {
                self.popupheading.text = "Please select position \(JurycontestViewController.currentshowingrank)"

            }
            
        }
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? JurycontestthreeTableViewCell {
            if let p = cell.player  {
                
                p.isMuted = !p.isMuted
            }
            
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scrolling Over")
        loadthisvideo = true
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Scrolling Starts")
        loadthisvideo = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("How about this")
        loadthisvideo = true
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let s = segue.destination as? JoinedeventsViewController {
            s.eventid = self.contestid
        }
        if let seg = segue.destination as? AllcommentsViewController {
            seg.postid = self.postid
            if let cm = self.tappedfeed as? feeds {
                if let cmm = cm.comments as? [comment] {
                    seg.tappedcommentlist = cmm
                }
            }
            seg.sendbackupdatedlist = {a,b in
                
            }
            seg.commentposted = {a,b in
                //                var c = 0
                //                for var k in self.alldata {
                //
                //                    if k.activityid == a?.activityid {
                //                        if let lc = self.table.cellForRow(at: IndexPath(row: c, section: 0)) as? TalentshowcaseTableViewCell {
                //
                //                            lc.leadcommentuser.text = a?.profilename.capitalized
                //                            lc.leadcomment.text = a?.comment.capitalized
                //
                //                            lc.leadcomment.text = "Hello"
                //                            lc.downloadprofileimage(url: a!.profileimage) { (ik) in
                //                                lc.leadcommentuserimage.image = ik
                //                            }
                //                        }
                //
                //                        k.comments.append(a!)
                //                        self.table.reloadData()
                //                    }
                //                    c=c+1
                //                }
            }
            
        }

        if let s = segue.destination as? ReviewsandRatingsViewController {
            s.contestid = self.contestid
            s.postid = self.postid
        }
        
    }
  

}



