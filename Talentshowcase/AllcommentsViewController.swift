//
//  AllcommentsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 24/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit




class AllcommentsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate{
    
    
    @IBOutlet weak var postbtn: UIButton!
    
    
    
    
    @IBOutlet weak var nodatawarn: Customlabel!
    
    
    
    
    
    
    @IBOutlet weak var cancelbtn: UIButton!
    
    
    var mode = "comments"
    var sendbackupdatedlist : ((_ x : [comment], _ y : Int) -> Void )?
    var tappedcommentlist : [comment] = []
    var commentposted: ((_ status: comment?,_ postid : Int) -> ())?

    
    var alllikes : [like] = []
    var allviews : [String] = []
    var allcomments : [commentinfo] = []
    var postid = 0
    var commenttobereplied : comment?
    var currentrunningstatus  = ""
    
    @IBOutlet weak var commentfield: UITextField!
    
    
    @IBOutlet weak var table: UITableView!
    
    var ineditingmode : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
     
        table.reloadData()
        
        self.nodatawarn.isHidden = true
        if currentrunningstatus == "closed" {
            self.postbtn.isHidden = true
            self.cancelbtn.isHidden = true
            self.commentfield.isHidden = true
        }
        else {
            self.postbtn.isHidden = false
            self.cancelbtn.isHidden = false
            self.commentfield.isHidden = false
        }
        
        
        if mode == "comments" {
//            fetchdata()
            print(tappedcommentlist)
            table.reloadData()
        }
        else if mode == "likes" {
            print("Likes data")
        }
        self.commentfield.delegate = self
       
//        self.commentfield.isHidden = true
//        self.postbtn.isHidden = true
        
