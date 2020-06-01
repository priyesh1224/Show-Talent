//
//  ThemePreviewViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/8/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class ThemePreviewViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    
    @IBOutlet weak var tablebottomspace: NSLayoutConstraint!
    
    @IBOutlet weak var bgbtns: UIView!
    @IBOutlet weak var hider: UIView!
    
    @IBOutlet weak var savetodraftsbtn: CustomButton!
    
    @IBOutlet weak var contestthemename: Customlabel!
    
    
    @IBOutlet weak var contestthemecategory: UITextView!
    

    @IBOutlet weak var startdateupperspace: NSLayoutConstraint!
    
    var allwinnersexistingprices : [pricewinnerwise] = []
    var themeselected : ((_ x : pretheme) -> Void)?
    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var themename: Customlabel!
    
    
    @IBOutlet weak var themephoto: UIImageView!
    
    
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    @IBOutlet weak var startdate: UILabel!
    
    
    @IBOutlet weak var entryfee: UILabel!
    
    
    @IBOutlet weak var view1: UIView!
    
    
    @IBOutlet weak var view2: UIView!
    
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var bt1: CustomButton!
    
    @IBOutlet weak var bt2: CustomButton!
    
    @IBOutlet weak var bt3: CustomButton!
    
    @IBOutlet weak var lv: UIView!
    
    var params : Dictionary<String,Any> = [:]
    var tempparams : Dictionary<String,Any> = [:]
    
    @IBOutlet weak var contestdetails: UITextView!
    
    
    @IBOutlet weak var noofwinners: UILabel!
    
    
    @IBOutlet weak var awardtype: UILabel!
    
    @IBOutlet weak var winnerpricingdetails: UITextView!
    
    
    @IBOutlet weak var detail1: UILabel!
    
    @IBOutlet weak var detail11: UILabel!
    
    
    @IBOutlet weak var detail2: UILabel!
    
    
    @IBOutlet weak var detail22: UILabel!
    
    
    @IBOutlet weak var detail3: UILabel!
    
    
    @IBOutlet weak var detail33: UILabel!
    
    @IBOutlet weak var contesttermsandcon: UITextView!
    
    
    @IBOutlet weak var expandtandc: NSLayoutConstraint!
    
    
    @IBOutlet weak var applytheme: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    
    var tobepassedtheme : pretheme?
    
    var createmode = false
    var contestid = 0
    var juryid = 0
    
    var tthemename = "jazz"
    
    var performancetypename = ""
    var performancetypeid = 0
    var gendername = ""
    var genderid = 0
    var winnerscount = 0
    
    
    var gotevent : strevent?
    var gotevent2 : pretheme?
    var categoryselected = "dance"
    var catname = ["dance","mimicry","music band","story telling","singing","acting"]
    var postbtncolor = ["#012C5E","#012C5E","006F9A","#62AA3C","012C5E","#348FDF"]

    var celltype = ["two","three","four","six","five","one"]
    var primarycoloroptions = ["#410014","#0F0515","#000000","#0ABCD8","#00C5CC","#07EAC3"]
    var secondarycoloroptions = ["#011C39","#16069C","#DC2E23","#4CC100","#004784","#16069C"]
    var currentcelltype = "one"
    var currentpostbtncolor = ""

    var insidecolors : Dictionary<String,Dictionary<String,Dictionary<String,Any>>> = [:]
    
    var tn = "Demo Theme"
    var themeid = 0
    var primarycolor = UIColor(red: 85/255, green: 190/255, blue: 216/255, alpha: 1)
    var secondarycolor = UIColor(red: 91/255, green: 180/255, blue: 99/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        if self.categoryselected.lowercased() == "hip-hop" {
           self.categoryselected = "hip hop"
        }
        
        
        
        var xt : Dictionary<String,Dictionary<String,Any>> = ["jazz" : ["primary" : "#000000" , "secondary" : "#644761"] , "hip hop" : ["primary" : "#644761" , "secondary" : "#2C1C00"] ,  "cultural dance" : ["primary" : "#171D1A" , "secondary" : "#171D1A"] ]
        
        var yt : Dictionary<String,Dictionary<String,Any>> = ["one act play" : ["primary" : "#060029" , "secondary" : "#232323"] , "group play" : ["primary" : "#171A1A" , "secondary" : "#171A1A"] ,  "other" : ["primary" : "#172524" , "secondary" : "#172524"] ]
        
        var zt : Dictionary<String,Dictionary<String,Any>> = ["solo singing" : ["primary" : "#3F4551" , "secondary" : "#0D0E10"] , "karoke" : ["primary" : "#0D7972" , "secondary" : "#000000"] ,  "sing with instrument" : ["primary" : "#101010" , "secondary" : "#00317A"] ]
        
        var at : Dictionary<String,Dictionary<String,Any>> = ["standup comedy" : ["primary" : "#78694F" , "secondary" : "#171D1A"] , "voice artist" : ["primary" : "#78694F" , "secondary" : "#340202"] ,  "puppeteer" : ["primary" : "#060029" , "secondary" : "#232323"] ]
        
        var bt : Dictionary<String,Dictionary<String,Any>> = ["comedy" : ["primary" : "#172524" , "secondary" : "#172524"] , "tragedy" : ["primary" : "#171825" , "secondary" : "#171825"] ,  "other" : ["primary" : "#171D1A" , "secondary" : "#171D1A"] ]
        
        var ct : Dictionary<String,Dictionary<String,Any>> = ["concert band" : ["primary" : "#0F1F2F" , "secondary" : "#0F1F2F"] , "school band" : ["primary" : "#2F0F0F" , "secondary" : "#2F0F0F"] ,  "rock band" : ["primary" : "#001431" , "secondary" : "#001431"] ]
        
        
        
        insidecolors["dance"] = xt
        insidecolors["acting"] = yt
        insidecolors["singing"] = zt
        insidecolors["mimicry"] = at
        insidecolors["story telling"] = bt
        insidecolors["music band"] = ct
        
        
        for var k in 0 ..< catname.count {
            if catname[k] == self.categoryselected.lowercased() {
                self.currentcelltype = celltype[k]
                self.currentpostbtncolor = postbtncolor[k]
            }
        }
        
        print(self.gotevent)
        print(self.gotevent2)
        
        print(categoryselected.lowercased())
        print(tthemename.lowercased())
        
        if let d = self.insidecolors[categoryselected.lowercased()] as? Dictionary<String,Dictionary<String,Any>> {
            if let e  = d["\(tthemename.lowercased())"] as? Dictionary<String,Any> {
                primarycolor = UIColor(hexString: e["primary"] as! String)
                secondarycolor = UIColor(hexString: e["secondary"] as! String)
            }
            else {
                for var k in 0 ..< self.catname.count {
                    if categoryselected.lowercased() == catname[k]
                    {
                        primarycolor = UIColor(hexString: primarycoloroptions[k])
                        secondarycolor = UIColor(hexString: secondarycoloroptions[k])
                    }
                }
            }
        }
        
        print("Primary color is \(primarycolor) and secondary is \(secondarycolor)")
        
        
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1250)
        self.scroll.isScrollEnabled = true
        paintborder(x:view1)
        paintborder(x:view2)
        paintborder(x:view3)
