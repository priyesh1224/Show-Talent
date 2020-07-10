//
//  DashboardViewController.swift
//  ShowTalent
//
//  Created by maraekat on 16/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire


struct searchcategory
{
    var id : Int
    var categoryname : String
    var createdon : String
    var isactive : Bool
    var categoryicon : String
    var activeby : String
    var inactiveby : String
    var inactiveon : String
    var activeon : String
    var groupname : String
    var groupid : Int
}

class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource , UISearchBarDelegate,UICollectionViewDelegateFlowLayout {
    
    
    
    var currenttutorialshowing = 1
    
    
    @IBOutlet weak var groupbtnwidth: NSLayoutConstraint!
    @IBOutlet weak var contestbtnwidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var newsearch: UIButton!
    
    @IBOutlet weak var newnotification: UIButton!
    
    
    @IBOutlet weak var newprofile: UIButton!
    
    @IBOutlet weak var try1: UIStackView!
    
    @IBOutlet weak var try2: UIView!
    
    
    @IBOutlet weak var try3: UIStackView!
    
    @IBOutlet weak var try4: UIStackView!
    
    static var categoryimageslist : Dictionary<Int,UIImage> = [ : ]
    static var trendingimageslist : Dictionary<String,UIImage> = [ : ]

    var gradients = [0:["#F956FF","#6B48FF"],1:["#FF0060","#FF4848"],2:["#5672FF","#005263"],3:["#FF0000","#2A0000"]]

    var contesttapped = false
    var searchalldata : [searchcategory] = []
    var matchedsearches : [searchcategory] = []
    
    
    var wholecategorydata : [strcategory] = []
    var wholetrendingdata : [strtrending] = []
    var wholeeventdata : [strevent] = []
    
    @IBOutlet var referfriends: UltraMinorButton!
    
    @IBOutlet var groupbtn: UltraMinorButton!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var categorytopassforseeall = ""
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    @IBOutlet weak var coinicon: UIButton!
    
    
    var selectedtrending : strtrending?
    var selectedevent : strevent?
    var selectedcategory : strcategory?
    var selectedcategory2 : searchcategory?
    @IBOutlet weak var searchpopup: UIView!
    
    var allcategories = ["Categories","Trending Wall","Events"]
    
    @IBOutlet weak var popupshowbtn: UIButton!
    
    @IBOutlet weak var popupshowbuttonrightspace: NSLayoutConstraint!
    
    
    @IBOutlet weak var jurysectionbtn: UltraMinorButton!
    
    
    @IBOutlet weak var popup: UIView!
    
    @IBOutlet weak var popupheight: NSLayoutConstraint!
    
    @IBOutlet weak var creategroupbutton: UIButton!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    @IBOutlet weak var iphone5s: UIStackView!
    
    
    var jurysectionpressed = false
    
    @IBOutlet weak var aboveiphone5s: UIStackView!
     var path = CGMutablePath()
    var pathlabel = UILabel()
    let maskLayer = CAShapeLayer()
    var overview : UIView?
    var introcount = 1
    
