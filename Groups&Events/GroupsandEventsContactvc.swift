//
//  GroupsandEventsContactvc.swift
//  ShowTalent
//
//  Created by maraekat on 22/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Contacts


struct customcontact
{
    var name: String
    var lastname : String
    var userimage : String?
    var profession : String
    var number : [String]?
    var countrycode : String
    var type : String
    var refid : String
    var profileimage : String
    var profilename : String
    var alreadyshared : Bool = false
}

struct customcontactcoredata
{
    var name: String
    var lastname : String
    var userimage : Data?
    var profession : String
    var number : [String]?
    var countrycode : String
    var type : String
}


class GroupsandEventsContactvc: UIViewController , UITableViewDelegate,UITableViewDataSource {
   
    var groupid = 9
    
    var mode = "jury"
    
    var juryeditmode = "new"
    @IBOutlet weak var upperimage: UIImageView!
    
    @IBOutlet weak var upperimageheight: NSLayoutConstraint!
    
    
     var passedgroup : groupcreated?
    var talentcontacts : [customcontact] = []
    var phonecontacts : [customcontact] = []
    
    var receivedallselectedcontacts : [othertalentcontact]?
    
    var addtogroupcontacts : [customcontact] = []
    
    @IBOutlet weak var invitepopup: UIView!
    
    @IBOutlet weak var invitepopuplabel: UILabel!
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var table1: UITableView!
    
    @IBOutlet weak var table2: UITableView!
    
    @IBOutlet weak var grouoname: Customlabel!
    
    var members : [groupmember] = []
    
    var passedjuryid = 0
    
    typealias sendcontacts = (_ alllist: [customcontactcoredata]?, _ err : Error?) -> Void
    
    var ischangedsomething : ((_ changed : Bool) -> ())?
    var juryupdated : ((_ changed : Bool) -> ())?

