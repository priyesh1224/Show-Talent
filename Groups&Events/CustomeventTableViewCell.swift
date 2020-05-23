//
//  CustomeventTableViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


struct languages
{
    var id : Int
    var language : String
}

struct customdate
{
    var dayname : String
    var daypart : String
    var actualdate : String
}

struct languagewiseevent
{
    var about : String
    var address1 : String
    var address2 : String
    var agelimit : String
    var artist : String
    var category : String
    var city : String
    var createby : String
    var createon :String
    var eventtime  : String
    var eventtype : String
    var fee : Int
    var fromdate : String
    var heading : String
    var id : Int
    var imagepath : String
    var isactive : Int
    var langauge : String
    var refcategory : Int
    var reflanguage : Int
    var termsandconditions : String
    var thumbnail : String
    var todate : String
}

class CustomeventTableViewCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {

    var page = 0
    var canfetchmore = true
    
    var daylist = ["Sun","Mon","Tue","Wed","Thur","Fri","Sat"]
    
    var alllanguages : [languages] = []
    var alldates : [customdate] = []
    
    var selecteddate = "all"
    
    var selectedlanguage  : languages?
    
    var allresponse : Dictionary<String,Dictionary<String,[languagewiseevent]>>?
    
    var tempdata = [languagewiseevent]()
    
    var passback : ((_ : [languagewiseevent]) -> Void)?
    
    
    @IBOutlet var banner: UIImageView!
    
    
    @IBOutlet var coll1: UICollectionView!
    
    
    @IBOutlet var coll2: UICollectionView!
    
    
    
    
    var layout : UICollectionViewFlowLayout?
     var layout2 : UICollectionViewFlowLayout?
    
