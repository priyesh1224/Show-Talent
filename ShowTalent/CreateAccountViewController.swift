//
//  CreateAccountViewController.swift
//  ShowTalent
//
//  Created by apple on 9/9/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import ProgressHUD

class CreateAccountViewController: UIViewController {

    var fname : String?
    var lname : String?
    var dob : String?
    var gender : String?
    var add1 : String?
    var add2 : String?
    var city : String?
    var state : String?
    var country : String?
    var datePicker : UIDatePicker?
    var toolbar : UIToolbar?
   // var dob : String?
    
    
    var selectedindexpath = IndexPath()
    
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create An Account"
        
        
         let screenWidth = UIScreen.main.bounds.width
         datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker!.datePickerMode = .date
    //    self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed())
        let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneButtonPressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPressed))
        
        
        toolbar!.setItems([cancelButton, flexibleSpace, doneBarButton], animated: false)
        
     //   self.inputAccessoryView = toolBar
            }
    @objc func cancelPressed() {
        self.resignFirstResponder()
        if let cell = self.tableview.cellForRow(at: self.selectedindexpath) as? TextFieldTableViewCell {
            cell.txtfld.endEditing(true)
        }
        
    }
    @objc func doneButtonPressed() {
        
        let indexPath = IndexPath.init(row: 2, section: 0)
        let cell = tableview.cellForRow(at: indexPath) as! TextFieldTableViewCell
        if let  datePicker = cell.txtfld.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            cell.txtfld.text = dateFormatter.string(from: datePicker.date)
            dob = dateFormatter.string(from: datePicker.date)
        }
        cell.txtfld.resignFirstResponder()
    }
   
    
    @objc func postUpdateequest() {
        ProgressHUD.show()
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let now = Date()
        let dateString = formatter.string(from:now)
    let request = BaseServiceClass()
    let params  : Dictionary<String , Any > =  [  "Ref_Guid": UserDefaults.standard.value(forKey: "refid") as? Any,
    "FirstName": fname as Any,
    "LastName": lname as Any,
    "CreateOn": dateString,
    "LastUpdate": dateString,
    "ProfileImg": "",
    "Gender": gender as Any,
    "Dob": dob,
    "Address1": add1 as Any,
    "Address2": add2 as Any,
    "City": city as Any,
    "State": state as Any,
    "Country": country as Any,
    "Location": "Mumbai",
    "Latitude": "19.0760",
    "Longitude": "72.8777",
    "IP": "192.168.0.0",
    "Device": UIDevice.current.name as Any,
    "AppVersion": Bundle.main.infoDictionary!["CFBundleShortVersionString"] as Any]
    UserDefaults.standard.set(false, forKey: "noauth")
      //  let request = BaseServiceClass()
//        request.postApiRequest(url: Constants.K_baseUrl+Constants.addProf, parameters: params ) {  (response, err) in
//
//            if response != nil{
////                print(response)
////                let decoder = JSONDecoder()
////                let jsondata = try! decoder.decode(RegisterResponse<Results>.self, from: (response?.data!)!)
//                var jresponse = Dictionary<String, Any>()
//                            do {
//                                let jsondata = try JSONSerialization.jsonObject(with: (response?.data!)!, options: .allowFragments) as! [String:Any]
//                                jresponse = jsondata
//                            } catch let error as NSError {
//                                print(error)
//                            }
//                if ((jresponse["ResponseStatus"] as? Int == 0) != nil) {
//                    ProgressHUD.dismiss()
//             //   if jsondata.ResponseStatus == 0
//
//
////                    UserDefaults.standard.set(jsondata.Result?.token, forKey: "token")
////                    UserDefaults.standard.set(jsondata.Result?.Ref_guid, forKey: "refid")
//
//
//                 self.performSegue(withIdentifier: "selectcat", sender: self)
//                }
//                else{
//                    ProgressHUD.showError("something went wrong please try again")
//
//                }
//            }
//            else
//            {
//               ProgressHUD.showError("something went wrong please try again")
//            }
//
//
//
//        }
}
 
}

