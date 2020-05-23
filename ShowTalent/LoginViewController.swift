//
//  LoginViewController.swift
//  ShowTalent
//
//  Created by apple on 8/30/19.
//  Copyright © 2019 apple. All rights reserved.

//struct LoginResp : Codable {
//var Error : String?
//var ResponseStatus : Int?
//
//var Result : Result?
//var TraceId : String?
//
//}
//struct Result : Codable {
//    var Ref_guid : String?
//    var profileStatus  : Int?
//    var token : String?
//    
//    
//}

import UIKit
import SkyFloatingLabelTextField
import ProgressHUD
import FontAwesome_swift
import ProgressHUD
import LGButton
class LoginViewController: UIViewController {

   
    //https://stackoverflow.com/questions/39390979/how-to-make-the-center-cell-of-the-uicollectionview-overlap-the-other-two-cells
  
    @IBOutlet weak var cardview: UIView!
    
    @IBOutlet weak var passtxtLbl: UILabel!
    @IBOutlet weak var desclbl: UILabel!
    @IBOutlet weak var btn_login: LGButton!
    @IBOutlet weak var txt_password: UnderLineImageTextField!
    @IBOutlet weak var txt_username: UnderLineImageTextField!
    var picker : UIPickerView!
    var toolBar : UIToolbar!
   // @IBOutlet weak var imgview: UIButton!
    var type : String?
    var  countrylist : [CountryCode]?
    var pickerData : [String] = []
    var ccode : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupview()
//        let picker: UIPickerView
        picker = UIPickerView(frame:  CGRect(x: 0, y: 200, width: self.view.frame.size.width , height: 250))//CGRectMake(0, 200, view.frame.width, 300))
        picker.backgroundColor = Constants.blueColor
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = Constants.blueColor
        toolBar.sizeToFit()
      //  imgview.layer.cornerRadius = imgview.frame.size.width/2
      //  imgview.clipsToBounds = true
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
    

        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
         // tableview.register(UINib(nibName: "TextFieldsTableViewCell", bundle: nil), forCellReuseIdentifier: "customTxtFld")
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      //   if txt_password.isEditing{
                translation = CGFloat(-keyboardSize.height / 4.8)
        //    }
        }
