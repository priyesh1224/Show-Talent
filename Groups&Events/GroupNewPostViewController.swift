//
//  GroupNewPostViewController.swift
//  ShowTalent
//
//  Created by maraekat on 10/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AVKit

class GroupNewPostViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var progresslabel: UILabel!
    
    @IBOutlet weak var groupname: Customlabel!
    
    @IBOutlet weak var groupfield: UITextField!
    
    @IBOutlet weak var uploadimagesbtn: UIButton!
    
    @IBOutlet weak var groupimage: UIImageView!
    
    @IBOutlet weak var upbtn: CustomButton!
    
    var notifysuccess : ((_ : Bool) -> Void)?
    
    var type = "Video"
    var imp = UIImagePickerController()
    
    var imgs : [UIImage] = []
    var imgtypes : [String] = []
    var videopath : NSURL?
    
    var groupid = 0
    var gn = ""
    static var notify : ((_ status : Double) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imp.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.progresslabel.isHidden = true
        self.upbtn.layer.cornerRadius = 30
        self.groupname.text = self.gn.capitalized
        if self.type == "Video"
        {
            uploadimagesbtn.setTitle("Upload Video", for: .normal)
        }

        

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
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
               
               if let mt = info[.mediaType] as? String {
                   
                   if mt == "public.image" {
                       if let image = info[.editedImage] as? UIImage {
                           self.groupimage.image = image
                            self.imgs.append(image)
                           
                       }

                   }
                   
                   else if mt == "public.movie" {
                       if let mediaurl = info[.mediaURL] as? NSURL {
                           self.videopath = mediaurl
                        if let im = self.videoSnapshot(filePathLocal: mediaurl.absoluteURL!) as? UIImage {
                            self.groupimage.image = im
                        }
                       }
                   }
               }
               self.imp.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func chooseimage(_ sender: UIButton) {
        if type == "Image" {
            let alert = UIAlertController(title: "Choose \(self.type.capitalized)", message: nil, preferredStyle: .actionSheet)
                  alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                      if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                          {
                              self.imp.sourceType = .camera
                        
                                  self.imp.mediaTypes = ["public.image"]
                              
                              self.imp.allowsEditing = true
                              self.present(self.imp, animated: true, completion: nil)
                              
                          }
                      
                  }))

                  alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                      
                      self.imp.sourceType = .photoLibrary
                          self.imp.mediaTypes = ["public.image"]
                      
                      self.imp.allowsEditing = true
                      self.present(self.imp, animated: true, completion: nil)
                  }))

                  alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                  
                  self.present(alert, animated: true, completion: nil)
        }
        else if self.type == "Video"
        {
            let alert = UIAlertController(title: "Choose \(self.type.capitalized)", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                    {
                        self.imp.sourceType = .camera
                  
                            self.imp.mediaTypes = ["public.movie"]
                        
                        self.imp.allowsEditing = true
                        self.present(self.imp, animated: true, completion: nil)
                        
                    }
                
            }))

            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
                              {
                self.imp.sourceType = .photoLibrary
                    self.imp.mediaTypes = ["public.movie"]
                
                self.imp.allowsEditing = true
                self.present(self.imp, animated: true, completion: nil)
                }
            }))

            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func videoSnapshot(filePathLocal:URL) -> UIImage? {
        do
        {
            let asset = AVURLAsset(url: filePathLocal)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at:CMTimeMake(value: Int64(0), timescale: Int32(1)),actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        }
        catch let error as NSError
        {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }
    
    
    @IBAction func uploadimages(_ sender: UIButton) {
        self.upbtn.isEnabled = false
        var ss = ""
        if let s = self.groupfield.text as? String {
            ss = s
        }
        if type == "Image" && imgs.count > 0 {
            self.progresslabel.isHidden = false
            self.progresslabel.text = "Image Uploading (0 % completed)"
            self.progresslabel.textColor = UIColor.black

            let params : Dictionary<String,Any> = ["PostType":"Photo","PostDesc":ss,"GroupId":self.groupid]
            print(params)
            let r = ImageUploadRequest()
            r.sendprogress = { a in
                print("hey \(a.fractionCompleted)")
                self.progresslabel.text = "Image Uploading (\(Int(a.fractionCompleted * 100)) % completed)"

            }
            r.uploadnewgrouppostimages(imagesdata: imgs, params: params, extensiontype: imgtypes) { (res, err) in
                print("Response is")
                if let r = res as? String {
                    if r == "SUCCESS" {
                        self.upbtn.isEnabled = true
                        self.progresslabel.text = "Image Uploaded !"
                        self.groupimage.image = nil
                        self.notifysuccess!(true)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                print(res)
            }
            
        }
        else if type == "Video"{
            if let u = self.videopath as? NSURL {
                self.progresslabel.isHidden = false
                self.progresslabel.text = "Video Uploading (0 % completed)"
                self.progresslabel.textColor = UIColor.black
                let params : Dictionary<String,Any> = ["PostType":"Videos","PostDesc":ss,"GroupId":self.groupid]
                    
                let r = VideoUploadRequest()
                r.sendprogress = {a in
                    print("hey \(a.fractionCompleted)")
                    self.progresslabel.text = "Video Uploading (\(Int(a.fractionCompleted * 100)) % completed)"
                }
                var data = NSData(contentsOf: u.absoluteURL!)
                r.uploadgrouppostvideo(imagesdata: data, params: params) { (response, err) in
                if let r = response as? String {
                        if r == "SUCCESS" {
                            self.upbtn.isEnabled = true
                            self.progresslabel.text = "Video Uploaded !"
                            self.groupimage.image = nil
                            self.notifysuccess!(true)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }

                }
            }
        }
        
        
        
        
    }
    
    
    @IBAction func backpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
