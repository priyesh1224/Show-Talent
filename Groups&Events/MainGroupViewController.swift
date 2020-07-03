//
//  MainGroupViewController.swift
//  ShowTalent
//
//  Created by maraekat on 22/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

struct groupmember
{
    var id : Int
    var name : String
    var profileimage : String
    var userid : String
}


struct obtainhere
{
    var groupid : Int
    var groupname : String
    var ref : Int
    var belongto : String
    var createdon : String
    var otherbelong : String
    var youare : String
    var members : [groupmember]
    var totalmembers : Int
    var groupimage : String
    var creator : groupmember
    var isVerify : Bool = false
    
}

struct grouppost
{
    var id : String
    var activityid : Int
    var posttype : String
    var refguide : String
    var postpath : String
    var description : String
    var createon : String
    var refgroupid : Int
    var profileimage : String
    var profilename : String
    var usertype : String
    var contestid : Int
    var contestname : String
    var contestimage : String
    var activitytype : Int
    var thumbnail : String
    var contestentrytype : String
    
}




class MainGroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{ 
   
    var passedgroup : groupcreated?
    
    var passedgroup2 : groupevent?
    
    var allgroupfeeds : [grouppost] = []
    
    @IBOutlet weak var bannerimageheight: NSLayoutConstraint!
    @IBOutlet weak var textmessage: UITextField!
    @IBOutlet weak var downloadtract: Customlabel!
    @IBOutlet weak var groupname: UILabel!
    
    @IBOutlet weak var groupadmin: UITextView!
    
    @IBOutlet weak var groupverifiedview: UIView!
    
    @IBOutlet weak var notificationindicator: UIView!
    
    static var takecount : ((_ x : Int) -> Void)?
    
    
    var currshareevent : grouppost?
    
    static var holder : Dictionary<String,UIImage> = [:]
    var isseguedevent = false
    var seguedeventid = 0
    
    var uploadtype = ""
    var isnewevent = false
    var currentinfo : obtainhere?
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var editbtn: UIButton!
    var imgtypes : [String] = []
    @IBOutlet weak var bannerimage: UIImageView!
    var pc : UIImagePickerController?
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupview()
        self.getgroupinfo()
        self.getgroupposts(pg : 0)


        
//        CoreDataManager.shared.resetAllRecords()
        print("Received Group------------------------")
        print(self.passedgroup2)
    