        if mode == "views" || mode == "likes" {
            self.commentfield.isHidden = true
            self.postbtn.isHidden = true
        }
    
        
    }
    
    
    @IBAction func cancelpressed(_ sender: Any) {
        self.commentfield.text = ""
        self.postbtn.setTitle("Post", for: .normal)
    }
    
    func fetchdata()
    {
        self.allcomments = []
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
               let params : Dictionary<String,Any> = ["Page":0 ,"PageSize": 9]

                                         
                                         var header : Dictionary<String,String> = [:]
                                         header["Accept"] = "application/json"
                                         header["Content-Type"] = "application/json"
                                         header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6Ijg3MGRlNWZhLWYyMDItNDFlNC04MjJlLTc4Y2M4MjdkY2YxNCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzY5MDEwLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9._wID6Wy6x7a6Yv5186x3M-no7tQ1sKVAAbqJf4ZjrAg"
                                         
                                         
                                         
        var url = Constants.K_baseUrl + Constants.categorywisecomment+"/\(self.postid)"
                                         var r = BaseServiceClass()
                                         r.postApiRequest(url: url, parameters: params) { (data, err) in
                                             print("-----------------")
                                          if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                                              if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                                                

                                              
                                                if let indv =  inv["Data"] as? [Dictionary<String,AnyObject>] {
                                                    for cim in indv {
                                                        var replycomm : [commentinfo] = []
                                                        
                                                        
                                                        if let replycomments = cim["ReplyComments"] as? [Dictionary<String,AnyObject>] {
                                                                                                                                                                          
                                                                                                                                                                          for rc in replycomments {
                                                                                                                                                                              if let cid = rc["CommentId"] as? Int,let aid = rc["ActivityId"] as? Int,let pn = rc["ProfilName"] as? String,let pi = rc["ProfileImage"] as? String,let uid = rc["UserID"] as? String,let cm = rc["Comment"] as? String,let on = rc["Ondate"] as? String  {
                                                                                                                                                                                  replycomm.append(commentinfo(activityid: aid, comment: cm, commentid: cid, id: "", ondate: on, profilename: pn, profileimage: pi, replycomments: nil, userid: uid,status:"replied"))
                                                                                                                                                                              }
                                                                                                                                                                          }
                                                                                                                                                                }
                                                       
                                                        if let cid = cim["CommentId"] as? Int,let aid = cim["ActivityId"] as? Int,let pn = cim["ProfilName"] as? String,let pi = cim["ProfileImage"] as? String,let uid = cim["UserID"] as? String,let cm = cim["Comment"] as? String,let on = cim["Ondate"] as? String  {
                                                            
                                                            if let rcc = replycomm as? [commentinfo] {
                                                                var newcomment = commentinfo(activityid: aid, comment: cm, commentid: cid, id: "", ondate: on, profilename: pn, profileimage: pi, replycomments: rcc, userid: uid,status:"main")
                                                                print(newcomment)
                                                                self.allcomments.append(newcomment)
                                                                if let fetchreplies = rcc as? [commentinfo] {
                                                                    for kk in fetchreplies {
                                                                        self.allcomments.append(kk)
                                                                    }
                                                                }
                                                            }
                                                            else
                                                            {
                                                                var newcomment = commentinfo(activityid: aid, comment: cm, commentid: cid, id: "", ondate: on, profilename: pn, profileimage: pi, replycomments: nil, userid: uid,status:"main")
                                                                print(newcomment)
                                                                self.allcomments.append(newcomment)

                                                            }
                                                        
                                                            
                                                            }
                                                        
                                                       
                                                    
                                                                                
                                                    }
                                                    if self.allcomments.count == 0 {
                                                        self.nodatawarn.isHidden = false
                                                    }
                                                    else {
                                                        self.nodatawarn.isHidden = true
                                                    }
                                                    self.table.reloadData()
                                                    for em in self.allcomments {
                                                        print("\(em.comment) with type \(em.status)")
                                                        print(em.replycomments)
                                                    }
                                                    print("Fetching Done")
                                                   
                                                
                                                }
                                            }
                                             
                                         
                                            }

        
        }
        
        

        
        
    }
    
    
     func postcomment(cmnttxt : String)
           {
            var newcomment : comment!

               let userid = UserDefaults.standard.value(forKey: "refid") as! String
            let params : Dictionary<String,Any> = ["PostId":self.postid as? Int ,"UserId": userid as? String,"UserComment":cmnttxt as? String]


            


               var url = Constants.K_baseUrl + Constants.postCOmment
               var r = BaseServiceClass()
               r.postApiRequest(url: url, parameters: params) { (data, err) in
                   print("-----------------")
                if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                    if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                        var id = ""
                        var cid = 0
                        var  aid = 0
                        var pname = ""
                        var pimage = ""
                        var uid = ""
                        var ucomment = ""
                        var ondate = ""
                        var replycomm : [comment] = []
                        if let s =  inv["Id"] as? String {
                            id = s
                        }
                        if let s =  inv["CommentId"] as? Int {
                            cid = s
                        }
                        if let s =  inv["ActivityId"] as? Int {
                            aid = s
                        }
                        if let s =  inv["ProfileName"] as? String {
                            pname = s
                        }
                        if let s =  inv["ProfileImage"] as? String {
                            pimage = s
                        }
                        if let s =  inv["UserID"] as? String {
                            uid = s
                        }
                        if let s =  inv["Comment"] as? String {
                            ucomment = s
                        }
                        if let s =  inv["Ondate"] as? String {
                            ondate = s
                        }
                        
                         newcomment = comment(id: id, comentid: cid, activityid: aid, profilename: pname, profileimage: pimage, userid: uid, usercomment: ucomment, ondate: ondate, replycomments: [] , status: "main")
                        

                            }
                    
                    
                    if let st = dv["ResponseStatus"] as? Int {
                        if st == 0 {
                            print(newcomment)
                            self.tappedcommentlist.append(newcomment)
                            self.table.reloadData()
                            self.sendbackupdatedlist!(self.tappedcommentlist,self.postid)
                            self.commentfield.text = ""
                        }
                        else {
                            self.commentposted!(nil,self.postid)
                        }
                        
                    }


                        }



                    }

            
            


           }
        
    
    func addnestedcommentandreturn(){
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        
        var curdatee = Date.getCurrentDate()
        curdatee = ""
        var params : Dictionary<String,Any> = [:]
        if let ct = self.commentfield.text as? String ,let ud = userid as? String,let pid = self.postid as? Int,let pcid = self.commenttobereplied?.comentid as? Int {
            params  = ["UserComment":ct,"UserId": ud,"PostId":pid,"ParentCommentId":pcid]
        }
        
         

                   
                   var header : Dictionary<String,String> = [:]
                   header["Accept"] = "application/json"
                   header["Content-Type"] = "application/json"
                   header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6Ijg3MGRlNWZhLWYyMDItNDFlNC04MjJlLTc4Y2M4MjdkY2YxNCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzY5MDEwLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9._wID6Wy6x7a6Yv5186x3M-no7tQ1sKVAAbqJf4ZjrAg"
                   
                   print(params)
                   
                   var url = Constants.K_baseUrl + Constants.nestedcomment
                   var r = BaseServiceClass()
                   r.postApiRequest(url: url, parameters: params) { (data, err) in
                       print("-----------------")
                    if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                        print(dv)
                        if let inv =  dv["Results"] as? Dictionary<String,AnyObject> {
                            print(inv)
                            var id = ""
                            var cid = 0
                            var  aid = 0
                            var pname = ""
                            var pimage = ""
                            var uid = ""
                            var ucomment = ""
                            var ondate = ""
                            var replycomm : [comment] = []
                            if let s =  inv["Id"] as? String {
                                id = s
                            }
                            if let s =  inv["CommentId"] as? Int {
                                cid = s
                            }
                            if let s =  inv["ActivityId"] as? Int {
                                aid = s
                            }
                            if let s =  inv["ProfileName"] as? String {
                                pname = s
                            }
                            if let s =  inv["ProfileImage"] as? String {
                                pimage = s
                            }
                            if let s =  inv["UserID"] as? String {
                                uid = s
                            }
                            if let s =  inv["Comment"] as? String {
                                ucomment = s
                            }
                            if let s =  inv["Ondate"] as? String {
                                ondate = s
                            }
                           
                            var repliedcomment = comment(id: id, comentid: cid, activityid: aid, profilename: pname, profileimage: pimage, userid: uid, usercomment: ucomment, ondate: ondate, replycomments: [] , status: "reply")
                
                            
                           
                           
                            
                            print("-----------")
                            print(repliedcomment)
                            for var k in 0..<self.tappedcommentlist.count {
                                               if self.tappedcommentlist[k].comentid == self.commenttobereplied?.comentid {
                                               
                                                   
                                                   
                                                   self.tappedcommentlist.insert(repliedcomment, at: k+1)
                                                   self.table.reloadData()
                                                   break
                                               }
                                           }
                            print("Another Fetching Done")
                            self.commentfield.text = ""
                            
                            self.postbtn.setTitle("Post", for: .normal)
                            self.commentfield.resignFirstResponder()
                        }
                    }
                    
                   }
                   
                   
               }
    
    
    
    
    
    @IBAction func postcommentpressed(_ sender: UIButton) {
        print("Post button pressed")
        if postbtn.titleLabel?.text == "Post" {
            if let cm = self.commentfield.text as? String {
                if cm != "" || cm != " " {
                    self.postcomment(cmnttxt: cm)
                }
                
            }
        }
        else if self.ineditingmode == true {
            if self.commentfield.text != "" {
//                goEdit(newtextc: self.commentfield.text!)
                addnestedcommentandreturn()
                
            }
        }
        else {
            if self.commentfield.text  != "" {
               
                              
            }
        }
           
    }
    
    
    
  func textFieldDidBeginEditing(textField: UITextField) {
    if (self.commentfield.text!.isEmpty){
        self.postbtn.isEnabled = false
    }
    else {
        self.postbtn.isEnabled = true
    }
          self.animateViewMoving(up: true, moveValue: 100)
  }
  func textFieldDidEndEditing(textField: UITextField) {
    if (self.commentfield.text!.isEmpty) {
        self.postbtn.isEnabled = false
    }
    else {
        self.postbtn.isEnabled = true
    }
          self.animateViewMoving(up: false, moveValue: 100)
  }
  
    func textFieldDidChange(textField : UITextField){
        if (self.commentfield.text!.isEmpty){
                self.postbtn.isEnabled = false
            }
            else {
                self.postbtn.isEnabled = true
            }
        }
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.commentfield.resignFirstResponder()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mode == "likes" {
            return self.alllikes.count
        }
        else if mode == "views" {
            return self.allviews.count
        }
        else {
            return self.tappedcommentlist.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mode == "comments" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "allcommentscell", for: indexPath) as? AllcommentsTableViewCell {
                
                
                cell.deletecomment = { a,b in
                    
                    let alert2 = UIAlertController(title: "Delete Comment ?", message: "Are you sure you want to delete this comment ?", preferredStyle: .actionSheet)
                    alert2.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                        let userid = UserDefaults.standard.value(forKey: "refid") as! String
                        let params : Dictionary<String,Any> = ["Id":a ,"UserId": userid as? String,"PostId":b]
                        

                        
                        var url = Constants.K_baseUrl + Constants.delComment
                        var r = BaseServiceClass()
                        r.postApiRequest(url: url, parameters: params) { (data, err) in
                            print("-----------------")
                            if let dv = data?.result.value as? Dictionary<String,AnyObject> {
                                if let inv =  dv["Results"] as? String {
                                    print(inv)
                                }
                            }
                            
                            if let st = data?.response?.statusCode as? Int {
                                if st == 200 {
                                    for k in 0..<self.tappedcommentlist.count {
                                        if self.tappedcommentlist[k].comentid == a{
                                            self.tappedcommentlist.remove(at: k)
                                            self.sendbackupdatedlist!(self.tappedcommentlist,self.postid)
                                            print("Rows left \(self.tappedcommentlist.count)")
                                            self.table.reloadData()
                                            break
                                        }
                                    }
                                }
                                else {
                                    
                                }
                                
                            }
                        }
                        
                        
                    }));
                    alert2.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert2, animated: true, completion: nil)
                    
                }
                
                
                
                
                cell.notifytoenableediting = {ans,comment,mode in
                    if ans! {
                        if mode == "reply" {
                        self.commenttobereplied = comment
                            self.postbtn.isEnabled = true
                            self.commentfield.isEnabled = true
                        self.postbtn.isHidden = false
                        self.commentfield.isHidden = false
                            if let pn = comment!.profilename as? String {
                                                self.commentfield.text = "@\(pn) "
                            }

                        self.postbtn.setTitle("Reply", for:.normal)
                        self.ineditingmode = true
                        }
                    }
                    else {
                         if mode == "reply" {
                        self.postbtn.isHidden = true
                        self.commentfield.isHidden = true
                        self.postbtn.setTitle("Post", for:.normal)
                        self.ineditingmode = false
                        self.commentfield.text = ""
                         self.commenttobereplied = nil
                        }
                    }
                }
                cell.updatecell(x: tappedcommentlist[indexPath.row] ,rs : currentrunningstatus)
                return cell
            }
        }
        else if mode == "likes"{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "allcommentscell", for: indexPath) as? AllcommentsTableViewCell {
                
                
                cell.updatecell2(x: alllikes[indexPath.row] , rs : currentrunningstatus)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mode == "comments" {
//            if allcomments[indexPath.row].status == "reply" || allcomments[indexPath.row].status == "replied" {
//                return self.table.frame.size.height/6.5
//
//            }
//            else{
//                return self.table.frame.size.height/5
//            }
        }
        return 200
    }
    
