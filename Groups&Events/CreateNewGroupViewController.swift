//
//  CreateNewGroupViewController.swift
//  ShowTalent
//
//  Created by maraekat on 22/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


struct groupbelong {
    var id : Int
    var name : String
}

struct groupcreated
{
    var groupid : Int
    var groupname : String
    var ref : Int
    var refuserid : String
    var createdon  :String
    var isDelete : Bool
    var otherbelong : String
    var youare : String
    var groupimage : String
}

class CreateNewGroupViewController: UIViewController,UIPickerViewDelegate , UIPickerViewDataSource,UITextFieldDelegate {

    
    var pickerdata : [groupbelong] = []
    var groupauthority : [groupbelong] = []
    
    var selectedbelong : groupbelong?
    var selectedauthority : groupbelong?
    
    var mode = "youare"
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    @IBOutlet weak var groupname: UITextField!
    
    @IBOutlet weak var createdby: UITextField!
    
    @IBOutlet weak var others: UITextField!
    @IBOutlet weak var youarea: UILabel!
    
    @IBOutlet weak var groupbelongingoutput: UILabel!
    
    
    @IBOutlet weak var createbottombtn: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBOutlet weak var piecker2: UIPickerView!
    
    @IBOutlet weak var picketouterview: UIView!
    
    @IBOutlet weak var pickerouterview2: UIView!
    
    
    var selectedgroupbelongto : groupbelong?
    
