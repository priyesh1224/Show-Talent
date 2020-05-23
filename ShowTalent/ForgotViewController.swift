//
//  ForgotViewController.swift
//  ShowTalent
//
//  Created by apple on 8/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Foundation
import SkyFloatingLabelTextField
import FontAwesome_swift
import LGButton
import ProgressHUD


class ForgotViewController: UIViewController {
    @IBOutlet weak var txt_forgot: UnderLineImageTextField!
    @IBOutlet weak var cardview: UIView!
    
    @IBOutlet weak var txt_selectCountry: UnderLineImageTextField!
    @IBOutlet weak var txt_emial: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var forgetbtn: LGButton!
    var picker : UIPickerView!
    var toolBar : UIToolbar!
    // @IBOutlet weak var imgview: UIButton!
    var type : String?
    var  countrylist : [CountryCode]?
    var pickerData : [String] = []
     var ccode : String?
  //  @IBOutlet weak var btn_sendEmail: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.title = "Verfiying your number"
       
        setupView()
        
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
    
        txt_selectCountry.inputView = picker
        txt_selectCountry.inputAccessoryView = toolBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if txt_forgot.isEditing{
                translation = CGFloat(-keyboardSize.height / 4.8)
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
    
    
    @objc func donePicker()
    {
        txt_selectCountry.resignFirstResponder()
        
        if  (txt_selectCountry.text?.isEmpty)!
        {
            self.txt_selectCountry.text = pickerData.first
            ccode =  countrylist![0].dial_code
        }
        
        
        
    }
    
    
    @IBAction func forgt_clicked(_ sender: Any) {
        
        
        if txt_forgot.text!.count > 0 {
            if txt_selectCountry.text!.count > 0 {
                
        postPasswordRequest()
                
               //
                
            }
            else
            {
                
                
            }
        }
        else
        {
            
        }
        
        //self.performSegue(withIdentifier: "resetVC", sender: self)
    }
    
    func postPasswordRequest()
    {
        if Connectivity.isConnectedToInternet() {
            ProgressHUD.show()
            
            var urls : String?
            var params : Dictionary<String , Any>?
            
          
                params  =
                    [
                        "PhoneNumber" : txt_forgot.text as Any ,
                        "CountryCode" : ccode
                ]
                
                urls = Constants.K_baseUrl + Constants.forGotPassUrl
                
        
          
            
            
            
            
            let request = BaseServiceClass()
            UserDefaults.standard.set(true, forKey: "noauth")
            request.postApiRequest(url: urls!, parameters: params! ) {  (response, err) in
                if response != nil {
                    print(response)
                    
                    
                    var jresponse = Dictionary<String, Any>()
                                do {
                                    let jsondata = try JSONSerialization.jsonObject(with: (response?.data!)!, options: .allowFragments) as! [String:Any]
                                    jresponse = jsondata
                                } catch let error as NSError {
                                    print(error)
                                }
                                if jresponse["ResponseStatus"] as? Int
                    
                                    == 0 {
                                    
                                    ProgressHUD.dismiss()
                                    self.performSegue(withIdentifier: "resetVC", sender: self)
                                    
                                }
                                else{
                                    
                                    let error = jresponse["Error"] as? [String : Any]
                                    
                                  //  let eee = error!["ErrorMessage"] as? String
                                    
                                    
                                    
                               ProgressHUD.showError("Some thing went wrong")
                    
                                    
                                    
                                    
                                    
                    }
                                 //   let responses = jresponse["Results"] as? [String: Any]
                    //            let decoder = JSONDecoder()
                    //                let jsondata = try! decoder.decode(Activities.self, from: ((response?.data)!))
                    
                    
//                                    let jsonData1 = try! JSONSerialization.data(withJSONObject: responses as Any)
//                                    let jsonString = NSString(data: jsonData1, encoding: String.Encoding.utf8.rawValue)
//
//                                    let decoder = JSONDecoder()
//                                    let jsondata = try! decoder.decode(Activities.self, from: ((jsonData1)))
//
//                                    print(jsondata)
                    
                    
                    
                    
                    
                    
                    
//
//                    let decoder = JSONDecoder()
//                    let jsondata = try! decoder.decode(RegisterResponse<Datas>.self, from: (response?.data!)!)
//                    if jsondata.ResponseStatus == 0 {
//
//                        self.performSegue(withIdentifier: "resetVC", sender: self)
//
//                    }
//                    else{
//                        ProgressHUD.showError(jsondata.Error?.ErrorMessage)
//                    }
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
        if segue.identifier == "resetVC" {
            if let vc = segue.destination as? ResetPasswordViewController {
              vc.phonenumber = txt_forgot.text
                vc.cccode = ccode
            }
        }
    }
        
        
   // }
    
    
    func setupView()
{
 //   txt_forgot.iconFont = UIFont.fontAwesome(ofSize: 20, style: .regular)
   // txt_forgot.iconText = String.fontAwesomeIcon(name: .user)
    txt_forgot.delegate = self
    txt_forgot.returnKeyType = .done
   // txt_forgot.delegate = self
   // txt_password.iconWidth = 20
  //  txt_forgot.iconMarginLeft = 10
   // txt_forgot.iconMarginBottom = 5
   // txt_forgot.placeholder = "Email / Mobile No."
//    txt_password.placeholder = "Password"
     //  txt_selectCountry.title = "Select Country"
 
   // txt_selectCountry.placeholder = "Country"
    
    
    cardview.layer.cornerRadius = 10
    cardview.layer.shadowRadius = 1.0
    cardview.layer.shadowColor = UIColor.gray.cgColor
    cardview.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
    cardview.layer.shadowOpacity = 0.5
    cardview.layer.masksToBounds = false
    
    
    
//    btn_sendEmail.layer.cornerRadius = btn_sendEmail.frame.height/2
//    btn_sendEmail.layer.shadowRadius = 3.0
//    btn_sendEmail.layer.shadowColor = UIColor.blue.cgColor
//    btn_sendEmail.layer.shadowOffset = CGSize(width: 2, height: 3.0)
//    btn_sendEmail.layer.shadowOpacity = 0.5
//    btn_sendEmail.layer.masksToBounds = false
//
    }

}

extension ForgotViewController : UITextFieldDelegate {
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        if textField == txt_forgot
        {
            txt_forgot.becomeFirstResponder()
            
            
        }
          
        else{
            
            txt_selectCountry.becomeFirstResponder()
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if textField == txt_forgot
        {
            txt_forgot.resignFirstResponder()
        }
        else
        {
            if textField == txt_selectCountry
            {
                txt_selectCountry.resignFirstResponder()
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_forgot
        {
            txt_selectCountry.becomeFirstResponder()
        }
        else
        {
            txt_selectCountry.resignFirstResponder()
        }
        
        return true
    }
    
    
}


    








extension ForgotViewController : UIPickerViewDelegate {
    
}



extension ForgotViewController : UIPickerViewDataSource {
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
        self.txt_selectCountry.text = pickerData[row]
        ccode =  countrylist![row].dial_code
       // ccode = ccode.dial_code
    }
}
