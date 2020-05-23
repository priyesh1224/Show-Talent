//
//  EventdatafeedsimpleTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EventdatafeedsimpleTableViewCell: UITableViewCell , UITextFieldDelegate{
    
    var passback : ((_ selectedtype : inputstype) -> ())?
    
    var sendfieldvalue : ((_ selectedtype : inputstype, _ fieldvalue : String) -> ())?
    var sendtogglevalue : ((_ selectedtype : inputstype, _ fieldvalue : Bool) -> ())?
    var sendtogglevalue2 : ((_ fieldvalue : Bool) -> ())?
    
    
    
    @IBOutlet var upperlabel: UITextView!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var textfieldplaceholder: UITextField!
    
    @IBOutlet weak var textfieldheight: NSLayoutConstraint!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var toggle: UISwitch!
    
    @IBOutlet weak var changebtn: UIButton!
    
    var currentitem : inputstype?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfieldplaceholder.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.sendfieldvalue!(self.currentitem!, textfieldplaceholder.text!)
    }
    
    
    
    @IBAction func didchangetoggle(_ sender: UISwitch) {
        if self.toggle.isOn {
            self.sendtogglevalue!(self.currentitem! , true)
        }
        else {
            self.sendtogglevalue!(self.currentitem! , false)
        }
    }
    
    
    @IBAction func changepressed(_ sender: UIButton) {
        print("Heyyya")
        print("Will pass \(self.currentitem!)")

        self.passback!(self.currentitem!)
    }
    
    
    func updatecell(x:inputstype , y : Dictionary<String,Any>) {
        
        print(x)
        print(y)

        upperlabel.text = x.fieldname.capitalized
        let color = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        textfieldplaceholder.attributedPlaceholder = NSAttributedString(string: textfieldplaceholder.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        textfieldplaceholder.textColor = color
        label.textColor = color
        self.selectionStyle = .none
        self.changebtn.layer.cornerRadius = self.changebtn.frame.size.height/2
        self.currentitem = x
        if x.fieldtype == "dropdown" {
            self.textfieldplaceholder.isHidden = true
            self.label.isHidden = false
            self.changebtn.isHidden = false
//            self.label.text = x.fieldname.capitalized
            self.toggle.isHidden = true
            if let v = y[x.fieldname] as? String  {
                self.label.text = v.capitalized
            }
            else if let v = y[x.fieldname.capitalized] as? String  {
                self.label.text = v.capitalized
            }
            else if let v = y[x.fieldname] as? Int  {
                self.label.text = "\(v)"
            }
            else {
                self.label.text = ""
            }
            
        }
        else if x.fieldtype == "checkbox" {
            self.textfieldplaceholder.isHidden = true
            self.label.isHidden = true
            self.changebtn.isHidden = true
            self.toggle.isHidden = false
//            self.label.text = x.fieldname.capitalized

        }
        else {
            self.textfieldplaceholder.isHidden = false
            self.label.isHidden = true
            self.changebtn.isHidden = true
            self.toggle.isHidden = true
            if x.datatype == "textarea" {
                self.textfieldheight.constant = 80
            }
            if let v = y[x.fieldname] as? String  {
                self.textfieldplaceholder.text = v.capitalized
            }
            else if let v = y[x.fieldname.capitalized] as? String  {
                self.textfieldplaceholder.text = v.capitalized
            }
            else if let v = y[x.fieldname] as? Int  {
                self.textfieldplaceholder.text = "\(v)"
            }
            else {
                self.textfieldplaceholder.text = ""
            }
            

        }
        
        textfieldplaceholder.delegate = self
        
        textfieldplaceholder.placeholder = "Enter \(x.fieldname.capitalized)"
    }
    
    
    func updatecell2(x:inputstype , y : Dictionary<String,Any> , z : strevent) {
        print(x)
         print(y)
        
            upperlabel.text = x.fieldname.capitalized
   
        print("Original data")
        print(z)
        
        
        var val = ""
        
        if x.fieldname == "Contest Name" {
            val = z.contestname
        }
        else if x.fieldname == "Category" {
            val = z.allowcategory
        }
        else if x.fieldname == "Organisation Allowed" {
            if z.organisationallow {
                self.sendtogglevalue2!(true)
            }
            else {
                self.sendtogglevalue2!(false)
            }
        }

        else if x.fieldname == "Invitation type" {
            val = z.invitationtype
        }

        else if x.fieldname == "Entry Type" {
            val = z.entrytype
        }

        else if x.fieldname == "Entry Fees" {
            val = "\(z.entryfee)"
        }

        else if x.fieldname == "Contest Start Date" {
            val = z.conteststart
        }

        else if x.fieldname == "Contest Location" {
            val = z.contestlocation
        }

        else if x.fieldname == "Contest Result Date" {
            val = z.resulton
        }

        else if x.fieldname == "Contest Price" {
            val = z.contestprice
        }
        else if x.fieldname == "Contest Winner Price Type" {
            val = z.contestpricetype
        }

        else if x.fieldname == "Contest Result Type" {
            val = z.resulttype
        }

        else if x.fieldname == "Contest Theme" {
            val = z.contestprice
        }

        print(val)
        
        let color = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textfieldplaceholder.attributedPlaceholder = NSAttributedString(string: textfieldplaceholder.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        textfieldplaceholder.textColor = color
        label.textColor = color
        self.selectionStyle = .none
        self.changebtn.layer.cornerRadius = self.changebtn.frame.size.height/2
        self.currentitem = x
        
        if x.fieldtype == "dropdown" {
            self.textfieldplaceholder.isHidden = true
            self.label.isHidden = false
            
            self.changebtn.isHidden = false
//            self.label.text = val.capitalized
            self.toggle.isHidden = true
            print("Text for \(x.fieldname) is \(self.label.text)")
            if let v = y[x.fieldname] as? String  {
                self.label.text = v.capitalized
            }

            else if let v = y[x.fieldname.capitalized] as? String  {
                self.label.text = v.capitalized
            }
            else if let v = y[x.fieldname] as? Int  {
                self.label.text = "\(v)"
            }
            else {
                self.label.text = ""
            }
            
        }
        else if x.fieldtype == "checkbox" {
            self.textfieldplaceholder.isHidden = true
            self.label.isHidden = true
            self.changebtn.isHidden = true
            self.toggle.isHidden = false
//            self.label.text = x.fieldname.capitalized
            if z.organisationallow == true {
                self.toggle.setOn(true, animated: true)
                self.sendtogglevalue2!(true)
            }
            else {
                self.toggle.setOn(false, animated: true)
                self.sendtogglevalue2!(false)
            }
            print("Text for \(x.fieldname) is \(self.label.text)")


        }
        else {
            self.textfieldplaceholder.text = val
            self.textfieldplaceholder.isHidden = false
            self.label.isHidden = true
            self.changebtn.isHidden = true
            self.toggle.isHidden = true
            if x.datatype == "textarea" {
                self.textfieldheight.constant = 80
            }
            if let v = y[x.fieldname] as? String  {
                self.textfieldplaceholder.text = v.capitalized
            }
            else if let v = y[x.fieldname.capitalized] as? String  {
                self.textfieldplaceholder.text = v.capitalized
            }
            else if let v = y[x.fieldname] as? Int  {
                self.textfieldplaceholder.text = "\(v)"
            }
            else {
                self.textfieldplaceholder.text = ""
            }
            
            print("Text for \(x.fieldname) is \(self.textfieldplaceholder.text)")

        }
        self.sendfieldvalue!(self.currentitem!, val)
        
        textfieldplaceholder.delegate = self
        
        textfieldplaceholder.placeholder = "Enter \(x.fieldname.capitalized)"
    }
    
    func setlabeltitle(x: String) {
        if let fv = self.currentitem?.fieldname as? String {
        self.label.text = "\(x.capitalized)"
        }
        
    }
}


extension UITextField {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
