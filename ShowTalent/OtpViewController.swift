//
//  OtpViewController.swift
//  ShowTalent
//
//  Created by apple on 9/5/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import OTPTextField
import LGButton
import ProgressHUD
class OtpViewController: UIViewController {
    @IBOutlet weak var lbl_mobileNo: UILabel!
    
    @IBOutlet weak var btn_submit: LGButton!
    @IBOutlet weak var txt_field6: UITextField!
    @IBOutlet weak var txt_field5: UITextField!
    
    @IBOutlet weak var txt_field4: UITextField!
    @IBOutlet weak var txt_field3: UITextField!
    @IBOutlet weak var txt_field2: UITextField!
    @IBOutlet weak var txt_field1: UITextField!
    var countdownTimer: Timer!
    var totalTime = 60
    var mobileNo : String?
    var refid : String?
    var cccode : String?
    var count : Int = 1
   // var totalTime3 =
    @IBOutlet weak var displaylbl: UILabel!
    
        
    @IBOutlet weak var btn_resendcode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationController?.navigationBar.prefersLargeTitles = false
       setUpView()
        btn_resendcode.isHidden = true
         //
        
        UINavigationBar.appearance().tintColor = .white
        
        // To apply textAttributes to title i.e. colour, font etc.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white,
                                                            .font : Constants.regularfonts(fontss: 20)]
        // To control navigation bar's translucency.
        UINavigationBar.appearance().isTranslucent = false
        self.navigationItem.backBarButtonItem=nil;
        self.title = "Verfiying Your Number!"
        count = +1
       
        lbl_mobileNo.text = "We have sent an OTP on your number \n \(cccode!)\(mobileNo!)"
        startTimer()
        
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        count = 0
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        displaylbl.text = "Resend Code: \(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            displaylbl.isHidden = true
            btn_resendcode.isHidden = false
            
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours : Int = (totalSeconds/3600)
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d:%02d",hours, minutes, seconds)
    }
   
    
    
    @IBAction func resendcode_clicked(_ sender: Any) {
        count += 1
        
        if count == 2{
        
    displaylbl.isHidden = false
            btn_resendcode.isHidden = true
            totalTime = 120
            displaylbl.isHidden = false
            btn_resendcode.isHidden = true
            startTimer()
           

        }
        
        else if count == 3{
           
            displaylbl.isHidden = false
            btn_resendcode.isHidden = true
         
            totalTime = 3600*7
               startTimer()
        }
    }
    @objc func textEditingDidBegin(_ sender: UITextField) {
        print("textEditDidBegin has been pressed")
        
                if !(sender.text?.isEmpty)!{
                    sender.selectAll(self)
                    //buttonUnSelected()
                }else{
                    print("Empty")
                    sender.text = " "
        
                }
    }
    @objc func textEditingChanged(_ sender: UITextField) {
        print("textEditChanged has been pressed")
                        let count = sender.text?.count
                        //
                        if count == 1{
        
                            switch sender {
                            case txt_field1:
                                txt_field2.becomeFirstResponder()
                            case txt_field2:
                                txt_field3.becomeFirstResponder()
                            case txt_field3:
                                txt_field4.becomeFirstResponder()
                            case txt_field4:
                                txt_field5.becomeFirstResponder()
                            case txt_field5:
                                txt_field6.becomeFirstResponder()
                            case txt_field6:
                                txt_field6.resignFirstResponder()
                            default:
                                print("default")
                            }
                        }
    }
    
   
    
    @IBAction func submit_clicked1(_ sender: Any) {
   
        
        
        if (txt_field1.text!.count > 0 && txt_field2.text!.count > 0 && txt_field3.text!.count > 0 && txt_field4.text!.count > 0 && txt_field5.text!.count > 0 && txt_field6.text!.count > 0)
        {
            
            
            let otp = "\(txt_field1!.text!)\( txt_field2!.text!)\( txt_field3!.text!)\( txt_field4!.text!)\( txt_field5!.text!)\( txt_field6!.text!)"
            
            print(otp)
            self.VerifyOtp(otp: otp)
        }
        else
        {
            //shoeweeor
        }
    }
    
    
    func VerifyOtp(otp : String)
    {
        ProgressHUD.show()
        
        
      
        let params : Dictionary<String , Any> =
        [
            "Code": otp,
            
            "PhoneNumber": mobileNo as Any,
            "ID": refid as Any,
            "CountryCode": cccode as Any
        ]
        
        
        
        
        let request = BaseServiceClass()
        UserDefaults.standard.set(true, forKey: "noauth")
        request.postApiRequest(url: Constants.K_baseUrl+Constants.verifyNumber, parameters: params ) {  (response, err) in
            
            if response != nil{
                print(response?.result)
                let decoder = JSONDecoder()
                let jsondata = try! decoder.decode(RegisterResponse<Result>.self, from: (response?.data!)!)
                if jsondata.ResponseStatus == 0 {
                    
                    ProgressHUD.dismiss()
                    if jsondata.Result!.profileStatus == false {
                    
                    self.performSegue(withIdentifier: "AccountVc", sender: self)
                    
                }
                else{
                  //      UserDefaults.standard.bool(forKey: "isLogin")
                        
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabbars") as! TabBarViewController
                        let navigationController = UINavigationController(rootViewController: nextViewController)
                        let appdelegate = UIApplication.shared.delegate as! AppDelegate
                        appdelegate.window!.rootViewController = navigationController

                }
                }
                else{
  ProgressHUD.showError(jsondata.Error?.ErrorMessage)                }
            }
            else
            {
                ProgressHUD.showError("something went wrong!")
            }
            
            
            
        }
        
        
    
    }
    
    
    func setUpView(){
//        txt_field1.setBorder()
//        txt_field2.setBorder()
//        txt_field3.setBorder()
//        txt_field4.setBorder()
//        txt_field5.setBorder
//         txt_field6.setBorder
        
        txt_field1.delegate = self
        txt_field2.delegate = self
        txt_field3.delegate = self
        txt_field4.delegate = self
         txt_field5.delegate = self
         txt_field6.delegate = self
        
       
        txt_field1.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
       txt_field2.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
       txt_field3.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        txt_field4.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        txt_field5.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
       txt_field6.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        
        txt_field1.addTarget(self, action: #selector(textEditingDidBegin(_:)), for: .editingDidBegin)
        txt_field2.addTarget(self, action: #selector(textEditingDidBegin(_:)), for: .editingDidBegin)
        txt_field3.addTarget(self, action: #selector(textEditingDidBegin(_:)), for: .editingDidBegin)
        txt_field4.addTarget(self, action: #selector(textEditingDidBegin(_:)), for: .editingDidBegin)
        txt_field5.addTarget(self, action: #selector(textEditingDidBegin(_:)), for: .editingDidBegin)
        txt_field6.addTarget(self, action: #selector(textEditingDidBegin(_:)), for: .editingDidBegin)
        
        
//         txt_field1.addTarget(self, action: "myTargetEditingDidBeginFunction:", forControlEvents: UIControlEvents.EditingDidBegin)
//         txt_field1.addTarget(self, action: "myTargetEditingDidBeginFunction:", forControlEvents: UIControlEvents.EditingDidBegin)
//         txt_field1.addTarget(self, action: "myTargetEditingDidBeginFunction:", forControlEvents: UIControlEvents.EditingDidBegin)
//         txt_field1.addTarget(self, action: "myTargetEditingDidBeginFunction:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        
        txt_field1.becomeFirstResponder()
        
       // buttonUnSelected()
    }

}
extension OtpViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = ""
        if textField.text == "" {
            print("Backspace has been pressed")
        }
        
        if string == ""
        {
            print("Backspace was pressed")
            switch textField {
            case txt_field2:
                txt_field1.becomeFirstResponder()
            case txt_field3:
                txt_field2.becomeFirstResponder()
            case txt_field4:
                txt_field3.becomeFirstResponder()
            case txt_field5:
                txt_field4.becomeFirstResponder()
            case txt_field6:
                txt_field5.becomeFirstResponder()
            default:
                print("default")
            }
            textField.text = ""
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      //  checkAllFilled()
    }
    

    
}
