//
//  VerifyGroupDocumentsViewController.swift
//  ShowTalent
//
//  Created by admin on 15/06/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class VerifyGroupDocumentsViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    
    
    @IBOutlet weak var im1: UIImageView!
    
    @IBOutlet weak var im2: UIImageView!
    
    
    @IBOutlet weak var im3: UIImageView!
    
    @IBOutlet weak var backbtn: UIButton!
    
    var currentgroupcreated : groupcreated?
    var isauthorized = false
    var groupid = 1097
    var allpasseddata : Dictionary<String,Dictionary<String,Any>> = [:]
    var imgsarray : [UIImage] = []
    var imgsext : [String] = []
    
    var imgtypes : Dictionary<String,String> = [:]
    var image1 : UIImage?
    var image2 : UIImage?
    var image3 : UIImage?
    
    @IBOutlet weak var uploadbtn1: UIButton!
    
    @IBOutlet weak var uploadbtn2: UIButton!
    
    @IBOutlet weak var skipbtn: UIButton!
    
    @IBOutlet weak var uploadbtn3: UIButton!
    var pc : UIImagePickerController?
    
    @IBOutlet weak var submitbtn: CustomButton!
    
    
    var imagetobeuploaded = "one"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isauthorized {
            skipbtn.isHidden = true
        }
        else {
             skipbtn.isHidden = false
        }
        
        uploadbtn1.layer.cornerRadius = uploadbtn1.frame.size.height/2
                uploadbtn2.layer.cornerRadius = uploadbtn2.frame.size.height/2
                uploadbtn3.layer.cornerRadius = uploadbtn3.frame.size.height/2
                submitbtn.layer.cornerRadius = submitbtn.frame.size.height/2
        pc = UIImagePickerController()
               pc?.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
               pc?.allowsEditing = true
               pc?.mediaTypes = ["public.image"]
               pc?.sourceType = .photoLibrary

        
    }
    

    @IBAction func backtapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    
    
    
    
    @IBAction func skipbtnpressed(_ sender: Any) {
        self.performSegue(withIdentifier: "entergroup", sender: nil)
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
    
    
    
    @IBAction func submitdocumentstapped(_ sender: Any) {
        
        
        if self.im1.image == nil && self.im2.image == nil && self.im3.image == nil {
            self.present(customalert.showalert(x: "You need to upload atleast one document"), animated: true, completion: nil)
        }
        else {
        
        
        
        allpasseddata.removeAll()
        submitbtn.isEnabled = false
        skipbtn.isEnabled = false
        backbtn.isEnabled = false
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
        
        
        var r = ImageUploadRequest()
        r.uploadgroupverificationimages(imagesdata: allpasseddata, imgsarray:imgsarray, params: ["groupId":self.groupid], extensiontype: self.imgtypes, exttype: imgsext) { (response, err) in
            if response == "done" {
                let alert2 = UIAlertController(title: "Documents Uploaded", message: "", preferredStyle: .actionSheet)
                alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    self.performSegue(withIdentifier: "entergroup", sender: nil)
                                                           
                }));
                self.present(alert2, animated: true, completion: nil)
            }
            self.submitbtn.isEnabled = true
            self.skipbtn.isEnabled = true
            self.backbtn.isEnabled = true
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
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? MainGroupViewController {
            if let s = self.currentgroupcreated as? groupcreated {
                seg.passedgroup = s
            }
            
        }
    }

    

}
