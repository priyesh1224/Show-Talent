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

class CreateNewGroupViewController: UIViewController,UIPickerViewDelegate , UIPickerViewDataSource,UITextFieldDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
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
    
    
    var groupid = 1097
    
    var allpasseddata : Dictionary<String,Dictionary<String,Any>> = [:]
    var imgsarray : [UIImage] = []
    var imgsext : [String] = []
    
    var imgtypes : Dictionary<String,String> = [:]
    var image1 : UIImage?
    var image2 : UIImage?
    var image3 : UIImage?
    
    var pc : UIImagePickerController?
    
     var imagetobeuploaded = "one"
    @IBOutlet weak var im1: UIImageView!
    
    @IBOutlet weak var im2: UIImageView!
    
    
    @IBOutlet weak var im3: UIImageView!
    
    
    
    @IBOutlet weak var uploadbtn1: UIButton!
    
    @IBOutlet weak var uploadbtn2: UIButton!
    
    
    @IBOutlet weak var uploadbtn3: UIButton!
    
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
        
        uploadbtn1.layer.cornerRadius = uploadbtn1.frame.size.height/2
        uploadbtn2.layer.cornerRadius = uploadbtn2.frame.size.height/2
        uploadbtn3.layer.cornerRadius = uploadbtn3.frame.size.height/2
        pc = UIImagePickerController()
                      pc?.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                      pc?.allowsEditing = true
                      pc?.mediaTypes = ["public.image"]
                      pc?.sourceType = .photoLibrary
       
    }
    
    @IBAction func uploadim1tapped(_ sender: Any) {
           
           
           imagetobeuploaded = "one"
           if let im = image1 as? UIImage {
               let alert = UIAlertController(title: "Are you sure you want to remove Image ?", message: nil, preferredStyle: .actionSheet)
                                 alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { _ in
                                  self.image1 = nil
                                  self.im1.image = nil
                                  self.uploadbtn1.setTitle("Upload Image", for: .normal)
                                  
                                 }))
                                  alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                              self.present(alert, animated: true, completion: nil)
           }
           else {
          
                          
                          
                             
                                  
                              let alert2 = UIAlertController(title: "Select From", message: nil, preferredStyle: .actionSheet)
                              alert2.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                                  if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                                  {
                                      self.pc?.sourceType = .camera
                                      self.pc?.allowsEditing = true
                                      self.present(self.pc!, animated: true, completion: nil)
                                      
                                  }
                                  
                              }))
                          alert2.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                              
                                  self.pc?.sourceType = .photoLibrary
                                  self.pc?.allowsEditing = true
                                  self.present(self.pc!, animated: true, completion: nil)
                                  
                              
                              
                          }))
                              
                              alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                          self.present(alert2, animated: true, completion: nil)
                          
                              
                          
                          
                   
            
           }

       }
       
       
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                  
                  
                  if picker.sourceType == .photoLibrary {
                      let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                      if (assetPath.absoluteString?.hasSuffix("JPG"))! {
                          print("JPG")
                          self.imgtypes[self.imagetobeuploaded] =  "jpg"
                      }
                      else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
                          self.imgtypes[self.imagetobeuploaded] =  "png"
                      }
                      else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
                         self.imgtypes[self.imagetobeuploaded] =  "gif"
                      }
                      else {
                          self.imgtypes[self.imagetobeuploaded] =  "unknown"
                      }
                  }
                  else if picker.sourceType == .camera {
                      self.imgtypes[self.imagetobeuploaded] =  "jpg"
                  }
                  
                  if let mt = info[.mediaType] as? String {
                      
                      if mt == "public.image" {
                          if let image = info[.editedImage] as? UIImage {
                              if self.imagetobeuploaded == "one" {
                                  image1 = image
                                  self.im1.image = image
                                  self.uploadbtn1.setTitle("Remove Image", for: .normal)
                              }
                              else if self.imagetobeuploaded == "two" {
                                  image2 = image
                                  self.im2.image = image
                                  self.uploadbtn2.setTitle("Remove Image", for: .normal)
                              }
                              else {
                                  image3 = image
                                  self.im3.image = image
                                  self.uploadbtn3.setTitle("Remove Image", for: .normal)
                              }
                              
                          }
                          
                      }
                          
                      
                  }
                  self.pc?.dismiss(animated: true, completion: nil)
                  
                  
                  
                  
                  
                  
                  
                  
          //        if let image = info[.editedImage] as? UIImage {
          //          self.imagebanner.image = image
          //        if picker.sourceType == .photoLibrary {
          //                   let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
          //                         if (assetPath.absoluteString?.hasSuffix("JPG"))! {
          //                             print("JPG")
          //                             self.imgtypes.append("jpg")
          //                         }
          //                         else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
          //                             self.imgtypes.append("png")
          //                             }
          //                         else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
          //                             self.imgtypes.append("gif")
          //                         }
          //                         else {
          //                             self.imgtypes.append("unknown")
          //                         }
          //               }
          //               else if picker.sourceType == .camera {
          //                   self.imgtypes.append("jpg")
          //               }
          //            uploadeventphoto(img : [image])
          //           self.dismiss(animated: true, completion: nil)
          //            self.addphotobtn.setTitle("Change Photo", for: .normal)
          //
          //        }
          //        else
          //        {
          //            print("Upload failed")
          //        }
                  
                  
              }
       
     
    func uploaddocumentstoverify()
    {
        
        if self.im1.image == nil && self.im2.image == nil && self.im3.image == nil {
            self.present(customalert.showalert(x: "You need to upload atleast one document"), animated: true, completion: nil)
        }
        else {
        
        
        
        allpasseddata.removeAll()
        
        if let i = image1 as? UIImage {
            allpasseddata["one"] = ["documentid_1" : i]
            if let i = image2 as? UIImage {
                allpasseddata["two"] = ["documentid_2" : i]
                if let i = image3 as? UIImage {
                    allpasseddata["three"] = ["documentid_3" : i]
                }
            }
            else if let i = image3 as? UIImage {
                allpasseddata["two"] = ["documentid_2" : i]
            }
        }
        else {
            if let i = image2 as? UIImage {
                allpasseddata["one"] = ["documentid_1" : i]
                if let i = image3 as? UIImage {
                    allpasseddata["two"] = ["documentid_2" : i]
                }
            }
            else {
                if let i = image3 as? UIImage {
                    allpasseddata["one"] = ["documentid_1" : i]
                }
                
            }
            
            
        }
        
        
        for each in allpasseddata {
            
                for nn in each.value {
                    if let t = nn.value as? UIImage {
                        self.imgsarray.append(t)
                        self.imgsext.append(self.imgtypes["\(each.key)"] ?? "")
                    }
                    
                }
                
            
        }
            
            print("All Params")
            print(self.groupid)
            print("-------")
            print(allpasseddata)
            print("-------")
            print(imgsarray)
            print("-------")
            print(imgsext)
        
        
        var r = ImageUploadRequest()
        r.uploadgroupverificationimages(imagesdata: allpasseddata, imgsarray:imgsarray, params: ["groupId":self.groupid], extensiontype: self.imgtypes, exttype: imgsext) { (response, err) in
            print(response)
            if response == "done" {
                let alert2 = UIAlertController(title: "Documents Uploaded", message: "", preferredStyle: .actionSheet)
                alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    self.performSegue(withIdentifier: "entergroup", sender: nil)
                                                           
                }));
                self.present(alert2, animated: true, completion: nil)
            }
            
            if let res = response as? Dictionary<String,Any> {
                print("hello")
                print(res)
                if let code = res["ResponseStatus"] as? Int {
                    print("code is \(code)")
                    if code == 0 {
                        let alert2 = UIAlertController(title: "Documents Uploaded", message: "", preferredStyle: .actionSheet)
                        alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            self.performSegue(withIdentifier: "entergroup", sender: nil)
                                                                   
                        }));
                        self.present(alert2, animated: true, completion: nil)
                    }
                    else {
                        let alert2 = UIAlertController(title: "Documents Could not be Uploaded", message: "", preferredStyle: .actionSheet)
                        alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                                                   
                        }));
                        self.present(alert2, animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        print(allpasseddata)
        }
    }
       
       
       
       
       
       @IBAction func uploadim2tapped(_ sender: Any) {
           imagetobeuploaded = "two"
                  if let im = image2 as? UIImage {
                      let alert = UIAlertController(title: "Are you sure you want to remove Image ?", message: nil, preferredStyle: .actionSheet)
                      alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { _ in
                       self.image2 = nil
                       self.im2.image = nil
                       self.uploadbtn2.setTitle("Upload Image", for: .normal)
                       
                      }))
                       alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                   self.present(alert, animated: true, completion: nil)
                  }
                  else {
  
                                       
                                     let alert2 = UIAlertController(title: "Select From", message: nil, preferredStyle: .actionSheet)
                                     alert2.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                                         if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                                         {
                                             self.pc?.sourceType = .camera
                                             self.pc?.allowsEditing = true
                                             self.present(self.pc!, animated: true, completion: nil)
                                             
                                         }
                                         
                                     }))
                                 alert2.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                                     
                                         self.pc?.sourceType = .photoLibrary
                                         self.pc?.allowsEditing = true
                                         self.present(self.pc!, animated: true, completion: nil)
                                         
                                     
                                     
                                 }))
                                     
                                     alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                 self.present(alert2, animated: true, completion: nil)
                                 
                                     
                                 
                                 
            
                  }
       }
       
       
       @IBAction func uploadim3tapped(_ sender: Any) {
           imagetobeuploaded = "three"
                 if let im = image3 as? UIImage {
                      let alert = UIAlertController(title: "Are you sure you want to remove Image ?", message: nil, preferredStyle: .actionSheet)
                                        alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { _ in
                                         self.image3 = nil
                                         self.im3.image = nil
                                         self.uploadbtn3.setTitle("Upload Image", for: .normal)
                                         
                                        }))
                                         alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                     self.present(alert, animated: true, completion: nil)
                  }
                  else {

                                     
                                     let alert2 = UIAlertController(title: "Select From", message: nil, preferredStyle: .actionSheet)
                                     alert2.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                                         if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                                         {
                                             self.pc?.sourceType = .camera
                                             self.pc?.allowsEditing = true
                                             self.present(self.pc!, animated: true, completion: nil)
                                             
                                         }
                                         
                                     }))
                                 alert2.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                                     
                                         self.pc?.sourceType = .photoLibrary
                                         self.pc?.allowsEditing = true
                                         self.present(self.pc!, animated: true, completion: nil)
                                         
                                     
                                     
                                 }))
                                     
                                 alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                                 self.present(alert2, animated: true, completion: nil)
     

                  }
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
        var allow = true
        
        if let y = self.selectedauthority?.id as? Int {
            if y == 2 {
                if image1 == nil && image2 == nil && image3 == nil {
                    allow = false
                    self.present(customalert.showalert(x: "You need to upload atleast one document if you are an authorized person."), animated: true, completion: nil)
                }
               
            }
            
        }
          
           
        if allow {
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
                    
                    self.groupid = groupid
                    self.currentgroupcreated = groupcreated(groupid: groupid, groupname: groupname, ref: ref, refuserid: refuserid, createdon: createdon, isDelete: isDelete, otherbelong: otherbelong, youare: youare, groupimage: groupimage)
                    print("Group Created")
                    print(self.currentgroupcreated)
                    self.uploaddocumentstoverify()
                    
//                    self.performSegue(withIdentifier: "verifygroup", sender: nil)
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
        
        if let seg = segue.destination as? VerifyGroupDocumentsViewController {
            if let gi = self.currentgroupcreated?.groupid as? Int {
                seg.groupid = gi
            }
            if let y = self.selectedauthority?.id as? Int {
                if y == 2 {
                    seg.isauthorized = true
                }
                else {
                    seg.isauthorized = false
                }
                
            }
            
            if let s = self.currentgroupcreated as? groupcreated {
                seg.currentgroupcreated = s
            }
           
        }
        
        if let seg = segue.destination as? GroupsandEventsContactvc {
            if let s = self.currentgroupcreated as? groupcreated {
                seg.passedgroup = s
            }
        }
    }
    
    
    
    

}