//        paintborder(x:view4)
        view4.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view4.layer.borderWidth = 2
        view4.layer.cornerRadius = 20
        bt1.layer.cornerRadius = 25
         savetodraftsbtn.layer.cornerRadius = 25
        bt2.layer.cornerRadius = 25
        bt3.layer.cornerRadius = 25
        lv.layer.cornerRadius = 15
        lv.layer.borderWidth = 1
        lv.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        applytheme.layer.cornerRadius = 25
        self.notificationindicator.layer.cornerRadius = 10
        self.setTableViewBackgroundGradient(sender: self.scroll, primarycolor, secondarycolor)
        
        
   
        if let s = self.gotevent as? strevent {
        
            tobepassedtheme = pretheme(contestid: s.contestid, contestname: s.contestname, categoryid: s.allowcategoryid, categoryname: s.allowcategory, organisationallow: s.organisationallow, invitationtypeid: s.invitationtypeid, invitationtype: s.invitationtype, entryallowedid: s.entryallowed, entrytype: s.entrytype, entryfee: s.entryfee, conteststart: s.conteststart, contestlocation: s.contestlocation, description: s.description, resulton: s.resulton, contestprice: s.contestprice, contestwinnerpricetypeid: s.contestwinnerpricetypeid, contestwinnerpricetype: s.contestpricetype, resultypeid: s.resulttypeid, resulttype: s.resulttype, userdid: s.userid, groupid: s.groupid, groupname: "", createon: s.createon, isactive: s.isactive, status: s.status, runnningstatusid: s.runningstatusid, runningstatus: s.runningstatus, joined: false, joinstatus: false, juries: s.juries, totalparticipant: 0, winners: [], contestimage: s.contestimage, creator: juryorwinner(id: 0, userid: "", name: "", profile: ""), totalreview: 0, themeid: self.themeid, themename: self.tthemename, performancetypeid: self.performancetypeid, performancetype: self.performancetypename, genderid: self.genderid, gendername: self.gendername, participationpostallow: false, termsandconditions: s.termsandcondition, contesttype: "", noofwinner: self.winnerscount)
            self.contestthemename.text = s.contestname.capitalized
            self.contestthemecategory.text = "Posted in \(s.allowcategory.capitalized)"
            self.themename.text = self.tthemename.capitalized
            self.startdate.text = "Start Date : \(s.conteststart) End Date : \(s.resulton)"
            self.entryfee.text = "Entry Fee : Rs \(s.entryfee)"
            self.contestdetails.text = "\(s.description)"
            self.noofwinners.text = "No of winners : \(self.winnerscount)"
            self.awardtype.text = "Award type : \(s.contestprice.capitalized)"
            self.winnerpricingdetails.text = "1st Price : 5000 , 2nd Price : Rs 3000 , 3rd Price : Rs 1000"
            self.detail11.text = "\(s.entrytype.capitalized)"
            self.detail22.text = "\(self.performancetypename.capitalized)"
            self.detail33.text = "\(self.gendername.capitalized)"
            contesttermsandcon.text = "\(s.termsandcondition)"
            self.downloadimage(url: s.contestimage ?? "") { (im) in
                if let i = im as? UIImage{
                    self.themephoto.image = i
                }
            }
        }
        else if let s = self.gotevent2 as? pretheme {
            allwinnersexistingprices = []
            allwinnersexistingprices.append(pricewinnerwise(id: 1, position: 1, amount: 10000))
            allwinnersexistingprices.append(pricewinnerwise(id: 2, position: 2, amount: 5000))
            tobepassedtheme = s
            self.contestthemename.text = s.contestname.capitalized
            self.contestthemecategory.text = "Posted in \(s.categoryname.capitalized)"
            self.themename.text = s.contestname.capitalized
            self.startdate.text = "Start Date : \(s.conteststart) End Date : \(s.resulton)"
            self.entryfee.text = "Entry Fee : Rs \(s.entryfee)"
            self.contestdetails.text = "\(s.description)"
            self.noofwinners.text = "No of winners : \(s.noofwinner)"
            self.awardtype.text = "Award type : \(s.contestprice.capitalized)"
            self.winnerpricingdetails.text = "1st Price : 5000 , 2nd Price : Rs 3000 , 3rd Price : Rs 1000"
            self.detail11.text = "\(s.entrytype.capitalized)"
            self.detail22.text = "\(s.performancetype)"
            self.detail33.text = "\(s.gendername)"
            contesttermsandcon.text = "\(s.termsandconditions)"
            self.downloadimage(url: s.contestimage ?? "") { (im) in
                if let i = im as? UIImage{
                    self.themephoto.image = i
                }
            }
        }
        
        if createmode {
            applytheme.setTitle("Create Contest", for: .normal)
            applytheme.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            applytheme.setTitleColor(#colorLiteral(red: 0.3236835599, green: 0.3941466212, blue: 0.8482848406, alpha: 1), for: .normal)
            bgbtns.backgroundColor = UIColor.clear
            savetodraftsbtn.isHidden = true
            applytheme.isHidden = false
            tablebottomspace.constant = 8
        }
        else {
            applytheme.isHidden = true
            tablebottomspace.constant = -40
//                applytheme.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                applytheme.setTitleColor(#colorLiteral(red: 0.3236835599, green: 0.3941466212, blue: 0.8482848406, alpha: 1), for: .normal)
//                hider.isHidden = true
//                startdateupperspace.constant = -90
//                bgbtns.backgroundColor = UIColor.clear
//                savetodraftsbtn.isHidden = true
        }
        
        self.scroll.isHidden = true
        table.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setTableViewBackgroundGradient(sender: UIScrollView, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        //        sender.backgroundView = backgroundView
    }
    
    func paintborder(x : UIView)
    {
        var y = CALayer()
        y.frame = CGRect(x: x.bounds.origin.x, y: x.bounds.origin.y, width: self.view.frame.size.width - 32, height: x.bounds.size.height)
        y.cornerRadius = 20
        y.borderWidth = 2
        y.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        x.layer.insertSublayer(y, at: 0)
        
        
        
        
        
    }
    
    
    
    @IBAction func applythemetapped(_ sender: Any) {
        if let g = self.gotevent2 as? pretheme {
            if createmode == false {
                self.themeselected!(g)
                self.dismiss(animated: true, completion:nil)
            }
        }
            else  if let g = self.gotevent as? strevent {
                self.applytheme.isEnabled = false
                var url = Constants.K_baseUrl + Constants.createcontest
                var r = BaseServiceClass()
                print(params)
                r.postApiRequest(url: url, parameters: self.params) { (response, err) in
                    if let res = response?.result.value as? Dictionary<String,Any> {
                        print(res)
                        
                        if let juryid = res["Results"] as? Int {
                            self.juryid = juryid
                        }
                        
                        if let resstatus = res["ResponseStatus"] as? Int {
                            if resstatus == 0 {
                                self.present(customalert.showalert(x: "Contest Created"), animated: true) {
                                    if let resstatus = res["Results"] as? Int {
                                        self.contestid = resstatus
                                    }
                                    self.performSegue(withIdentifier: "addjury2", sender: nil)
                                }
                            }
                            else {
                                 self.applytheme.isEnabled = true
                                self.present(customalert.showalert(x: "Could not create contest.Try again later."), animated: true, completion: nil)
                            }
                        }
                        else {
                            self.applytheme.isEnabled = true

                             self.present(customalert.showalert(x: "Could not create contest.Try again later."), animated: true, completion: nil)
                        }
                    }
                    else {
                        self.applytheme.isEnabled = true

                         self.present(customalert.showalert(x: "Could not create contest.Try again later."), animated: true, completion: nil)
                    }
                }
            }
           
        }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "thf", for: indexPath) as? ThemefixedcellTableViewCell {
                
                if let e = self.tobepassedtheme {
                    cell.update2(x : e, p: self.currentpostbtncolor,s : "#FE6F00" , creatingcontest : self.createmode)
                }
                return cell
            }
        }
        else {
            if currentcelltype == "one" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th1", for: indexPath) as? ThemetypeoneTableViewCell {
                    cell.themetapped = {a in
                        self.themeselected!(a)
                        self.dismiss(animated: true, completion:nil)
                    }
                    if let e = self.tobepassedtheme {
                        
               
                        
                         cell.update2(x : e, p: "#FF00FF",s : "#FFF000", creatingcontest : self.createmode, winnerpricelist: self.allwinnersexistingprices)
                    }
                    return cell
                }
            }
            
            if currentcelltype == "two" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th2", for: indexPath) as? ThemetypetwoTableViewCell {
                    cell.themetapped = {a in
                        self.themeselected!(a)
                        self.dismiss(animated: true, completion:nil)
                    }
                    if let e = self.tobepassedtheme {
                        
                        cell.update2(x : e, p: "#FF00FF",s : "#FFF000", creatingcontest : self.createmode, winnerpricelist: self.allwinnersexistingprices)
                    return cell
                }
            }
            }
            if currentcelltype == "three" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th3", for: indexPath) as? ThemetypethreeTableViewCell {
                    cell.themetapped = {a in
                        self.themeselected!(a)
                        self.dismiss(animated: true, completion:nil)
                    }
                    if let e = self.tobepassedtheme {
                         cell.update2(x : e, p: "#FF00FF",s : "#FFF000", creatingcontest : self.createmode, winnerpricelist: self.allwinnersexistingprices)
                    }
                    return cell
                }
            }
            
            
            if currentcelltype == "four" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th4", for: indexPath) as? ThemetypefourTableViewCell {
                    cell.themetapped = {a in
                        self.themeselected!(a)
                        self.dismiss(animated: true, completion:nil)
                    }
                    if let e = self.tobepassedtheme {
                         cell.update2(x : e, p: "#FF00FF",s : "#FFF000", creatingcontest : self.createmode, winnerpricelist: self.allwinnersexistingprices)
                    }
                    return cell
                }
            }
            
            if currentcelltype == "five" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th5", for: indexPath) as? ThemetypefiveTableViewCell {
                    cell.themetapped = {a in
                        self.themeselected!(a)
                        self.dismiss(animated: true, completion:nil)
                    }
                    if let e = self.tobepassedtheme {
                         cell.update2(x : e, p: "#FF00FF",s : "#FFF000", creatingcontest : self.createmode, winnerpricelist: self.allwinnersexistingprices)
                    }
                    return cell
                }
            }
            
            if currentcelltype == "six" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "th6", for: indexPath) as? ThemetypesixTableViewCell {
                    cell.themetapped = {a in
                        self.themeselected!(a)
                        self.dismiss(animated: true, completion:nil)
                    }
                    if let e = self.tobepassedtheme {
                         cell.update2(x : e, p: "#FF00FF",s : "#FFF000", creatingcontest : self.createmode, winnerpricelist: self.allwinnersexistingprices)
                    }
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            if indexPath.row == 0 {
                return 250
            }
            else {
                return 1400
            }

    }
    
    

    
    
    
    @IBAction func tandcmoretapped(_ sender: Any) {
        if self.expandtandc.constant == 60 {
            self.expandtandc.constant = 180
            self.contesttermsandcon.isHidden = false
        }
        else {
            self.expandtandc.constant = 60
            self.contesttermsandcon.isHidden = true
        }
    }
    
    
    
    @IBAction func backbtntapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? GroupsandEventsContactvc {
            seg.mode = "jury"
            seg.passedjuryid = self.juryid
            seg.groupid =  self.contestid
        }
    }
    
    

}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format : "#%06x" , rgb)
}
}
