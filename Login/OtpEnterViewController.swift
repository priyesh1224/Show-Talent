//
//  OtpEnterViewController.swift
//  ShowTalent
//
//  Created by maraekat on 04/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire


class customalert{
    static func showalert(x:String) -> UIAlertController {
        let alert = UIAlertController(title: "Show Talent", message: "\(x)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        return alert
    }
}

class OtpEnterViewController: UIViewController , UITextFieldDelegate {

    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var receivedotp : otpresult?
    
    var mode : String = ""
    @IBOutlet weak var otpstatus: UILabel!
    
    @IBOutlet weak var tf1: UITextField!
    
    @IBOutlet weak var tf2: UITextField!
    
    
    @IBOutlet weak var tf3: UITextField!
    
    @IBOutlet weak var tf4: UITextField!
    
    @IBOutlet weak var tf5: UITextField!
    
    @IBOutlet weak var tf6: UITextField!
    
    @IBOutlet weak var loginbtn: UIButton!
    
    
    @IBOutlet weak var newpassword: UITextField!
    
    
    @IBOutlet weak var newconfirmpassword: UITextField!
    
    @IBOutlet weak var otpfieldswrapper: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tf1.delegate = self
         tf2.delegate = self
         tf3.delegate = self
         tf4.delegate = self
         tf5.delegate = self
         tf6.delegate = self
        
        tf1.tag = 1
        tf2.tag = 2
        tf3.tag = 3
        tf4.tag = 4
        tf5.tag = 5
        tf6.tag = 6
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        
        tf1.textContentType = .oneTimeCode
        tf2.textContentType = .oneTimeCode
        tf3.textContentType = .oneTimeCode
        tf4.textContentType = .oneTimeCode
       tf5.textContentType = .oneTimeCode
       tf6.textContentType = .oneTimeCode
        
        tf1.becomeFirstResponder()
        
        loginbtn.layer.cornerRadius = 10
        
        
        if self.mode  == "login" {
            self.loginbtn.setTitle("Log In", for: .normal)
            self.newpassword.isHidden = true
            self.newconfirmpassword.isHidden = true
        }
        else if self.mode == "forgot"{
             self.loginbtn.setTitle("Reset Password", for: .normal)
            self.newpassword.isHidden = false
                self.newconfirmpassword.isHidden = false
        }
        else {
             self.loginbtn.setTitle("Verify", for: .normal)
            self.newpassword.isHidden = true
                self.newconfirmpassword.isHidden = true
        }

        
    }
    
    @IBAction func cancelotpenter(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.text!.count < 1  && string.count > 0 && textField.tag < 6 {
            let nextTag = textField.tag + 1

            // get next responder
            var nextResponder = textField.superview?.viewWithTag(nextTag)

            if (nextResponder == nil){

                nextResponder = textField.superview?.viewWithTag(1)
            }
            textField.text = string
            nextResponder?.becomeFirstResponder()
            return false
        }
        else if textField.tag == 6 && textField.text!.count == 1 {
//            tf6.resignFirstResponder()
        }

        return true

    }
    

    @IBAction func resendotpclicked(_ sender: UIButton) {
        
    }
    
    
    
