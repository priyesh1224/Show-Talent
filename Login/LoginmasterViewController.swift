//
//  LoginmasterViewController.swift
//  ShowTalent
//
//  Created by maraekat on 03/02/20.
//  Copyright © 2020 apple. All rights reserved.
//
import QuartzCore
import UIKit

struct inputvals {
    var key : String
    var val : Dictionary<String,String>
}

struct otpresult {
    var token : String
    var refid : String
    var firstname : String
    var lastname : String
    var profileimage : String
    var countrycode : String
    var mobilenumber : String
}

class LoginmasterViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout , UIPickerViewDelegate,UIPickerViewDataSource {
   
    @IBOutlet var loginbtntopspace: NSLayoutConstraint!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var otp : otpresult?
    
    static var allcountrycodes : [String] = []
    static var allcountrynames : [String] = []
    
    var preservetext = ""
    
    
    @IBOutlet weak var signupextraview: UIView!
    
    
    @IBOutlet weak var waveimage: UIImageView!
    
    
    @IBOutlet weak var referallnewfield: UIView!
    
    
    @IBOutlet weak var referalnewfield: UITextField!
    
    
    @IBOutlet weak var newsignupbtn: UIButton!
    
    @IBOutlet weak var loginbuttonouterview: UIView!
    
    var collectiondata = ["Sign In","Forgot Password","Sign Up"]
    
    var loginfields = ["Mobile Number / Email" ,"Password"]
    var loginotpfields = ["Mobile Number / Email","Country Code"]
    var loginmobilepassowrdfields = ["Mobile Number / Email","Country Code","Password"]
    var signupfields = ["Email","Country Code","Mobile","Password","Confirm Password"]
    var forgotpasswordfields = ["Country Code","Mobile Number / Email"]
    
    
    @IBOutlet weak var tableviewheight: NSLayoutConstraint!
    var fcm = "evsSl8PEi01yrP2STQ6qPh:APA91bFe0pcQNTzL51okYetIEngoEBBtJ5iam_Lg07LMJ8EsGkONzR7XJXvgRfhXn9sff6qAFuokLjePgFsysKJ5I_UsjnxDthIqEyhwoquzrcwr_6zseiSeShDKPyzDXtQQeeyMBYEi"
    
    @IBOutlet weak var passwordlogin: UIButton!
    
    
    @IBOutlet weak var countrycodespicker: UIPickerView!
    
    @IBOutlet weak var countrycodesview: UIView!
    
    @IBOutlet weak var countrycodesnextbtn: UIButton!
    
    @IBOutlet weak var otplogin: UIButton!
    
    var inputdonefileds : [inputvals] = []
    
    
    var loginwithpasswordpressed = false
    
    
    
    @IBOutlet weak var loginextrabuttons: UIStackView!
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var describingtext: UILabel!
    
    
    @IBOutlet weak var loginbutton: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var bottomtext: UILabel!
    
    @IBOutlet weak var bottommosttext: UILabel!
    
    var type = "login"
    var selectedIndex = ""
    var countrycode = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.isHidden = true
        setupview()
        self.referalnewfield.layer.borderWidth = 0
        self.referallnewfield.layer.cornerRadius = 10
        print("Current country code is \(self.countrycode) with type \(self.type)")

        UserDefaults.standard.removeObject(forKey: "firstname")
        UserDefaults.standard.removeObject(forKey: "lastname")
        UserDefaults.standard.removeObject(forKey: "gender")
        UserDefaults.standard.removeObject(forKey: "dob")
        table.delegate = self
        table.dataSource = self
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
        collection.allowsSelection = true
        collection.allowsMultipleSelection = false
        table.reloadData()
//        self.table.addcustomShadow()
        table.addCorner()
    
        newsignupbtn.layer.cornerRadius = 25

        self.loginbuttonouterview.isHidden = false
        self.signupextraview.isHidden = true
        
        self.countrycodespicker.delegate = self
        self.countrycodespicker.dataSource = self
        
        self.countrycodesview.layer.cornerRadius = 20
        self.countrycodesnextbtn.layer.cornerRadius = 20
        self.countrycodesview.isHidden = true
        
        print(self.type)
        