    override func viewWillDisappear(_ animated: Bool) {
//        DashboardViewController.categoryimageslist.removeAll()
//        DashboardViewController.trendingimageslist.removeAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !InternetCheck.isConnectedToNetwork() {
        self.present(customalert.showalert(x: "Sorry you are not connected to internet."), animated: true, completion: nil)
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        print("Hello my width is \(self.view.frame.size.width)")
        self.collection.delegate = self
        self.collection.dataSource = self
        if !InternetCheck.isConnectedToNetwork() {
            self.present(customalert.showalert(x: "Sorry you are not connected to internet."), animated: true, completion: nil)
               }
               else {
               self.collection.reloadData()
               }
        
        
      var l = UICollectionViewFlowLayout()
                       l.scrollDirection = .vertical
        l.itemSize = CGSize(width: self.collection.frame.size.width / 2.2, height: 200)
                    collection.collectionViewLayout = l
           
                   
//        if self.view.frame.size.width > 330 {
//            self.iphone5s.isHidden = true
//            self.aboveiphone5s.isHidden = false
//        }
//        else {
            self.iphone5s.isHidden = false
            self.aboveiphone5s.isHidden = true
//        }
        
        DispatchQueue.global(qos: .background).async {
//            CoreDataManager.shared.deletecrossedgroups()
        }
        
        print("popup height is \(self.view.frame.size.height/2.5)")
    if self.view.frame.size.height/2.5 < 350 {
        popupheight.constant = 350
        }
    else {
        popupheight.constant = self.view.frame.size.height/2.5
        }

        referfriends.layer.cornerRadius = 15
        referfriends.clipsToBounds = true
        groupbtn.layer.cornerRadius = 15
        groupbtn.clipsToBounds = true
        jurysectionbtn.layer.cornerRadius = 15
        jurysectionbtn.clipsToBounds = true
        var m = self.applygradient(a:  #colorLiteral(red: 0.2941176471, green: 0.3294117647, blue: 0.8235294118, alpha: 1) , b: #colorLiteral(red: 0.3333333333, green: 0.5960784314, blue: 0.9450980392, alpha: 1))
        referfriends.layer.insertSublayer(m, at: 0)
        var tim = UIImageView(frame: CGRect(x: 10, y: 6, width: 20, height: 15))
        tim.image = #imageLiteral(resourceName: "surface1")
        referfriends.addSubview(tim)
        var tx : UITextView
        var ttx : UITextView
        var ttxj : UITextView
        if self.view.frame.size.width > 330 {
            
         tx = UITextView(frame: CGRect(x: 32, y: 0, width: 60, height: 30))
            tx.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        }
        else {
             tx = UITextView(frame: CGRect(x: 22, y: 0, width: 60, height: 30))
            tx.font = UIFont(name: "NeusaNextStd-Light", size: 4)
        }
        tx.backgroundColor = UIColor.clear
        tx.isEditable = false
        tx.text = "Contests"
        
        tx.textAlignment = .right
        tx.textColor = UIColor.white
        referfriends.addSubview(tx)
        referfriends.addTarget(self, action: #selector(rfpressed), for: .touchUpInside)
        let tpg = UITapGestureRecognizer(target: self, action: #selector(rfpressed))
        tpg.numberOfTapsRequired = 1
        tpg.isEnabled = true
        tx.addGestureRecognizer(tpg)
        var n = self.applygradient(a:  #colorLiteral(red: 0.8235294118, green: 0.2941176471, blue: 0.5411764706, alpha: 1) , b: #colorLiteral(red: 0.9450980392, green: 0.3333333333, blue: 0.3333333333, alpha: 1))
        groupbtn.layer.insertSublayer(n, at: 0)
        
        
        if self.view.frame.size.width > 330 {
            
            ttx = UITextView(frame: CGRect(x: 32, y: 0, width: 60, height: 30))
            ttx.font = UIFont(name: "NeusaNextStd-Light", size: 6)
        }
        else {
            ttx = UITextView(frame: CGRect(x: 22, y: 0, width: 60, height: 30))
            ttx.font = UIFont(name: "NeusaNextStd-Light", size: 4)
        }

        ttx.backgroundColor = UIColor.clear
        ttx.isEditable = false
        ttx.text = "Groups"
        ttx.textAlignment = .right
        ttx.textColor = UIColor.white
        let tpgg = UITapGestureRecognizer(target: self, action: #selector(rfpressed2))
        tpgg.numberOfTapsRequired = 1
        tpgg.isEnabled = true
        ttx.addGestureRecognizer(tpgg)
        groupbtn.addSubview(ttx)
        var ttim = UIImageView(frame: CGRect(x: 10, y: 6, width: 22, height: 16))
          ttim.image = #imageLiteral(resourceName: "ic_group_24px-1")
          groupbtn.addSubview(ttim)
        
        var nj = self.applygradient(a:  #colorLiteral(red: 0.3137254902, green: 0.05882352941, blue: 0.5607843137, alpha: 1) , b: #colorLiteral(red: 0.4235294118, green: 0.2352941176, blue: 0.6156862745, alpha: 1))
        jurysectionbtn.layer.insertSublayer(nj, at: 0)
        
        if self.view.frame.size.width > 330 {
            
            ttxj = UITextView(frame: CGRect(x: 26, y: 0, width: 80, height: 30))
            ttxj.font = UIFont(name: "NeusaNextStd-Light", size: 5)
            ttxj.text = "Jury Section"
        }
        else {
            ttxj = UITextView(frame: CGRect(x: 18, y: 0, width: 60, height: 30))
            ttxj.font = UIFont(name: "NeusaNextStd-Light", size: 4)
            ttxj.text = "Jury"
        }
        
        ttxj.backgroundColor = UIColor.clear
        ttxj.isEditable = false
        
        ttxj.textAlignment = .right
        ttxj.textColor = UIColor.white
        let tpggg = UITapGestureRecognizer(target: self, action: #selector(rfpressed3))
        tpggg.numberOfTapsRequired = 1
        tpggg.isEnabled = true
        ttxj.addGestureRecognizer(tpggg)
                jurysectionbtn.addSubview(ttxj)
        var ttimj = UIImageView(frame: CGRect(x: 10, y: 6, width: 22, height: 16))
        ttimj.image = UIImage(named: "Group 1777")
        jurysectionbtn.addSubview(ttimj)
        
       

        searchbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchbar.layer.borderWidth = 0
        tableview.delegate = self
        tableview.dataSource = self
        popup.layer.cornerRadius = 20
        popup.alpha = 0.99
        creategroupbutton.layer.cornerRadius = 5
        
//        popupshowbtn.layer.cornerRadius = popupshowbtn.frame.size.height/2

        popup.isHidden = true
        self.searchbar.delegate = self
        self.searchpopup.isHidden = true
        if InternetCheck.isConnectedToNetwork() {
            self.actualseachdata { (st) in
                if st {
                    
                    if let v = UserDefaults.standard.value(forKey: "needtoshowdashboardtutorial") as? Bool {
                        if v {
                        self.overview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
                        self.overview?.backgroundColor = #colorLiteral(red: 0.0264734456, green: 0.0264734456, blue: 0.0264734456, alpha: 0.8351122359)

                        let tp = UITapGestureRecognizer(target: self, action: #selector(self.handleoverviewtap))
                                tp.numberOfTouchesRequired = 1
                                tp.numberOfTapsRequired = 1
                                tp.isEnabled = true
                        self.overview?.addGestureRecognizer(tp)
                        self.view.addSubview(self.overview ?? UIView())
                        self.maskLayer.backgroundColor = UIColor.white.cgColor
                        self.maskLayer.fillRule = .evenOdd
                        self.overview?.layer.mask = self.maskLayer
                        self.overview?.clipsToBounds = true
                        self.pathlabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2.4, width: self.view.frame.size.width, height: 90))
                        self.pathlabel.numberOfLines = 0
                        self.pathlabel.textAlignment = .center
                        self.pathlabel.textColor = UIColor.white
                        self.overview?.addSubview(self.pathlabel)
                        self.bringinintro(intro: self.introcount)
                        UserDefaults.standard.set(false, forKey: "needtoshowdashboardtutorial")
                        }
                    }
                }
            }
        }
        
//        self.fetchsearchdata { (done) in
//            print("Status is \(done)")
//            if (done)
//            {
//                self.collection.reloadData()
//                print("All categories are getting fetched")
//
//                    self.spinner.isHidden = true
//                    self.spinner.stopAnimating()
//
//            }
//        }
        

        
        
        
        
    }
    
    
    
    func bringinintro(intro : Int)
    {
        
       
        
                
                
               
        
        
        if intro == 1 {
            let frame = self.try1.convert(coinicon.layer.frame, to:self.view)
            
                path.addArc(center: CGPoint(x: frame.origin.x+15, y: frame.origin.y+16),
                            radius: groupbtn.frame.size.height/2 + 5,
                               startAngle: 0.0,
                               endAngle: 2.0 * .pi,
                               clockwise: false)
                path.addRect(CGRect(origin: .zero, size: overview?.frame.size ?? CGSize.zero))
                maskLayer.path = path

               
                pathlabel.text = "Click to share app among friends. \n\n\n Tap for next suggestion"
                
        }
        else if intro == 2 {
            let frame = self.try4.convert(referfriends.layer.frame, to:self.view)
                   
                   path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 6))
                   path.addRoundedRect(in: CGRect(x: frame.origin.x, y: frame.origin.y - 2, width: try3.frame.size.width/3, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)

                             maskLayer.path = path
            pathlabel.text = "Click here to view contests and create new contest. \n\n\n Tap for next suggestion"
        }
        else if intro == 3 {
            let frame = self.try4.convert(groupbtn.layer.frame, to:self.view)
                   
                   path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 8))
                   path.addRoundedRect(in: CGRect(x: frame.origin.x - 2, y: frame.origin.y - 2, width: try3.frame.size.width/3 + 4, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)

                             maskLayer.path = path
            pathlabel.text = "Click here to view groups and create new group. \n\n\n Tap for next suggestion"
        }
        else if intro == 4 {
            let frame = self.try4.convert(jurysectionbtn.layer.frame, to:self.view)
                   
                   path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 8))
                   path.addRoundedRect(in: CGRect(x: frame.origin.x - 2, y: frame.origin.y - 2, width: try3.frame.size.width/3 + 4, height: frame.size.height + 5), cornerWidth: 20, cornerHeight: frame.size.height/2)

                             maskLayer.path = path
            pathlabel.text = "Click here to view contests in which you are jury. \n\n\n Tap for next suggestion"
        }
            else if intro == 5 {
                let frame = self.iphone5s.convert(newsearch.layer.frame, to:self.view)
                       
                       path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 8))
                       path.addRoundedRect(in: CGRect(x: frame.origin.x - 2, y: frame.origin.y - 2, width: frame.size.width+12, height: frame.size.height + 5), cornerWidth: frame.size.width/2, cornerHeight: frame.size.height/2)

                                 maskLayer.path = path
                pathlabel.text = "Click here to search among categories. \n\n\n Tap for next suggestion"
            }
            else if intro == 6 {
                let frame = self.iphone5s.convert(newnotification.layer.frame, to:self.view)
                       
                       path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 8))
                       path.addRoundedRect(in: CGRect(x: frame.origin.x - 4, y: frame.origin.y - 4, width: frame.size.width+8, height: frame.size.height + 5), cornerWidth: frame.size.width/2, cornerHeight: frame.size.height/2)

