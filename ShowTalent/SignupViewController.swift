//
//  SignupViewController.swift
//  ShowTalent
//
//  Created by apple on 8/30/19.
//  Copyright © 2019 apple. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField
import LGButton
import ProgressHUD

struct RegisterResponse<T : Decodable> : Decodable {
    var Error : Error1?
    var ResponseStatus : Int?
    
    var Result : Result?
    var Results : T?
    var TraceId : String?
    
}



struct Datas : Decodable {
    var Data_1 : [Data_]?
    enum CodingKeys: String, CodingKey {
        case Data_1 = "Data"
    }
}



struct Result : Codable {
  //
    
   // var Data : [Data_]?
    var Ref_guid : String?
    var profileStatus : Bool
    var token : String?
    
    
}

struct Error1 : Codable  {
    var  ErrorCode : Int?
    var ErrorMessage : String?
}


struct Results : Decodable {
    var Results : String?
}

class SignupViewController: UIViewController {

    @IBOutlet weak var desclbl: UILabel!
    //  @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var btn_signup: LGButton!
    //    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var scrollview: UIScrollView!
  //  @IBOutlet weak var scrollview: UIScrollView!
    //   @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var txt_confirmpass: UnderLineImageTextField!
    @IBOutlet weak var txt_password: UnderLineImageTextField!
    @IBOutlet weak var txt_mobile: UnderLineImageTextField!
    @IBOutlet weak var txt_email: UnderLineImageTextField!
   // @IBOutlet weak var btn_signup: UIButton!
  //  @IBOutlet weak var btn_signup: GradientButton!
    @IBOutlet weak var cardview: UIView!
    
    @IBOutlet weak var txt_country: SkyFloatingLabelTextFieldWithIcon!
     let appdelegate = UIApplication.shared.delegate as? AppDelegate
    var  countrylist : [CountryCode]?
    var pickerData : [String] = []
    var ccode : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       scrollview.contentSize = CGSize(width: self.view.frame.width-20, height:
        self.view.frame.height-100)
//scr
        scrollview.delaysContentTouches = false
        scrollview.isExclusiveTouch = false
      //  scrollview.delaysContentTouches = false
        
        //pickerData = ["1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10"]
        let picker: UIPickerView
        picker = UIPickerView(frame:  CGRect(x: 0, y: 200, width: self.view.frame.size.width , height: 250))//CGRectMake(0, 200, view.frame.width, 300))
        picker.backgroundColor = Constants.blueColor
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = Constants.blueColor
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
     txt_country.inputView = picker
txt_country.inputAccessoryView = toolBar
        
        
        

        setupview()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    
    
    
    }
    
    
    
