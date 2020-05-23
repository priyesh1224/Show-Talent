//
//  ProfileTablePostsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 08/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AVKit

class ProfileTablePostsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    
    
    
    @IBOutlet weak var table: UITableView!
    
     var passeddata : [videopost] = []
    var currentindex = 0
    var cat = ""
    var contactlisttobepassed : [commentinfo] = []
    var liketobepassed : [like] = []
    var mode = ""
    var postid = 0
    static var cachepostthumbnail = NSCache<NSString,UIImage>()
    static var cachepostprofileimage = NSCache<NSString,UIImage>()
    static var cachepostvideo = NSCache<NSString,AVURLAsset>()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.table.reloadData()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
            print("Clearing all cache")
        ProfileTablePostsViewController.cachepostvideo.removeAllObjects()
        ProfileTablePostsViewController.cachepostthumbnail.removeAllObjects()
        
        ProfileTablePostsViewController.cachepostprofileimage.removeAllObjects()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.passeddata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let userid = UserDefaults.standard.value(forKey: "refid") as! String
        if self.passeddata[indexPath.row].type.capitalized == "Video"
                {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "talenttable", for: indexPath) as? TalentshowcaseTableViewCell {
                        cell.selectionStyle = .none
                        cell.commentfield.delegate = self
                        
                    
                        
                        if self.passeddata.count > indexPath.row {
                        cell.update(x: self.passeddata[indexPath.row])
                        }
                        
                        
                        
                        cell.togglelike = {pos,likestatus in
                        
                            
                            for var index in 0..<self.passeddata.count {
                                if self.passeddata[index].activityid == pos.activityid {
                                    self.passeddata[index].status = !self.passeddata[index].status
                                    if !self.passeddata[index].status == true {
                                        self.passeddata[index].like = self.passeddata[index].like - 1
                                        
                                        for var lki in 0..<self.passeddata[index].likebyme.count {
                                                if self.passeddata[index].likebyme[lki].userid == userid {
                                                    self.passeddata[index].likebyme.remove(at: lki)
                                                }
                                            
                                        }
                                        
                                        
                                        print("Like to \(self.passeddata[index].activityid) is \(self.passeddata[index].like) where as array count is \(self.passeddata[index].likebyme.count)")
                                    }
                                    else {
                                        self.passeddata[index].like = self.passeddata[index].like + 1
                                        
                                        
                                        self.passeddata[index].likebyme.append(like(activityid: self.passeddata[index].activityid, id: self.passeddata[index].id, ondate: "", profilename: "Auth user to be replace with", profileimage: "", userid: userid))
                                        
                                        
                                         print("Like to \(self.passeddata[index].activityid) is \(self.passeddata[index].like) where as array count is \(self.passeddata[index].likebyme.count)")
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
                            
                            self.mode = "likes"
                            self.liketobepassed = gotdata.likebyme
                            self.performSegue(withIdentifier: "taketoallcomments", sender: nil)
                        }
                        cell.commentposted = {st in
                           
                            print("-------")
                            if let sst = st as? commentinfo {
                                print("Hello")
                                for var ec in self.passeddata {
                                    if ec.activityid == st!.activityid {
                                        ec.comments.append(sst)
            //                            self.table.reloadRows(at: [indexPath], with: .automatic)
                                        break
                                    }
                                }
                                
            //                    self.fetchdata()
                            }
                        }
                        if indexPath.row == self.currentindex {
                           tableView.scrollToRow(at: indexPath , at: .middle, animated: true)

                        }
                        return cell
                    }
                }
                else {
                       if let cell = tableView.dequeueReusableCell(withIdentifier: "talenttable2", for: indexPath) as? TalentshowcaseTableViewCell2 {
                                cell.selectionStyle = .none
                                cell.commentfield.delegate = self
                        print("\(indexPath.row) and \(self.passeddata.count)")
                                cell.updatecell(x: self.passeddata[indexPath.row])
                        
                       
                        cell.togglelike = {pos,likestatus in
                            
              
                            
                            for var index in 0..<self.passeddata.count {
                                if self.passeddata[index].activityid == pos.activityid {
                                    self.passeddata[index].status = !self.passeddata[index].status
                                    if !self.passeddata[index].status == true {
                                        self.passeddata[index].like = self.passeddata[index].like - 1
                                        for var lki in 0..<self.passeddata[index].likebyme.count {
                                                            if self.passeddata[index].likebyme[lki].userid == userid {
                                                                self.passeddata[index].likebyme.remove(at: lki)
                                                            }
                                                        
                                                    }

                                    }
                                    else {
                                        self.passeddata[index].like = self.passeddata[index].like + 1
                                        
                                        self.passeddata[index].likebyme.append(like(activityid: self.passeddata[index].activityid, id: self.passeddata[index].id, ondate: "", profilename: "Auth user to be replace with", profileimage: "", userid: userid))
                                        
                                    }
                                    
                                    
                                    
                                    
                                    break
                                }
                            }
                            
                     
                            
        //                    self.table.reloadRows(at: [indexPath], with: .none)
                        }
                        
                        
                                cell.onSeeAllcomments = {gotdata , iid in
                                    print(gotdata)
                                    self.mode = "comments"
                                    self.postid = iid
                                    self.contactlisttobepassed = gotdata.comments
                                    self.performSegue(withIdentifier: "taketoallcomments", sender: nil)
                                }
                                cell.onSeeAlllikes = {gotdata in
                                    print(gotdata)
                                    self.mode = "likes"
                                    self.liketobepassed = gotdata.likebyme
                                    self.performSegue(withIdentifier: "taketoallcomments", sender: nil)
                                }
                                cell.commentposted = {st in
                                    print(st)
                                    print("-------")
                                    if let sst = st as? commentinfo {
                                        print("Hello")
                                        for var ec in self.passeddata {
                                            if ec.activityid == st!.activityid {
                                                ec.comments.append(sst)
                    //                            self.table.reloadRows(at: [indexPath], with: .automatic)
                                                break
                                            }
                                        }
                                        
                    //                    self.fetchdata()
                                    }
                                }
                        
                        if indexPath.row == self.currentindex {
                           tableView.scrollToRow(at: indexPath , at: .middle, animated: true)

                        }
                        
                                return cell
                            }
                }
                return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("height is \(self.view.frame.size.height/1.7)")
        if self.passeddata[indexPath.row].type.capitalized == "Video" {
        if self.view.frame.size.height/1.2 < 750 {
            return 750
        }
        return self.view.frame.size.height/1.2
        }
        else {
            if self.view.frame.size.height/1.7 < 550 {
                return 550
            }
            return self.view.frame.size.height/1.7
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TalentshowcaseTableViewCell {
            if self.self.passeddata[indexPath.row].type.capitalized == "Video" && self.passeddata.count > indexPath.row {
            cell.player.pause()
                cell.player.cancelPendingPrerolls()
            }
            
        }
    }
    

    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let seg = segue.destination as? AllcommentsViewController {
                    seg.mode = self.mode
                    if mode == "comments" {
        //                seg.allcomments = self.contactlisttobepassed
                        
                        seg.postid = self.postid
//                        seg.commentposted = {a,b in
//                            var c = 0
//                            for var k in self.passeddata {
//
//                                if k.activityid == a?.activityid {
//                                    if let lc = self.table.cellForRow(at: IndexPath(row: c, section: 0)) as? TalentshowcaseTableViewCell {
//
//                                        lc.leadcommentuser.text = a?.profilename.capitalized
//                                        lc.leadcomment.text = a?.comment.capitalized
//
//                                        lc.leadcomment.text = "Hello"
//                                        lc.downloadprofileimage(url: a!.profileimage) { (ik) in
//                                            lc.leadcommentuserimage.image = ik
//                                        }
//                                    }
//
//                                    k.comments.append(a!)
//                                    self.table.reloadData()
//                                }
//                                 c=c+1
//                            }
//                        }
                    }
                    else if mode == "likes" {
                        seg.alllikes = self.liketobepassed
                    }
                }

    }
    
}