        var arrayindex = 0
        var k = 0
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print("Current is \(countryCode)")
            selectedIndex = countryCode
             }
        
        for each in LoginMasterTableViewCell.countryPrefixes {
            LoginmasterViewController.allcountrycodes.append(each.value)
            LoginmasterViewController.allcountrynames.append(each.key)
            
        }
     
        
        self.countrycodespicker.selectRow(k, inComponent: 0, animated: true)
        
        

       
    }
    
    @IBAction func newsignuppressed(_ sender: Any) {
        signupuser()
    }
    
    
    @IBAction func skiplogin(_ sender: UIButton) {
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        let params : Dictionary<String,String> = ["DeviceId":"\(UIDevice.current.identifierForVendor!.uuidString)","FCMTokenID":fcm,"Devicetype":"\(UIDevice.current.model)","Devicename":"\(UIDevice.current.localizedModel)"]
        
        let r  = BaseServiceClass()
        let url = Constants.K_baseUrl + Constants.guestlogin
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let code = res["ResponseStatus"] as? Int {
                    if code == 0 {
                        if let details = res["Result"] as? Dictionary<String,Any> {
                            if let toke = details["token"] as? String {
                                print(toke)
                                UserDefaults.standard.setValue(toke, forKey: "token")
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: "logintodashboard", sender: nil)
                            }
                        }
                    }
                    else {
                        self.present(customalert.showalert(x: "Unable to skip login"), animated: true, completion: nil)
                    }
                }
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LoginmasterViewController.allcountrycodes.count
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return "+ \(LoginmasterViewController.allcountrycodes[row])"
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
    @IBAction func closecountrycodes(_ sender: UIButton) {
        self.countrycodesview.isHidden = true
    }
    
    
    @IBAction func selectedcountrycode(_ sender: UIButton) {
        self.countrycode =  LoginmasterViewController.allcountrycodes[self.countrycodespicker.selectedRow(inComponent: 0)]
        print(self.countrycode)
        if type == "login"
        {
            
                if let c =    self.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginMasterTableViewCell {
                    c.mobilenumber.text = "Choosen code : \(self.countrycode)"
                }
            
        }
        else if type == "loginmobile"
        {
            if let c =    self.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginMasterTableViewCell {
                c.mobilenumber.text = "Choosen code : \(self.countrycode)"
            }
        }
        else if type == "forgot" {
            if let c =    self.table.cellForRow(at: IndexPath(row: 0, section: 0)) as? LoginMasterTableViewCell {
                c.mobilenumber.text = "Choosen code : \(self.countrycode)"
            }
        }
        else if type == "signup" {
            if let c =    self.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginMasterTableViewCell {
                c.mobilenumber.text = "Choosen code : \(self.countrycode)"
            }
        }
        self.countrycodesview.isHidden = true
    }
    
    func setupview()
    {
        
        self.table.layer.cornerRadius = 10
        self.table.clipsToBounds = true
        
        
        print("Type changed to \(self.type)")
        
        
        self.loginbuttonouterview.layer.cornerRadius = 30
        self.loginbutton.layer.cornerRadius = 30
        self.loginbuttonouterview.clipsToBounds = false
        
        
        if type == "login" {
            self.loginbutton.setTitle("Log In", for: .normal)
            
        }
        else if type == "loginmobile"
        {
            if loginwithpasswordpressed == true {
                 tableviewheight.constant = 380
            }
            else {
                tableviewheight.constant = 220
            }
            self.loginbutton.setTitle("Log In", for: .normal)
        }
        else if type == "forgot" {
            tableviewheight.constant = 220
            self.loginbutton.setTitle("Forgot Password", for: .normal)
        }
        else {
            tableviewheight.constant = 220
            self.loginbutton.setTitle("Sign up", for: .normal)
        }
        if type == "loginmobile" {
            self.loginextrabuttons.isHidden = false
            self.loginbtntopspace.constant = 64
        }
        else {
            self.loginextrabuttons.isHidden = true
            self.loginbtntopspace.constant = 32

        }
        
        self.countrycode = "91"
        
//        if type == "login"
//               {
//
//                       if let c =    self.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginMasterTableViewCell {
//                           c.mobilenumber.text = "Choosen code : \(self.countrycode)"
//                       }
//
//               }
            if type == "loginmobile"
               {
                   if let c =    self.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginMasterTableViewCell {
                       c.mobilenumber.text = "Choosen code : \(self.countrycode)"
                   }
               }
               else if type == "forgot" {
                   if let c =    self.table.cellForRow(at: IndexPath(row: 0, section: 0)) as? LoginMasterTableViewCell {
                       c.mobilenumber.text = "Choosen code : \(self.countrycode)"
                   }
               }
               else if type == "signup" {
                   if let c =    self.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginMasterTableViewCell {
                       c.mobilenumber.text = "Choosen code : \(self.countrycode)"
                   }
               }
        
        
        
        
        
    }
    
    
    @IBAction func loginbuttonpressed(_ sender: UIButton) {
        print("------------")
        print(self.inputdonefileds)
        print(self.type)
        self.spinner.isHidden = false
        self.spinner.startAnimating()

        resignlastfield()
        if type == "login" {
            loginusingpassword()
        }
        else if type == "loginmobile" {
            if self.loginwithpasswordpressed == false {
                loginusingotp()
            }
            else {
                loginusingmobilepassword()
            }
        }
        else if type == "forgot" {
            forgotpassword()
        }
        else if type == "signup" {
            signupuser()
        }
        
        
    }
    
    
    func signupuser()
    {
        var e = ""
        var m = ""
        var p = ""
        var c = ""
        var ref = ""
        for each in self.inputdonefileds {
            if each.key == "signup" {
                for iin in each.val {
                    if iin.key == "Email" {
                        e = iin.value.lowercased()
                        if e == "" || e == " " {
                                 customalert.showalert(x: "One of the fields are missing.")
                            stopspinner()
                                 return
                             }
                    }
                    if iin.key == "Mobile" {
                        m = iin.value
                        if m == "" || m == " " {
                                 customalert.showalert(x: "One of the fields are missing.")
                            stopspinner()
                                 return
                             }
                    }
                    if iin.key == "Password" {
                        p = iin.value
                        if p == "" || p == " " {
                                 customalert.showalert(x: "One of the fields are missing.")
                            stopspinner()
                                 return
                             }
                    }
                    if iin.key == "Confirm Password" {
                        c = iin.value
                        if c == "" || c == " " {
                                 customalert.showalert(x: "One of the fields are missing.")
                            stopspinner()
                                 return
                             }
                    }
                    if let nre = self.referalnewfield.text as? String {
                        if nre != "" && nre != " " {
                            ref = nre
                        }
                    }
                }
            }
        }
        
        if e == "" || m == "" || p == "" || c == "" {
            self.present(customalert.showalert(x: "All fields are mandatory"), animated: true, completion: nil)
            stopspinner()
            print("All fields are mandatory")
            return
        }
        if (p != c) {
        self.present(customalert.showalert(x: "Password and Confirm Password does not match"), animated: true, completion: nil)
            stopspinner()
            print("Password and Confirm Password does not match")
            return
            
        }
        
        let params : Dictionary<String,String> = ["Email":"\(e)","Password":"\(p)","Mobile":"\(m)","CountryCode":"+\(self.countrycode)","DeviceId":"\(UIDevice.current.identifierForVendor!.uuidString)","FCMTokenID":fcm,"Devicetype":"\(UIDevice.current.model)","Devicename":"\(UIDevice.current.localizedModel)" ,"ReferralCode" : ref]
        
        print(params)
               
               UserDefaults.standard.setValue(m as? String, forKey: "mobile")

               var url = Constants.K_baseUrl + Constants.registerUrl
               var r = BaseServiceClass()
               r.postApiRequest(url: url, parameters: params) { (data, err) in
                if(err != nil) {
                    print(err)
                }
                print(data)
                   if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                    
                    if let rs = resv["ResponseStatus"] as? Int {
                        if rs == 1 {
                            if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                if let m = errrr["ErrorMessage"] as? String {
                                    self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                    self.stopspinner()
                                }
                            }
                        }
                    }
                       
                       if let usefuldata = resv["Result"] as? Dictionary<String,Any>,let ress = resv["ResponseStatus"] as? Int {
                        print(usefuldata)
                           if ress == 0{
                            var t = ""
                            var r  = ""
                            if let ti = usefuldata["token"]  as? String {
                                t = ti
                            }
                            if let ri = usefuldata["Ref_guid"]  as? String {
                                r = ri
                            }
                            
                               self.otp = otpresult(token: "\(t)", refid: "\(r)", firstname: "", lastname: "", profileimage: "", countrycode: "+\(self.countrycode)", mobilenumber: m)
                            print(self.otp)
                               self.performSegue(withIdentifier: "taketootp", sender: nil)
                           }
                           else {
                              self.present(customalert.showalert(x: "Could not Register"), animated: true, completion: nil)
                            self.stopspinner()
                               print("Could not Register")
                           }
                       }
                       
                   }
               }
        
        
        
        
        
        
        
        
    }
    
    
    func stopspinner()
    {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
    func loginusingmobilepassword()
    {
        
        
        print("called login mobile with password")
        var e = ""
        var p = ""
        for each in self.inputdonefileds {
            if each.key == "loginmobile" {
                for iin in each.val {
                    if iin.key == "Mobile Number / Email" {
                        e = iin.value.lowercased()
                        if e == "" || e == " " {
                                 customalert.showalert(x: "One of the fields are missing.")
                            stopspinner()
                                 return
                             }
                    }
                    if iin.key == "Password" {
                        p = iin.value
                        if p == "" || p == " " {
                                 customalert.showalert(x: "One of the fields are missing.")
                            stopspinner()
                                 return
                             }
                    }
                }
            }
        }
        
        
        let params : Dictionary<String,String> = ["PhoneNumber":"\(e)","Password":"\(p)","CountryCode":"+\(self.countrycode)","DeviceId":"\(UIDevice.current.identifierForVendor!.uuidString)","FCMTokenID":fcm,"Devicetype":"\(UIDevice.current.model)","Devicename":"\(UIDevice.current.localizedModel)"]
                      
                   var vtok = ""
                   var vfn = ""
                   var vln = ""
                   var vpi = ""
                   var vrn = ""
                    var pstatus = true
        
        
        print(params)
                      
                      var url = Constants.K_baseUrl + Constants.mloginwpassword
                      var r = BaseServiceClass()
                      r.postApiRequest(url: url, parameters: params) { (data, err) in
                          if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                            print(resv)
                            if let rs = resv["ResponseStatus"] as? Int {
                                              if rs == 1 {
                                                  if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                                      if let m = errrr["ErrorMessage"] as? String {
                                                          self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                                        self.stopspinner()
                                                      }
                                                  }
                                              }
                                          }
                            
                            
                              if let usefuldata = resv["Result"] as? Dictionary<String,Any> {
                                
                                
                               
                               if let token = usefuldata["token"] as? String {
                                  
                                   vtok = token
                                   UserDefaults.standard.setValue(vtok as? String, forKey: "token")
                               }
                                UserDefaults.standard.setValue(e as? String, forKey: "mobile")

                                if let rn = usefuldata["Ref_guid"] as? String {
                                        
                                        vrn = rn
                                        UserDefaults.standard.setValue(vrn as? String, forKey: "ref")
                                                            
                                        print("setting \(vrn) to refid")
                                        UserDefaults.standard.setValue(vrn as? String, forKey: "refid")

                                    }
                                
                                if let ps = usefuldata["profileStatus"] as? Bool {
                                    pstatus = ps
                                }
                                
                                  
                               if let pdata = usefuldata["Profile"] as? Dictionary<String,Any> {
                                   
                                
                                
                                   if let fn = pdata["FirstName"] as? String {
                                       print("First name is \(fn)")
                                    UserDefaults.standard.setValue("\(fn)" as? String, forKey: "firstname")
                                       vfn = fn
                                   }
                                   if let ln = pdata["LastName"] as? String {
                                             print("Last name is \(ln)")
                                    UserDefaults.standard.setValue("\(ln)" as? String, forKey: "lastname")
                                       vln = ln
                                       }
                                   UserDefaults.standard.setValue("\(vfn) \(vln)" as? String, forKey: "name")
                                   
                               if let gen = pdata["Gender"] as? String {
                                                              UserDefaults.standard.set(gen, forKey: "gender")
                                                          }
                                                          
                                                          if let dob = pdata["Dob"] as? String {
                                                              UserDefaults.standard.set(dob, forKey: "dob")
                                                          }

                                   if let profileimage = pdata["ProfileImg"] as? String {
                                       print("Profile Image is \(profileimage)")
                                       vpi = profileimage
                                       UserDefaults.standard.setValue(vpi as? String, forKey: "profileimage")
                                    
                                    DispatchQueue.global(qos: .background).async {
                                        CoreDataManager.shared.loadallfromcontacts()

                                    }
                                    DispatchQueue.main.async {
                                                                       if pstatus == false {
                                                                           self.performSegue(withIdentifier: "incompleteprofile", sender: nil)
                                                                       }
                                                                       else {
                                                                           self.performSegue(withIdentifier: "logintodashboard", sender: nil)
                                                                       }

                                                                   }
                                    

                                   }
                                                
                               
                               }
                                  
                              }
                              
                          }
                      }
    }
    
    
    func resignlastfield()
    {
        if type == "login" {
          
                if let cell = table.cellForRow(at: IndexPath(row: self.loginfields.count - 1, section: 0)) as? LoginMasterTableViewCell {
                    cell.mobilenumberfield.resignFirstResponder()
                }
            
        }
        else if type == "loginmobile" {
            if self.loginwithpasswordpressed == false {
                if let cell = table.cellForRow(at: IndexPath(row: self.loginotpfields.count - 1, section: 0)) as? LoginMasterTableViewCell {
                    cell.mobilenumberfield.resignFirstResponder()
                }
            }
            else {
                if let cell = table.cellForRow(at: IndexPath(row: self.loginmobilepassowrdfields.count - 1, section: 0)) as? LoginMasterTableViewCell {
                    cell.mobilenumberfield.resignFirstResponder()
                }
            }
        }
        else if type == "forgot" {
            if let cell = table.cellForRow(at: IndexPath(row: self.forgotpasswordfields.count - 1, section: 0)) as? LoginMasterTableViewCell {
                cell.mobilenumberfield.resignFirstResponder()
            }
        }
        else if type == "signup" {
            if let cell = table.cellForRow(at: IndexPath(row: self.signupfields.count - 1, section: 0)) as? LoginMasterTableViewCell {
                cell.mobilenumberfield.resignFirstResponder()
            }
        }
    }
    
    
    
    
    func forgotpassword()
    {
        var e = ""
               var cc = self.countrycode
               print(e)
               print(cc)
                      for each in self.inputdonefileds {
                          if each.key == "forgot" {
                              for iin in each.val {
                                  if iin.key == "Mobile Number" || iin.key == "Mobile Number / Email"  {
                                      e = iin.value.lowercased()
                                    if e == "" || e == " " {
                                             customalert.showalert(x: "One of the fields are missing.")
                                        self.stopspinner()
                                             return
                                         }
                                  }
                
                              }
                          }
                      }
        
        print("Yes it is \(e.isPhoneNumber)")
        
        
        if e.isPhoneNumber {
            let params : Dictionary<String,String> = ["PhoneNumber":"\(e)","CountryCode":"+\(self.countrycode)"]
            
            
            var url = Constants.K_baseUrl + Constants.forGotPassUrl
            var r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: params) { (data, err) in
                if(err != nil) {
                    print(err)
                }
                print(data)
                if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                    
                    if let rs = resv["ResponseStatus"] as? Int {
                        if rs == 1 {
                            if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                if let m = errrr["ErrorMessage"] as? String {
                                    self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                    self.stopspinner()
                                }
                            }
                        }
                    }
                    
                    if let usefuldata = resv["Result"] as? String,let ress = resv["ResponseStatus"] as? Int {
                        print(usefuldata)
                        if ress == 0{
                            self.otp = otpresult(token: "", refid: "", firstname: "", lastname: "", profileimage: "", countrycode: "+\(self.countrycode)", mobilenumber: e)
                            self.performSegue(withIdentifier: "taketootp", sender: nil)
                        }
                        else {
                            self.present(customalert.showalert(x: "OTP could not be sent"), animated: true, completion: nil)
                            self.stopspinner()
                            print("OTP Could not be sent")
                        }
                    }
                    
                }
            }
        }
        else {
            let params : Dictionary<String,String> = ["Email":"\(e)"]
            
            
            var url = Constants.K_baseUrl + Constants.forgotpassemail
            var r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: params) { (data, err) in
                if(err != nil) {
                    print(err)
                }
                print(data)
                if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                    
                    if let rs = resv["ResponseStatus"] as? Int {
                        if rs == 1 {
                            if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                if let m = errrr["ErrorMessage"] as? String {
                                    self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                    self.stopspinner()
                                }
                            }
                        }
                    }
                    
                    if let usefuldata = resv["Result"] as? String,let ress = resv["ResponseStatus"] as? Int {
                        print(usefuldata)
                        if ress == 0{
                            self.otp = otpresult(token: "", refid: "", firstname: "", lastname: "", profileimage: "", countrycode: "+\(self.countrycode)", mobilenumber: e)
                            self.performSegue(withIdentifier: "taketootp", sender: nil)
                        }
                        else {
                            self.present(customalert.showalert(x: "OTP could not be sent"), animated: true, completion: nil)
                            self.stopspinner()
                            print("OTP Could not be sent")
                        }
                    }
                    
                }
            }
        }
        
        

        
        
        
        
    }
    

    func loginusingotp()
    {
        
        var e = ""
        var cc = self.countrycode
        print(e)
        print(cc)
               for each in self.inputdonefileds {
                   if each.key == "loginmobile" {
                       for iin in each.val {
                           if iin.key == "Mobile Number / Email" {
                               e = iin.value.lowercased()
                            if e == "" || e == " " {
                                     customalert.showalert(x: "One of the fields are missing.")
                                self.stopspinner()
                                     return
                                 }
                           }
         
                       }
                   }
               }
        
   
     
        
        let params : Dictionary<String,String> = ["PhoneNumber":"\(e)","CountryCode":"+\(self.countrycode)","DeviceId":"\(UIDevice.current.identifierForVendor!.uuidString)","FCMTokenID":fcm,"Devicetype":"\(UIDevice.current.model)","Devicename":"\(UIDevice.current.localizedModel)"]
        
        print(params)
           
        var vtok = ""
        var vfn = ""
        var vln = ""
        var vpi = ""
        var vrn = ""
        var pstatus = true
           
           var url = Constants.K_baseUrl + Constants.mlogin
           var r = BaseServiceClass()
           r.postApiRequest(url: url, parameters: params) { (data, err) in
            if(err != nil) {
                print(err)
            }
   
               if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                
                print("*************************************")
                                                     print(url)
                                                     print(params)
                                                     print(resv)
                                                     
                                                     print("*************************************")
                
                if let rs = resv["ResponseStatus"] as? Int {
                                  if rs == 1 {
                                      if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                          if let m = errrr["ErrorMessage"] as? String {
                                              self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                            self.stopspinner()
                                          }
                                      }
                                  }
                              }
                
                
                
                   if let usefuldata = resv["Result"] as? Dictionary<String,Any> {
                    print(usefuldata)
                     UserDefaults.standard.setValue(e as? String, forKey: "mobile")
                    if let token = usefuldata["token"] as? String {
                        print("Token us \(token)")
                        vtok = token
                        UserDefaults.standard.setValue(vtok as? String, forKey: "token")
                       
                    }
                    if let rn = usefuldata["Ref_guid"] as? String {
                                                 print("Ref is \(rn)")
                                           vrn = rn

                                           }
                    
                    
                       
                    if let pdata = usefuldata["Profile"] as? Dictionary<String,Any> {
                        
                        if let fn = pdata["FirstName"] as? String {
                            print("First name is \(fn)")
                            vfn = fn
                        }
                        if let ln = pdata["LastName"] as? String {
                                  print("Last name is \(ln)")
                            vln = ln
                            }
                        
                        
                       

                        if let profileimage = pdata["ProfileImg"] as? String {
                            print("Profile Image is \(profileimage)")
                            vpi = profileimage

                        }
                        self.otp = otpresult(token: vtok, refid: vrn, firstname: vfn, lastname: vln, profileimage: vpi, countrycode: "+\(self.countrycode)", mobilenumber: e)
                    
                    }
                    self.performSegue(withIdentifier: "taketootp", sender: nil)
                   }
                   
               }
           }
        
        
        
    }
    
    
    
    func loginusingpassword()
    {
        var e = ""
        var p = ""
        for each in self.inputdonefileds {
            if each.key == "login" {
                for iin in each.val {
                    if iin.key == "Mobile Number / Email" {
                        e = iin.value.lowercased()
                        if e == "" || e == " " {
                            customalert.showalert(x: "One of the fields are missing.")
                            self.stopspinner()
                            return
                        }
                    }
                    if iin.key == "Password" {
                        p = iin.value
                        if p == "" || p == " " {
                                 customalert.showalert(x: "One of the fields are missing.")
                            self.stopspinner()
                                 return
                             }
                    }
                }
            }
        }
        
        let params : Dictionary<String,String> = ["Email":"\(e)","Password":"\(p)","DeviceId":"\(UIDevice.current.identifierForVendor!.uuidString)","FCMTokenID":fcm,"Devicetype":"\(UIDevice.current.model)","Devicename":"\(UIDevice.current.localizedModel)"]
                  
               var vtok = ""
               var vfn = ""
               var vln = ""
               var vpi = ""
               var vrn = ""
                var pstatus = true
                  
                  var url = Constants.K_baseUrl + Constants.elogin
                  var r = BaseServiceClass()
                  r.postApiRequest(url: url, parameters: params) { (data, err) in
                      if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                        
                        if let rs = resv["ResponseStatus"] as? Int {
                                          if rs == 1 {
                                              if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                                  if let m = errrr["ErrorMessage"] as? String {
                                                      self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                                    self.stopspinner()
                                                  }
                                              }
                                          }
                                      }
                        
                        
                          if let usefuldata = resv["Result"] as? Dictionary<String,Any> {
                            
                            
                           
                           if let token = usefuldata["token"] as? String {
                              
                               vtok = token
                               UserDefaults.standard.setValue(vtok as? String, forKey: "token")
                           }
                            if let rn = usefuldata["Ref_guid"] as? String {
                                    
                                    vrn = rn
                                    UserDefaults.standard.setValue(vrn as? String, forKey: "ref")
                                                        
                                    print("setting \(vrn) to refid")
                                    UserDefaults.standard.setValue(vrn as? String, forKey: "refid")

                                }
                            
                            if let ps = usefuldata["profileStatus"] as? Bool {
                                pstatus = ps
                            }
                            
                              
                           if let pdata = usefuldata["Profile"] as? Dictionary<String,Any> {
                               
                            
                            
                               if let fn = pdata["FirstName"] as? String {
                                   print("First name is \(fn)")
                                UserDefaults.standard.setValue("\(fn)" as? String, forKey: "firstname")
                                   vfn = fn
                               }
                            
                            if let mn = pdata["Mobile"] as? String {
                                UserDefaults.standard.setValue("\(mn)" as? String, forKey: "mobile")
                                                              
                            }
                               if let ln = pdata["LastName"] as? String {
                                         print("Last name is \(ln)")
                                UserDefaults.standard.setValue("\(ln)" as? String, forKey: "lastname")
                                   vln = ln
                                   }
                               UserDefaults.standard.setValue("\(vfn) \(vln)" as? String, forKey: "name")
                               
                            
                            if let gen = pdata["Gender"] as? String {
                                UserDefaults.standard.set(gen, forKey: "gender")
                            }
                            
                            if let dob = pdata["Dob"] as? String {
                                UserDefaults.standard.set(dob, forKey: "dob")
                            }
                           

                               if let profileimage = pdata["ProfileImg"] as? String {
                                   print("Profile Image is \(profileimage)")
                                   vpi = profileimage
                                   UserDefaults.standard.setValue(vpi as? String, forKey: "profileimage")
                                
                                DispatchQueue.global(qos: .background).async {
                                    CoreDataManager.shared.loadallfromcontacts()

                                }
                                DispatchQueue.main.async {
                                    if pstatus == false {
                                        self.performSegue(withIdentifier: "incompleteprofile", sender: nil)
                                    }
                                    else {
                                        self.performSegue(withIdentifier: "logintodashboard", sender: nil)
                                    }

                                }
                                

                               }
                                            
                           
                           }
                              
                          }
                          
                      }
                  }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("New selected")
        print(indexPath.row)
        self.bottomtext.isHidden = false
        self.bottommosttext.isHidden = false
        if indexPath.row == 0 {
            self.loginbuttonouterview.isHidden = false
            self.signupextraview.isHidden = true
            type = "login"
        }
        else if indexPath.row == 1 {
            self.loginbuttonouterview.isHidden = false
            self.signupextraview.isHidden = true
            type = "forgot"
        }
        else {
            self.loginbuttonouterview.isHidden = true
            self.signupextraview.isHidden = false
            type = "signup"
        }
        