                                 maskLayer.path = path
                pathlabel.text = "Click here to see all the notifications.. \n\n\n Tap for next suggestion"
            }
            else if intro == 7 {
                let frame = self.iphone5s.convert(newprofile.layer.frame, to:self.view)
                       
                       path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y - 8))
                       path.addRoundedRect(in: CGRect(x: frame.origin.x - 4, y: frame.origin.y - 4, width: frame.size.width+8, height: frame.size.height + 5), cornerWidth: frame.size.width/2, cornerHeight: frame.size.height/2)

                                 maskLayer.path = path
                pathlabel.text = "Click here to see your profile. \n\n\n Tap for next suggestion"
            }
        else {
            self.overview?.isHidden = true
        }
                
                
                

    }
    
    
    @objc func handleoverviewtap()
    {
        introcount = introcount +  1
        self.bringinintro(intro: introcount)
    }
    
    @objc func rfpressed()
    {
        print("xyz")
        jurysectionpressed = false
        if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            
            print("a")
            contesttapped = true
            performSegue(withIdentifier: "gotocontestsandgroups", sender: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func rfpressed2()
    {
        print("xyz")
        jurysectionpressed = false
        if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            
            print("b")
            contesttapped = false
            performSegue(withIdentifier: "gotocontestsandgroups", sender: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func rfpressed3()
    {
        print("xyz")
        jurysectionpressed = true
        if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            
            print("b")
            contesttapped = false
            performSegue(withIdentifier: "gotocontestsandgroups", sender: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func applygradient(a:UIColor , b:UIColor) -> CAGradientLayer
          {
              let gl = CAGradientLayer()
              gl.frame = CGRect(x: 0, y: 0, width: self.jurysectionbtn.frame.size.width * 2, height: 30)
              gl.colors = [a.cgColor,b.cgColor]
            gl.cornerRadius = 15
              return gl
          }
    
     typealias progressindata = ((_ done : Bool) -> Void)
    
    func actualseachdata(d : @escaping progressindata)
    {
        var url = Constants.K_baseUrl + Constants.dashboardfeed
        print("Dashboard Feed  \(url)")
        var r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: [:]) { (res, err) in
            if let rv = res?.result.value  as? Dictionary<String,Any>{
                
                if let jsonres = rv as?
                    Dictionary<String,AnyObject> {
                    if let results = jsonres["Results"] as? Dictionary<String,AnyObject> {
                         if let af = results["activityFeeds"] as? AnyObject {
                        }
                        var usefuldata : AnyObject?
                        for key in results.keys {
                        }
                            if let cm = results["categoryModels"] as? AnyObject {
                                usefuldata = cm
                                if self.searchalldata.count == 0 {
                                       if let ud = usefuldata!["Data"] as? AnyObject {
                                    for eachdata in ud as! [[String: AnyObject]]{
                                        if let caticon = eachdata["categoryIcon"] as? String , let catid = eachdata["CategoryId"] as? Int ,let totalact = eachdata["TotalActivity"] as? Int, let catname = eachdata["CategoryName"] as? String {
                                           
                                            var catone = searchcategory(id: catid, categoryname: catname, createdon: "", isactive: true, categoryicon: caticon, activeby: "", inactiveby: "", inactiveon:"", activeon: "", groupname: "", groupid: 0)
                                            self.searchalldata.append(catone)
                                        }

                                    }
                                }
                                }
                                
                                self.collection.reloadData()
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                d(true)
                               
                            }
                        
                        
                        
                        
                    }
                }
                
              }
            }

        
    }
    
    
    
//    func getsearchbardata()
//    {
//        var url = Constants.K_baseUrl + Constants.getCategory
//
//        print(url)
//        var r = BaseServiceClass()
//        r.getApiRequest(url: url, parameters: [:]) { (res, err) in
//            if  let rv = res?.result.value as? Dictionary<String,Any> {
//
//                    if let jsonres = rv as?
//                        Dictionary<String,AnyObject> {
//                        if let results = jsonres["Results"] as? Dictionary<String,AnyObject> {
//
//                            var usefuldata : AnyObject?
//
//
//                                if let cm = results["Data"] as? AnyObject {
//                                    usefuldata = cm
//                                    for eachdata in usefuldata as! [[String: AnyObject]]{
//
//
//
//
//                                        print("New cat \(eachdata["CategoryName"])")
//
//
//                                        var id = 0
//                                        var catname = ""
//                                        var createdon = ""
//                                        var isactive = false
//                                        var icon = ""
//                                        var activateby = ""
//                                        var inactivateby = ""
//                                        var inactiveon = ""
//                                        var activeon = ""
//                                        var groupname = ""
//                                        var groupid = 0
//
//
//
//
//                                        if let i = eachdata["ID"] as? Int {
//                                            id = i
//                                        }
//                                        if let cat = eachdata["CategoryName"] as? String{
//                                            catname = cat
//                                        }
//                                        if let crt = eachdata["CreatedOn"] as? String {
//                                            createdon = crt
//                                        }
//                                        if let ia = eachdata["IsActive"] as? Bool {
//                                            isactive = ia
//                                        }
//                                        if let icn = eachdata["CategoryIcon"] as? String {
//                                            icon = icn
//                                        }
//                                        if let acby = eachdata["ActivatBy"] as? String {
//                                            activateby = acby
//                                        }
//                                        if let icby = eachdata["InactiveBy"] as? String {
//                                            inactivateby = icby
//                                        }
//                                        if let icon = eachdata["InactiveOn"] as? String {
//                                            inactiveon = icon
//                                        }
//                                        if let acon = eachdata["ActiveOn"] as? String {
//                                            activeon = acon
//                                        }
//                                        if let gnam = eachdata["GroupName"] as? String {
//                                            groupname = gnam
//                                        }
//                                        if let giid = eachdata["GroupId"] as? Int
//                                        {
//                                                groupid = giid
//                                        }
//                                                var x = searchcategory(id: id, categoryname: catname, createdon: createdon, isactive: isactive, categoryicon: icon, activeby: activateby, inactiveby: inactivateby, inactiveon: inactiveon, activeon: activeon, groupname: groupname, groupid: groupid)
//                                                self.searchalldata.append(x)
//                                                print("Got \(self.searchalldata.count)")
//
//                                        }
//                                    self.collection.reloadData()
//                                    self.spinner.stopAnimating()
//                                    self.spinner.isHidden = true
//                                    }
//                                }
//                            }
//                        }
//
//        }
//    }
    
    
    @IBAction func searchbtnpressed(_ sender: Any) {
        self.matchedsearches = []
               self.searchpopup.isHidden = false
//               self.popupshowbtn.isHidden = true
        self.searchbar.isHidden = false
    }
    
    
    @IBAction func newsearchpressed(_ sender: Any) {
        self.matchedsearches = []
        self.searchpopup.isHidden = false
        //               self.popupshowbtn.isHidden = true
        self.searchbar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("height is \(self.collection.frame.size.height / 4)")
        
        if collectionView.tag == 10 {
            return CGSize(width: self.collection.frame.size.width / 2.2, height: 200)
        }
        
        if self.collection.frame.size.height / 4 < 180 {
            return CGSize(width: self.collection.frame.size.width/2.1, height: 180)
        }
        return CGSize(width: self.collection.frame.size.width/2.2, height: self.collection.frame.size.height / 4)
        
    }
    
    @IBAction func closesearchbarpressed(_ sender: UIButton) {
    self.searchbar.resignFirstResponder()

        self.searchpopup.isHidden = true
//        self.popupshowbtn.isHidden = false
        self.searchbar.isHidden = true

    }
    
    
    @IBAction func referfriendspressed(_ sender: UIButton) {
        jurysectionpressed = false
        if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            
            print("a")
            contesttapped = true
            performSegue(withIdentifier: "gotocontestsandgroups", sender: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    
    @IBAction func groupbtnpressed(_ sender: UIButton) {
        jurysectionpressed = false
        if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            
            print("b")
            contesttapped = false
            performSegue(withIdentifier: "gotocontestsandgroups", sender: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func jurysectionpressed(_ sender: Any) {
        jurysectionpressed = true
        if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            
            print("b")
            contesttapped = false
            performSegue(withIdentifier: "gotocontestsandgroups", sender: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar begin editing")
        self.matchedsearches = []
        self.searchpopup.isHidden = false
//        self.popupshowbtn.isHidden = true
       
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.matchedsearches = []
        if let s = searchBar.text as? String {
            self.matchedsearches = s.isEmpty ? []: self.searchalldata.filter { (item: searchcategory) -> Bool in
                return item.categoryname.lowercased().contains(s.lowercased())

            }

            self.collection.reloadData()
        }
      }
    
    

    @IBAction func popupshowbtnclicked(_ sender: UIButton) {
        popup.isHidden = !popup.isHidden
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("hello scolling")
        
        UIView.animate(withDuration: 5, animations: {
//            self.popupshowbuttonrightspace.constant = -16
            }) { (completed) in
               
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
           UIView.animate(withDuration: 5, animations: {
//            self.popupshowbuttonrightspace.constant = 16
            }) { (completed) in
               
            }
        })
        
        }
        
   
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("Returning \(self.searchalldata.count) cells")
    if self.matchedsearches.count > 0 {
        return self.matchedsearches.count
    }
    return self.searchalldata.count
   }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.matchedsearches.count > 0 {
            self.selectedcategory2 = self.matchedsearches[indexPath.row]
                    }
        else {
            self.selectedcategory2 = self.searchalldata[indexPath.row]
        }
        self.selectedcategory = nil

        
         self.performSegue(withIdentifier: "tappedcategory", sender: nil)
    }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchcell", for: indexPath) as? SearchcategoryCollectionViewCell {
        if self.matchedsearches.count > 0 {
            cell.updateview(x: self.matchedsearches[indexPath.row], a : self.gradients[indexPath.row % 4]?[0] ?? ""  , b : self.gradients[indexPath.row % 4]?[1] ?? "")
        }
        else {
            cell.updateview(x: self.searchalldata[indexPath.row], a : self.gradients[indexPath.row % 4]?[0] ?? ""  , b : self.gradients[indexPath.row % 4]?[1] ?? "")
        }
        
        return cell
    }
    return UICollectionViewCell()
   }
        
    typealias search = (_ x:Bool) -> Void
    func fetchsearchdata(y : @escaping search)
    {
      
        var url = "http://thcoreapi.maraekat.com/api/v1/Category/Get"
        
        var r  = BaseServiceClass()
        
        r.getApiRequest(url: url, parameters: ["":""]) { (res, err) in
            print(res)
            if  let rv = res!.result.value as? Dictionary<String,Any> {
                    
                    if let jsonres = rv as?
                        Dictionary<String,AnyObject> {
                        if let results = jsonres["Results"] as? Dictionary<String,AnyObject> {
                            
                            var usefuldata : AnyObject?
                            
                            
                                if let cm = results["Data"] as? AnyObject {
                                    usefuldata = cm
                                    if self.searchalldata.count == 0 {
                                    for eachdata in usefuldata as! [[String: AnyObject]]{
                                       
                                        print("--------")
                                        print(eachdata["ID"])
                                        print(eachdata["CategoryName"])
                                        print(eachdata["CategoryOn"])
                                        print(eachdata["IsActive"])
                                        print(eachdata["CategoryIcon"])
                                        print(eachdata["ActivatBy"])
                                        print(eachdata["InactiveBy"])
                                        print(eachdata["InactiveOn"])
                                        print(eachdata["ActiveOn"])
                                        print(eachdata["GroupName"])
                                        print(eachdata["GroupId"])
                                
                                        
                                        
                                        
                                            if let id = eachdata["ID"] as? Int,let catname = eachdata["CategoryName"] as? String , let createdon = eachdata["CreatedOn"] as? String, let isactive = eachdata["IsActive"] as? Bool,let icon = eachdata["CategoryIcon"] as? String,let activateby = eachdata["ActivatBy"] as? String,let inactivateby = eachdata["InactiveBy"] as? String,let inactiveon = eachdata["InactiveOn"] as? String, let activeon = eachdata["ActiveOn"] as? String,let groupname = eachdata["GroupName"] as? String,let groupid = eachdata["GroupId"] as? Int
                                            {
                                                var x = searchcategory(id: id, categoryname: catname, createdon: createdon, isactive: isactive, categoryicon: icon, activeby: activateby, inactiveby: inactivateby, inactiveon: inactiveon, activeon: activeon, groupname: groupname, groupid: groupid)
                                                self.searchalldata.append(x)
                                                print("Got \(self.searchalldata.count)")
                                            }
                                        }
                                    }
                                        y(true)
                                    }
                                    
                                }
                }
                            
                            }
        }
        
  
        
            
        }
    
        


    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
   }
    func numberOfSections(in tableView: UITableView) -> Int {
        return allcategories.count
    }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardcell", for: indexPath) as? DashboardTableViewCell{
        print("Sending \(allcategories[indexPath.section])")
        cell.updatehead(x: allcategories[indexPath.section])
        cell.selectionStyle = .none
        
        cell.isblannk = {a, b in
            if a {
                if b == "group" {
                    cell.nodataimage.isHidden = false
                    cell.collection.isHidden = true
                    cell.nodataimage.image = UIImage(named: "nogroupsplaceholder")
                }
                else if b == "contest" {
                    cell.nodataimage.isHidden = false
                    cell.collection.isHidden = true
                    cell.nodataimage.image = UIImage(named: "nocontestsplaceholder")
                }
            }
            else {
                if b == "group" {
                    cell.nodataimage.isHidden = true
                    cell.collection.isHidden = false
                    cell.nodataimage.image = UIImage(named: "nogroupsplaceholder")
                }
                else if b == "contest" {
                    cell.nodataimage.isHidden = true
                    cell.collection.isHidden = false
                    cell.nodataimage.image = UIImage(named: "nocontestsplaceholder")
                }
            }
        }
        
        
        
        cell.copytakebackevent = {a in
            self.wholeeventdata = a
        }
        cell.copytakeback = {a in
            self.wholetrendingdata = a
        }
        cell.copytakebackcategory = {a in
            self.wholecategorydata = a
        }
        
        cell.seealltappedfor = {a in
            self.categorytopassforseeall = a
            self.performSegue(withIdentifier: "seeallpressed", sender: nil)
        }
        
        cell.takeback = {a in
            self.selectedtrending = a
            
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            self.performSegue(withIdentifier: "describeit", sender: nil)
            }
        }
        
        cell.takebackevent = {a in
            self.selectedevent = a
            
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
            self.performSegue(withIdentifier: "otherevents", sender: nil)
            }
        }
        
        cell.takebackcategory = {d in
            self.selectedcategory = d
            self.selectedcategory2 = nil
            if let auth = UserDefaults.standard.value(forKey: "refid") as? String {
                
               
                self.performSegue(withIdentifier: "tappedcategory", sender: nil)
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        

        return cell;
    }
    return UITableViewCell()
   }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if(self.view.frame.size.height / 3.2 < 250) {
            return 250
        }
        return self.view.frame.size.height / 3.2
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? IndividualpostViewController {
            seg.activityid = self.selectedtrending!.activityid
        }
        if let seg = segue.destination as? SeeAllgeneralViewController {
            if self.categorytopassforseeall == "categories" {
                seg.typeoffetch = "categories"
                seg.categories = self.wholecategorydata
            }
            else if self.categorytopassforseeall == "events" {
                seg.typeoffetch = "dashboardevents"
                seg.dashboardevents = self.wholeeventdata
            }
            else if self.categorytopassforseeall == "trending" {
                seg.typeoffetch = "trendingdata"
                seg.trendingdata = self.wholetrendingdata
            }
        }
        if let seg = segue.destination as? JoinedeventsViewController {
            seg.eventid = self.selectedevent?.contestid ?? 0
        }
        if let seg = segue.destination as? CategorywisecontestsViewController {
            seg.hideit = false
            seg.categoryid = self.selectedcategory?.id ?? self.selectedcategory2?.id ?? 0
            seg.categoryname = self.selectedcategory?.categoryName.lowercased() ?? self.selectedcategory2?.categoryname.lowercased() ?? ""
        }
        if let seg = segue.destination as? GroupandEventsViewController {
            print(jurysectionpressed)
            if jurysectionpressed == true {
                seg.jurysectionpressed = true
            }
            else {
                seg.isother = self.contesttapped
            }
        }
    }

}




extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 0)
    }
}