        if let group = self.passedgroup as? groupcreated {
            groupname.text = group.groupname.capitalized
            if let u = group.groupimage as? String {
                if u != "" && u != " " {
                    self.downloadimage(url: u) { (im) in
                        self.bannerimage.image = im
                    }
                }
            }
        }
        else if let group2 = self.passedgroup2 as? groupevent {
            groupname.text = group2.groupname.capitalized
            if let u = group2.groupimage as? String {
                if u != "" && u != " " {
                    self.downloadimage(url: u) { (im) in
                        self.bannerimage.image = im
                    }
                }
            }
        }
       
        
        pc = UIImagePickerController()
        pc?.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pc?.allowsEditing = true
        pc?.mediaTypes = ["public.image"]
        pc?.sourceType = .photoLibrary

        
    }
    
    func getgroupposts(pg : Int)
    {
        if pg == 0 {
            self.allgroupfeeds = []
        }
        
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
        var id = 0
        if isseguedevent {
            id = seguedeventid
        }
        
        else if let g = self.passedgroup as? groupcreated {
            id = g.groupid
        }
        else if let g = self.passedgroup2 as? groupevent {
            id = g.groupid
        }
        var params : Dictionary<String,Any> = ["Page": 0,
        "PageSize": 10]
        var url = "\(Constants.K_baseUrl)\(Constants.groupfeeds)/\(id)"
        print(url)
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let resv = res["Results"] as? [Dictionary<String,Any>] {
                    for each in resv {
                        var id  = ""
                        var activityid = 0
                        var posttype = ""
                        var refguide = ""
                        var postpath = ""
                        var description = ""
                        var createon = ""
                        var refgroupid = 0
                        var profileimage = ""
                        var profilename = ""
                        var usertype = ""
                        
                        var ccontestid = 0
                        var ccontestname = ""
                        var ccontestimage = ""
                        var acttype = 0
                        var thumb = ""
                        var contestentrytype = ""
                        
                        if let r = each["ProfileName"] as? String {
                            profilename = r
                        }
                        if let r = each["RefGuid"] as? String {
                            refguide = r
                        }
                        if let r = each["Description"] as? String {
                            description = r
                        }
                        if let r = each["ProfileImg"] as? String {
                            profileimage = r
                        }
                        if let r = each["RefGroupId"] as? Int {
                            refgroupid = r
                        }
                        if let r = each["Usertype"] as? String {
                            usertype = r
                        }
                        if let r = each["PostType"] as? String {
                            posttype = r
                        }
                        if let r = each["PostPath"] as? String {
                            postpath = r
                        }
                        if let r = each["ActivityId"] as? Int {
                            activityid = r
                        }
                        if let r = each["CreateOn"] as? String {
                            createon = r
                        }
                        if let r = each["ID"] as? String {
                            id = r
                        }
                        if let r = each["ContestId"] as? Int {
                            ccontestid = r
                        }
                        if let r = each["ContestName"] as? String {
                            ccontestname = r
                        }
                        if let r = each["ContestImage"] as? String {
                            ccontestimage = r
                        }
                        if let r = each["ActivityType"] as? Int {
                            acttype = r
                        }
                        if let r = each["Thumbnail"] as? String {
                            thumb = r
                        }
                        if let r = each["ContestEntryType"] as? String {
                            contestentrytype = r
                        }
                        var x = grouppost(id: id, activityid: activityid, posttype: posttype, refguide: refguide, postpath: postpath, description: description, createon: createon, refgroupid: refgroupid, profileimage: profileimage, profilename: profilename, usertype: usertype, contestid: ccontestid, contestname: ccontestname , contestimage: ccontestimage, activitytype: acttype,thumbnail: thumb,contestentrytype: contestentrytype)
                        self.allgroupfeeds.append(x)
                    }
                    
                    self.table.reloadData()
                }
                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")

            }
        }
    }
    
    
    
   
    func getgroupinfo()
    {
        var id = 0
        if isseguedevent {
            id = seguedeventid
        }
        else if let g = self.passedgroup as? groupcreated {
            print("Hola")
            print(g)
            id = g.groupid
        }
        else if let g = self.passedgroup2 as? groupevent {
            print("Why")
            print(g)
            id = g.groupid
        }
        let url = Constants.K_baseUrl + Constants.fetchfurthergroupinfo
        var params : Dictionary<String,Any> = ["userId":UserDefaults.standard.value(forKey: "refid")! , "groupId" : id]
        
        print(params)
        var r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: params) { (response, err) in
            if let dv = response?.result.value as? Dictionary<String,AnyObject> {
                if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                    var groupid = 0
                    var groupname = ""
                    var ref  = 0
                    var belongto = ""
                    var createdon = ""
                    var otherbelong = ""
                    var youare  = ""
                    var members : [groupmember] = []
                    var totalmembers = 0
                    var groupimage = ""
                    var creator = ""
                    var isverify = false
                    if let g = inv["GroupName"] as? String {
                                                           groupname = g
                                                       }
                                                       if let g = inv["GroupImage"] as? String {
                                                           groupimage = g
                                                       }
                                                       if let g = inv["BelongTo"] as? String {
                                                           belongto = g
                                                       }
                                                       if let g = inv["CreatedOn"] as? String {
                                                           createdon = g
                                                       }
                                                       if let g = inv["YouAre"] as? String {
                                                           youare = g
                                                       }
                                                       if let g = inv["OtherBelong"] as? String {
                                                           otherbelong = g
                                                       }
                                                       if let g = inv["GroupID"] as? Int {
                                                           groupid = g
                                                       }
                                                       if let g = inv["Ref_BelongGroup"] as? Int {
                                                           ref = g
                                                       }
                    if let g = inv["IsVerify"] as? Bool {
                        isverify = g
                    }
                    
                    if let g = inv["Ref_UserId"] as? String {
                        creator = g
                    }
                    
                    if let g = inv["Members"] as? [Dictionary<String,Any>] {
                        for each in g  {
                            var id = 0
                            var name = ""
                            var profileimage = ""
                            var userid = ""
                            
                            if let i = each["ID"] as? Int {
                                id = i
                            }
                            if let i = each["Name"] as? String {
                                name = i
                            }
                            if let i = each["ProfileImage"] as? String {
                                profileimage = i
                            }
                            if let i = each["UserId"] as? String {
                                userid = i
                            }
                            members.append(groupmember(id: id, name: name, profileimage: profileimage, userid: userid))
                        }
                    }
                    
                    var grpcreator = groupmember(id: 0, name: "", profileimage: "", userid: "")
                    if let g = inv["Creator"] as? Dictionary<String,Any> {
                                                var id = 0
                                                   var name = ""
                                                   var profileimage = ""
                                                   var userid = ""
                                                   
                                                   if let i = g["ID"] as? Int {
                                                       id = i
                                                   }
                                                   if let i = g["Name"] as? String {
                                                       name = i
                                                   }
                                                   if let i = g["Profile"] as? String {
                                                       profileimage = i
                                                   }
                                                   if let i = g["UserID"] as? String {
                                                       userid = i
                                                   }
                        grpcreator = groupmember(id: id, name: name, profileimage: profileimage, userid: userid)
                    }
                    
                    if let g = inv["TotalMembers"] as? Int {
                        totalmembers = g
                    }
                    
                    self.currentinfo = obtainhere(groupid: groupid, groupname: groupname, ref: ref, belongto: belongto, createdon: createdon, otherbelong: otherbelong, youare: youare, members: members, totalmembers: totalmembers, groupimage: groupimage, creator: grpcreator , isVerify: isverify)
                    self.groupname.text = groupname.capitalized
                    self.downloadimage(url: groupimage) { (im) in
                        if let i = im as? UIImage{
                            self.bannerimage.image = im
                        }
                    }
                    print("H337777777777777777777777777")
                    print(self.currentinfo)
                    var uid = UserDefaults.standard.value(forKey: "refid") as! String
                           if uid == creator {
//                               self.editbtn.isHidden = false
                               
                           }
                           else {
//                               self.editbtn.isHidden = true
                              
                           }

                    if let d = self.currentinfo as? obtainhere {
                        self.groupadmin.text = "Group Admin : \(d.creator.name.capitalized)"
                        self.table.reloadData()
                    }
                    
                }
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
    
    
    @IBAction func editbuttonpressed(_ sender: Any) {
        self.present(self.pc!, animated: true, completion: nil)
    }
    
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
        
        
        if let image = info[.editedImage] as? UIImage {
          self.bannerimage.image = image
            self.updategroupicon()
           self.dismiss(animated: true, completion: nil)
            
            
        }
        else
        {
            print("Upload failed")
        }
        
        
    }
    
    
    
    
    func posttextmessage(m:String)
    {
        var gid = 0
        if let g = self.passedgroup as? groupcreated {
            gid = g.groupid
        }
        else if let g = self.passedgroup2 as? groupevent {
            gid = g.groupid
        }
        
        let useid = UserDefaults.standard.value(forKey: "refid") as! String
        
        var url = Constants.K_baseUrl + Constants.grouppost
        var r = ImageUploadRequest()
        
        var params : Dictionary<String,Any> = ["PostType" : "Text","PostDesc":m,"GroupId":gid]
        print(params)
        r.uploadnewgrouppost(imagesdata: [], params: params, extensiontype: []) { (response, err) in
            print("Check")
            print(response)
            if let r = response as? Bool {
                if r {
                    if let c =  self.table.cellForRow(at: IndexPath(row: 0, section: 0)) as? MaingroupStaticTableViewCell {
                        c.textfieldmessage.text = ""
                        self.getgroupposts(pg : 0)
                        c.postbtn.isEnabled = true

                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    func updategroupicon()
    {
        var gid = 0
               if let g = self.passedgroup as? groupcreated {
                   gid = g.groupid
               }
               else if let g = self.passedgroup2 as? groupevent {
                   gid = g.groupid
               }
        let r  = ImageUploadRequest()
        var params : Dictionary<String,Int> = ["groupId":gid]
        self.downloadtract.isHidden = false
        r.sendprogress = {a in
            self.downloadtract.text = "\(a.fractionCompleted * 100) % completed"
            if a.fractionCompleted == 1.0 {
                self.downloadtract.isHidden = true
            }
            print(a.fractionCompleted)
        }
        r.uploadgroupIcon(imagesdata: [self.bannerimage.image!], params: params, extensiontype:self.imgtypes) { (d, e) in
            
        }
    }
    
    
    
    
    
    
    
    
    
    func setupview()
    {
        notificationindicator.layer.cornerRadius = 10
//        bannerimage.layer.cornerRadius = 20
        editbtn.layer.cornerRadius = 7
        let rectShape = CAShapeLayer()
               rectShape.bounds = self.bannerimage.frame
               rectShape.position = self.bannerimage.center
        var newrect = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: self.bannerimage.bounds.height)
        rectShape.path = UIBezierPath(roundedRect: newrect, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 25, height: 25)).cgPath
               self.bannerimage.layer.mask = rectShape
    }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createeventpressed(_ sender: UIButton) {
        performSegue(withIdentifier: "modified", sender: nil)
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return self.allgroupfeeds.count
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "maingroupstatic", for: indexPath) as? MaingroupStaticTableViewCell  {
                
                cell.deletegroup = {a in
                    if a {
                        let alert = UIAlertController(title: "Leave Group", message: "Are you sure you want to leave this group ?", preferredStyle: .actionSheet)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                            
                            var r  = BaseServiceClass()
                            if let g = self.currentinfo as? obtainhere  {
                                var uid = UserDefaults.standard.value(forKey: "refid")!
                                var params : Dictionary<String,Any> = ["GroupId" : g.groupid , "UserId" : uid]
                                var url = Constants.K_baseUrl + Constants.leavegroup
                                r.postApiRequest(url: url, parameters: params) { (response, err) in
                                    if let res = response?.result.value as? Dictionary<String,Any> {
                                        print(res)
                                        if let code = res["ResponseStatus"] as? Int {
                                            if code == 0 {
                                                let alert2 = UIAlertController(title: "Group Deleted", message: "", preferredStyle: .actionSheet)
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
                            }
                            
                            
                        }));
                        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                if let g = self.currentinfo as? obtainhere  {
                    cell.updatecell(d: g)
                }
                cell.showallmembers = {a in
                    self.performSegue(withIdentifier: "showmem", sender: nil)
                }
                cell.sendbacktype = {a in
                    if a == "Audio" {
                        self.performSegue(withIdentifier: "taketoaudio", sender: nil)
                    }
                    else {
                        self.uploadtype = a
                        self.performSegue(withIdentifier: "uploadcontent", sender: nil)
                    }
                }
                
                cell.postmessage = {a in
                    self.posttextmessage(m: a)
                    
                }
                
                cell.invitemembers = {a in
                    self.performSegue(withIdentifier: "invitemem", sender: nil)
                }
                
                cell.showallevents = {a in
                    if a {
                    self.isnewevent = a
                    self.performSegue(withIdentifier: "modified", sender: nil)
                    }
                    else {
                        self.isnewevent = false
                        self.performSegue(withIdentifier: "letscreateevent", sender: nil)
                    }
                }
                return cell
            }
        }
        else {
            
            if self.allgroupfeeds[indexPath.row].posttype.lowercased() == "share" {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "categorywisecontest", for: indexPath) as? CategorywiseeventsTableViewCell {
                    cell.sendbackdata2 = { a in
                        print("Got here")
                        self.currshareevent = a 
                        self.performSegue(withIdentifier: "take2", sender: nil)
                    }
                    cell.updatecell2(x: self.allgroupfeeds[indexPath.row])
                }
                
            }
            else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "maingroupdynamic", for: indexPath) as? MainGroupDynamicTableViewCell {
                    cell.updatecell(x : self.allgroupfeeds[indexPath.row])
                    return cell
                }
            }
            

        }
        return UITableViewCell()
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if(self.view.frame.size.height/3 < 400) {
                return 400
            }
            return self.view.frame.size.height/2.8
        }
        else {
            if self.allgroupfeeds[indexPath.row].posttype == "Text" {
                var tc = self.allgroupfeeds[indexPath.row].description.count
                var nl = CGFloat(tc/55)
                if nl < 1 {
                    nl = 1.5
                }
                return (50.0 * nl + 70)
            }
            else if self.allgroupfeeds[indexPath.row].posttype == "Audio" {
               
                return (280)
            }
            if(self.view.frame.size.height/3 < 280) {
                return (280 + CGFloat(self.allgroupfeeds[indexPath.row].description.count / 55 * 50) + 70)
            }
            return (self.view.frame.size.height/3 + CGFloat(self.allgroupfeeds[indexPath.row].description.count / 55 * 50) + 70)
        }
        return 60
    }
    
    @IBAction func editbtnpressed(_ sender: UIButton) {
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let s = segue.destination as? GroupNewPostViewController {
            
            s.notifysuccess = { a in
                if a {
                    self.getgroupposts(pg: 0)
                }
            }
            
            
            s.type = self.uploadtype
            if let p = self.passedgroup as? groupcreated {
                s.groupid = p.groupid
                s.gn = p.groupname
            }
            else if let p = self.passedgroup2 as? groupevent {
                s.groupid = p.groupid
                s.gn = p.groupname
            }
            
        }
        if let seg = segue.destination as? JoinedeventsViewController {
            seg.eventid = self.currshareevent?.contestid ?? 0
        }
        if let s = segue.destination as? ShowAllinviteesViewController {
            s.passbackupdatedcount = {a in
                MainGroupViewController.takecount!(a)
            }
            s.groupcreator = self.currentinfo?.creator.userid ?? ""
            if let p = self.passedgroup as? groupcreated {
                s.groupid = p.groupid
            }
            else if let p = self.passedgroup2 as? groupevent {
                s.groupid = p.groupid
            }
        }
        
        if let s  = segue.destination as? EventDetailsfeedViewController {
            s.isnewevent = self.isnewevent
             if let f = self.passedgroup as? groupcreated {
                           s.groupid = f.groupid
                       }
                       else if let f = self.passedgroup2 as? groupevent {
         
                           s.groupid = f.groupid
                       }
        }
        
        if let s  = segue.destination as? ModifiedcontestcreateViewController {
            if let f = self.passedgroup as? groupcreated {
                s.groupid = f.groupid
            }
            else if let f = self.passedgroup2 as? groupevent {
                
                s.groupid = f.groupid
            }
        }
        
        if let s  = segue.destination as? AudioUploadViewController {
           s.groupmode = true
            if let f = self.passedgroup as? groupcreated {
                s.groupid = f.groupid
            }
            else if let f = self.passedgroup2 as? groupevent {
                
                s.groupid = f.groupid
            }
            
        }
        
        if let s = segue.destination as? GroupsandEventsContactvc {
            print("Moving to contacts")
            print(self.passedgroup)
            print(self.passedgroup2)
            s.mode = "invite"
            s.members = self.currentinfo?.members ?? []
            
            s.ischangedsomething = {a in
                if a {
                    self.getgroupinfo()
                    self.present(customalert.showalert(x: "Participants Added !"), animated: true, completion: nil)
                }
            }
            
            
            if let f = self.passedgroup as? groupcreated {
                print("passing Hola")
                print(f)
                s.groupid = f.groupid
                s.passedgroup = f
            }
            else if let f = self.passedgroup2 as? groupevent {
                print("passing Why")
                print(f)
                s.groupid = f.groupid
                var x = groupcreated(groupid: f.groupid, groupname: f.groupname, ref: f.ref_belongto, refuserid: f.group_belong, createdon: f.createdon, isDelete: false, otherbelong: "", youare: f.youare, groupimage: f.groupimage)
                s.passedgroup = x
            }
            
        }
    }
    
    

}