extension CreateAccountViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "txtcel") as? TextFieldTableViewCell
        cell?.txtfld.placeholderColor = .black
        cell?.txtfld.foregroundColor = .white
        cell?.txtfld.layer.cornerRadius = 4
        cell?.txtfld.layer.borderWidth = 1.0
        cell?.txtfld.layer.borderColor = UIColor.blue.cgColor
         cell?.txtfld.tag = indexPath.row
        cell?.txtfld.delegate = self
        switch indexPath.row {
        
        case 0:
              cell?.txtfld.placeholder = "First Name"
             cell?.txtfld.returnKeyType = .next
              
             return cell!
            
        case 1:
            cell?.txtfld.placeholder = "Last Name"
            cell?.txtfld.returnKeyType = .next

            return cell!
            
        case 2:
           // cell?.txtfld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))

            cell?.txtfld.placeholder = "DOB"
            cell?.txtfld.inputView = datePicker
            cell?.txtfld.inputAccessoryView = toolbar
            self.selectedindexpath = indexPath
            return cell!
            
        case 3:
            cell?.txtfld.placeholder = "Gender"
            cell?.txtfld.returnKeyType = .next

            return cell!
            
        case 4:
            cell?.txtfld.placeholder = "Address1"
            cell?.txtfld.returnKeyType = .next

            return cell!
            
        case 5:
            cell?.txtfld.placeholder = "Address2"
            cell?.txtfld.returnKeyType = .next

            return cell!
        case 6:
            cell?.txtfld.placeholder = "City"
            cell?.txtfld.returnKeyType = .next

            return cell!
        case 7:
            cell?.txtfld.placeholder = "State"
            cell?.txtfld.returnKeyType = .next

            return cell!
        case 8:
            cell?.txtfld.placeholder = "Country"
            cell?.txtfld.returnKeyType = .done
            

            return cell!
        case  9 :
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "btncell") as? ButtonTableViewCell
//cell1?.btn.setTitle("SUBMIT", for: .normal)
            cell1?.btn.addTarget(self, action:#selector(postUpdateequest), for: .touchUpInside)
            return cell1!
        default:
           break
        }
    //    cell?.txtfld.placeholder = "First Name"
        
        return UITableViewCell()
       
    }
    
    
    
    
}

extension CreateAccountViewController : UITableViewDelegate
{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 9{
            return 50
        }
        else
        {
            return 70
        }
    }
}



extension CreateAccountViewController : UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
                switch textField.tag {
                case 0:
                    textField.becomeFirstResponder()
                case 1:
                    textField.becomeFirstResponder()
                case 2:
                    textField.becomeFirstResponder()
                case 3:
                    textField.becomeFirstResponder()
              
                case 4:
                    textField.becomeFirstResponder()
                case 5:
                        textField.becomeFirstResponder()
                case 6:
                    textField.becomeFirstResponder()
                case 7:
                        textField.becomeFirstResponder()
                case 8:
                    textField.becomeFirstResponder()
                case 9:
                    textField.becomeFirstResponder()
                default:
                    break
                }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            fname = textField.text
        case 1:
            lname = textField.text
        case 2:
            dob = textField.text
        case 3:
            gender = textField.text
            
        case 4:
            add1 = textField.text
        case 5:
            add2 = textField.text
        case 6:
            city = textField.text
        case 7:
            state = textField.text
        case 8:
            country = textField.text
        default:
            break
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let cellContainingFirstResponder = textField.superview?.superview
        var rowOfCellContainingFirstResponder: Int? = nil
        if let cellContainingFirstResponder = cellContainingFirstResponder as? UITableViewCell {
            rowOfCellContainingFirstResponder = tableview.indexPath(for: cellContainingFirstResponder)?.row ?? 0
        }
        // Get a reference to the next cell.
        let indexPathOfNextCell = IndexPath(row: (rowOfCellContainingFirstResponder ?? 0) + 1, section: 0)
        let nextCell = tableview.cellForRow(at: indexPathOfNextCell) as? TextFieldTableViewCell
        if nextCell != nil {
            nextCell?.txtfld.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
       // return  true
    }
 
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField.tag {
        case 0:
         fname = textField.text
        case 1:
          lname = textField.text
        case 2:
          dob = textField.text
        case 3:
          gender = textField.text
            
        case 4:
         add1 = textField.text
        case 5:
           add2 = textField.text
        case 6:
         city = textField.text
        case 7:
        state = textField.text
        case 8:
         country = textField.text
        default:
            break
        }
    }

}
extension UITextField {
    
    func addInputViewDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    //    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed())
    let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: selector)
             let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPressed))
        
        
        toolBar.setItems([cancelButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
        
        
    }
    
    
    
   @objc func cancelPressed() {
        self.resignFirstResponder()
    
    }

}