    var currentgroupcreated  : groupcreated?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationindicator.layer.cornerRadius = 10
        createbottombtn.layer.cornerRadius = 25
        picketouterview.layer.cornerRadius = 20
        picketouterview.isHidden = true
        pickerouterview2.isHidden = true
        picker.delegate = self
        picker.dataSource = self
        piecker2.delegate = self
        piecker2.dataSource = self
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 900)
        self.scroll.isScrollEnabled = true
        var fn = UserDefaults.standard.value(forKey: "firstname") as! String
        var ln = UserDefaults.standard.value(forKey: "lastname") as! String
        self.createdby.text = "\(fn) \(ln)"
        
        
        picker.tintColor = UIColor.white
        fetchgroupbelongto()
        groupname.delegate = self
        createdby.delegate = self
        others.delegate = self
        self.others.isEnabled = false
       
    }
    
    func fetchgroupbelongto()
    {
       
           
           let userid = UserDefaults.standard.value(forKey: "refid") as! String
        let params : Dictionary<String,Any> = ["Page":0  ,"PageSize": 9]

           
           
           
           
           var url = Constants.K_baseUrl + Constants.getallgroupmaster
           var r = BaseServiceClass()
           r.postApiRequest(url: url, parameters: params) { (data, err) in
               print("-----------------")
            if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                     if let inev =  inv["BelongGroupMaster"] as? Dictionary<String,AnyObject> {
                        if let innv =  inev["Data"] as? [Dictionary<String,AnyObject>] {
                            for each in innv {
                                var id = 0
                                var name = ""
                                if let i = each["ID"] as? Int,let n = each["GroupName"] as? String {
                                    id = i
                                    name = n
                                    var x = groupbelong(id: i, name: n)
                                    self.pickerdata.append(x)
                                }
                            }
                            self.picker.reloadAllComponents()
                        }
                    }
                    
                    if let inev =  inv["GroupAuthority"] as? Dictionary<String,AnyObject> {
                        if let innv =  inev["Data"] as? [Dictionary<String,AnyObject>] {
                            for each in innv {
                                var id = 0
                                var name = ""
                                if let i = each["ID"] as? Int,let n = each["Authority"] as? String , let m = each["IsActive"] as? Bool {
                                    id = i
                                    name = n
                                    var x = groupbelong(id: i, name: n)
                                    if m {
                                        self.groupauthority.append(x)
                                    }
                                }
                            }
                            self.piecker2.reloadAllComponents()
                        }
                        
                        print(self.groupauthority)
                    }
                }
            }
         
           }
           
    }
    
    
    
    
    func createnewgroup()
       {
          
              
              let userid = UserDefaults.standard.value(forKey: "refid") as! String
        
        var gn = ""
        var ref = 0
        var obelong = ""
        var youare = 0
        
        if let n = self.groupname.text as? String {
            gn = n
        }
        if let r = self.selectedgroupbelongto?.id as? Int {
            ref = r
        }

        if let o = self.others.text as? String {
            if self.others.isEnabled == true {
                obelong = o
            }
        }
        if let y = self.selectedauthority?.id as? Int {
            youare = y
        }
        let params : Dictionary<String,Any> = ["GroupName":gn  ,"Ref_BelongGroup": ref ,"OtherBelong": obelong   ,"YouAre":youare ]

              
              self.createbottombtn.isEnabled = false
              
              var url = Constants.K_baseUrl + Constants.creategroup
              var r = BaseServiceClass()
              r.postApiRequest(url: url, parameters: params) { (data, err) in
                  print("-----------------")
               if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                
                   if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                  
                           var groupid = 0
                         var groupname = ""
                         var ref = 0
                         var refuserid  = ""
                         var createdon  = ""
                         var isDelete = false
                         var otherbelong = ""
                         var youare = ""
                         var groupimage = ""
                    
                    if let gn = inv["GroupName"] as? String {
                        groupname = gn
                    }
                    if let gi  = inv["ID"] as? Int {
                        groupid = gi
                    }
                    if let rf = inv["Ref_BelongGroup"] as? Int {
                        ref = rf
                    }
                    if let ruser = inv["Ref_Userid"] as? String {
                        refuserid = ruser
                    }
                    if let creat = inv["CreatedOn"] as? String {
                        createdon = creat
                    }
                    if let idel = inv["IsDelete"] as? Bool {
                        isDelete = idel
                    }
                    if let ob = inv["OtherBelong"] as? String {
                        otherbelong = ob
                    }
                    if let ya = inv["YouAre"] as? String {
                        youare = ya
                    }
                    if let gim = inv["GroupImage"] as? String {
                        groupimage = gim
                    }
                    
                    
                    self.currentgroupcreated = groupcreated(groupid: groupid, groupname: groupname, ref: ref, refuserid: refuserid, createdon: createdon, isDelete: isDelete, otherbelong: otherbelong, youare: youare, groupimage: groupimage)
                    print("Group Created")
                    print(self.currentgroupcreated)
                    
                    self.performSegue(withIdentifier: "entergroup", sender: nil)
                   }
                   else {
                    self.createbottombtn.isEnabled = true
                    self.present(customalert.showalert(x: "Could not create group. Try again later."), animated: true, completion: nil)
                    }
               }
               else {
                self.createbottombtn.isEnabled = true

                self.present(customalert.showalert(x: "Could not create group. Try again later."), animated: true, completion: nil)
                }
            
              }
              
       }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        groupname.resignFirstResponder()
        createdby.resignFirstResponder()
        others.resignFirstResponder()
        
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         if pickerView.tag == 1 {
            return 1
        }
         else  if pickerView.tag == 2 {
            return 1
        }
       return 0
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerdata.count
        }
        else if pickerView.tag == 2 {
            print("Will render \(groupauthority.count)")
            return groupauthority.count
        }
        return 0
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        var c =  #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
//        if pickerView.tag == 1 {
//           return NSAttributedString(string: pickerdata[row].name.capitalized, attributes: [NSAttributedString.Key.foregroundColor: c ])
//        }
//        else if pickerView.tag == 2 {
//            return NSAttributedString(string: groupauthority[row].name.capitalized, attributes: [NSAttributedString.Key.foregroundColor: c ])
//        }
//        return NSAttributedString(string: "")
//
//    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          if pickerView.tag == 1 {
            return pickerdata[row].name.capitalized
        }
        else if pickerView.tag == 2 {
        return groupauthority[row].name.capitalized
        }
        return ""
    
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
    @IBAction func groupbenongtoclicked(_ sender: UIButton) {
        print("B")

        self.picketouterview.isHidden = false
        self.pickerouterview2.isHidden = true
    }
    
    
    
    @IBAction func youareapressed(_ sender: Any) {
        self.mode == "youare"
        print("A")

        self.pickerouterview2.isHidden = false
        self.picketouterview.isHidden = true
    }
    
   
    @IBAction func pickercancelled(_ sender: Any) {
        self.picketouterview.isHidden = true
    }
    
    
    @IBAction func creategrouptapped(_ sender: UIButton) {
        
        
        
        if let c = self.selectedgroupbelongto as? groupbelong {
            
        }
        else {
            self.present(customalert.showalert(x: "You need to select Group Belong To"), animated: true, completion: nil)
            return
        }
        if let c = self.selectedauthority as? groupbelong {
            
        }
        else {
            self.present(customalert.showalert(x: "You need to select your role."), animated: true, completion: nil)
            return
        }
        
        if self.groupname.text == "" || self.groupname.text == " " {
            self.present(customalert.showalert(x: "Enter Group Name"), animated: true, completion: nil)
            return
        }
        
        
        if self.others.isEnabled == true && (self.others.text == "" || self.others.text == " ") {
            self.present(customalert.showalert(x: "You need to enter Others field if the selected group belong to is Other"), animated: true, completion: nil)
            return
        }
        
        createnewgroup()
    }
    
    
    
    
    @IBAction func pickerok2(_ sender: Any) {
        self.selectedauthority = groupauthority[piecker2.selectedRow(inComponent: 0)]
        
        self.youarea.text = selectedauthority?.name.capitalized
        self.pickerouterview2.isHidden = true
        
    }
    
    
    @IBAction func cancel2pressed(_ sender: Any) {
        self.pickerouterview2.isHidden = true
    }
    
    
    @IBAction func pickerok(_ sender: Any) {
        
        self.selectedgroupbelongto = pickerdata[picker.selectedRow(inComponent: 0)]
        print(self.selectedgroupbelongto?.name)
        if selectedgroupbelongto?.name.lowercased() == "other" {
            self.others.isEnabled = true
        }
        else {
            self.others.isEnabled = false
        }
        self.groupbelongingoutput.text = selectedgroupbelongto?.name.capitalized
        self.picketouterview.isHidden = true
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? MainGroupViewController {
            if let s = self.currentgroupcreated as? groupcreated {
                seg.passedgroup = s
            }
            
        }
        
        if let seg = segue.destination as? GroupsandEventsContactvc {
            if let s = self.currentgroupcreated as? groupcreated {
                seg.passedgroup = s
            }
        }
    }
    
    
    
    

}