    func update()
    {
        self.selectionStyle = .none
        coll1.delegate = self
        coll2.delegate = self
        coll1.dataSource = self
        coll2.dataSource = self
        
        coll1.allowsMultipleSelection = false
        coll2.allowsMultipleSelection = false
        coll1.allowsSelection = true
        coll2.allowsSelection = true
//        coll1.reloadData()
//        coll2.reloadData()
        
        self.fetchlanuages(pg: page)
        
        layout = UICollectionViewFlowLayout()
        layout2 = UICollectionViewFlowLayout()
        
        
        
        
        
        
            
            if let l = layout {
                l.scrollDirection = .horizontal
                l.itemSize = CGSize(width: 70, height: 60)
                coll1.reloadData()
                coll1.collectionViewLayout = l
    
            }
        
        if let l = layout2 {
            l.scrollDirection = .horizontal
            l.itemSize = CGSize(width: 50, height: 60)
      
            coll2.reloadData()
            coll2.collectionViewLayout = l
        }
        print("@@@@@@@@@@@@@@@@@@@@@@@@@")

        
        for var i in 0 ..< 14 {
            let curee = Calendar.current
            let next10days = curee.date(byAdding: .day, value: i, to: Date())
            
            let date = curee.component(.day, from: next10days ?? Date())
            let day = curee.component(.weekday, from: next10days ?? Date())
            var yearpart = curee.component(.year, from: Date())
            var monthpart = curee.component(.month, from: Date())
            var combined = "\(yearpart)-\(monthpart)-\(date)T12:00:00.5"
            print(combined)
            var x = customdate(dayname: self.daylist[day%7], daypart: "\(date)", actualdate: combined)
            self.alldates.append(x)
            
            
            print(date)
            print(day)
        }
        self.coll1.reloadData()
        
    
        
            
        
    }
    
    
    func fetchlanuages(pg : Int)
    {

        var url = Constants.K_baseUrl + Constants.alllanguages
        var params = ["Page": pg,"PageSize": 10]
        var r  = BaseServiceClass()
        var beforecount = self.alllanguages.count
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let code = res["ResponseStatus"] as? Int {
                    if code == 0 {
                        self.page = self.page + 1
                        if let data = res["Results"] as? Dictionary<String,Any> {
                            if let useful = data["Data"] as? [Dictionary<String,Any>] {
                                for each in useful {
                                    var id = 0
                                    var name = ""
                                    var active = false
                                    if let i = each["ID"] as? Int {
                                        id = i
                                    }
                                    if let i = each["Language"] as? String {
                                        name = i
                                    }
                                    if let i = each["IsActive"] as? Bool {
                                        active = i
                                    }
                                    if active {
                                        var x  = languages(id: id, language: name)
                                        self.alllanguages.append(x)
                                    }
                                }
                                if beforecount == self.alllanguages.count {
                                    self.canfetchmore = false
                                }
                                self.coll2.reloadData()
                                print(self.alllanguages)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    func fetchallresponses(language: languages, date : String ,page : Int)
    {
        if page == 0 {
            tempdata = []
        }
        
        var langindex = ""
        var dateindex = "all"
        
        var url = "\(Constants.K_baseUrl)\(Constants.alleventsfetch)?"
        if let l = language as? languages {
            if l.language != "" && l.language != " " {
                url = "\(url)languageId=\(l.id)"
                langindex = l.language
                if let d = date as? String {
                    if d != "" && d != "all" {
                        dateindex = d
                        url = "\(url)&eventDate=\(d)"
                    }
                }
            }
            else {
                langindex = "all"
                if let d = date as? String {
                    if d != "" && d != "all" {
                        dateindex = d
                        url = "\(url)&eventDate=\(d)"
                    }
                    else {
                        dateindex = "all"
                    }
                }
                else {
                    dateindex = "all"
                }
            }
        }
        else {
            langindex = "all"
            if let d = date as? String {
                if d != "" && d != "all"{
                    dateindex = d
                    url = "\(url)eventDate=\(d)"
                }
                else {
                    dateindex = "all"
                }
            }
            else {
                dateindex = "all"
            }
        }
        
        print(url)
        
        var params : Dictionary<String,Any> = ["Page": page,
                                               "PageSize": 10]
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (resp, err) in
            if let res = resp?.result.value as? Dictionary<String,Any> {
                if let code = res["ResponseStatus"] as? Int {
                    if code == 0 {
                        if let alllan = res["Results"] as? Dictionary<String,Any > {
                            if let alllandata = alllan["Data"] as? [Dictionary<String,Any>] {
                                
                                for lan in alllandata {
                                    var about = ""
                                    var add1 = ""
                                    var add2 = ""
                                    var agelimit = ""
                                    var artist = ""
                                    var category = ""
                                    var city = ""
                                    var createdby = ""
                                    var createon = ""
                                    var eventtime = ""
                                    var eventtype = ""
                                    var fee = 0
                                    var fromdate = ""
                                    var heading  = ""
                                    var id = 0
                                    var imagepath = ""
                                    var isactive = 0
                                    var language = ""
                                    var refcategory = 0
                                    var reflanguage = 0
                                    var termsandcondtns = ""
                                    var thumbnail = ""
                                    var todate = ""
                                    
                                    if let a = lan["About"] as? String {
                                        about = a
                                    }
                                    if let a = lan["Address1"] as? String {
                                        add1 = a
                                    }
                                    if let a = lan["Address2"] as? String {
                                        add2 = a
                                    }
                                    if let a = lan["AgeLimit"] as? String {
                                        agelimit = a
                                    }
                                    if let a = lan["Artist"] as? String {
                                        artist = a
                                    }
                                    if let a = lan["Category"] as? String {
                                        category = a
                                    }
                                    if let a = lan["City"] as? String {
                                        city = a
                                    }
                                    if let a = lan["CreateBy"] as? String {
                                        createdby = a
                                    }
                                    if let a = lan["CreateOn"] as? String {
                                        createon = a
                                    }
                                    if let a = lan["EventTime"] as? String {
                                        eventtime = a
                                    }
                                    if let a = lan["EventType"] as? String {
                                        eventtype = a
                                    }
                                    if let a = lan["Fee"] as? Int {
                                        fee = a
                                    }
                                    if let a = lan["FromDate"] as? String {
                                        fromdate = a
                                    }
                                    if let a = lan["Heading"] as? String {
                                        heading = a
                                    }
                                    if let a = lan["ID"] as? Int {
                                        id = a
                                    }
                                    if let a = lan["ImagePath"] as? String {
                                        imagepath = a
                                    }
                                    if let a = lan["IsActive"] as? Int {
                                        isactive = a
                                    }
                                    if let a = lan["Language"] as? String {
                                        language = a
                                    }
                                    if let a = lan["RefCategory"] as? Int {
                                        refcategory = a
                                    }
                                    if let a = lan["RefLanguage"] as? Int {
                                        reflanguage = a
                                    }
                                    if let a = lan["TermCondition"] as? String {
                                        termsandcondtns = a
                                    }
                                    if let a = lan["Thumbnail"] as? String {
                                        thumbnail = a
                                    }
                                    if let a = lan["ToDate"] as? String {
                                        todate = a
                                    }
                                    
                                    
                                    var x  = languagewiseevent(about: about, address1: add1, address2: add2, agelimit: agelimit, artist: artist, category: category, city: city, createby: createdby, createon: createon, eventtime: eventtime, eventtype: eventtype, fee: fee, fromdate: fromdate, heading: heading, id: id, imagepath: imagepath, isactive: isactive, langauge: language, refcategory: refcategory, reflanguage: reflanguage, termsandconditions: termsandcondtns, thumbnail: thumbnail, todate: todate)
                                    
                                    
                                    self.tempdata.append(x)
                                    print(artist)
                                    print(langindex)
                                    print(dateindex)
                                    
                                    if let s = self.allresponse?[langindex] as? Dictionary<String,[languagewiseevent]> {
                                        print("Not nill")
                                        var ss = s
                                        if let t = s[dateindex] as? [languagewiseevent] {
                                           var tt = t
                                            tt.append(x)
                                        }
                                        else {
                                            ss[dateindex] = [languagewiseevent]()
                                            ss[dateindex]?.append(x)
                                        }
                                        
                                    }
                                    else {
                                        print("Actullly nil")
                                        
                                        
                                        self.allresponse?[langindex] = ["" : [languagewiseevent]()]
                                    }
                                    
                                    
                                    
                                    print(self.allresponse)
                                    
                                    
                                    
                                }
                                self.passback!(self.tempdata)
                            }
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
           return self.alldates.count
        }
        else {
            return self.alllanguages.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(collectionView.tag)
        if collectionView.tag == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ucell", for: indexPath) as? UpperCollectionViewCell {
                print("hey")
                cell.passbackselection = { a in
                    for var k in 0 ..< collectionView.numberOfItems(inSection: 0) {
                        if a == self.alldates[k].actualdate {
                            if self.selecteddate == a {
                                self.selecteddate = "all"
                                if let d = collectionView.cellForItem(at: IndexPath(row: k, section: 0)) as? UpperCollectionViewCell {
                                    collectionView.selectItem(at: IndexPath(row: k, section: 0), animated: true, scrollPosition: .bottom)
                                    d.tapp.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                    d.tapp.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
                                }
                            }
                            else {
                                self.selecteddate = a
                                if let d = collectionView.cellForItem(at: IndexPath(row: k, section: 0)) as? UpperCollectionViewCell {
                                    collectionView.selectItem(at: IndexPath(row: k, section: 0), animated: true, scrollPosition: .bottom)
                                    d.tapp.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
                                    d.tapp.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                                }
                            }
                            self.fetchallresponses(language: self.selectedlanguage ?? languages(id: 0, language: "all"), date: self.selecteddate, page: 0)
      
                        }
                        else {
                            if let d = collectionView.cellForItem(at: IndexPath(row: k, section: 0)) as? UpperCollectionViewCell {
                                
                                collectionView.selectItem(at: IndexPath(row: k, section: 0), animated: true, scrollPosition: .top)
                                d.tapp.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                d.tapp.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
                            }
                        }
                    }
                }

                cell.update(x : alldates[indexPath.row])
                return cell
            }
        }
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lcell", for: indexPath) as? LowerCollectionViewCell {
                cell.passbackselection = { a in
                    for var k in 0 ..< collectionView.numberOfItems(inSection: 0) {
                        if a.language == self.alllanguages[k].language {
                            self.selectedlanguage = a
                            var found = false
                            if let s = self.allresponse?[a.language] as? Dictionary<String,[languagewiseevent]> {
                                
                                if let t = s[self.selecteddate] as? [languagewiseevent] {
                                    if t.count > 0 {
                                        found = true
                                        print("Already Exist")
                                    }
                                }
                            }
                            else if let s = self.allresponse?["all"] as? Dictionary<String,[languagewiseevent]> {
                                
                                if let t = s[self.selecteddate] as? [languagewiseevent] {
                                    if t.count > 0 {
                                        found = true
                                        print("Already Exist")
                                    }
                                }
                            }
                            
                            if found == false {
                                self.fetchallresponses(language: a, date: self.selecteddate, page: 0)
                            }
                            if let d = collectionView.cellForItem(at: IndexPath(row: k, section: 0)) as? LowerCollectionViewCell {
                                collectionView.selectItem(at: IndexPath(row: k, section: 0), animated: true, scrollPosition: .bottom)
                                d.tppp.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
                                d.tppp.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                            }
                        }
                        else {
                            if let d = collectionView.cellForItem(at: IndexPath(row: k, section: 0)) as? LowerCollectionViewCell {
                                
                                collectionView.selectItem(at: IndexPath(row: k, section: 0), animated: true, scrollPosition: .top)
                                d.tppp.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                d.tppp.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
                            }
                        }
                    }
                }
                cell.update(x : alllanguages[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: self.frame.size.width/5, height: 40)

        }
        else {
            return CGSize(width: self.frame.size.width/4, height: 30)

        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello \(indexPath.row)")
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Tapped \(indexPath.row)")
//
//        if collectionView.tag == 1 {
//
//
//            if let cell = collectionView.cellForItem(at: indexPath) as? UpperCollectionViewCell {
//                if cell.isSelected {
//                        cell.tapp.backgroundColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)
//                        cell.tapp.setTitleColor(UIColor.white, for: .normal)
//                }
//            }
//        }
//        else {
//
//            for var k in 0 ..< self.coll2.numberOfItems(inSection: 0) {
//                if let cell = coll2.cellForItem(at: IndexPath(row: k, section: 0)) as? LowerCollectionViewCell {
//                    if k == indexPath.row {
//                        cell.tppp.backgroundColor = #colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1)
//                        cell.tppp.setTitleColor(UIColor.white, for: .normal)
//                    }
//                    else {
//                        cell.tppp.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                        cell.tppp.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
//                    }
//                }
//            }
//
//
//
//
//
//        }
//    }
//
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.alllanguages.count - 3 {
            print("Reached end")
            if canfetchmore {
                self.fetchlanuages(pg: page)
            }
        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//         if collectionView.tag == 1 {
//                   if let cell = collectionView.cellForItem(at: indexPath) as? UpperCollectionViewCell {
//                    cell.tapp.backgroundColor = UIColor.clear
//                               cell.tapp.setTitleColor(#colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1), for: .normal)
//                   }
//               }
//               else {
//                   if let cell = collectionView.cellForItem(at: indexPath) as? LowerCollectionViewCell {
//                       cell.tppp.backgroundColor = UIColor.clear
//                       cell.tppp.setTitleColor(#colorLiteral(red: 0.3356483877, green: 0.4170081019, blue: 0.761711657, alpha: 1), for: .normal)
//                   }
//               }
//    }
    
    

}