    @IBOutlet weak var showothercontactbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table1.delegate = self
        table1.dataSource = self
        table2.delegate = self
        table2.dataSource = self
        table2.isHidden = true
        print("On enter got")
        print("Passed jury id is \(self.passedjuryid)")
        print(self.passedgroup)
        self.invitepopup.isHidden = true
        self.invitepopup.layer.cornerRadius = 20
        self.notificationindicator.layer.cornerRadius = 10
        fetchcontacts()
        if self.mode == "jury" {
            self.grouoname.text = "Add Jury"
            self.upperimage.image = UIImage(named: "jry1")
            self.upperimageheight.constant = self.view.frame.size.height/3
        }
        if self.mode == "participants" {
            self.grouoname.text = "Add Participants"
            self.upperimageheight.constant = 0
        }
        else if self.mode == "invite"{
            self.grouoname.text = "Invite Members"
            self.upperimageheight.constant = 0
            print("Members")
            print(members)
            print("Talent Contacts")
            print(self.talentcontacts)
            
            
        }
       
    }
    
    
    @IBAction func uploadallcontacts(_ sender: UIButton) {
        
        if self.mode == "jury" && self.juryeditmode == "new" {
            self.addjury()
        }
        else if self.mode == "jury" && self.juryeditmode == "edit" {
            self.editjury()
        }
        else if self.mode == "participants" {
            self.addparticipants()
        }
        else if self.mode == "invite"
        {
            if self.addtogroupcontacts.count > 0 {
                var allinfos : [Dictionary<String,String>] = []
                for all in self.addtogroupcontacts {
                    allinfos.append(["Contact" : all.number![0],"FirstName" : all.name , "LastName" : all.lastname])
                    
                }
                var r = BaseServiceClass()
                var url = Constants.K_baseUrl + Constants.addpeople
                var params : Dictionary<String,Any> = ["GroupId" : self.groupid , "Contact" : allinfos]
                print(params)
                
                r.postApiRequest(url: url, parameters: params) { (response, error) in
                    if let resv = (response?.result.value) as? Dictionary<String,AnyObject> {
                        if let code = resv["ResponseStatus"] as? Int {
                            if code == 0 {
                                print("Hurrah ")
                                self.ischangedsomething?(true)
                                self.dismiss(animated: true, completion: nil)
                            }
                            else {
                                self.present(customalert.showalert(x: "Error adding users.Please try again !"), animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    
    @IBAction func showothercontacttapped(_ sender: Any) {
        performSegue(withIdentifier: "showother", sender: nil)
    }
    
    
    
    func addparticipants()
    {
        print("---------------------------------------------------------------")
        if self.addtogroupcontacts.count > 0 {
            var allinfos : [Dictionary<String,String>] = []
            for all in self.addtogroupcontacts {
                allinfos.append(["Contact" : all.number![0],"FirstName" : all.name , "LastName" : all.lastname])
                
            }
            var r = BaseServiceClass()
            var url = Constants.K_baseUrl + Constants.addparticipants
            var params : Dictionary<String,Any> = ["GroupId" : self.groupid , "Contact" : allinfos]
            print(params)
            
            r.postApiRequest(url: url, parameters: params) { (response, error) in
                if let resv = (response?.result.value) as? Dictionary<String,AnyObject> {
                    print(resv)
                    if let code = resv["ResponseStatus"] as? Int {
                        if code == 0 {
                            print("Hurrah ")
                            self.ischangedsomething?(true)
    //                        self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "start", sender: nil)
                        }
                        else {
                            self.present(customalert.showalert(x: "Error adding users.Please try again !"), animated: true, completion: nil)
                        }
                        
                        
                    }
                }
                
            }
        }

    }
    
    func addjury()
    {
         var allinfos : [Dictionary<String,String>] = []
        
        if self.addtogroupcontacts.count == 0 {
            var contact = UserDefaults.standard.value(forKey: "mobile") as? String
            var firstname = UserDefaults.standard.value(forKey: "firstname") as? String
            var lastname = UserDefaults.standard.value(forKey: "lastname") as? String
            var pf = UserDefaults.standard.value(forKey: "profileimage") as? String
            print(contact)
            print(firstname)
            print(lastname)
            self.addtogroupcontacts.append(customcontact(name: firstname ?? "", lastname: lastname ?? "", userimage: pf ?? "", profession: "", number: [contact ?? ""], countrycode: "91", type: "", refid: "", profileimage: "", profilename: "" ))
            
            print(allinfos)
            
        }
        
        
        print("Ok data is ")
        print(self.addtogroupcontacts)
        
        
        if self.addtogroupcontacts.count > 1 {
            self.present(customalert.showalert(x: "Only one jury is allowed !"), animated: true, completion: nil)
        }
        else {
           
            for all in self.addtogroupcontacts {
                allinfos.append(["Contact" : all.number![0],"FirstName" : all.name , "LastName" : all.lastname])
                
            }
            var r = BaseServiceClass()
            var url = Constants.K_baseUrl + Constants.addjury
            var params : Dictionary<String,Any> = ["GroupId" : self.passedjuryid , "Contact" : allinfos]
            print(params)
            
            r.postApiRequest(url: url, parameters: params) { (response, error) in
                if let resv = (response?.result.value) as? Dictionary<String,AnyObject> {
                    print(resv)
                    if let code = resv["ResponseStatus"] as? Int {
                        print("Hurrah ")
                        self.ischangedsomething?(true)
                        self.present(customalert.showalert(x: "Jury Added !"), animated: true) {
                            self.performSegue(withIdentifier: "taketopublish", sender: nil)
                        }
                        
                        self.receivedallselectedcontacts = []
                        self.showothercontactbtn.setTitle("Search other talent contacts ( 0 Selected )", for: .normal)
//                        self.grouoname.text = "Add Participants"
//                        print("Before")
//                        print(self.talentcontacts)
//                        for each in self.addtogroupcontacts {
//                            var found = false
//                            for var k in 0 ..< self.talentcontacts.count {
//                                if self.talentcontacts[k].name == each.name && self.talentcontacts[k].number![0] == each.number![0] {
//                                    print("Found duplicates with name \(each.name)")
////                                    if let c = self.table1.cellForRow(at: IndexPath(row: k, section: 0)) as? TalentContactTableViewCell {
////                                        c.addbtn.isEnabled = false
////                                        c.addbtn.setTitle("Jury", for: .normal)
////                                    }
//                                    self.talentcontacts.remove(at: k)
//                                    self.table2.reloadData()
//                                    self.table2.isHidden = false
//                                    self.table1.isHidden = true
//                                    break
//                                }
//                            }
//                        }
//                        print("After")
//                        print(self.talentcontacts)
//                        self.addtogroupcontacts = []
//                        self.mode = "participants"
                        
                        
                    }
                }
                
            }
        }

    }
    
    
    
    func editjury()
    {
        var allinfos : [Dictionary<String,String>] = []
        
        if self.addtogroupcontacts.count == 0 {
            var contact = UserDefaults.standard.value(forKey: "mobile") as? String
            var firstname = UserDefaults.standard.value(forKey: "firstname") as? String
            var lastname = UserDefaults.standard.value(forKey: "lastname") as? String
            print(contact)
            print(firstname)
            print(lastname)
            self.addtogroupcontacts.append(customcontact(name: firstname ?? "", lastname: lastname ?? "", userimage: "", profession: "", number: [contact ?? ""], countrycode: "91", type: "" , refid: "", profileimage: "", profilename: "" ))
            allinfos.append(["Contact" : contact ?? "","FirstName" :firstname ?? ""  , "LastName" : lastname ?? ""])
            print(allinfos)
            
        }
        
        
        print("Ok data is ")
        print(self.addtogroupcontacts)
        
        
        if self.addtogroupcontacts.count > 1 {
            self.present(customalert.showalert(x: "Only one jury is allowed !"), animated: true, completion: nil)
        }
        else {
            
            for all in self.addtogroupcontacts {
                allinfos.append(["Contact" : all.number![0],"FirstName" : all.name , "LastName" : all.lastname])
                
            }
            var r = BaseServiceClass()
            var url = Constants.K_baseUrl + Constants.updatejury
            var params : Dictionary<String,Any> = ["GroupId" : self.passedjuryid , "Contact" : allinfos]
            print(params)
            
            r.postApiRequest(url: url, parameters: params) { (response, error) in
                if let resv = (response?.result.value) as? Dictionary<String,AnyObject> {
                    print(resv)
                    if let code = resv["ResponseStatus"] as? Int {
                        print("Hurrah ")
                        self.ischangedsomething?(true)
                        self.juryupdated!(true)
                        self.present(customalert.showalert(x: "Jury Updated !"), animated: true) {
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                        self.receivedallselectedcontacts = []
                        self.showothercontactbtn.setTitle("Search other talent contacts ( 0 Selected )", for: .normal)
                        //                        self.grouoname.text = "Add Participants"
                        //                        print("Before")
                        //                        print(self.talentcontacts)
                        //                        for each in self.addtogroupcontacts {
                        //                            var found = false
                        //                            for var k in 0 ..< self.talentcontacts.count {
                        //                                if self.talentcontacts[k].name == each.name && self.talentcontacts[k].number![0] == each.number![0] {
                        //                                    print("Found duplicates with name \(each.name)")
                        ////                                    if let c = self.table1.cellForRow(at: IndexPath(row: k, section: 0)) as? TalentContactTableViewCell {
                        ////                                        c.addbtn.isEnabled = false
                        ////                                        c.addbtn.setTitle("Jury", for: .normal)
                        ////                                    }
                        //                                    self.talentcontacts.remove(at: k)
                        //                                    self.table2.reloadData()
                        //                                    self.table2.isHidden = false
                        //                                    self.table1.isHidden = true
                        //                                    break
                        //                                }
                        //                            }
                        //                        }
                        //                        print("After")
                        //                        print(self.talentcontacts)
                        //                        self.addtogroupcontacts = []
                        //                        self.mode = "participants"
                        
                        
                    }
                }
                
            }
        }
        
    }

    
    
    
    func fetchcontacts()
    {
        var data = CoreDataManager.shared.fetch()
        self.talentcontacts = []
        self.phonecontacts = []
        for each in data {
            var x = customcontact(name: "\(each.FirstName)",lastname : " \(each.LastName)", userimage: "", profession: "", number: [each.Contact], countrycode: "", type: "talent" ,  refid: each.refid, profileimage: each.profileimage, profilename: each.profilename )
           
            if each.onserver == false {
                self.phonecontacts.append(x)
            }
            else
            {
                self.talentcontacts.append(x)
            }
        }
        print(self.talentcontacts)
        for each in members {
            for k in 0 ..< self.talentcontacts.count {
                if each.userid == self.talentcontacts[k].refid {
                    self.talentcontacts[k].alreadyshared = true
                }
            }
        }
        self.table1.reloadData()
    }
    
    static func fetchcontactsforcoredata(completion:@escaping sendcontacts)
       {
        var phonecontacts : [customcontactcoredata] = []
          var t =  UIApplication.shared.delegate as? AppDelegate
           t?.requestForAccess(completionHandler: { (ans) in
              if ans {
               let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
               CNContactEmailAddressesKey,
               CNContactPhoneNumbersKey,
               CNContactImageDataAvailableKey,
               CNContactThumbnailImageDataKey] as [Any]
               var contacts = [CNContact]()
               var message: String!
               let req = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
               
                   let cs = (UIApplication.shared.delegate as? AppDelegate)?.contactStore
                   do {
                       try cs!.enumerateContacts(with: req){
                           (contact, cursor) -> Void in
                           contacts.append(contact)
                       }
                       if contacts.count == 0 {
                           message = "No contacts were found matching the given name."
                        completion(nil, nil)
                       }
                       else {
                           for cont in contacts {
                        
                               var tempphone : [String] = []
                               for pn in cont.phoneNumbers {
                                   tempphone.append((pn.value.stringValue as? String) ?? "")
                               }
             
                               
                               var x = customcontactcoredata(name: "\(cont.givenName)",lastname:cont.familyName , userimage: nil, profession: "", number: tempphone, countrycode: "", type: "phone")
                            
                            
                               phonecontacts.append(x)
                           }
                        
                        
                         completion(phonecontacts,nil)
                       }
                   }
                   catch {
                       message = "Contacts Fetching Error"
                        completion(nil,error)
                   }
               }
           
           })
       }
    
    
    @IBAction func invitepopupclose(_ sender: Any) {
        self.invitepopup.isHidden = true
    }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "ShowTalents", message: message, preferredStyle: UIAlertController.Style.alert)
     
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
     
        alertController.addAction(dismissAction)
     
        
     
        self.present(alertController, animated: true, completion: nil)
    }
    
  
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.mode == "jury" ||  self.mode == "participants" {
            return 1
        }
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return talentcontacts.count
        }
        else {
            return phonecontacts.count
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "talentcontact", for: indexPath) as? TalentContactTableViewCell {
                    
                    cell.passbackcontact = {a , b in
                        
                        print("hello")
                        print(a)
                        print(b)
                        print(self.mode)
                        print(self.addtogroupcontacts)
                        
                        if b && self.addtogroupcontacts.count == 0 && self.mode == "jury" {
                            print("Added \(a.name)")
                                self.addtogroupcontacts.append(a)
                            cell.addbtn.setTitle("Remove", for: .normal)
                        }
                        else if b && self.addtogroupcontacts.count > 0 && self.mode == "jury" {
                            cell.addbtn.setTitle("Add", for: .normal)
                            cell.addbtn.backgroundColor = #colorLiteral(red: 0.3236835599, green: 0.3941466212, blue: 0.8482848406, alpha: 1)
                            self.present(customalert.showalert(x: "You are allowed to make only one jury"), animated: true, completion: nil)
                        }
                        else if b && (self.mode == "participants" || self.mode == "invite") {
                            print("Added \(a.name)")
                            self.addtogroupcontacts.append(a)
                            cell.addbtn.setTitle("Remove", for: .normal)
                        }
                        
                        else  {
                            for k in 0 ..< self.addtogroupcontacts.count  {
                                
                                if k < self.addtogroupcontacts.count {
                                    if self.addtogroupcontacts[k].name == a.name && self.addtogroupcontacts[k].number?[0] == a.number?[0] {
                                        print("Removed \(a.name) with number \(a.number?[0])")
                                        self.addtogroupcontacts.remove(at: k)
                                                cell.addbtn.setTitle("Add", for: .normal)
                                    }
                                }
                            }
                        }
                    }
                    
                    cell.updatecell(x: self.talentcontacts[indexPath.row])
                }
            }
            else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "phonecontact", for: indexPath) as? PhoneContactTableViewCell {
                    cell.addbtn.tag = indexPath.row
                    cell.returnValue = { rv in
//                        self.invitepopuplabel.text = "Invite \(rv.name.capitalized) via"
//                        self.invitepopup.isHidden = false
                        let image = #imageLiteral(resourceName: "dashboard")
                        var applink = "demoapplink"
                        // set up activity view controller
                        let imageToShare = [ image , applink ] as [Any]
                        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                        
                        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

                        

                        // present the view controller
                        self.present(activityViewController, animated: true, completion: nil)
                    }
                    cell.updatecell(x: self.phonecontacts[indexPath.row])
                }
            }
            return UITableViewCell()
       }
    
     
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.table1.frame.size.height/10 < 70 {
            return 70
        }
        return self.table1.frame.size.height/10
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let u = UIView(frame: CGRect(x: 0, y: 0, width: self.table1.frame.size.width, height: 18))
        u.backgroundColor = self.view.backgroundColor
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: self.table1.frame.size.width, height: 18))
        lab.font = UIFont.boldSystemFont(ofSize: 18)
        lab.textAlignment = .left
        if section == 0 && talentcontacts.count > 0 {
            lab.text =  "Show Talent Contacts(\(self.talentcontacts.count))"
        }
        else if section == 1 && phonecontacts.count > 0 {
            lab.text =  "Show Phone Contacts(\(self.phonecontacts.count))"
        }
        u.addSubview(lab)
        
        return u
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? ShowtalentothercontactsViewController {
            seg.allselectedcontacts = self.receivedallselectedcontacts ?? []
            seg.passallselectedcontacts = {a in
                self.receivedallselectedcontacts = a
                self.showothercontactbtn.setTitle("Search other talent contact ( \(a.count) Selected )", for: .normal)
                var u = self.addtogroupcontacts.count - 1
                for m in stride(from: u, through: 0, by: -1) {
                    if self.addtogroupcontacts[m].type == "talentother" {
                        self.addtogroupcontacts.remove(at: m)
                    }
                }
                
               
                for each in a {
                    var x = customcontact(name: each.name, lastname: "", userimage: each.profileimage, profession:"", number: [each.contact], countrycode: each.countrycode, type: "talentother" , refid: "" , profileimage: "",profilename: "")
                    self.addtogroupcontacts.append(x)
                }
                
            }
            
        }
        
        
        if let seg = segue.destination as? NewEventViewController {
            seg.eventid = self.groupid
            seg.timetopublish = false
        }
        if let s = segue.destination as? JoinedeventsViewController {
            s.eventid = self.groupid
            s.timetopublish = true
            s.dangeringoingback = true
        }
    }
    
    

}