    @IBAction func loginpressed(_ sender: UIButton) {
        
        
        if tf1.text!.count != 1 || tf2.text!.count != 1 || tf3.text!.count != 1 || tf4.text!.count != 1 || tf5.text!.count != 1 || tf6.text!.count != 1 {
            
        }
        else {
            var combinedcode = "\(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)\(tf5.text!)\(tf6.text!)"
            
            
            if self.mode == "login" || self.mode == "loginmobile" {
            
                    var mo = ""
                    var co = ""
                    var uo = ""
                    if let m = self.receivedotp?.mobilenumber as? String {
                        mo = m
                    }
                    if let c = self.receivedotp?.countrycode as? String {
                        co = c
                    }
                    if let u = self.receivedotp?.refid as? String {
                        uo = u
                    }
                    
                    let params : Dictionary<String,String> = ["PhoneNumber":"\(mo)","CountryCode":"\(co)","Code":"\(combinedcode)","ID":"\(uo)"]
                           
                           print(params)
                              
                           var vtok = ""
                           var vfn = ""
                           var vln = ""
                           var vpi = ""
                           var vrn = ""
                var pstatus = true
                              
                              var url = Constants.K_baseUrl + Constants.verifyNumber
                              var r = BaseServiceClass()
                self.spinner.isHidden = false
                self.spinner.startAnimating()
                self.loginbtn.isEnabled = false
                              r.postApiRequest(url: url, parameters: params) { (data, err) in
                               if(err != nil) {
                                   print(err)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.loginbtn.isEnabled = true
                               }
                                  if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                                    print("*************************************")
                                    print(url)
                                    print(params)
                                    print(resv)
                                    
                                    print("*************************************")
                                    
                                      if let usefuldata = resv["Result"] as? Dictionary<String,Any> {
                                       print(usefuldata)
                                        UserDefaults.standard.setValue("\(mo)" as? String, forKey: "mobile")

                                       if let token = usefuldata["token"] as? String {
                                           print("Token us \(token)")
                                           vtok = token
                                          
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
                                            if let ln = pdata["LastName"] as? String {
                                                        print("Last name is \(ln)")
                                                        UserDefaults.standard.setValue("\(ln)" as? String, forKey: "lastname")
                                                        vln = ln
                                            }
                                           
                                           if let gen = pdata["Gender"] as? String {
                                                                          UserDefaults.standard.set(gen, forKey: "gender")
                                                                      }
                                                                      
                                                                      if let dob = pdata["Dob"] as? String {
                                                                          UserDefaults.standard.set(dob, forKey: "dob")
                                                                      }
                                          

                                           if let profileimage = pdata["ProfileImg"] as? String {
                                               print("Profile Image is \(profileimage)")
                                               vpi = profileimage

                                           }
                                       }
                                      }
                                    if let ans = resv["ResponseStatus"] as? Int {
                                        if ans == 0 {
                                            if uo == vrn {
                                                   print("Verfied")

                                                UserDefaults.standard.setValue("\(vfn) \(vln)" as? String, forKey: "name")
                                                
                                      
                                                
                                                
                                                UserDefaults.standard.setValue(vpi as? String, forKey: "profileimage")
                                                
                                                DispatchQueue.global(qos: .background).async {
                                                    CoreDataManager.shared.loadallfromcontacts()
                                                    DispatchQueue.main.async {
                                                    self.loginbtn.isEnabled = true
                                                    self.spinner.isHidden = true
                                                    self.spinner.stopAnimating()
                                                    }
                                                }
                                                       DispatchQueue.main.async {
                                                        self.loginbtn.isEnabled = true
                                                        self.spinner.isHidden = true
                                                        self.spinner.stopAnimating()
                                                        print("Current pstatus is \(pstatus)")
                                                                             if pstatus == false {
                                                                                 self.performSegue(withIdentifier: "taketoaddon", sender: nil)
                                                                             }
                                                                             else {
                                                                                 self.performSegue(withIdentifier: "logintodashboard", sender: nil)
                                                                             }

                                                                         }
                                                
                                                       
                                                
                                            }
                                        }
                                        else {
                                            self.loginbtn.isEnabled = true
                                            self.spinner.isHidden = true
                                            self.spinner.stopAnimating()
                                            self.otpstatus.text = "OTP verification failed "
                                            print("Otp Not Verified")
                                        }
                                    }
                                    
                                  }

                              }
            }
            else if self.mode == "forgot" {
                
                var p = self.newpassword.text
                var c = self.newconfirmpassword.text
                
                if p == "" || p == " " || p != c {
                    self.otpstatus.text = "Either password is empty or both password does not match."
                    return
                }
                
                
                
                var mo = ""
                var co = ""
               
                if let m = self.receivedotp?.mobilenumber as? String {
                    mo = m
                }
                if let c = self.receivedotp?.countrycode as? String {
                    co = c
                }
              
                
                let params : Dictionary<String,String> = ["PhoneNumber":"\(mo)","CountryCode":"\(co)","Code":"\(combinedcode)","Password":"\(self.newpassword.text)"]
                       
                       print(params)
                          
                       var vtok = ""
                       var vfn = ""
                       var vln = ""
                       var vpi = ""
                       var vrn = ""
                          
                          var url = Constants.K_baseUrl + Constants.resetPass
                          var r = BaseServiceClass()
                self.spinner.isHidden = false
                self.spinner.startAnimating()
                self.loginbtn.isEnabled = false
                          r.postApiRequest(url: url, parameters: params) { (data, err) in
                           if(err != nil) {
                               print(err)
                            self.loginbtn.isEnabled = true
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                           }
                              if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                                  
                                 if let usefuldata = resv["Result"] as? String,let ress = resv["ResponseStatus"] as? Int {
                                          print(usefuldata)
                                             if ress == 0{
                                                self.otpstatus.text = "Password successfully changed"
                                                self.otpfieldswrapper.isHidden = true
                                                self.loginbtn.isEnabled = true
                                                self.newpassword.isHidden = true
                                                
                                                self.newconfirmpassword.isHidden = true
                                                self.loginbtn.isHidden = true
                                                self.spinner.isHidden = true
                                                self.spinner.stopAnimating()
                                                print("Password successfully changed")
                                             }
                                             else {
                                                                            self.otpstatus.text = "Password could not be changed"
                                                self.loginbtn.isEnabled = true
                                                self.spinner.isHidden = true
                                                self.spinner.stopAnimating()
                                                 print("Password Could not be changed")
                                             }
                                         }
                                
                              }

                          }
                
                
                
            }
            else {
            
                    var mo = ""
                    var co = ""
                    var uo = ""
                var to = ""
                
                if let t = self.receivedotp?.token as? String {
                        to = t
                    }
                    if let m = self.receivedotp?.mobilenumber as? String {
                        mo = m
                    }
                    if let c = self.receivedotp?.countrycode as? String {
                        co = c
                    }
                    if let u = self.receivedotp?.refid as? String {
                        uo = u
                    }
                    
                    let params : Dictionary<String,String> = ["PhoneNumber":"\(mo)","CountryCode":"\(co)","Code":"\(combinedcode)","ID":"\(uo)"]
                           
                           print(params)
                              
                           var vtok = ""
                           var vfn = ""
                           var vln = ""
                           var vpi = ""
                           var vrn = ""
                              
                              var url = Constants.K_baseUrl + Constants.verifyNumber
                              var r = BaseServiceClass()
                self.spinner.isHidden = false
                self.spinner.startAnimating()
                self.loginbtn.isEnabled = false
                              r.postApiRequest(url: url, parameters: params) { (data, err) in
                               if(err != nil) {
                                   print(err)
                                self.loginbtn.isEnabled = true
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                               }
                                  if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                                      if let usefuldata = resv["Result"] as? Dictionary<String,Any> {
                                       print(usefuldata)
                                       if let token = usefuldata["token"] as? String {
                                           print("Token us \(token)")
                                           vtok = token
                                          
                                       }
                                        UserDefaults.standard.setValue("\(mo)" as? String, forKey: "mobile")

                                        if let rn = usefuldata["Ref_guid"] as? String {
                                                                           
                                                                           vrn = rn
                                                                           UserDefaults.standard.setValue(vrn as? String, forKey: "ref")
                                                                                               
                                                                           print("setting \(vrn) to refid")
                                                                           UserDefaults.standard.setValue(vrn as? String, forKey: "refid")

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
                                           
                                           if let gen = pdata["Gender"] as? String {
                                                                          UserDefaults.standard.set(gen, forKey: "gender")
                                                                      }
                                                                      
                                                                      if let dob = pdata["Dob"] as? String {
                                                                          UserDefaults.standard.set(dob, forKey: "dob")
                                                                      }
                                     

                                           if let profileimage = pdata["ProfileImg"] as? String {
                                               print("Profile Image is \(profileimage)")
                                               vpi = profileimage

                                           }
                                       }
                                      }
                                    if let ans = resv["ResponseStatus"] as? Int {
                                        if ans == 0 {
                                            if uo == vrn {
                                                   print("Verfied")
                                            UserDefaults.standard.setValue(vtok as? String, forKey: "token")
                                                
                            
                                                
                                           
                                                
                                        
                                        self.otpstatus.text = "User created and verified "
                                                print("User created and verified")
                                                
                                                DispatchQueue.global(qos: .background).async {
                                                    CoreDataManager.shared.loadallfromcontacts()
                                                    self.loginbtn.isEnabled = true
                                                    self.spinner.isHidden = true
                                                    self.spinner.stopAnimating()
                                                }
                                                DispatchQueue.main.async {
                                                    self.loginbtn.isEnabled = true
                                                    self.spinner.isHidden = true
                                                    self.spinner.stopAnimating()
                                                    self.performSegue(withIdentifier: "taketoaddon", sender: nil)

                                                }

                                                

                                                
                                                
                                            
                                            }
                                        }
                                        else {
                                            self.loginbtn.isEnabled = true
                                            self.otpstatus.text = "OTP verification failed "
                                            print("Otp Not Verified")
                                        }
                                    }
                                    
                                  }

                              }
            }
            
            
            
        }
    }
    
}