//    @objc func donePicker()
//    {
//        txt_country.resignFirstResponder()
//
//
//    }
    @objc func donePicker()
    {
        txt_country.resignFirstResponder()
        
        if  (txt_country.text?.isEmpty)!
        {
            self.txt_country.text = pickerData.first
            ccode =  countrylist![0].dial_code
        }
        
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if txt_mobile.isEditing{
                translation = CGFloat(-keyboardSize.height / 4.8)
            }
            else if txt_password.isEditing {
                translation = CGFloat(-keyboardSize.height / 2.8)
                
            }
            else if txt_confirmpass.isEditing {
                translation = CGFloat(-keyboardSize.height / 1.4)
        }
        }
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: translation)
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    

    func setupview()
    {
        let attrs1 = [NSAttributedString.Key.font : Constants.regularfonts(fontss: 16), NSAttributedString.Key.foregroundColor : UIColor.gray]
        
        let attrs2 = [NSAttributedString.Key.font : Constants.regularfonts(fontss: 16), NSAttributedString.Key.foregroundColor : UIColor.red]
        
           let attrs3 = [NSAttributedString.Key.font : Constants.regularfonts(fontss: 16), NSAttributedString.Key.foregroundColor : UIColor.gray]
          let attrs4 = [NSAttributedString.Key.font : Constants.regularfonts(fontss: 16), NSAttributedString.Key.foregroundColor : UIColor.red]
        
        let attributedString1 = NSMutableAttributedString(string:"By creating an account, you agree to our ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"Terms of Service ", attributes:attrs2)
        
         let attributedString3 = NSMutableAttributedString(string:"and ", attributes:attrs3)
         let attributedString4 = NSMutableAttributedString(string:"Privacy Policy", attributes:attrs4)
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
        self.desclbl.attributedText = attributedString1
        
        txt_email.delegate = self
        txt_email.returnKeyType = .next
       /// txt_email.iconFont =
//            txt_email.iconImage = UIImage(named: "mail")
//        txt_email.iconWidth = 20
//        txt_email.iconMarginLeft = 10
//        txt_email.iconMarginBottom = 6
        txt_password.delegate = self
      //  txt_username.iconFont =
//            txt_password.iconImage = UIImage(named: "password")
//        txt_password.iconWidth = 20
//        txt_password.iconMarginLeft = 10
//        txt_password.iconMarginBottom = 6
        txt_mobile.delegate = self
        txt_mobile.returnKeyType = .next
   //     txt_mobile.iconFont =
//        txt_mobile.iconImage = UIImage(named: "Profile")
//        txt_mobile.iconWidth = 20
//        txt_mobile.iconMarginLeft = 10
//        txt_mobile.iconMarginBottom = 6
        txt_confirmpass.delegate = self
        //txt_confirmpass.iconFont =
//            txt_confirmpass.iconImage = UIImage(named: "password")
//        txt_confirmpass.iconWidth = 20
//        txt_confirmpass.iconMarginLeft = 10
//        txt_confirmpass.iconMarginBottom = 6
//
        
        cardview.layer.cornerRadius = 10
        cardview.layer.shadowRadius = 1.0
        cardview.layer.shadowColor = UIColor.gray.cgColor
        cardview.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
        cardview.layer.shadowOpacity = 0.5
        cardview.layer.masksToBounds = false
//        cardview.layer.shadowColor = UIColor.black.cgColor
//        cardview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        cardview.layer.shadowOpacity = 0.8
      //  cardview.layer.masksToBounds = false
        
        
        
//        btn_signup.layer.cornerRadius = btn_signup.frame.height/2
//        btn_signup.layer.shadowRadius = 3.0
//        btn_signup.layer.shadowColor = UIColor.blue.cgColor
//        btn_signup.layer.shadowOffset = CGSize(width: 2, height: 3.0)
//        btn_signup.layer.shadowOpacity = 0.5
//        btn_signup.layer.masksToBounds = false
        
        if let path = Bundle.main.path(forResource: "country", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jList = try JSONDecoder().decode([CountryCode].self, from: data)
                
                
                self.countrylist = jList
                self.pickerData = (self.countrylist?.map { $0.name })! as! [String]
             
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        
        
    }
    
    
    func PostSignUpRequest()
    {
          if Connectivity.isConnectedToInternet() {
        ProgressHUD.show()
        UserDefaults.standard.set(true, forKey: "noauth")

        
        
   //     let activityindicator = UIActivityIndicatorView()
//        let device = UIDevice.current.name
//        let deviceID = UIDevice.current.identifierForVendor?.uuidString
//
        let params : Dictionary<String , Any> =
            ["Email": txt_email.text!,
             "Password": txt_password.text!,
             "Mobile": txt_mobile.text!,
             "CountryCode": ccode!,
             "DeviceId": UIDevice.current.identifierForVendor?.uuidString as! String,
             "FCMTokenID": "12263276317673762361786323",
             "Devicetype": "iOS",
             "Devicename": UIDevice.current.name]
        
        
        
        
        let request = BaseServiceClass()
        request.postApiRequest(url: Constants.K_baseUrl+Constants.registerUrl, parameters: params ) {  (response, err) in

            if response != nil{
     print(response)
                let decoder = JSONDecoder()
                let jsondata = try! decoder.decode(RegisterResponse<Datas>.self, from: (response?.data!)!)
                if jsondata.ResponseStatus == 0 {
                    
                    
                    
                    UserDefaults.standard.set(jsondata.Result?.token, forKey: "token")
                    UserDefaults.standard.set(jsondata.Result?.Ref_guid, forKey: "refid")
                    
                    
                    self.performSegue(withIdentifier: "otpvc", sender: self)
                    ProgressHUD.dismiss()
                }
                else{
                    ProgressHUD.showError(jsondata.Error?.ErrorMessage)
                }
            }
            else
            {
                 ProgressHUD.showError("Something Went wrong please try again")
            }



        }
          }
            else{
                let appdelgate = UIApplication.shared.delegate as? AppDelegate
                appdelgate?.showAlerts(title: "Internet!", message: "please connect to network and try again")
                
            }
    }
    
    
    
    

    
    
    @IBAction func signup_clicked(_ sender: Any) {
   

        
        if txt_email.text!.count > 0 {
            
            if txt_mobile.text!.count > 0
            {
                if txt_country.text!.count > 0
                {
                    
                    if txt_password!.text!.count > 0
                    {
               //         let bool1 = validate(password: txt_password.text!)
                        
//                        if bool1 == true
//                        {
                            if txt_confirmpass!.text!.count > 0 {
                                if txt_confirmpass.text != txt_password.text
                                {
                                    let apdelegate = UIApplication.shared.delegate as? AppDelegate
                                    apdelegate?.showAlerts(title: "Error!", message: "Password and Confirm Password should be same")
                                }
                                else{
                                    
                                    PostSignUpRequest()
                                }
                        }
                            else
                            {
                                let apdelegate = UIApplication.shared.delegate as? AppDelegate
                                apdelegate?.showAlerts(title: "Error!", message: "Confirm password cannot be empty.")
                            }

                       // }
//
                        
                        
                        
                       
                        }
                   // }
                    else{
                        appdelegate?.showAlerts(title: "Error!", message: "Password Cannot b be empty")
                    }
                }
                else{
                    appdelegate?.showAlerts(title: "Error!", message: "Please select Country")
                    
                }
                
                
            }
            else{
                appdelegate?.showAlerts(title: "Error!", message: "Mobile No. Cannot be empty.")
                
            }
            
        }
        else{
            appdelegate?.showAlerts(title: "Error!", message: "Email Cannot be empty.")

        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "otpvc" {
            if let vc = segue.destination as? OtpViewController {
               vc.mobileNo = txt_mobile.text
                vc.cccode = ccode
                vc.refid = UserDefaults.standard.value(forKey: "refid") as! String
            }
        }
    }
    func validate(password: String) -> Bool
    {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: password)
    }

}




extension SignupViewController : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txt_email
        {
            txt_email.becomeFirstResponder()
           
        }
            else if textField == txt_mobile
        {
            txt_mobile.becomeFirstResponder()
        }
            
        else if textField ==  txt_country {
            txt_password.becomeFirstResponder()
        }
        else if textField ==  txt_password {
          txt_password.becomeFirstResponder()
          //  self.pickupo
        }
        else{
            txt_confirmpass.becomeFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txt_email
        {
            txt_email.resignFirstResponder()
            
        }
        else if textField == txt_mobile
        {
            txt_mobile.resignFirstResponder()
        }
            
        else if textField == txt_password {
            txt_password.resignFirstResponder()
        }
        else{
            txt_confirmpass.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_email
        {
            txt_email.resignFirstResponder()
            txt_mobile.becomeFirstResponder()
            
        }
        else if textField == txt_mobile
        {
            txt_mobile.resignFirstResponder()
            txt_password.becomeFirstResponder()
        }
            
        else if textField == txt_password {
            
          
        txt_password.resignFirstResponder()
            txt_confirmpass.becomeFirstResponder()
}
else{
    txt_confirmpass.resignFirstResponder()

        }
        return true
    }
    
    //  func text
    
    
    
    
    
}


extension SignupViewController : UIPickerViewDelegate
{
    
    
}


extension SignupViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txt_country.text = pickerData[row]
        ccode =  countrylist![row].dial_code
       // ccode = code.dial_code
    }
    //MARK:- TextFiled Delegate
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.pickUp(txt_pickUpData)
//    }
    
    
    
}

