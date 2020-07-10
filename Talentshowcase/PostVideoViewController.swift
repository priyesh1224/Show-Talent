//
//  PostVideoViewController.swift
//  ShowTalent
//
//  Created by maraekat on 29/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import CLImageEditor

struct categorybrief {
    var categoryid : Int
    var categoryname : String
}


class PostVideoViewController : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource , CLImageEditorDelegate  {
   
    // implment  UIDocumentMenuDelegate,UIDocumentPickerDelegate when ready to use icloud kit
    
    var sendprogress : ((_ done : Progress) -> Void)?
    
    var justuploaded : ((_ done : Bool) -> Void)?
    
    var contestid = 0
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var showviewimage: UIImageView!
    
    @IBOutlet weak var showview: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var screentitle: UILabel!
    
    @IBOutlet weak var videotitle: UITextField!
    
    
    @IBOutlet weak var videodescription: UITextField!
    
    
    @IBOutlet weak var hashtagsfield: UITextField!
    
    
    @IBOutlet weak var publicbtn: UIButton!
    
    
    @IBOutlet weak var friendsbtn: UIButton!
    
    
    @IBOutlet weak var privatebtn: UIButton!
    
    @IBOutlet weak var choosencategorylabel: UILabel!
    
    @IBOutlet weak var postvideobtn: UIButton!
    
    
    @IBOutlet weak var popup: UIView!
    
    @IBOutlet weak var popupcurrcat: UILabel!
    
    var iseventpost = true
    var tfdata = ""
    var ttfdata = ""
    
    var type = "image"
    var img : [UIImage] = []
    var imgtypes : [String] = []
    var usercategories : [categorybrief] = []
    var selectedtype = "Public"
    var allcategories : [categorybrief] = []
    var videopath : NSURL?
    var dp : UIDocumentPickerViewController?
    var currentselectedcategory : categorybrief?
    
    var completion : ((_ completed : Bool) -> Void)?
    var completion2 : ((_ completed : Bool) -> Void)?
    
    var pickercontroller = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        setupview()
        pickercontroller.delegate = self
        self.screentitle.text = type.capitalized
        self.spinner.isHidden = false
        self.spinner.startAnimating()
       
        
        if let s = self.currentselectedcategory as? categorybrief {
            self.popup.isHidden = true
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            self.choosencategorylabel.text = s.categoryname.capitalized
        }
        else {
             fetchcategories()
        }
        
        
        
        
        
        self.completion = {a in
            if a {
                if self.usercategories.count == 0 {
                    self.usercategories = self.allcategories
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    self.table.reloadData()
                }
                else {
                self.combinearrays()
                }
            }
        }
        
//        if type == "file"
//        {
//            let types: [String] = [kUTTypePDF as String]
//            dp = UIDocumentPickerViewController(documentTypes: types, in: .import)
//            dp!.delegate = self
//            dp!.modalPresentationStyle = .formSheet
////            self.present(dp!, animated: true, completion: nil)
//        }
        
