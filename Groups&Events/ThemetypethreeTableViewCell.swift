//
//  ThemetypethreeTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/18/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ThemetypethreeTableViewCell: UITableViewCell, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    
    
    var themetapped : ((_ x : pretheme) -> Void)?
    var changejury : ((_ x : Bool) -> Void)?
    var currepretheme : pretheme?
    
    @IBOutlet weak var v1: UIView!
    
    
    @IBOutlet weak var contestrulesview: UIView!
    
    
    @IBOutlet weak var contestrules: UITextView!
    
    @IBOutlet weak var v2: UIView!
    
    
    @IBOutlet weak var awardsouterview: UIView!
    
    
    @IBOutlet weak var noofwinnersouterview: UIView!
    
    
    @IBOutlet weak var noofwinners: UILabel!
    
    
    @IBOutlet weak var awardtype: UITextView!
    
    
    @IBOutlet weak var winnerscollection: UICollectionView!
    
    
    @IBOutlet weak var v3: UIView!
    
    @IBOutlet weak var changejurybtn: UIButton!
    
    
    @IBOutlet weak var jurycollection: UICollectionView!
    
    
    @IBOutlet weak var v4: UIView!
    
    
    @IBOutlet weak var otherdetailsouterview: UIView!
    
    
    @IBOutlet weak var entryallowedformat: UILabel!
    
    
    @IBOutlet weak var performancetype: UILabel!
    
    
    @IBOutlet weak var gender: UILabel!
    
    
    @IBOutlet weak var termsandconditionsouterview: UIView!
    
    
    @IBOutlet weak var termsandconditions: UITextView!
    
    
    @IBOutlet weak var applythemebtn: CustomButton!
    @IBOutlet weak var tandcheight: NSLayoutConstraint!
         var winnersprice : [pricewinnerwise] = []
    var currentjurylist : [juryorwinner] = []
    func update2(x : pretheme , p : String , s : String, creatingcontest : Bool,winnerpricelist : [pricewinnerwise])
    {
        currepretheme = x
        winnerscollection.delegate = self
        winnerscollection.dataSource = self
        currentjurylist = x.juries
        var xx  = juryorwinner(id: 1, userid: "", name: "John", profile: "http://thcoreapi.maraekat.com/Upload/Profile/066af0e3-5394-4a86-9e99-acdeb9879ac5/066af0e3-5394-4a86-9e99-acdeb9879ac5.jpg")
        self.currentjurylist.append(xx)
        self.currentjurylist.append(xx)
        self.currentjurylist.append(xx)
        self.winnersprice = winnerpricelist
        jurycollection.delegate = self
        jurycollection.dataSource = self
        setupextraviews()
        termsandconditionsouterview.layer.cornerRadius = 10
        termsandconditionsouterview.layer.borderColor = UIColor.white.cgColor
        termsandconditionsouterview.clipsToBounds = true
        self.selectionStyle = .none
        termsandconditionsouterview.layer.borderWidth = 2
        contestrules.text = x.description.capitalized
        noofwinners.text = "No of winners : \(x.noofwinner)"
        awardtype.text = "Award Type : \(x.contestprice.capitalized)"
        entryallowedformat.text = "\(x.entrytype.capitalized)"
        performancetype.text = x.performancetype.capitalized
        gender.text = x.gendername.capitalized
        termsandconditions.text = x.termsandconditions
        applythemebtn.layer.cornerRadius = applythemebtn.frame.size.height/2
        
        applythemebtn.isHidden = false
        self.changejurybtn.isEnabled = false
        
        var l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.itemSize = CGSize(width: 100, height: 70)
        winnerscollection.reloadData()
        winnerscollection.collectionViewLayout = l
        winnerscollection.reloadData()
        
        
        var ll = UICollectionViewFlowLayout()
        ll.scrollDirection = .horizontal
        ll.itemSize = CGSize(width: self.jurycollection.frame.size.width, height: 100)
        jurycollection.reloadData()
        jurycollection.collectionViewLayout = ll
        jurycollection.reloadData()
        if creatingcontest {
            self.applythemebtn.isHidden = true
        }
        else {
            self.applythemebtn.isHidden = false
        }
        self.changejurybtn.setTitleColor(UIColor.black, for: .normal)
              self.changejurybtn.backgroundColor = UIColor.white
              self.changejurybtn.layer.cornerRadius = 5
        
    }
    func update(x:strevent,b : Bool, c : Bool , conimage : String ,winnerpricelist : [pricewinnerwise], allwinners : [juryorwinner] , participants : Int , isllowed : Bool , timetopublish : Bool , win : Int , pt : String , gen : String, needtoshowapplytheme : Bool)
    {
        self.changejurybtn.setTitleColor(UIColor.black, for: .normal)
              self.changejurybtn.backgroundColor = UIColor.white
              self.changejurybtn.layer.cornerRadius = 5
        currentjurylist = x.juries
        var xx  = juryorwinner(id: 1, userid: "", name: "priyesh", profile: "http://thcoreapi.maraekat.com/Upload/Profile/066af0e3-5394-4a86-9e99-acdeb9879ac5/066af0e3-5394-4a86-9e99-acdeb9879ac5.jpg")

        setupextraviews()
        winnerscollection.delegate = self
        winnerscollection.dataSource = self
        termsandconditionsouterview.clipsToBounds = true
        self.selectionStyle = .none
     self.winnersprice = winnerpricelist
        contestrules.text = x.description.capitalized
        noofwinners.text = "No of winners : \(win)"
        awardtype.text = "Award Type : \(x.contestprice.capitalized)"
        entryallowedformat.text = "\(x.entrytype.capitalized)"
        performancetype.text = pt
        gender.text = gen
        termsandconditions.text = x.termsandcondition
        applythemebtn.layer.cornerRadius = applythemebtn.frame.size.height/2
        if needtoshowapplytheme {
            applythemebtn.isHidden = false
        }
        else {
            applythemebtn.isHidden = true
        }
        var l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.itemSize = CGSize(width: 100, height: 70)
        winnerscollection.reloadData()
        winnerscollection.collectionViewLayout = l
        winnerscollection.reloadData()
        jurycollection.delegate = self
        jurycollection.dataSource = self
        var ll = UICollectionViewFlowLayout()
        ll.scrollDirection = .horizontal
        ll.itemSize = CGSize(width: 120, height: 100)
        jurycollection.reloadData()
        jurycollection.collectionViewLayout = ll
        jurycollection.reloadData()
        if let aa = x as? strevent {
            
            var userid = UserDefaults.standard.value(forKey: "refid") as! String
            if aa.userid == userid && aa.isactive == false {
                self.changejurybtn.isHidden = false
            }
            else {
                self.changejurybtn.isHidden = true
            }
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 100, height: 70)
        }
        else {
            return CGSize(width: self.jurycollection.frame.size.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return winnersprice.count
        }
        else {
            return currentjurylist.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winpricetype", for: indexPath) as? WinnerpriceCollectionViewCell {
                 cell.update(x: winnersprice[indexPath.row])
                return cell
            }
        }
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alljurycell", for: indexPath) as? AllyourjuryCollectionViewCell {
                cell.update(x: self.currentjurylist[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func setupextraviews()
    {
        
        awardsouterview.layer.borderColor = UIColor.white.cgColor
        awardsouterview.layer.borderWidth = 2
        awardsouterview.layer.cornerRadius = 20
        contestrulesview.layer.borderColor = UIColor.white.cgColor
        contestrulesview.layer.borderWidth = 2
        contestrulesview.layer.cornerRadius = 20
        jurycollection.layer.borderColor = UIColor.white.cgColor
        jurycollection.layer.borderWidth = 2
        jurycollection.layer.cornerRadius = 20
        otherdetailsouterview.layer.borderColor = UIColor.white.cgColor
        otherdetailsouterview.layer.borderWidth = 2
        otherdetailsouterview.layer.cornerRadius = 20
        v1.layer.cornerRadius = v1.frame.size.height/2
        v2.layer.cornerRadius = v1.frame.size.height/2
        v3.layer.cornerRadius = v1.frame.size.height/2
        v4.layer.cornerRadius = v1.frame.size.height/2
        self.noofwinnersouterview.layer.cornerRadius = self.noofwinnersouterview.frame.size.height/2
        
    }
    
    
    @IBAction func applythemepressed(_ sender: Any) {
       self.themetapped!(self.currepretheme ?? pretheme(contestid: 0, contestname: "", categoryid: 0, categoryname: "", organisationallow: true, invitationtypeid: 0, invitationtype: "", entryallowedid: 0, entrytype: "", entryfee: 0, conteststart: "", contestlocation: "", description: "", resulton: "", contestprice: "", contestwinnerpricetypeid: 0, contestwinnerpricetype: "", resultypeid: 0, resulttype: "", userdid: "", groupid: 0, groupname: "", createon: "", isactive: true, status: true, runnningstatusid: 0, runningstatus: "", joined: true, joinstatus: true, juries: [], totalparticipant: 0, winners: [], contestimage: "", creator: juryorwinner(id: 0, userid: "", name: "", profile: ""), totalreview: 0, themeid: 0, themename: "", performancetypeid: 0, performancetype: "", genderid: 0, gendername: "", participationpostallow: true, termsandconditions: "", contesttype: "", noofwinner: 0))
    }
    
    
    @IBAction func toggletermsandconditions(_ sender: Any) {
        
        if tandcheight.constant == 60 {
            tandcheight.constant = 260
        }
        else {
            tandcheight.constant = 60
        }
    }
    
    
    @IBAction func changejurypressed(_ sender: Any) {
        self.changejury!(true)
    }

}