//        for m in 0 ..< collectiondata.count {
//            if m != indexPath.row {
//                if let cell = collectionView.cellForItem(at:IndexPath(row: m, section: 0)) as? LoginmasterCollectionViewCell {
//                    cell.title.font = UIFont.systemFont(ofSize: 26)
//                }
//            }
//            else {
//                if let cell = collectionView.cellForItem(at: IndexPath(row: m, section: 0)) as? LoginmasterCollectionViewCell {
//                    cell.title.font = UIFont.boldSystemFont(ofSize: 28)
//                }
//            }
//        }
        
        self.collection.reloadData()
        self.table.reloadData()
        self.setupview()
        
        
    }
    
    @IBAction func loginwithpasswordpressed(_ sender: UIButton) {
        self.bottomtext.isHidden = true
        self.bottommosttext.isHidden = true
       if self.loginwithpasswordpressed == false {
        self.loginwithpasswordpressed = true
         tableviewheight.constant = 300
        self.table.reloadData()
        
        self.passwordlogin.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        self.otplogin.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        }
        
    }
    
    
    @IBAction func loginwithotptapped(_ sender: UIButton) {
        self.bottomtext.isHidden = false
        self.bottommosttext.isHidden = false
        
        if self.loginwithpasswordpressed == true {
             tableviewheight.constant = 220
        self.loginwithpasswordpressed = false
        self.table.reloadData()
        self.passwordlogin.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
            self.otplogin.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        }
    }
    
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/1.5, height: 60)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectiondata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var ty = 0
        if type == "login" {
            ty = 0
        }
        else if type == "forgot" {
            ty = 1
        }
        else {
            ty = 2
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mastercc", for: indexPath) as? LoginmasterCollectionViewCell {
            cell.tag = indexPath.row
            cell.updatecell(x: self.collectiondata[indexPath.row],y:ty)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "login" {
         return self.loginfields.count
            
        }
        else if type == "loginmobile"
        {
            if self.loginwithpasswordpressed == false {
                return self.loginotpfields.count
            }
            else {
                return self.loginmobilepassowrdfields.count
            }
        }
        else if type == "forgot" {
            return self.forgotpasswordfields.count
        }
        else {
            return self.signupfields.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mastertc", for: indexPath) as? LoginMasterTableViewCell {
            
            cell.showcountrycode = {s,t,f in
                if(s) {
                    self.countrycodesview.isHidden = false
                    for r in 0 ..< LoginmasterViewController.allcountrynames.count { if(LoginmasterViewController.allcountrynames[r] == self.selectedIndex) {
                        self.countrycodespicker.selectRow(r, inComponent: 0, animated: true)
                        }
                    }
                    }
                
            }
            
            
            cell.sendback = {a,b,c in
                print("Received \(a) \(b) \(c)")
          
                var d = ["\(b)" : "\(c)"]
                var k = inputvals(key: a, val: d)
                var f1 = false
                var f2 = false
                for var each in 0 ..< self.inputdonefileds.count {
                    print("Each key is \(self.inputdonefileds[each].key)")
                    if self.inputdonefileds[each].key == a {
                        f1 = true
                        print("Setting it to \(b) \(c)")
                        print(self.inputdonefileds)
                        self.inputdonefileds[each].val.removeValue(forKey: b)
                        print("After")
                        print(self.inputdonefileds)
                        if f2 == false {
//                            each.val["\(b)"] = c
                            self.inputdonefileds[each].val[b] = c
                        }
                        break
                    }
                }
                
                if f1 == false {
                    self.inputdonefileds.append(k)
                }
            }
            
            
            cell.changestatus = {a,b in
                self.type = a
                self.table.reloadData()
                print("Type changed to \(self.type)")
                if a == "loginmobile" {
                    self.loginbtntopspace.constant = 64
                }
                else {
                    self.loginbtntopspace.constant = 32
                }
                if a == "loginmobile" {
                    self.loginextrabuttons.isHidden = false
                    self.loginwithpasswordpressed = false
                    self.preservetext = b
                    if let cell = self.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginMasterTableViewCell {
                        cell.mobilenumberfield.text = b
                    }
                }
                else if a == "login" {
                    self.loginextrabuttons.isHidden = true
                     self.preservetext = b
                    if let cell = self.table.cellForRow(at: IndexPath(row: 0, section: 0)) as? LoginMasterTableViewCell {
                        cell.mobilenumberfield.text = b
                    }
                }
            }
            
            
            cell.selectionStyle = .none
            if type == "login" {
             
                cell.updatecell(x: self.loginfields[indexPath.row],t:type)
                if indexPath.row == 0 {
                cell.mobilenumberfield.text = self.preservetext
                }
                
            }
            else if type == "loginmobile"
            {
                if self.loginwithpasswordpressed == false {
                    print(indexPath.row)
                    if indexPath.row < self.loginotpfields.count {
                        cell.updatecell(x: self.loginotpfields[indexPath.row], t: type)
                    }
                }
                else
                {
                     if indexPath.row < self.loginmobilepassowrdfields.count {
                        cell.updatecell(x: self.loginmobilepassowrdfields[indexPath.row],t:type)
                    }
                }
                if indexPath.row == 0 {
                cell.mobilenumberfield.text = self.preservetext
                }

            }
            else if type == "forgot" {
                cell.updatecell(x: self.forgotpasswordfields[indexPath.row],t:type)
            }
            else {
                cell.updatecell(x: self.signupfields[indexPath.row],t:type)
            }
            
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? OtpEnterViewController {
            print("Passing to OTP")
            print(self.otp)
            seg.mode = self.type
            seg.receivedotp = self.otp
        }
    }
    
    
    
    

}


extension String {

    

    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    //validate PhoneNumber
    var isPhoneNumber: Bool {

        let charcter  = NSCharacterSet(charactersIn: "+0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = self.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "") as NSString
        return  NSString(string: self) == filtered

    }
}


extension UITableView {
    func addCorner(){
        self.layer.cornerRadius = 15
        self.clipsToBounds = false
    }

    func addcustomShadow(){
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowRadius = 40
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowOffset = CGSize(width: 50, height: 20)
//        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = false
        self.layer.borderWidth = 0.0

        self.layer.shadowColor = UIColor.green.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 12, height: 12)
    }
}