        if type == "image" {
            self.videotitle.placeholder = "Type your Image Title"
            self.videodescription.placeholder = "Type Image Description"
            self.choosencategorylabel.text = "Select Image Category eg. Dancing"
            self.postvideobtn.setTitle("Filter Image", for: .normal)
        }
        else if type == "video" {
            self.videotitle.placeholder = "Type your Video Title"
            self.videodescription.placeholder = "Type Video Description"
            self.choosencategorylabel.text = "Select Video Category eg. Dancing"
            self.postvideobtn.setTitle("Post Video", for: .normal)
        }
        

        
    }
    
    
    @IBAction func showtableviewpressed(_ sender: Any) {
         self.popup.isHidden = false
    }
    @IBAction func closetableviewpressed(_ sender: Any) {
        self.popup.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.table.frame.size.height/7
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usercategories.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "choosecell", for: indexPath) as? ChooseEachCategoryTableViewCell {
            cell.selectionStyle = .none
            
            
            cell.gobackwithdata = {a in
                print(a)
                self.currentselectedcategory = a
                self.popupcurrcat.text = "Selected : \(a.categoryname.capitalized)"
                self.choosencategorylabel.text = a.categoryname.capitalized
            }
            
            cell.update(x: self.usercategories[indexPath.row])
        }
           return UITableViewCell()
       }
    
    func combinearrays()
    {
        var originallength = usercategories.count
        if usercategories.count > 0 && allcategories.count > 0 {
            for k in 0 ..< allcategories.count {
                var found = false
                for m in 0..<originallength {
                    if allcategories[k].categoryid == usercategories[m].categoryid || allcategories[k].categoryname == usercategories[m].categoryname {
                        found = true
                    }
                }
                if found == false {
                    usercategories.append(allcategories[k])
                }
            }
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            print(self.usercategories)
            self.table.reloadData()
        }
    }
    
    
    func fetchcategories()
    {

        let userid = UserDefaults.standard.value(forKey: "refid") as! String

        var params : Dictionary<String,Any> = [:]




        var url = Constants.K_baseUrl + Constants.getCategory
                   var r = BaseServiceClass()


        r.getApiRequest(url: url, parameters: [:]) { (data, error) in
                       print("-----------------")
                    if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                        if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                            if let indv =  inv["Data"] as? [Dictionary<String,AnyObject>] {
                                for eachcat in indv {
                                    if let cat = eachcat["CategoryName"] as? String , let catid = eachcat["ID"] as? Int {
                                             
                                        var x  = categorybrief(categoryid: catid, categoryname: cat)
                                        self.allcategories.append(x)

                                    }
                                }
                               
                                self.fetchusercategories()
                                self.completion2 = {a in
                                    if a {
                                        self.completion!(true)
                                    }
                                }

                            }
                        }
                    }
        }
    }



    func fetchusercategories()
    {
        var uurl = Constants.K_baseUrl + Constants.getUserCat
                   var rr = BaseServiceClass()


        rr.getApiRequest(url: uurl, parameters: [:]) { (data, error) in
                       print("-----------------")
                    if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                        if let indv =  dv["Results"] as? [Dictionary<String,AnyObject>] {

                                for eachcat in indv {
                                    if let cat = eachcat["CategoryName"] as? String , let catid = eachcat["CategoryMasterID"] as? Int {
                                        var x  = categorybrief(categoryid: catid, categoryname: cat)
                                        self.usercategories.append(x)
                                    }
                                }
                            print(self.usercategories)
                            self.completion2!(true)


                        }
                    }
        }
    }
    
    
    func uploadpdf()
    {
        var cid = 0
        if let cc = self.currentselectedcategory?.categoryid as? Int {
            cid = cc
        }
        let request = Pdfuploadrequest()
        request.sendprogress = {a in
            self.sendprogress!(a)
        }
        
        var params = Dictionary<String , Any>()
        params = ["PostType" :"File",
                     "PostDesc" : self.videodescription.text!,
                     "CategoryId" : cid,
                     "Title" : self.videotitle.text!,
                     "Video category mode" : selectedtype]
        
    
        request.uploadImage(url: NSURL(string: "")!, params: params, filename: "Test.pdf") { (response, err) in
                  if response != nil{

                               print("PDF Uploaded Sucessfully")
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
    
    
    func uploadimageforevent()
    {
         var cid = 0
                if let cc = self.currentselectedcategory?.categoryid as? Int {
                    cid = cc
                }
                   let request = ImageUploadRequest()
                
                request.sendprogress = {a in
                    self.sendprogress?(a)
                }
             
                
                   
                
                
                   var params = Dictionary<String , Any>()
                params = [
                 "ContestId":self.contestid,
                 "PostType" :self.type.capitalized,
                 "PostDesc" : tfdata,
                 "CategoryId" : cid,
                 "Title" : ttfdata]
                   
                   let images = [String]()
        print("Holla")
                   print(params)
                  
                print(img)
        
        
        request.uploadgroupIcontry(imagesdata: img, params: params, extensiontype: self.imgtypes) { (response, err) in
            
            if response != nil{
                
                                        print(response)
                                        print("--------------------------")
                                        print(self.img)
                                    self.justuploaded!(true)
                                        print(self.img.count)
                                           print("Image Uploaded Sucessfully")
                                        DispatchQueue.main.async {
                                            self.pickercontroller.dismiss(animated: true) {
                                                self.dismiss(animated: true, completion: nil)
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
        
        
//        request.uploadImage(imagesdata:img, params: params
//    , url: Constants.K_baseUrl + Constants.participatepost , extensiontype : self.imgtypes) {  (response, err) in
//
//                       if response != nil{
//
//                        print(response)
//                        print("--------------------------")
//                        print(self.img)
//                        print(self.img.count)
//                           print("Image Uploaded Sucessfully")
//                        DispatchQueue.main.async {
//                            self.pickercontroller.dismiss(animated: true) {
//        //                        self.dismiss(animated: true, completion: nil)
//                            }
//                        }
//
//                       }
//
//                       else
//                       {
//                        DispatchQueue.main.async {
//                            self.pickercontroller.dismiss(animated: true, completion: nil)
//                        }
//                       }
//
//                   }
    }

     
    func UploadImage()
       {
        

        
        
        var cid = 0
        if let cc = self.currentselectedcategory?.categoryid as? Int {
            cid = cc
        }
           let request = ImageUploadRequest()
        
        request.sendprogress = {a in
            self.sendprogress?(a)
        }
        var tfdata = ""
        DispatchQueue.main.async {
            tfdata = self.videodescription.text ?? ""
        }
        
           var params = Dictionary<String , Any>()
        params = ["PostType" :self.type.capitalized,
                     "PostDesc" : tfdata,
                     "CategoryId" : cid,
                     "Title" : self.videotitle.text ?? "",
                     "Video category mode" : selectedtype]
           
           let images = [String]()
           print(params)
          
        print(img)
        request.uploadImage(imagesdata:img, params: params , url : Constants.K_baseUrl + Constants.imageUploadurl,extensiontype : self.imgtypes) {  (response, err) in
               
               if response != nil{
            
                print(response)
                print("--------------------------")
                print(self.img)
                print(self.img.count)
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
    
    func UploadVideo()
    {
    let request = VideoUploadRequest()
        
        request.sendprogress = {a in
            DispatchQueue.main.async {
                self.sendprogress!(a)
            }
            
        }
        
        var cid = 0
        if let cc = self.currentselectedcategory?.categoryid as? Int {
            cid = cc
        }
      
        
        var params = Dictionary<String , Any>()
       params = ["PostType" :self.type.capitalized,
        "PostDesc" : self.videodescription.text!,
        "CategoryId" : cid,
        "Title" : self.videotitle.text!,
        "Video category mode" : selectedtype]
        
        
//        request.upload(videoURL: (videopath?.absoluteURL)!, success: nil, failure: nil,params: params ) { (data, err) in
//
//        }
//
        
        var movieData: NSData?
        do {
            movieData = try NSData(contentsOfFile: ((videopath?.relativePath!)!), options: NSData.ReadingOptions.alwaysMapped)
        } catch _ {
            movieData = nil
            return
        }
        print(movieData)
//        DispatchQueue.global(qos: .background).async {
        request.uploadVideo(imagesdata: movieData , params: params , url : Constants.K_baseUrl + Constants.imageUploadurl) {  (response, err) in

                if response != nil{
                    print("Video Uploaded Sucessfully")

                }

                else
                {
                    print("Some thing went wrong please try again!")
                }

            }
//        }
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
   
    }

    
    func setupview()
    {
        notificationindicator.layer.cornerRadius = 10
        publicbtn.layer.cornerRadius = 5
        friendsbtn.layer.cornerRadius = 5
        privatebtn.layer.cornerRadius = 5
        postvideobtn.layer.cornerRadius = 5
    }
    
    func uploadvideoforevent()
    {
            let request = VideoUploadRequest()
                
                request.sendprogress = {a in
                    DispatchQueue.main.async {
                        self.sendprogress?(a)
                    }
                    
                }
                
                var cid = 0
                if let cc = self.currentselectedcategory?.categoryid as? Int {
                    cid = cc
                }
        
        var description = ""
        if let d = self.videodescription.text as? String {
            description = d
        }
              
                
                var params = Dictionary<String , Any>()
               params = [
                "ContestId":self.contestid,
                "PostType" :self.type.capitalized,
                "PostDesc" : description,
                "CategoryId" : cid,
                "Title" : self.videotitle.text!]
                
                

                
                var movieData: NSData?
                do {
                    movieData = try NSData(contentsOfFile: ((videopath?.relativePath!)!), options: NSData.ReadingOptions.alwaysMapped)
                } catch _ {
                    movieData = nil
                    return
                }
                print(movieData)
        //        DispatchQueue.global(qos: .background).async {
        request.uploadVideo(imagesdata: movieData , params: params , url : Constants.K_baseUrl + Constants.participatepost) {  (response, err) in
            print(response?.result.value)
                        if response != nil{
                            print("Video Uploaded Sucessfully")
                            self.justuploaded!(true)

                        }

                        else
                        {
                            print("Some thing went wrong please try again!")
                        }

                    }
        //        }
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
    }
    
    @IBAction func postvideopressed(_ sender: UIButton) {
        
       
        
        if self.type == "video" {
            if let v = self.videopath as? NSURL {
                DispatchQueue.global(qos: .utility).async {
                    if self.iseventpost == false {
                        self.UploadVideo()
                    }
                    else {
                        self.uploadvideoforevent()
                    }

                }
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)

                }
            }
        }
        else if self.type == "image" {
            if currentselectedcategory != nil {
                if img.count > 0 {
                    performSegue(withIdentifier: "tofilters", sender: nil)
                }

                   }

        }
    }
    

    @IBAction func backpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func showallvideocategories(_ sender: UIButton) {
    }
    
    
    @IBAction func publicpressed(_ sender: UIButton) {
        self.publicbtn.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.friendsbtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.privatebtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.selectedtype = "Public"
    }
    
    
    @IBAction func friendspressed(_ sender: UIButton) {
        self.publicbtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.friendsbtn.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.privatebtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.selectedtype = "Friends"
    }
    
    
    @IBAction func privatepresed(_ sender: UIButton) {
        self.publicbtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.friendsbtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.privatebtn.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.selectedtype = "Private"
    }
    
    
    @IBAction func sidebarpressed(_ sender: Any) {

    }
    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        print("url", urls[0])
//    }
//
//    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
//        documentPicker.delegate = self
//        self.present(documentPicker, animated: true, completion: nil)
//    }
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func uploadvideo(_ sender: UIButton) {
        
//        if self.type == "file"
//        {
//            let importMenu = UIDocumentMenuViewController(documentTypes: [(kUTTypePDF as String)], in: .import)
//            importMenu.delegate = self
//            importMenu.modalPresentationStyle = .formSheet
//            self.present(importMenu, animated: true, completion: nil)
//            return
//        }
        
        
        
        let alert = UIAlertController(title: "Choose \(self.type.capitalized)", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
                    self.pickercontroller.sourceType = .camera
                    if self.type == "video" {
                        self.pickercontroller.mediaTypes = ["public.movie"]
                    }
                    else if self.type == "image"  {
                        self.pickercontroller.mediaTypes = ["public.image"]
                    }
                    self.pickercontroller.allowsEditing = true
                    self.present(self.pickercontroller, animated: true, completion: nil)
                    
                }
            
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            
            self.pickercontroller.sourceType = .photoLibrary
            if self.type == "video" {
                self.pickercontroller.mediaTypes = ["public.movie"]
            }
            else if self.type == "image"  {
                self.pickercontroller.mediaTypes = ["public.image"]
            }
            self.pickercontroller.allowsEditing = true
            self.present(self.pickercontroller, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    var selectedimage : UIImage?
    
    
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
          
                    
                                        let editor = CLImageEditor(image: image)
                                           editor?.delegate = self
                                           selectedimage = image
                                           
                                           self.showviewimage.image = image
                                           picker.dismiss(animated: true) {
                                               self.present(editor!, animated: true, completion: nil)
                                           }
                    
                }

            }
            
            else if mt == "public.movie" {
                if let mediaurl = info[.mediaURL] as? NSURL {
                    if let im = self.videoSnapshot(filePathLocal: mediaurl.absoluteURL!) as? UIImage {
                        self.showviewimage.image = im
                    }
                    self.videopath = mediaurl
                }
                self.pickercontroller.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
            
        self.img.insert(image, at: 0)
           self.showviewimage.image = image
        self.tfdata = self.videodescription.text ?? ""
        self.ttfdata = self.videotitle.text ?? ""
        DispatchQueue.global(qos: .background).async {
            if self.iseventpost == false {
                self.UploadImage()
            }
            else {
                self.uploadimageforevent()
            }
        
        }
//        DispatchQueue.main.async {
//            self.dismiss(animated: true, completion: nil)
//        }
           editor.dismiss(animated: true, completion: nil)
           
       }

       func imageEditorDidCancel(_ editor: CLImageEditor!) {
           if let im = selectedimage as? UIImage {
            self.img.append(im)
                  self.showviewimage.image = im
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? FilterImageViewController {
            seg.type = self.type
            seg.originalimage = self.img.first
            
            seg.filterdone = {im in
                print("Got image back")
                self.img[0] = im

                if self.img.count > 0 {
//                    self.tfdata = self.videodescription.text ?? ""
//                    self.ttfdata = self.videotitle.text ?? ""
//                    DispatchQueue.global(qos: .background).async {
//                        if self.iseventpost == false {
//                            self.UploadImage()
//                        }
//                        else {
//                            self.uploadimageforevent()
//                        }
//
//                    }
//                    DispatchQueue.main.async {
//                        self.dismiss(animated: true, completion: nil)
//                    }
                                    
  

                }
            }
        }
    }
    
    

}