//    func goEdit(newtextc:String){
//        let userid = UserDefaults.standard.value(forKey: "refid") as! String
//        let params : Dictionary<String,Any> = ["Id":self.commenttobereplied!.commentid as? Int ,"UserId": userid as? String,"PostId":self.commenttobereplied!.activityid,"UserComment":self.commenttobeedited!.comment]
//
//
//                                  var header : Dictionary<String,String> = [:]
//                                  header["Accept"] = "application/json"
//                                  header["Content-Type"] = "application/json"
//                                  header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6Ijg3MGRlNWZhLWYyMDItNDFlNC04MjJlLTc4Y2M4MjdkY2YxNCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzY5MDEwLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9._wID6Wy6x7a6Yv5186x3M-no7tQ1sKVAAbqJf4ZjrAg"
//
//
//
//                                  var url = Constants.K_baseUrl + Constants.editComment
//                                  var r = BaseServiceClass()
//                                  r.postApiRequest(url: url, parameters: params) { (data, err) in
//                                      print("-----------------")
//        //                           if let dv = data?.result.value as? Dictionary<String,AnyObject> {
//        //                               if let inv =  dv["Results"] as? String {
//        //                                   print(inv)
//        //                               }
//        //                           }
//
//                                      if let st = data?.response?.statusCode as? Int {
//                                          if st == 200 {
//                                            for var ec in self.allcomments {
//                                                if ec.commentid == self.commenttobeedited?.commentid {
//                                                    ec.comment = newtextc
//                                                    self.table.reloadData()
//                                                    break
//                                                }
//                                            }
//                                          }
//                                          else {
//
//                                           }
//
//                                      }
//                                  }
//        self.commentfield.text = ""
//        self.commentfield.isHidden = true
//        self.postbtn.isHidden = true
//    }
//
    
   
    

    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}


extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        return dateFormatter.string(from: Date())

    }
    
    static func getCurrentFromDate(d:Date) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(from: d)

    }
}
