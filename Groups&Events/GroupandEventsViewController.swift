//
//  GroupandEventsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreLocation

struct streventcover
{
    var a : strevent
    var b : Bool
    var c : Bool
}

class GroupandEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var isother = false
    
    var sections = ["events","i am jury in","joined groups","groups","joined events"]
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var creategroupupperbutton: UIButton!
    
    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    static var cachegroupimage = NSCache<NSString,UIImage>()
    
    var choosensectionforseeall = 0
    var groupscount = 0
    var eventscount = 0

    var receivedgroup : groupevent?
    var receivedevent : strevent?
    var alldata : [streventcover] = []
    var jurydata : [streventcover] = []
    
    var copygroupdata : [groupevent] = []
    var copyunpublishedevents : [strevent] = []
    var copyevents : [strevent] = []
    var copyjoinedevents : [streventcover] = []
    var copyjoinedgroups : [groupevent] = []
    var copyrecommendedcontests : [streventcover] = []
    
    var copyjuryevents : [streventcover] = []
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        
        if self.isother {
            sections = ["unpublished contests","i am jury in","events","joined events" ,"recommended contests"]
            self.creategroupupperbutton.setTitle("Create Contest", for: .normal)
        }
        else {
            sections = ["i am jury in","joined groups","groups"]
            self.creategroupupperbutton.setTitle("Create Group", for: .normal)
        }
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        setupviews()
        
        var lat = CLLocationDegrees(exactly: 0)
        var longi = CLLocationDegrees(exactly: 0)
        
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
            
        }
        else {
            locationManager.requestWhenInUseAuthorization()

        }

 
    }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupviews()
    {
        self.notificationindicator.layer.cornerRadius = 10
        self.creategroupupperbutton.layer.cornerRadius = 20
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "getable", for: indexPath) as? GroupsandEventsTableViewCell {
            cell.tag = indexPath.section
            cell.updatecell(x: sections[indexPath.section].lowercased(),w:self.view.frame.size.width/2,h:self.table.frame.size.height)
            
            
            cell.isblannk = {a, b,c in
                if c == cell.tag {
//                if a {
//                    if b == "group" {
//                        cell.nodataimage.isHidden = false
//                        cell.collection.isHidden = true
//                        cell.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//                    }
//                    else if b == "contest" {
//                        cell.nodataimage.isHidden = false
//                        cell.collection.isHidden = true
//                        cell.nodataimage.image = UIImage(named: "nocontestsplaceholder")
//                    }
//
//                }
//                else {
//                    if b == "group" {
//                        cell.nodataimage.isHidden = true
//                        cell.collection.isHidden = false
//                        cell.nodataimage.image = UIImage(named: "nogroupsplaceholder")
//                    }
//                    else if b == "contest" {
//                        cell.nodataimage.isHidden = true
//                        cell.collection.isHidden = false
//                        cell.nodataimage.image = UIImage(named: "nocontestsplaceholder")
//                    }
//                }
                }
            }
            
            
            cell.passalljoinedgroups = {a in
                self.copyjoinedgroups = a
            }
            cell.passallrecommendedevents = { a in
                self.copyrecommendedcontests = a
            }
            cell.passallevents = {a in
                self.copyevents = a
            }
            cell.passalljoinedevents = {a in
                self.copyjoinedevents = a
            }
            cell.passallgroups = {a in
                self.copygroupdata = a
            }
            cell.passalljuryevents = {a in
                self.copyjuryevents = a
            }
            cell.passallunpublishedevents = { a in
                self.copyunpublishedevents = a
            }
            
            cell.passcounts = {a in
                print("Heyya events count is \(a)")
                self.eventscount = a
              
            }
            cell.selectedgrouppassed = {g in
                print("Received")
                self.receivedgroup = g
                self.performSegue(withIdentifier: "explaingroup", sender: nil)
                print(g)
            }
            cell.selectedeventpassed = {e in
                print("Heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy")
                print(e)
                self.receivedevent = e
                var uid = UserDefaults.standard.value(forKey: "refid") as! String
//                if uid == e.userid {
//                    self.performSegue(withIdentifier: "taketomyevents", sender: nil)
//                }
//                else {
                    self.performSegue(withIdentifier: "taketoothersevent", sender: nil)
//                }
                
            }
            
            cell.selectedjurypassed = {a in
                self.receivedevent = a.a
                self.performSegue(withIdentifier: "juryshowevent", sender: nil)
            }
            
            return cell
        }
        return UITableViewCell()
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
//        return self.view.frame.size.height/3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:30))
        view.backgroundColor = self.view.backgroundColor
        let label = Customlabel(frame: CGRect(x:30, y:5, width:tableView.frame.size.width/1.8, height:25))
           label.font = UIFont(name: "NeusaNextStd-Light", size: 19)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if self.sections[section] == "i am jury in" {
            label.font = UIFont(name: "NeusaNextStd-Light", size: 10)
            label.text = "You are jury in"
        }
        else if self.sections[section] == "unpublished contests" {
            label.text = "Unpublished contests"
        }
        else if self.sections[section] == "events" {
            label.text = "Your contests"
        }
        else if self.sections[section] == "joined events" {
            label.text = "Your joined contests"
        }
        else if self.sections[section] == "recommended contests" {
            label.text = "Recommended contests"
        }
        else {
            
            label.text = "Your \(self.sections[section].capitalized)"
        }
    
           view.addSubview(label)
       
        
        let btn = UIButton(frame: CGRect(x:tableView.frame.size.width/1.65,y:7,width:tableView.frame.size.width/2.5,height: 18))
        btn.setTitle("See all", for: .normal)
        btn.titleLabel?.textAlignment = .right
        btn.tag = section
        btn.addTarget(self, action: #selector(seealltapped), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "NeusaNextStd-Light", size: 12)
        
        btn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        view.addSubview(btn)

           return view
       }
    
    @objc func seealltapped(sender:UIButton) {
        print("Tapped see all for section \(sender.tag)")
        self.choosensectionforseeall = sender.tag
        
        performSegue(withIdentifier: "showseeallcontents", sender: nil)
    }
    
    
    @IBAction func creategrouptapped(_ sender: Any) {
        if self.isother {
            print("Right place \(self.copyunpublishedevents.count)")
            if self.copyunpublishedevents.count > 3 {
               self.present(customalert.showalert(x: "Please publish or delete your unpublished contests before creating a new contest."), animated: true, completion: nil)
            }
            else {
                performSegue(withIdentifier: "creatingnewcontest", sender: nil)
            }
        }
        else {
            performSegue(withIdentifier: "creatinggroup", sender: nil)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let seg = segue.destination as? ModifiedcontestcreateViewController {
            seg.comingwithoutgroup = true
        }
        
        
        if let seg = segue.destination as? MainGroupViewController {
            
            print("Sending Main")
            print(receivedgroup)
            seg.passedgroup2 = self.receivedgroup
        }
        if let s = segue.destination as? SeeAllgeneralViewController {
            
            if self.isother {
                s.modefetch = "contest"
            }
            else {
                s.modefetch = "group"
            }
            
            if !self.isother
            {
            
                if self.choosensectionforseeall == 0 {
                    s.typeoffetch = "juryevents"
                    s.juryevents = self.copyjuryevents
                }
                else if self.choosensectionforseeall == 1 {
                    s.typeoffetch = "joinedgroups"
                    s.joinedgroups = self.copyjoinedgroups
                }
                else if self.choosensectionforseeall == 2 {
                    s.typeoffetch = "yourgroups"

                    s.yourgroups = self.copygroupdata
                }
            
            }
            else {
                if self.choosensectionforseeall == 0 {
                    s.typeoffetch = "unpublished contests"
                    s.unpublisedcontests = self.copyunpublishedevents
                }
                else if self.choosensectionforseeall == 1 {
                    s.typeoffetch = "juryevents"
                    s.juryevents = self.copyjuryevents
                }
                if self.choosensectionforseeall == 2 {
                    s.typeoffetch = "yourevents"
                    s.yourevents = self.copyevents
                }
                else if self.choosensectionforseeall == 3{
                    s.typeoffetch = "joinedevents"
                    print("Here check for joined events data")
                    print(self.copyjoinedevents)

                    s.joinedevents = self.copyjoinedevents
                }
                else if self.choosensectionforseeall == 4{
                    s.typeoffetch = "joinedevents"
                    print("Here check for joined events data")
                    
                    
                    s.joinedevents = self.copyrecommendedcontests
                }
            }
        }
        
        if let s = segue.destination as? JoinedeventsViewController {
            s.dangeringoingback = false
            s.eventid = self.receivedevent?.contestid ?? 0
            
        }
        if let s = segue.destination as? NewEventViewController {
            s.eventid = self.receivedevent?.contestid ?? 0
            s.passbackupdatedevent = { a in
                
            }
        }
        if let s = segue.destination as? JurycontestViewController {
            s.contestid = self.receivedevent?.contestid ?? 0
        }
    }
    

}
