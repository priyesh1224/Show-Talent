//
//  Editprofile1ViewController.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


class PaddedImageView: UIImageView {
       override var alignmentRectInsets: UIEdgeInsets {
           return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
       }
   }

class Paddedbutton: UIButton {
    
    override func awakeFromNib() {
    self.titleLabel?.font = UIFont(name: "NeusaNextStd-Light", size: 10)
      }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}


class Editprofile1ViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    
    var further : ((_ a : Bool) -> Void)?
    var passedprofile : basicprofile?
    @IBOutlet weak var tableview1: UITableView!
    
    
    @IBOutlet weak var tableview2: UITableView!
    
    
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var editphotobtn: UIButton!
    
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    
    @IBOutlet weak var occupation: UILabel!
    
    @IBOutlet weak var editprofilebtn: UIButton!
    
    
    
    @IBOutlet weak var plusbuttoncovering: UIView!
    
    @IBOutlet weak var plusbutton: UIButton!
    
    
     let pickercontroller = UIImagePickerController()
    
    var fn : NSAttributedString?
    var ln = ""
    var occ = ""
    var profimage : UIImage?
    
    var imgtypes : [String] = []
    
    var content1 = ["notifications","bookmarking","change password","privacy","your wallet","buy pro version"]
    var content2 = ["block accounts","customer support","change language","change category","logout"]
    
    var im1 = ["custom – 1 4","bookmark-settings","pending payment","custom – 1 5","",""]
    var im2 = ["block" ,"support","languages","list","logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupallviews()
        self.tableview1.delegate = self
        self.tableview1.dataSource = self
        self.tableview2.delegate = self
        self.tableview2.dataSource = self
        self.tableview1.reloadData()
        self.tableview2.reloadData()
        tableview1.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        tableview1.layer.borderWidth = 1
        tableview2.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        tableview2.layer.borderWidth = 1
        
        pickercontroller.allowsEditing = true
        pickercontroller.mediaTypes = ["public.image"]
        pickercontroller.delegate = self
        if let s = self.fn {
        self.firstname.attributedText = self.fn
        }
        if let p = self.profimage {
        self.profileimage.image = self.profimage
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func changeprofimage(_ sender: Any) {
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
    
    
    
    
    func setupallviews()
    {
        self.tableview1.layer.cornerRadius = 10
        self.tableview2.layer.cornerRadius = 10
        self.profileimage.layer.cornerRadius = self.profileimage.frame.size.height/2 + 12
        self.profileimage.clipsToBounds = true
        
        self.profileimage.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.profileimage.layer.borderWidth = 4
        
        self.editphotobtn.layer.cornerRadius = 15
        self.editprofilebtn.layer.cornerRadius = 15
        self.editprofilebtn.layer.borderWidth = 3
        self.editprofilebtn.layer.borderColor = UIColor.clear.cgColor
        
        self.plusbuttoncovering.layer.cornerRadius = 55
            self.plusbutton.layer.cornerRadius = 37
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("selected table is \(tableView.restorationIdentifier)")
        if let ti = tableView.restorationIdentifier as? String {
            if ti == "one" {
                return self.content1.count
            }
            else if ti == "two"
            {
                return self.content2.count
            }
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let ti = tableView.restorationIdentifier as? String {
            if ti == "one" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "editprofilecell", for: indexPath) as? Editprofile1TableViewCell {
                    print("Sending \(self.content1[indexPath.row])")
                    cell.updatecell(x: self.content1[indexPath.row],y:1,z : im1[indexPath.row])
                    cell.selectionStyle = .none

                    return cell
                }
            }
            else if ti == "two"
            {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "editprofilecell2", for: indexPath) as? Editprofile1TableViewCell {
                    print("Sending \(self.content2[indexPath.row])")
                    cell.updatecell(x: self.content2[indexPath.row],y:2,z : im2[indexPath.row])
                    cell.selectionStyle = .none

                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ti = tableView.restorationIdentifier as? String {
            if ti == "one" {
                var x = self.content1[indexPath.row]
                if x == "your wallet" {
                    performSegue(withIdentifier: "coins", sender: nil)
                }
                else if x == "notifications" {
                    performSegue(withIdentifier: "notifications", sender: nil)
                }
                
            }
            else {
                var x = self.content2[indexPath.row]
                if x == "logout" {
                    logout()
                }
            }
        }
    }
    
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func editprofiletapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ep", sender: nil)
    }
    
    
    
    
    
    func logout()
    {
        var contact = UserDefaults.standard.value(forKey: "mobile")
        var firstname = UserDefaults.standard.value(forKey: "firstname")
        var lastname = UserDefaults.standard.value(forKey: "lastname")
        print(contact)
        print(firstname)
        print(lastname)
        
        
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        UserDefaults.standard.set(nil, forKey: "refid")
        performSegue(withIdentifier: "logout", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? EditProfileDetailsViewController {
                seg.passedprofile = self.passedprofile
                seg.sendfeedback = {a in
                    if(a) {
                        self.further!(true)
                    }
                }
            
            
        }
    }
    
    
    

}
