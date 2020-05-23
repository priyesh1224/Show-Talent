//
//  Talentshowcase3viewcontroller.swift
//  ShowTalent
//
//  Created by maraekat on 12/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit


class Talentshowcase3viewcontroller: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate , UIScrollViewDelegate {

   @IBOutlet weak var progressviewheight: NSLayoutConstraint!
       
       @IBOutlet weak var collectionheight: NSLayoutConstraint!
       
       
       @IBOutlet weak var progressview: UIView!
       
       @IBOutlet weak var progressviewlabel: UILabel!
       
       @IBOutlet weak var navigationindicator: UIView!
       
       @IBOutlet weak var popupbtn: UIButton!
       
       @IBOutlet weak var screentitle: UILabel!
       
       
       @IBOutlet weak var collection: UICollectionView!
       
       @IBOutlet weak var table: UITableView!
       
       
       @IBOutlet weak var progressindicatorview: UIView!
       
       
       @IBOutlet weak var progressindicatorwidth: NSLayoutConstraint!
       
       @IBOutlet weak var addfilepopup: UIView!
       
       @IBOutlet weak var popupheight: NSLayoutConstraint!
       
//       var alldata : [videopost] = []
       var allimagedata : [videopost] = []
       var contactlisttobepassed : [commentinfo] = []
       var liketobepassed : [like] = []
       var mode = ""
       var postid = 0

       
       var cat = "Image"
       var tapped = ""
       var page = 0
       
       var oldcount = 0
       var canfetchmore = true
       
       override func viewDidLoad() {
           super.viewDidLoad()
           popupheight.constant = self.view.frame.size.height / 2.5
           self.progressviewheight.constant = 0

           
           self.addfilepopup.layer.cornerRadius = 10
           self.progressview.isHidden = true
           self.addfilepopup.isHidden = true
           setupview()
           self.screentitle.text = self.cat.capitalized
           
               
           self.collection.isHidden = true
           
           collection.delegate = self
           collection.dataSource = self
           collection.delegate = collection.dataSource as! UICollectionViewDelegate
           self.collection.reloadData()
           self.collectionheight.constant = self.view.frame.size.height/4.8
           table.delegate = self
           table.dataSource = self
           self.progressindicatorview.layer.cornerRadius = 5
          
               self.fetchdata()
           
           
           
           
           // Do any additional setup after loading the view.
       }
       
       @IBAction func closepopuppressed(_ sender: Any) {
           self.addfilepopup.isHidden = true
       }
       
       @IBAction func popupshowtappedtg(_ sender: UITapGestureRecognizer) {
           self.addfilepopup.isHidden = false
       }
       
       
     
       
       
       @IBAction func popuppressed(_ sender: UIButton) {
           self.addfilepopup.isHidden = false
       }
       
       
       
       
      
       
       

       
       func textFieldDidBeginEditing(textField: UITextField) {
               self.animateViewMoving(up: true, moveValue: 100)
       }
       func textFieldDidEndEditing(textField: UITextField) {
               self.animateViewMoving(up: false, moveValue: 100)
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           return true
       }

       func animateViewMoving (up:Bool, moveValue :CGFloat){
           var movementDuration:TimeInterval = 0.3
           var movement:CGFloat = ( up ? -moveValue : moveValue)
           UIView.beginAnimations( "animateView", context: nil)
           UIView.setAnimationBeginsFromCurrentState(true)
           UIView.setAnimationDuration(movementDuration )
           self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
           UIView.commitAnimations()
       }
       
       
       
