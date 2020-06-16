//
//  DashboardTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 16/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

struct strcategory {
    var id : Int
    var totalactivity : Int
    var categoryName : String
    var categoryicon : String
}
struct strtrending {
    var id : String
    var profileimage : String
    var profilename : String
    var thumbnail : String
    var activityid : Int
    var userid : String
    var activitypath :String
    var type : String
    var category : String
    var view : Int
    var like : Int
    var title : String
    var description :String
    var publishedon : String
    var images : [String]
    var comments : [String]
    var likebyme : String
}

struct strevent {
    var contestid : Int
    var contestname : String
    var allowcategoryid : Int
    var allowcategory : String
    var organisationallow : Bool
    var invitationtypeid : Int
    var invitationtype : String
    var entryallowed : Int
    var entrytype : String
    var entryfee : Int
    var conteststart : String
    var contestlocation : String
    var description : String
    var resulton : String
    var contestprice : String
    var contestwinnerpricetypeid : Int
    var contestpricetype : String
    var resulttypeid : Int
    var resulttype : String
    var userid : String
    var groupid : Int
    var createon : String
    var isactive : Bool
    var status : Bool
    var runningstatusid : Int
    var runningstatus : String
    var juries : [juryorwinner]
    var contestimage : String
    var termsandcondition : String
    var noofwinners : Int
    var participationpostallow : Bool = false
}


class DashboardTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    var gradients = [0:["#F956FF","#6B48FF"],1:["#FF0060","#FF4848"],2:["#5672FF","#005263"],3:["#FF0000","#2A0000"]]
    
    var category = ""
    
    var selectedcategorydata : [strcategory] = []
    var selectedtrendingdata : [strtrending] = []
    var selectedeventsdata : [strevent] = []
    
    var categorytotalcount = 0
    var trendingtotalcount = 0
    var eventtotalcount = 0
    
    
    @IBOutlet weak var nodataimage: UIImageView!
    
     var isblannk : ((_ count : Bool , _ x : String) -> ())?
    
    var seealltappedfor : ((_ x : String) -> Void)?
    
    var takeback : ((_ x : strtrending) -> Void)?
    var takebackevent : ((_ x : strevent) -> Void)?
     var takebackcategory : ((_ x : strcategory) -> Void)?
    
    var copytakeback : ((_ x : [strtrending]) -> Void)?
    var copytakebackevent : ((_ x : [strevent]) -> Void)?
     var copytakebackcategory : ((_ x : [strcategory]) -> Void)?
    
    
    var blankcat = strcategory(id:0 ,totalactivity :0 ,categoryName :"" ,categoryicon : "")
    var blanktrending = strtrending(id: "", profileimage: "", profilename: "", thumbnail: "", activityid: 0, userid: "", activitypath: "", type: "", category: "", view: 0, like: 0, title: "", description: "", publishedon: "", images: [], comments: [], likebyme: "")
    var blankevent = strevent(contestid: 0, contestname: "", allowcategoryid: 0, allowcategory: "", organisationallow: false, invitationtypeid: 0, invitationtype: "", entryallowed: 0, entrytype: "", entryfee: 0, conteststart: "", contestlocation: "", description: "", resulton: "", contestprice: "", contestwinnerpricetypeid: 0, contestpricetype: "", resulttypeid: 0, resulttype: "", userid: "", groupid: 0, createon: "", isactive: false, status: false, runningstatusid: 0, runningstatus: "", juries: [], contestimage: "", termsandcondition: "", noofwinners: 0, participationpostallow: false)
    
    
    @IBOutlet var categorylabel: UITextView!
    @IBOutlet weak var categorycount: UIButton!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fittingSize = CGSize(width: categorylabel.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * 1) / 2
        let positiveTopOffset = max(1, topOffset)
        categorylabel.contentOffset.y = -positiveTopOffset
        collection.delegate = self
        collection.dataSource = self
        self.nodataimage.isHidden =  true
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        
        
    }
    
    
    @IBAction func seeallpressed(_ sender: UIButton) {
        if self.category == "categories" {
            self.seealltappedfor!("categories")
        }
        else if self.category == "events" {
            self.seealltappedfor!("events")
        }
        else {
            self.seealltappedfor!("trending")
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(self.category == "categories") {
            return CGSize(width: self.frame.size.width/3, height: self.frame.size.height * 0.7)
        }
        else if self.category == "events" {
            return CGSize(width: self.frame.size.width/2.8, height: self.frame.size.height * 0.9)
        }
        else
        {
            return CGSize(width: self.frame.size.width/1.7, height: self.frame.size.height * 0.7)
        }
    }
    
    
    func fetchfreshcategories()
    {
        var url = Constants.K_baseUrl + Constants.freshcategories
         var r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: [:]) { (response, err) in
            if let resp = response?.result.value as? Dictionary<String,Any> {
                print(resp)
                if let rr = resp["Results"] as? Dictionary<String,Any> {
                    if let dt = rr["Data"] as? [Dictionary<String,Any>] {
                        for eachdata in dt {
                            if let caticon = eachdata["CategoryIcon"] as? String , let catid = eachdata["ID"] as? Int , let catname = eachdata["CategoryName"] as? String {
                                var catone = strcategory(id:catid ,totalactivity :0 ,categoryName :catname ,categoryicon : "http://thcoreapi.maraekat.com/\(caticon)")
                                self.selectedcategorydata.append(catone)
                            }
                        }
                        self.copytakebackcategory!(self.selectedcategorydata)
                        self.collection.reloadData()
                    }
                }
            }
        }
        
    }
    
    
    func fetchdata(y:String) {
        var url = Constants.K_baseUrl + Constants.dashboardfeed
        print("Dashboard Feed  \(url)")
        var r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: [:]) { (res, err) in
            print(res)
            if let rv = res?.result.value  as? Dictionary<String,Any>{
                
                if let jsonres = rv as?
                    Dictionary<String,AnyObject> {
                    if let results = jsonres["Results"] as? Dictionary<String,AnyObject> {
                         if let af = results["activityFeeds"] as? AnyObject {
                        }
                        var usefuldata : Dictionary<String,Any>?
                        for key in results.keys {
                        }
                        if y == "categories" {
                            if let cm = results["categoryModels"] as? Dictionary<String,Any> {
                                usefuldata = cm
                                if self.selectedcategorydata.count == 0 {
                                    if let ud = usefuldata!["Data"] as? AnyObject {
                                for eachdata in ud as! [[String: AnyObject]]{
                                    if let caticon = eachdata["categoryIcon"] as? String , let catid = eachdata["CategoryId"] as? Int ,let totalact = eachdata["TotalActivity"] as? Int, let catname = eachdata["CategoryName"] as? String {
                                        var catone = strcategory(id:catid ,totalactivity :totalact ,categoryName :catname ,categoryicon : caticon)
//                                        self.selectedcategorydata.append(catone)
                                    }

                                  }
                                }
                            }
                                self.copytakebackcategory!(self.selectedcategorydata)
                                self.collection.reloadData()
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                               
                            }
                        }
                        else if y == "trending wall" {
                            if let af = results["activityFeeds"] as? Dictionary<String,Any> {
                                usefuldata = af
                                if self.selectedtrendingdata.count == 0 {
                                    if let ud = af["Data"] as? [Dictionary<String,Any>] {
                                    
                                for eachdata in ud {
                                    var allimages = eachdata["images"] as? [String] ?? []
                                    var allcomments = eachdata["allcomments"] as? [String] ?? []
                                    var likedbyme = eachdata["likebyme"] as? String ?? ""
                                    
                                    if let id = eachdata["Id"] as? String
                                    {
                                        if let proimg = eachdata["ProfileImg"] as? String
                                        {
                                            if let proname = eachdata["ProfileName"] as? String{
                                                
                                                if let tmb = eachdata["thumbnail"] as? String{
                                                    if let actid = eachdata["ActivityId"] as? Int {
                                                        
                                                        if let uid = eachdata["UserId"] as? String {
                                                            
                                                            if let actpath = eachdata["ActivityPath"] as? String{
                                                                
                                                                if let type = eachdata["Type"] as? String {
                                                                    if let categor = eachdata["Category"] as? String {
                                                                        
                                                                        if let view = eachdata["View"] as? Int {
                                                                            
                                                                            if let like = eachdata["Like"] as? Int {
                                                                                
                                                                                if let title = eachdata["Title"] as? String {
                                                                                    if let desc = eachdata["Description"] as? String {
                                                                                        
                                                                                    if let publish = eachdata["PublishOn"] as? String{
                                        var ctrensing = strtrending(id: id, profileimage: proimg, profilename: proname, thumbnail: tmb, activityid: actid, userid: uid, activitypath: actpath, type: type, category: categor, view: view, like: like, title: title, description: desc, publishedon: publish, images: allimages, comments: allcomments, likebyme: likedbyme)
                                                self.selectedtrendingdata.append(ctrensing)
                                 
                                        }
                                                                                    }}}}}}}}}}}}}
                                }
                                    }
                                
                            }
                                self.copytakeback!(self.selectedtrendingdata)
                                 DispatchQueue.main.async {
                                self.collection.reloadData()
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                }
                            }
                        }
                        
                        
                    }
                }
                
              }
            }

        
    }
    
    
    
    
    func fetchevents()
    {
        if let u = UserDefaults.standard.value(forKey: "refid") as? String {}else {return }
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        if let u = userid as? String {}else {return }

        var url = Constants.K_baseUrl + Constants.getevents
        var addon = "?userid=\(userid)&contestStatus=2&invitationType=0&categoryId=0&contestTheme=0&performanceId=0&gender=0&entryfeetype=0&isActive=true"
        var allu = "\(url)\(addon)"
        var params : Dictionary<String,Any> = ["Page": 0,"PageSize": 10,"contestStatus":2,"contestType": 0 ,"userid":"\(userid)"]
        print(params)
        var r = BaseServiceClass()
        r.postApiRequest(url: allu, parameters: params) { (response, err) in
            print("Response")
            print(response)
            if let resv = response?.result.value as? Dictionary<String,Any> {
                if let resps = resv["ResponseStatus"] as? Int {
                    if resps == 1 {
                        print("Error")
                    }
                    else {
                        if let results = resv["Results"] as? Dictionary<String,Any> {
                            if let tc = results["Total"] as? Int {
                                self.categorycount.setTitle("See all", for: .normal)
                            }
                            if let data = results["Data"] as? [Dictionary<String,Any>] {
                                if self.selectedeventsdata.count == 0 {
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
                                    if let cn = each["RunningStatus"] as? [juryorwinner] {
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
                                        runningstatusid = cn
                                    }
                                    
                                    var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                                    
                                    self.selectedeventsdata.append(x)
                              
                                }
                                    
                                
                                self.copytakebackevent!(self.selectedeventsdata)
                                    
                                     DispatchQueue.main.async {
                                        self.spinner.isHidden = true
                                        self.spinner.stopAnimating()
                                        
                                            if let r = self.selectedeventsdata.count as? Int {
                                                print("hola \(r)")
                                                if r  == 0 {
                                                    self.isblannk!(true,"contest")
                                                }
                                                else {
                                                    self.isblannk!(false,"contest")
                                                    self.collection.reloadData()
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
    
    
    
    func fetchcategorydata(y:String) {
        var headers = Dictionary<String,String>()
      
        var url = "http://thcoreapi.maraekat.com/api/v1/Dashboard/DashboardFeed"
        
        Alamofire.request(url, method: .get, parameters: [:], encoding:URLEncoding.default , headers: headers).responseJSON { (res) in
            print(res)
            let rv = res.result.value
            
            if let jsonres = rv as?
                Dictionary<String,AnyObject> {
                if let results = jsonres["Results"] as? Dictionary<String,AnyObject> {
                     if let af = results["activityFeeds"] as? AnyObject {
                    }
                    var usefuldata : AnyObject?
                    for key in results.keys {
                    }
                    if y == "categories" {
                        if let cm = results["categoryModels"] as? AnyObject {
                            usefuldata = cm
                            if self.selectedcategorydata.count == 0 {
                            for eachdata in usefuldata as! [[String: AnyObject]]{
                                if let caticon = eachdata["categoryIcon"] as? String , let catid = eachdata["CategoryId"] as? Int ,let totalact = eachdata["TotalActivity"] as? Int, let catname = eachdata["CategoryName"] as? String {
                                    var catone = strcategory(id:catid ,totalactivity :totalact ,categoryName :catname ,categoryicon : caticon)
                                    self.selectedcategorydata.append(catone)
                                }

                            }
                        }
                            self.collection.reloadData()
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                           
                        }
                    }
                    else if y == "trending wall" {
                        if let af = results["activityFeeds"] as? AnyObject {
                            usefuldata = af
                            if self.selectedtrendingdata.count == 0 {
                            for eachdata in usefuldata as! [[String: AnyObject]]{
                                var allimages = eachdata["images"] as? [String] ?? []
                                var allcomments = eachdata["allcomments"] as? [String] ?? []
                                var likedbyme = eachdata["likebyme"] as? String ?? ""
                                
                                if let id = eachdata["Id"] as? String
                                {
                                    if let proimg = eachdata["ProfileImg"] as? String
                                    {
                                        if let proname = eachdata["ProfileName"] as? String{
                                            
                                            if let tmb = eachdata["thumbnail"] as? String{
                                                if let actid = eachdata["ActivityId"] as? Int {
                                                    
                                                    if let uid = eachdata["UserId"] as? String {
                                                        
                                                        if let actpath = eachdata["ActivityPath"] as? String{
                                                            
                                                            if let type = eachdata["Type"] as? String {
                                                                if let categor = eachdata["Category"] as? String {
                                                                    
                                                                    if let view = eachdata["View"] as? Int {
                                                                        
                                                                        if let like = eachdata["Like"] as? Int {
                                                                            
                                                                            if let title = eachdata["Title"] as? String {
                                                                                if let desc = eachdata["Description"] as? String {
                                                                                    
                                                                                if let publish = eachdata["PublishOn"] as? String{
                                    var ctrensing = strtrending(id: id, profileimage: proimg, profilename: proname, thumbnail: tmb, activityid: actid, userid: uid, activitypath: actpath, type: type, category: categor, view: view, like: like, title: title, description: desc, publishedon: publish, images: allimages, comments: allcomments, likebyme: likedbyme)
                                            self.selectedtrendingdata.append(ctrensing)
                                    }
                                                                                }}}}}}}}}}}}}
                            }
                        }
                            DispatchQueue.main.async {
     
                            self.collection.reloadData()
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                                
                            }
                        }
                    }
                    
                    
                }
            }
        }
  
        
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
    func updatehead(x:String)
    {
        print("Cat is \(x)")
        
        if x == "Trending Wall" {
            self.categorycount.isHidden = true
        }
      
        self.category = x.lowercased()
        if self.category  == "categories"
        {
            DispatchQueue.global(qos: .utility).async {
                self.fetchfreshcategories()
            }
            
        }
        print("Passed \(x)")
        self.categorylabel.text = "\(x)"
        
        if x == "Events" {
            DispatchQueue.global(qos: .utility).async {
                self.fetchevents()
            }
            
        }
        else {
            DispatchQueue.global(qos: .utility).async {
                self.fetchdata(y: "\(x.lowercased())")
            }
           
        }

     

    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.category == "categories" {
            return self.selectedcategorydata.count
        }
        else if self.category == "events" || self.category == "Events" {
            print("Events turn \(self.selectedeventsdata.count)")
            return self.selectedeventsdata.count
        }
        else {
            return self.selectedtrendingdata.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardcollection", for: indexPath) as? DashboardCollectionViewCell {
            print("Cate is \(self.category)")
            if(self.category == "categories")
            {
                var fc = self.gradients[indexPath.row%4]![0]
                var sc = self.gradients[indexPath.row%4]![1]
               
                cell.updatebanner(c : self.category,x : self.selectedcategorydata[indexPath.row],y:blanktrending,z:blankevent,a:hexStringToUIColor(hex: fc),b:hexStringToUIColor(hex: sc) , number : indexPath.row)
            }
            else if self.category == "events" || self.category == "Events" {
                print("Events turn \(self.category) \(self.selectedeventsdata[indexPath.row])")
                cell.updatebanner(c : self.category,x:blankcat,y:blanktrending,z : self.selectedeventsdata[indexPath.row],a:UIColor.black,b:UIColor.white , number : indexPath.row)
            }
            else
            {
                cell.updatebanner(c : self.category,x:blankcat,y : self.selectedtrendingdata[indexPath.row],z:blankevent,a:UIColor.black,b:UIColor.white , number : indexPath.row)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.category == "categories" {
            self.takebackcategory!(self.selectedcategorydata[indexPath.row])
        }
        else if self.category == "events" {
            self.takebackevent!(self.selectedeventsdata[indexPath.row])
        }
        else {
            self.takeback!(self.selectedtrendingdata[indexPath.row])
        }
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