//        UIView.animate(withDuration: 0.2) {
//            self.view.transform = CGAffineTransform(translationX: 0, y: translation)
//        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
//        UIView.animate(withDuration: 0.2) {
//            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
//        }
    }
    
    @objc func donePicker()
    {
        txt_password.resignFirstResponder()
        
        if  (txt_password.text?.isEmpty)!
        {
            self.txt_password.text = pickerData.first
            ccode =  countrylist![0].dial_code
        }
        
        
    }
    
    
    
    func setupview()
    {
        cardview.layer.cornerRadius = 10
        cardview.layer.shadowRadius = 1.0
        cardview.layer.shadowColor = UIColor.gray.cgColor
        cardview.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
        cardview.layer.shadowOpacity = 0.5
        cardview.layer.masksToBounds = false
        
        let attrs1 = [NSAttributedString.Key.font : Constants.regularfonts(fontss: 16), NSAttributedString.Key.foregroundColor : UIColor.gray]
        
        let attrs2 = [NSAttributedString.Key.font : Constants.regularfonts(fontss: 16), NSAttributedString.Key.foregroundColor : UIColor.red]
        
        let attributedString1 = NSMutableAttributedString(string:"Don't have account? Swipe right to ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"Create a new account", attributes:attrs2)
        
        attributedString1.append(attributedString2)
    self.desclbl.attributedText = attributedString1
        
        txt_username.placeholder = "Username"
        txt_password.placeholder = "Password"
     //   txt_password.title = ""
        passtxtLbl.textColor = .gray
       //   passtxtLbl = "Password"
        passtxtLbl.text = "Password"
        
        txt_username.delegate = self
        txt_password.delegate = self
    

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
    
    
    @IBAction func login_clicked(_ sender: Any) {
        
        if txt_username.text!.count > 0 {
            
            if txt_password.text!.count > 0 {
                PostSinInRequest()
            }
            else{
                //                txt_password.errorColor = UIColor.red
                //                txt_password.errorMessage = "Password Cannot be empty"
            }
            
        }
            
        else
        {
            txt_username.shaketitle()

           //   txt_username.errorColor = UIColor.red
            //        txt_username.errorMessage = "Username Cannot be empty"
        }
        
        
    }
    @IBAction func signingClicked(_ sender: Any) {
        
        
        if txt_username.text!.count > 0 {
            if txt_password.text!.count > 0 {
            PostSinInRequest()
            }
            else{
//                txt_password.errorColor = UIColor.red
//                txt_password.errorMessage = "Password Cannot be empty"
            }
            
        }
    
    else
    {
//    txt_username.errorColor = UIColor.red
//        txt_username.errorMessage = "Username Cannot be empty"
    }
}

    
    func PostSinInRequest()
    {
        
        
        if Connectivity.isConnectedToInternet() {
        ProgressHUD.show()
        
        var urls : String?
        var params : Dictionary<String , Any>?
        
        if type == "Mobile" {
         params  =
        [
            "PhoneNumber": txt_username.text,
            "CountryCode": ccode,
            "DeviceId": UIDevice.current.identifierForVendor?.uuidString as! String,
            "FCMTokenID": "122632763176737623617863",
            "Devicetype": "iOS",
            "Devicename": UIDevice.current.name]
            
            
            urls = Constants.K_baseUrl + Constants.mlogin

        }
        else{
            params = [
            
            "Email": txt_username.text,
            "Password": txt_password.text ,
            "DeviceId": UIDevice.current.identifierForVendor?.uuidString as! String,
            "FCMTokenID": "122632763176737623617863",
            "Devicetype": "iOS",
            "Devicename": UIDevice.current.name
            ]
            urls = Constants.K_baseUrl + Constants.elogin

        }

        
    
        
        let request = BaseServiceClass()
        UserDefaults.standard.set(true, forKey: "noauth")
        request.postApiRequest(url: urls!, parameters: params! ) {  (response, err) in
                        if response != nil {
                print(response)
                let decoder = JSONDecoder()
                            let jsondata = try! decoder.decode(RegisterResponse<Datas>.self, from: (response?.data!)!)
                if jsondata.ResponseStatus == 0 {
                    
                    UserDefaults.standard.set(jsondata.Result?.token, forKey: "token")
                    
                        UserDefaults.standard.set(jsondata.Result?.Ref_guid, forKey: "refid")
                    
                       print("Token")
                    print(UserDefaults.standard.value(forKey: "refid") as! String)
                       print("Refid")
                    print(UserDefaults.standard.value(forKey: "refid") as! String)
                        
                       ProgressHUD.dismiss()
                    if self.type == "Mobile" {
                    self.performSegue(withIdentifier: "signInOtp", sender: self)
                 
                    }
                    
                    else{
                        
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabbars") as! TabBarViewController
                        let navigationController = UINavigationController(rootViewController: nextViewController)
                        let appdelegate = UIApplication.shared.delegate as! AppDelegate
                        appdelegate.window!.rootViewController = navigationController
                    }
                }
                else{
                      ProgressHUD.showError("Some thing went wrong")
                }
            }
            else
            {
                ProgressHUD.showError("Some thing went wrong")
                //showerror
            }
            
            
            
        }
        
        }
        else{
            let appdelgate = UIApplication.shared.delegate as? AppDelegate
            appdelgate?.showAlerts(title: "Internet!", message: "please connect to network and try again")
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signInOtp" {
            if let vc = segue.destination as? OtpViewController {
                vc.mobileNo = txt_username.text
                vc.cccode = ccode
                vc.refid = UserDefaults.standard.value(forKey: "refid") as! String
            }
        }
    }
    
    
    
}



extension LoginViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if txt_username.text!.contains("@")
        {
            
         //   DispatchQueue.main.async {
            passtxtLbl.text = "Password"
               // self.txt_password.title = "Password"
                self.txt_password.placeholder = "Password"

          //  }
            txt_password.isSecureTextEntry = true
            txt_password.inputView = nil
            txt_password.inputAccessoryView = nil
            type = "Email"
           
        }
        else if txt_username.text!.isInt
            
        {
          //  DispatchQueue.main.async {
            passtxtLbl.text = "Country Code"
               // self.txt_password.title = "Country code"
                self.txt_password.placeholder = "Country Code"
          //  }
         
            txt_password.isSecureTextEntry = false
            txt_password.inputView = picker
            txt_password.inputAccessoryView = toolBar
            type = "Mobile"
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txt_username
        {
            txt_username.becomeFirstResponder()
//                         if txt_username.text!.contains("@")
//
//                {
//                txt_password.title = ""
//                txt_password.title = "Password"
//                    txt_password.placeholder = "Password"
//                    txt_password.isSecureTextEntry = true
//                    txt_password.inputView = nil
//                    txt_password.inputAccessoryView = nil
//                    type = "Email"
//
//            }
//            else if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: txt_username.text!))
//            {
//
//                txt_password.title = ""
//               txt_password.title = "Country"
//                txt_password.placeholder = "Country Code"
//                txt_password.isSecureTextEntry = false
//                txt_password.inputView = picker
//                txt_password.inputAccessoryView = toolBar
//                type = "Mobile"
//            }
            }
//        }
        else{
            
            txt_password.becomeFirstResponder()
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txt_username
        {
            txt_username.resignFirstResponder()
        }
        else
        {
            if textField == txt_password
            {
                txt_password.resignFirstResponder()
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_username
        {
            txt_password.becomeFirstResponder()
        }
        else
        {
            txt_password.resignFirstResponder()
        }
        
        return true
    }
    

    
    
    
}
extension LoginViewController : UIPickerViewDelegate
{
    
    
}
extension LoginViewController : UIPickerViewDataSource {
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
        self.txt_password.text = pickerData[row]
        ccode =  countrylist![row].dial_code
        // ccode = code.dial_code
}
}




extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