       func setupview()
       {
       self.navigationindicator.layer.cornerRadius = 10
           self.popupbtn.layer.cornerRadius = 30
          }
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 5
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "talentcollection", for: indexPath) as? TalentshowcaseCollectionViewCell {
               cell.updatecell()
               return cell
           }
           return UICollectionViewCell()
       }
       
       func collectionView(_ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 500.0, height: 100.0)
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

               self.oldcount = self.allimagedata.count
               return self.allimagedata.count
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let userid = UserDefaults.standard.value(forKey: "refid") as! String
    
          
                  if let cell = tableView.dequeueReusableCell(withIdentifier: "talenttable2", for: indexPath) as? TalentshowcaseTableViewCell2 {
                           cell.selectionStyle = .none
                           cell.commentfield.delegate = self
                  
                   if indexPath.row < self.allimagedata.count {
                   cell.updatecell(x: self.allimagedata[indexPath.row])
                   }
                  
                   cell.togglelike = {pos,likestatus in
                       
         
                       
                       for var index in 0..<self.allimagedata.count {
                           if self.allimagedata[index].activityid == pos.activityid {
                               self.allimagedata[index].status = !self.allimagedata[index].status
                               if !self.allimagedata[index].status == true {
                                   self.allimagedata[index].like = self.allimagedata[index].like - 1
                                   for var lki in 0..<self.allimagedata[index].likebyme.count {
                                                       if self.allimagedata[index].likebyme[lki].userid == userid {
                                                           self.allimagedata[index].likebyme.remove(at: lki)
                                                       }
                                                   
                                               }

                               }
                               else {
                                   self.allimagedata[index].like = self.allimagedata[index].like + 1
                                   
                                   self.allimagedata[index].likebyme.append(like(activityid: self.allimagedata[index].activityid, id: self.allimagedata[index].id, ondate: "", profilename: "Auth user to be replace with", profileimage: "", userid: userid))
                                   
                               }
                               
                               
                               
                               
                               break
                           }
                       }
                       
                
                       
   //                    self.table.reloadRows(at: [indexPath], with: .none)
                   }
                   
                   
                           cell.onSeeAllcomments = {gotdata , iid in
                               self.mode = "comments"
                               self.postid = iid
                               self.contactlisttobepassed = gotdata.comments
                               self.performSegue(withIdentifier: "taketoallcomments", sender: nil)
                           }
                           cell.onSeeAlllikes = {gotdata in
                            
                            // Uncomment this to start seeing who likes the post
                            
//                               self.mode = "likes"
//                               self.liketobepassed = gotdata.likebyme
//                               self.performSegue(withIdentifier: "taketoallcomments", sender: nil)
                           }
                   
                  
                   
                           cell.commentposted = {st in
         
                               if let sst = st as? commentinfo {
                                   for var ec in self.allimagedata {
                                       if ec.activityid == st!.activityid {
                                           ec.comments.append(sst)
               //                            self.table.reloadRows(at: [indexPath], with: .automatic)
                                           break
                                       }
                                   }
                                   
               //                    self.fetchdata()
                               }
                           }
                   
             
                  
                           return cell
                       }
           
           return UITableViewCell()
       }
       
       
       
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           print("Displaying \(indexPath.row)")
                   print("I am \(indexPath.row)")
        if self.allimagedata.count < 5 && self.page >= 2 {
                        self.canfetchmore = false
                    }
                   if indexPath.row == self.allimagedata.count - 5 && self.canfetchmore == true {
                                   self.fetchdata()
                   }
           
           
       }
       
       
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return 680
    
              if let cell = tableView.cellForRow(at: indexPath) as? TalentshowcaseTableViewCell2 {
                  if cell.shouldadjustheight == true {
                      if self.view.frame.size.height/1.4 < 550 {
                          return 550
                      }
                      return self.view.frame.size.height/1.4
                  }
              }
               
               if self.view.frame.size.height/1.2 < 600 {
                   return 600
               }
               return self.view.frame.size.height/1.2
           
       }
       
     
       

       
       
       
       
       func fetchdata()
       {
           
           print("Fetching Again for page \(self.page)")
           
           
           if self.page == 1 {
               
           }
           
           if canfetchmore == true
           {
 
           
           
           liketobepassed = []
               let params : Dictionary<String,Int> = ["Page":self.page,"PageSize":9]
               self.page = self.page + 1
           let userid = UserDefaults.standard.value(forKey: "refid") as! String

           
           
           
           var url = Constants.K_baseUrl + Constants.activitydata + "\(userid),\(cat)"
           var r = BaseServiceClass()
           r.postApiRequest(url: url, parameters: params) { (data, err) in
               if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                   
                   if let usefuldata = resv["Results"] as? [AnyObject] {
                     print("Received for page \(self.page - 1) is \(usefuldata.count)")
                    if usefuldata.count == 0 {
                        self.canfetchmore = false
                    }
                       for eachv in usefuldata  {
                           if let rawdetails = eachv as? Dictionary<String,AnyObject> {
                               
                               var avii = 0
                               var avpp = ""
                               var catt = ""
                               var dess = ""
                               var iddd = ""
                               var imagess : [String] = []
                               var likee = 0
                               var likedbymee : [Dictionary<String,AnyObject>] = []
                               var profimagee = ""
                               var profnamee = ""
                               var pbonn = ""
                               var titlee = ""
                               var typee = ""
                               var u_idd = ""
                               var vww = 0
                               var cmntss : [commentinfo] = []
                               var tmbb = ""
                               
                               
                               if let avi = rawdetails["ActivityId"] as? Int {
                                   avii = avi
                               }
                               if let avp = rawdetails["ActivityPath"] as? String {
                                   avpp = avp
                                   
                               }
                               if let cat = rawdetails["Category"] as? String {
                                   catt = cat
                                   
                               }
                               if let des = rawdetails["Description"] as? String {
                                   dess = des
                               }
                               if let idd = rawdetails["Id"] as? String {
                                   iddd = idd
                               }
                               if let images = rawdetails["Images"] as? [String] {
                                   imagess = images
                               }
                               if let like = rawdetails["Like"] as? Int {
                                   likee = like
                                   
                               }
                               var currstatus = false
                               if let likedbyme = rawdetails["LikeByMe"] as? [Dictionary<String,AnyObject>] {
                               
                                   for eachcom in likedbyme {
                                       var cmactids = 0
                                       var cmuserids = ""
                                       var cmmidd = 0
                                       var cmmondateee = ""
                                       var idd = ""
                                       var cmmprofnamee = ""
                                       var cmmprofimagee = ""

                                       var cmmuidd = ""
                                       if let cmactid = eachcom["ActivityId"] as? Int {
                                           cmactids = cmactid
                                       }
                                       
                                       if let cmuserid = eachcom["UserID"] as? String {
                                           if userid == cmuserid {
                                               currstatus = true
                                           }
                                           
                                            cmuserids = cmuserid
                                        }
                                       if let cmmiddd = eachcom["Id"] as? String {
                                            idd = cmmiddd
                                        }
                                       if let cmmondatee = eachcom["Ondate"] as? String {
                                            cmmondateee = cmmondatee
                                        }

                                       if let cmmprofname = eachcom["ProfilName"] as? String {
                                            cmmprofnamee = cmmprofname
                                        }
                                       if let cmmprofimage = eachcom["ProfileImage"] as? String {
                                            cmmprofimagee = cmmprofimage
                                        }

                                       var xc = like(activityid: cmactids, id: idd, ondate: cmmondateee, profilename: cmmprofnamee, profileimage: cmmprofimagee, userid: cmuserids)
                                       
                                       
                                       
                                       
                                       self.liketobepassed.append(xc)
                                       
                                       
                                       
                                   }
                               }
                               if let profimage = rawdetails["ProfileImg"] as? String {
                                   profimagee = profimage
                               }
                               if let profname = rawdetails["ProfileName"] as? String {
                                   profnamee = profname
                               }
                               if let pbon = rawdetails["PublishOn"] as? String {
                                   pbonn = pbon
                               }
                               if let title = rawdetails["Title"] as? String {
                                   titlee = title
                               }
                               if let type = rawdetails["Type"] as? String {
                                   typee = type
                               }
                               if let u_id = rawdetails["UserId"] as? String {
                                   u_idd = u_id
                               }
                               if let vw = rawdetails["View"] as? Int {
                                   vww = vw
                               }
                               if let cmnts = rawdetails["comments"] as? [Dictionary<String,AnyObject>] {
                                   for eachcom in cmnts {
                                       var cmaii = 0
                                       var cmmm = ""
                                       var cmmidd = 0
                                       var cmmondatee = ""
                                       var idd = ""
                                       var cmmprofnamee = ""
                                       var cmmprofimagee = ""
                                       var cmmreplycmmm : Dictionary<String,AnyObject> = [:]
                                       var cmmuidd = ""
                                       if let cmai = eachcom["ActivityId"] as? Int {
                                           cmaii = cmai
                                       }
                                       
                                       if let cmm = eachcom["Comment"] as? String {
                                            cmmm = cmm
                                        }
                                       if let cmmid = eachcom["CommentId"] as? Int {
                                            cmmidd = cmmid
                                        }
                                       if let cmmondate = eachcom["Ondate"] as? String {
                                            cmmondatee = cmmondate
                                        }
                                       if let id = eachcom["Id"] as? String {
                                           idd = id
                                       }
                                       if let cmmprofname = eachcom["ProfilName"] as? String {
                                            cmmprofnamee = cmmprofname
                                        }
                                       if let cmmprofimage = eachcom["ProfileImage"] as? String {
                                            cmmprofimagee = cmmprofimage
                                        }
                                       if let cmmreplycmm = eachcom["ReplyComments"] as? Dictionary<String,AnyObject> {
                                            cmmreplycmmm = cmmreplycmm
                                        }
                                       if let cmmuid = eachcom["UserID"] as? String {
                                           cmmuidd = cmmuid
                                            
                                        }
                                       
                                       
                                       var xc = commentinfo(activityid: cmaii, comment: cmmm, commentid: cmmidd, id: idd, ondate: cmmondatee, profilename: cmmprofnamee, profileimage: cmmprofimagee, replycomments: nil, userid: cmmuidd,status:"")
                                       
                                       
                                       cmntss.append(xc)
                                       
                                       
                                       
                                   }
                               }
                               if let tmb = rawdetails["thumbnail"] as? String {
                                   tmbb = tmb
                               }
                               
                               
                               var x = videopost(activityid: avii, activitypath: avpp, category: catt, descrip: dess, id: iddd, images: imagess, like: likee, likebyme: self.liketobepassed, profileimg: profimagee, profilename: profnamee, publichon: pbonn, title: titlee, type: typee, userid: u_idd, views: vww, comments: cmntss, thumbnail: tmbb,status: currstatus)
                               
                                
                     
                                   self.allimagedata.append(x)
                               
                               

                           }

                       }
                       
                       

                      
                       DispatchQueue.main.async {
                  
                           if self.cat  == "Image" {
                               if self.allimagedata.count > 0 {
                                   self.table.reloadData()
                               }
                           }

                       }
                                
                                          if self.cat  == "Image" {
                                              if self.oldcount == self.allimagedata.count {
                                              self.oldcount = self.allimagedata.count
                                          }
                       
                   }
                   
               }
           }
           
           
       }
       }
       }
       
       
       @IBAction func uploadnewvideo(_ sender: UIButton) {
           tapped = "video"
           self.addfilepopup.isHidden = true
           performSegue(withIdentifier: "movetoupload", sender: nil)
       }
       
       
       
       @IBAction func uploadnewaudio(_ sender: UIButton) {
       }
       
       
       @IBAction func uploadnewimage(_ sender: UIButton) {
           tapped = "image"
           performSegue(withIdentifier: "movetoupload", sender: nil)
       }
       
       
       
       @IBAction func uploadnewfile(_ sender: UIButton) {
           tapped = "file"
           performSegue(withIdentifier: "movetoupload", sender: nil)
       }
       
       
       
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if let seg = segue.destination as? PostVideoViewController {
               seg.type = self.tapped
               seg.sendprogress = {a in

                   DispatchQueue.main.async{
                       
                       self.progressviewheight.constant = 120
                       self.progressview.isHidden = false
                       var per = Int(a.fractionCompleted * 100)
                       
                       
                       var totaltofollow = self.progressview.frame.size.width - 32
                       var bringto = per/100 * Int(totaltofollow)
                       UIView.animate(withDuration: 1) {
                           self.progressindicatorwidth.constant = CGFloat(bringto)
                       }
                       
                       
                       
                       self.progressviewlabel.text = "\(per) % uploaded"
                       if per == 100 {
                           self.progressviewheight.constant = 0
                           DispatchQueue.global(qos: .background).async {
                               self.fetchdata()
                           }
                           
                       }
                   }
               }
           }
           
           
           
           if let seg = segue.destination as? AllcommentsViewController {
               seg.mode = self.mode
               if mode == "comments" {
   //                seg.allcomments = self.contactlisttobepassed
                   
                   seg.postid = self.postid

               }
               else if mode == "likes" {
                   seg.alllikes = self.liketobepassed
               }
           }
         }

}



public extension UIGraphicsRenderer {
    static func renderImagesAt(urls: [NSURL], size: CGSize, scale: CGFloat = 1) throws -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)

        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: max(size.width * scale, size.height * scale),
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]

        let thumbnails = try urls.map { url -> CGImage? in
            if  let imageSource = CGImageSourceCreateWithURL(url, nil) {

                if let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) {
                     return scaledImage
                }
            }
            return nil
        }

        // Translate Y-axis down because cg images are flipped and it falls out of the frame (see bellow)
        let rect = CGRect(x: 0,
                          y: -size.height,
                          width: size.width,
                          height: size.height)

        let resizedImage = renderer.image { ctx in

            let context = ctx.cgContext
            context.scaleBy(x: 1, y: -1) //Flip it ( cg y-axis is flipped)
            for image in thumbnails {
                if let im  = image  {
                    context.draw(im, in: rect)
                }
                
            }
        }

        return resizedImage
    }
}


public extension UIGraphicsRenderer {
    static func renderImageAt(url: NSURL, size: CGSize, scale: CGFloat = 1) throws -> UIImage {
        return try renderImagesAt(urls: [url], size: size, scale: scale)!
    }
}
