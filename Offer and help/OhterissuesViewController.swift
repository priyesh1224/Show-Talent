//
//  OhterissuesViewController.swift
//  ShowTalent
//
//  Created by admin on 16/06/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class OhterissuesViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var deletebtn: UIButton!
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var name: UITextField!
    
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var contactnumber: UITextField!
    
    
    @IBOutlet weak var subject: UITextField!
    
    
    @IBOutlet weak var cdescription: UITextView!
    
    
    @IBOutlet weak var attachafilebtn: UIButton!
    
    
    @IBOutlet weak var submitbtn: UIButton!
    
    @IBOutlet weak var cancelbtn: UIButton!
    
    
    @IBOutlet weak var scroll: UIScrollView!
    
    var selectedimage : UIImage?
       var pc : UIImagePickerController?
    var imgtypes = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cdescription.layer.borderWidth = 1
        cdescription.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        cdescription.layer.cornerRadius = 5
        submitbtn.layer.cornerRadius = 20
        cancelbtn.layer.cornerRadius = 20
        notificationindicator.layer.cornerRadius = 10
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        self.scroll.isScrollEnabled = true
        deletebtn.isHidden = true
        pc = UIImagePickerController()
                      pc?.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                      pc?.allowsEditing = true
                      pc?.mediaTypes = ["public.image"]
                      pc?.sourceType = .photoLibrary
        
        var fn = UserDefaults.standard.value(forKey: "firstname") as? String
         var ln = UserDefaults.standard.value(forKey: "lastname") as? String
         var em = UserDefaults.standard.value(forKey: "email") as? String
         var mo = UserDefaults.standard.value(forKey: "mobile") as? String
        
        name.text = "\(fn ?? "") \(ln ?? "")"
        email.text = em
        contactnumber.text = mo
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deletebtnpressed(_ sender: Any) {
        selectedimage = nil
        attachafilebtn.setTitle("+ Attach a File", for: .normal)
        deletebtn.isHidden = true
    }
    
    

    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func attachfilebtnpressed(_ sender: Any) {
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
    
    
    @IBAction func submitbtnpressed(_ sender: Any) {
        if name.text == "" || name.text == " " {
            self.present(customalert.showalert(x: "You need to enter name"), animated: true, completion: nil)
        }
        else if email.text == "" || email.text == " " {
            self.present(customalert.showalert(x: "You need to enter email"), animated: true, completion: nil)
        }
        else if contactnumber.text == "" || contactnumber.text == " " {
            self.present(customalert.showalert(x: "You need to enter contact number"), animated: true, completion: nil)
        }
        else if subject.text == "" || subject.text == " " {
            self.present(customalert.showalert(x: "You need to enter subject"), animated: true, completion: nil)
        }
        else if cdescription.text == "" || cdescription.text == " " {
            self.present(customalert.showalert(x: "You need to enter description"), animated: true, completion: nil)
        }
        else {
            var ver = ""
            
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                ver = version
            }
            var r = ImageUploadRequest()
            var uid = UserDefaults.standard.value(forKey: "refid") as! String
            var params : Dictionary<String,Any> = ["AppVersion" : "\(ver)" , "ContactNumber" : "\(self.contactnumber.text ?? "")","Description" : "\(self.cdescription.text ?? "")","Email" : "\(self.email.text ?? "")","mobileOs" : "iOS" , "Name" : "\(self.name.text ?? "")","Subject" : "\(self.subject.text ?? "")" , "UserId" : "\(uid)"]
            print(params)
            var ta : [UIImage] = []
            if let i = selectedimage as? UIImage {
                ta.append(i)
            }
            r.uploadticket(imagesdata: ta, params: params, extensiontype: [self.imgtypes]) { (response, err) in
                if response == "done" {
                    let alert2 = UIAlertController(title: "Ticket Submitted", message: "", preferredStyle: .actionSheet)
                    alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        self.dismiss(animated: true, completion: nil)
                                                               
                    }));
                    self.present(alert2, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if picker.sourceType == .photoLibrary {
                let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                if (assetPath.absoluteString?.hasSuffix("JPG"))! {
                    print("JPG")
                    self.imgtypes =  "jpg"
                }
                else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
                    self.imgtypes =  "png"
                }
                else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
                   self.imgtypes =  "gif"
                }
                else {
                    self.imgtypes =  "unknown"
                }
            }
            else if picker.sourceType == .camera {
                self.imgtypes =  "jpg"
            }
            
            if let mt = info[.mediaType] as? String {
                
                if mt == "public.image" {
                    if let image = info[.editedImage] as? UIImage {
                        selectedimage = image
                        deletebtn.isHidden = false
                        attachafilebtn.setTitle("Image Selected", for: .normal)
                        
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

    
    @IBAction func cancelbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
