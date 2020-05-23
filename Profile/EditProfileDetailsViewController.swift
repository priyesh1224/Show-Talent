//
//  EditProfileDetailsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 07/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileDetailsViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var imgtypes : [String] = []
    var passedprofile : basicprofile?
    var currentdate : Date = Date()
    var currentgender = ""
    
    var sendfeedback : ((_ x : Bool) -> Void)?
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var changephotobtn: UIButton!
    
    @IBOutlet weak var fnfield: UITextField!
    
    
    @IBOutlet weak var lnfield: UITextField!
    
    @IBOutlet weak var doblabel: UILabel!
    
    
    @IBOutlet weak var genderlabel: UILabel!
    

    @IBOutlet weak var editprofilebtn: UIButton!
    
    
    
    @IBOutlet weak var popupview: UIView!
    
    @IBOutlet weak var popupviewlabel: UILabel!
    
    @IBOutlet weak var popupokbtn: UIButton!
    
    @IBOutlet weak var pv: UIPickerView!
    
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    var type = ""
    
    var gender = ["male","female"]
    let pickercontroller = UIImagePickerController()
    var selecteddob = ""
    var selectedgender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileimage.layer.cornerRadius = 60
        self.changephotobtn.layer.cornerRadius = 10
        self.editprofilebtn.layer.cornerRadius = 10
        self.popupokbtn.layer.cornerRadius = 10
        self.popupview.isHidden = true
        pickercontroller.allowsEditing = true
        pickercontroller.mediaTypes = ["public.image"]
        pickercontroller.delegate = self
        
        self.fnfield.text = self.passedprofile?.firstname.capitalized
        self.lnfield.text = self.passedprofile?.lastname.capitalized
        if let g = self.passedprofile?.gender as? String {
        self.genderlabel.text = "Gender : \(g.capitalized)"
            self.currentgender = g
        }
        
        if self.passedprofile?.profileimg != "" && self.passedprofile?.profileimg != " " {
            if let u = self.passedprofile?.profileimg as? String {
                self.downloadimage(url: u) { (imm) in
                    self.profileimage.image = imm
                }
            }
        }
        var usefuldate = ""
        if let d  = self.passedprofile?.dob as? String {
            if d != "" || d != " " {
                var arr = d.components(separatedBy: "T")
                if arr.count == 2 {
                    usefuldate = arr[0]
                }
                else if d.count == 10 {
                    usefuldate = d
                }
            }
        }
        var d = ""
        var m = ""
        var y = ""
        if usefuldate != "" {
            var darr = usefuldate.components(separatedBy: "-")
            y = darr[0]
            m = darr[1]
            d = darr[2]
        }
        if let yy = Int(y) as? Int {
            print("year is \(yy)")
        }
        if let mm = Int(m) as? Int {
             print("Month is \(mm)")
        }
        if let dd = Int(d) as? Int {
             print("Day is \(dd)")
            
        }
        
        var finaldate = "\(d)-\(m)-\(y)"
        self.doblabel.text = "DOB : \(finaldate)"
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy/dd"
        if let cusdate = formatter.date(from: "\(m)/\(y)/\(d)") as? Date {
            self.currentdate = cusdate
            self.datepicker.date = cusdate
        }
        
        
        
        pv.delegate = self
        pv.dataSource = self
        pv.reloadAllComponents()
      
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.gender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.gender[row].capitalized
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    @IBAction func pickerokbtnpressed(_ sender: UIButton) {
        if self.type == "dob" {
            self.selecteddob = Date.getCurrentFromDate(d: datepicker.date)
            
            self.doblabel.text = "DOB : \(self.selecteddob)"
        }
        else {
            self.selectedgender = self.gender[pv.selectedRow(inComponent: 0)]
            self.genderlabel.text = "Gender : \(self.selectedgender.capitalized)"
            self.currentgender = self.selectedgender
        }
        self.popupview.isHidden = true
    }
    
    
    @IBAction func pickerclosebtnpressed(_ sender: UIButton) {
        self.popupview.isHidden = true
    }
    
    
    
    @IBAction func changephotopressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
               alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                   if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                       {
                           self.pickercontroller.sourceType = .camera
                
                               self.pickercontroller.mediaTypes = ["public.image"]
                           
                           self.pickercontroller.allowsEditing = true
                           self.present(self.pickercontroller, animated: true, completion: nil)
                           
                       }
                   
               }))

               alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                   
                   self.pickercontroller.sourceType = .photoLibrary
             
                       self.pickercontroller.mediaTypes = ["public.image"]
                   
                   self.pickercontroller.allowsEditing = true
                   self.present(self.pickercontroller, animated: true, completion: nil)
               }))

               alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
               
               self.present(alert, animated: true, completion: nil)
           }
           
           
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let mt = info[.mediaType] as? String {
                   
                   if picker.sourceType == .photoLibrary {
                       let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                             if (assetPath.absoluteString?.hasSuffix("JPG"))! {
                                 print("JPG")
                                 self.imgtypes.append("jpg")
                             }
                             else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
                                 self.imgtypes.append("png")
                                 }
                             else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
                                 self.imgtypes.append("gif")
                             }
                             else {
                                 self.imgtypes.append("unknown")
                             }
                   }
                   else if picker.sourceType == .camera {
                       self.imgtypes.append("jpg")
                   }
                          
                          if mt == "public.image" {
                              if let image = info[.editedImage] as? UIImage {
                                  self.profileimage.image = image
                               self.UploadImage(img:[image])
                                  
                              }

                          }
                          
                         
                      }
                      self.pickercontroller.dismiss(animated: true, completion: nil)
    }
    
    
    func UploadImage(img : [UIImage])
            {
           
                let request = ImageUploadRequest()
             
    
             
                var params = Dictionary<String , Any>()
             params = [:]
                
                let images = [String]()
                print(params)
               
             print(img)
             request.uploadImageprofilepicture(imagesdata:img, params: params , extensiontype : self.imgtypes) {  (response, err) in
                    
                    if response != nil{
                 
                     print(response)
                     print("--------------------------")
           
                        print("Image Uploaded Sucessfully")
                     DispatchQueue.main.async {
                         self.pickercontroller.dismiss(animated: true) {
     //                        self.dismiss(animated: true, completion: nil)
                         }
                     }
                       
                    }
                        
                    else
                    {
                     DispatchQueue.main.async {
                         self.pickercontroller.dismiss(animated: true, completion: nil)
                     }
                    }
                    
                }
            }
     
    
    @IBAction func editprofilepressed(_ sender: UIButton) {
        
        var fntxt = ""
        var fnpassed = ""
        var lntxt = ""
        var lnpassed = ""
        var passedgender = ""
        
        if let f = self.fnfield.text as? String {
            fntxt = f.lowercased()
        }
        if let n = self.lnfield.text as? String {
            lntxt = n.lowercased()
        }
        if let fp = self.passedprofile?.firstname as? String {
            fnpassed = fp.lowercased()
        }
        if let lp = self.passedprofile?.lastname as? String {
            lnpassed = lp.lowercased()
        }
        if let gp = self.passedprofile?.gender as? String {
            passedgender = gp.lowercased()
        }
        
        
        
        if fntxt != fnpassed || lntxt != lnpassed || self.datepicker.date != self.currentdate || self.currentgender.lowercased() != passedgender {
            editprofile()
            
        }
    }
    
    
    func editprofile()
    {
        if let userid = UserDefaults.standard.value(forKey: "refid") as? String {

            let params : Dictionary<String,String> = ["Ref_Guid": userid,
                                                      "FirstName": "\(self.fnfield.text!)",
                                                      "LastName": "\(self.lnfield.text!)",
                                                      "Gender": "\(self.currentgender)",
                "Dob": "\(self.datepicker.date)"]
                      
                print(params)
                      
            var url = "\(Constants.K_baseUrl)\(Constants.editprofile)"
            print(url)
            let r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: params) { (data, error) in
                 if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                        print(resv)
                    if let rs = resv["ResponseStatus"] as? Int {
                            if rs == 1 {
                                if let errrr = resv["Error"] as? Dictionary<String,Any> {
                                    if let m = errrr["ErrorMessage"] as? String {
                                        self.sendfeedback!(false)
                                        self.present(customalert.showalert(x: "\(m)"), animated: true, completion: nil)
                                    }
                                }
                            }
                            else {
                                self.sendfeedback!(true)
                                        self.present(customalert.showalert(x: "Profile Updated"), animated: true, completion: nil)
                                
                            }
                    }
                }
            }
            
        }
    }
    
    
    @IBAction func dobpressed(_ sender: UIButton) {
        self.type = "dob"
        popupviewlabel.text = "Select DOB"
        self.datepicker.isHidden = false
        self.pv.isHidden =  true
        self.popupview.isHidden = false

    }
    
    
    @IBAction func genderpressed(_ sender: UIButton) {
        self.type = "gender"
        popupviewlabel.text = "Select Gender"
        self.datepicker.isHidden = true
        self.pv.isHidden =  false
        self.popupview.isHidden = false

    }
    
    

    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    typealias imgcomp = (_ x : UIImage) -> Void
    func downloadimage(url : String,p : @escaping imgcomp)
    {
     var uurl = "http://thcoreapi.maraekat.com/Upload/Category/noicon.png"
        var receivedimage : UIImage?
     if let u = url as? String {
        Alamofire.request(u, method:.get).responseData { (rdata) in
         if let d = rdata.data as? Data {
             if let i = UIImage(data: d) as? UIImage {
                 p(i)

             }
         }
        }
     }

    }

}
