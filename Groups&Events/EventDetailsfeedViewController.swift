//
//  EventDetailsfeedViewController.swift
//  ShowTalent
//
//  Created by maraekat on 21/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

struct event
{
    var eventid : Int
    var eventname : String
    var eventicon : String
    var time : String
    var endtime : String
    var location : String
    var createdby : String
}

struct inputstype
{
    var fieldname : String
    var fieldtype : String
    var datatype : String
}

struct entrytype
{
    var contestentrytype : String
    var addon : String
    var isactive : Bool
    var contestmasters : [String]
    var id : Int
}

struct contestwintypes
{
    var contestwintype : String
    var createdon : String
    var isactive : Bool
    var contestmasters : [String]
    var id : Int
     var winner : Int
}
struct contestwinnerpricess
{
    var winnerprice : String
    var addon : String
    var isactive : Bool
    var contestmasters : [String]
    var id : Int
   
}
struct conteststatuses
{
    var contestrunningstatus : String
    var addon : String
    var isactive : Bool
    var contestmasters : [String]
    var id : Int
}
struct invitationtypess
{
    var invitation : String
    var isactive : Bool
    var addon : String
    var contestmasters : [String]
    var id : Int
}

struct performancetypemodels
{
    var id : Int
    var peroformance : String
}
struct genders
{
    var id : Int
    var gender : String
}
struct themes
{
    var id : Int
    var theme : String
}
struct entrytypefees
{
    var id : Int
    var fees : String
}

class EventDetailsfeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource {

    var isineditmode = false
    var eventid = 0
    var eventwhole : strevent?
    var tappedevent : strevent?
    var createtablefields : [inputstype] = []
    var upcomingevents :[strevent] = []
    var pastevents:[strevent] = []
    
    var contestwinnertypes : [contestwintypes] = []
    var entrytypes : [entrytype] = []
    var contestwinnerprices : [contestwinnerpricess] = []
    var conteststatus : [conteststatuses] = []
    var invitationtypes : [invitationtypess] = []
    var allcategories : [categorybrief] = []
    var allperformancemodels : [performancetypemodels] = []
    var allgenders : [genders] = []
    var allthemes : [themes] = []
    var eventcreator : juryorwinner?
    var groupid = 9
    var isnewevent = false
    var allchoosenfields : Dictionary<String,Any> = [:]
    var alldatainsync : Dictionary<String,Any> = [:]
    
    var juryid = 0
    
    
    @IBOutlet weak var nodatawarn: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    @IBOutlet var okbtn: UIButton!
    
    @IBOutlet weak var popupview: UIView!
    
    
    @IBOutlet weak var custompicker: UIPickerView!
    
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var slider: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var createbottombutton: UIButton!
    
    
    @IBOutlet weak var sliderwrapperview: UIView!
    
    
    @IBOutlet weak var createsliderbtn: UIButton!
    
    @IBOutlet weak var upcomingsliderbtn: UIButton!
    
    @IBOutlet weak var pastsliderbtn: UIButton!
    
    var type = "simple" // or complex or complexpast
    
    
    var dropdownselectedtype = ""
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.spinner.isHidden = true
        self.nodatawarn.isHidden = true
        self.spinner.stopAnimating()
        okbtn.layer.cornerRadius = 30
        if self.isineditmode == true {
            self.createsliderbtn.setTitle("Edit", for: .normal)
            self.createbottombutton.setTitle("Edit", for: .normal)
        }
        else {
            self.createsliderbtn.setTitle("Create", for: .normal)
            self.createbottombutton.setTitle("Create", for: .normal)
        }
        self.table.delegate = self
        self.table.dataSource = self
        self.datepicker.minimumDate = Date()
        self.datepicker.locale = Locale(identifier: "en_GB")
        setupviews()
        setupdummydata()
        self.popupview.isHidden = true
        self.custompicker.delegate = self
        self.custompicker.dataSource = self
        
            self.fetchdata()
        
        self.fetchcategories()
        self.allchoosenfields["Organisation Allowed"] = false
        if type == "simple" {
            self.createbottombutton.isHidden = false
        }
        else {
            self.createbottombutton.isHidden = true
        }
        
        if isnewevent == true {
            self.type = "simple"
            
            createsliderbtn.isHidden = false
            upcomingsliderbtn.isHidden = true
            pastsliderbtn.isHidden = true
            createbottombutton.isHidden = false
            
        }
        else {
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            self.type = "complex"
            createsliderbtn.isHidden = true
            upcomingsliderbtn.isHidden = false
            pastsliderbtn.isHidden = false
            createbottombutton.isHidden = true

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

                            }
                        }
                    }
        }
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if self.dropdownselectedtype == "Entry Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Invitation type" {
            return 1
        }
        else if self.dropdownselectedtype == "Contest Winner Price Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Contest Result Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Category" {
            return 1
        }
        else if self.dropdownselectedtype == "Performance Type" {
            return 1
        }
        else if self.dropdownselectedtype == "Gender" {
            return 1
        }
        else if self.dropdownselectedtype == "Contest Theme" {
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        print("Picker View dropdownselectedtype \(self.dropdownselectedtype) \(self.allperformancemodels.count)")
        
        if self.dropdownselectedtype == "Entry Type" {
            return self.entrytypes.count
        }
        else if self.dropdownselectedtype == "Invitation type" {
            return self.invitationtypes.count
        }
        else if self.dropdownselectedtype == "Contest Winner Price Type" {
            return self.contestwinnerprices.count
        }
        else if self.dropdownselectedtype == "Contest Result Type" {
            return self.contestwinnertypes.count
        }
        else if self.dropdownselectedtype == "Category" {
            return self.allcategories.count
        }
        else if self.dropdownselectedtype == "Performance Type" {
            return self.allperformancemodels.count
        }
        else if self.dropdownselectedtype == "Gender" {
            return self.allgenders.count
        }
        else if self.dropdownselectedtype == "Contest Theme" {
            return self.allthemes.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
 
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {


         if self.dropdownselectedtype == "Entry Type" {
                    return self.entrytypes[row].contestentrytype.capitalized
               }
            else if self.dropdownselectedtype == "Invitation type" {
            return self.invitationtypes[row].invitation.capitalized
            }
               else if self.dropdownselectedtype == "Contest Winner Price Type" {
                    return self.contestwinnerprices[row].winnerprice.capitalized
               }
               else if self.dropdownselectedtype == "Contest Result Type" {
                    return self.contestwinnertypes[row].contestwintype.capitalized
               }
               else if self.dropdownselectedtype == "Category" {
                    return self.allcategories[row].categoryname.capitalized
               }
        else if self.dropdownselectedtype == "Performance Type" {
            return self.allperformancemodels[row].peroformance.capitalized
        }
        else if self.dropdownselectedtype == "Gender" {
            return self.allgenders[row].gender.capitalized
        }
        else if self.dropdownselectedtype == "Contest Theme" {
            return self.allthemes[row].theme.capitalized
        }
               return ""
    }
    
    
    func fetchdata()
    {
        var r = BaseServiceClass()
        var url = Constants.K_baseUrl + Constants.getprerequisitecontests
        r.getApiRequest(url: url, parameters: [:]) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let usefuldata = res["Results"] as? Dictionary<String,Any> {
                    if let entrytypes = usefuldata["EntryTypes"] as? [Dictionary<String,Any>] {
                        for each in entrytypes {
                            var a = ""
                            var b = ""
                            var c = false
                            var d : [String] = []
                            var e = 0
                            
                            if let aa = each["ContestEntryType"] as? String {
                                a = aa
                            }
                            if let aa = each["AddOn"] as? String {
                                b = aa
                            }
                            if let aa = each["IsActive"] as? Bool {
                                c = aa
                            }
                            if let aa = each["ContestMasters"] as? [String] {
                                d = aa
                            }
                            if let aa = each["ID"] as? Int {
                                e = aa
                            }
                            var x = entrytype(contestentrytype: a, addon: b, isactive: c, contestmasters: d, id: e)
                            self.entrytypes.append(x)
                        }
                        print(self.entrytypes)
                    }
                    if let entrytypes = usefuldata["ContestWinTypes"] as? [Dictionary<String,Any>] {
                                      for each in entrytypes {
                                      var a = ""
                                      var b = ""
                                      var c = false
                                      var d : [String] = []
                                      var e = 0
                                        var f = 0
                                      
                                      if let aa = each["ContestWinnerType"] as? String {
                                          a = aa
                                      }
                                      if let aa = each["CreateOn"] as? String {
                                          b = aa
                                      }
                                      if let aa = each["IsActive"] as? Bool {
                                          c = aa
                                      }
                                      if let aa = each["ContestMasters"] as? [String] {
                                          d = aa
                                      }
                                      if let aa = each["ID"] as? Int {
                                          e = aa
                                      }
                                        if let aa = each["Winner"] as? Int {
                                            f = aa
                                        }
                                        var x  = contestwintypes(contestwintype: a, createdon: b, isactive: c, contestmasters: d, id: e, winner: f)
                                        self.contestwinnertypes.append(x)
                                  }
                        print(self.contestwinnertypes)
                    }
                    if let entrytypes = usefuldata["ContestWinnerPrices"] as? [Dictionary<String,Any>] {
                                      for each in entrytypes {
                                      var a = ""
                                      var b = ""
                                      var c = false
                                      var d : [String] = []
                                      var e = 0
                                      
                                      if let aa = each["WinnerPrice"] as? String {
                                          a = aa
                                      }
                                      if let aa = each["AddOn"] as? String {
                                          b = aa
                                      }
                                      if let aa = each["IsActive"] as? Bool {
                                          c = aa
                                      }
                                      if let aa = each["ContestMasters"] as? [String] {
                                          d = aa
                                      }
                                      if let aa = each["ID"] as? Int {
                                          e = aa
                                      }
                                    
                                        var x = contestwinnerpricess(winnerprice: a, addon: b, isactive: c, contestmasters: d, id: e)
                                        self.contestwinnerprices.append(x)
                                    
                                  }
                        print(self.contestwinnerprices)
                    }
                    if let entrytypes = usefuldata["ContestStatuses"] as? [Dictionary<String,Any>] {
                                      for each in entrytypes {
                                      var a = ""
                                      var b = ""
                                      var c = false
                                      var d : [String] = []
                                      var e = 0
                                      
                                      if let aa = each["ContestRunningStatus"] as? String {
                                          a = aa
                                      }
                                      if let aa = each["AddOn"] as? String {
                                          b = aa
                                      }
                                      if let aa = each["IsActive"] as? Bool {
                                          c = aa
                                      }
                                      if let aa = each["ContestMasters"] as? [String] {
                                          d = aa
                                      }
                                      if let aa = each["ID"] as? Int {
                                          e = aa
                                      }
                                      var x = conteststatuses(contestrunningstatus: a, addon: b, isactive: c, contestmasters: d, id: e)
                                      self.conteststatus.append(x)
                                  }
                        print(self.conteststatus)
                    }
                    if let entrytypes = usefuldata["InvitationTypes"] as? [Dictionary<String,Any>] {
                                      for each in entrytypes {
                                      var a = ""
                                      var b = ""
                                      var c = false
                                      var d : [String] = []
                                      var e = 0
                                      
                                      if let aa = each["Invitation"] as? String {
                                          a = aa
                                      }
                                      if let aa = each["AddOn"] as? String {
                                          b = aa
                                      }
                                      if let aa = each["IsActive"] as? Bool {
                                          c = aa
                                      }
                                      if let aa = each["ContestMasters"] as? [String] {
                                          d = aa
                                      }
                                      if let aa = each["ID"] as? Int {
                                          e = aa
                                      }
                                        var x = invitationtypess(invitation: a, isactive: c, addon: b, contestmasters: d, id: e)
                                      self.invitationtypes.append(x)
                                  }
                        print(self.invitationtypes)
                    }
                    
                    if let entrytypes = usefuldata["PerformanceTypeModels"] as? [Dictionary<String,Any>] {
                                                  for each in entrytypes {
                                                  var a = 0
                                                  var b = ""
                                                 
                                                  
                                                  if let aa = each["Id"] as? Int {
                                                      a = aa
                                                  }
                                                  if let aa = each["Performance"] as? String {
                                                      b = aa
                                                  }
                                                 
                                                    var x = performancetypemodels(id: a, peroformance: b)
                                                  self.allperformancemodels.append(x)
                                              }
                                    print(self.allperformancemodels)
                                }
                    
                    if let entrytypes = usefuldata["Genders"] as? [Dictionary<String,Any>] {
                                                  for each in entrytypes {
                                                  var a = 0
                                                  var b = ""
                                                 
                                                  
                                                  if let aa = each["Id"] as? Int {
                                                      a = aa
                                                  }
                                                  if let aa = each["GenderType"] as? String {
                                                      b = aa
                                                  }
                                                 
                                                    var x = genders(id: a, gender: b)
                                                    self.allgenders.append(x)
                                              }
                                    print(self.allgenders)
                                }
               
                }
            }
            
          
        }
    }
    
    
    @IBAction func closepopup(_ sender: UIButton) {
        self.popupview.isHidden = true
    }
    
    
    @IBAction func okpopup(_ sender: UIButton) {
        var selectedval = ""
        print("Selected \(self.dropdownselectedtype)")
        if self.dropdownselectedtype == "Entry Type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.entrytypes[self.custompicker.selectedRow(inComponent: 0)]
            
            if let sv = self.entrytypes[self.custompicker.selectedRow(inComponent: 0)] as? entrytype {
                selectedval = sv.contestentrytype
                self.alldatainsync[self.dropdownselectedtype] = selectedval
            }
            
            
        }
        else if self.dropdownselectedtype == "Invitation type" {
                      self.allchoosenfields[self.dropdownselectedtype] = self.invitationtypes[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.invitationtypes[self.custompicker.selectedRow(inComponent: 0)].invitation
            self.alldatainsync[self.dropdownselectedtype] = selectedval

        }
            else if self.dropdownselectedtype == "Performance Type" {
                          self.allchoosenfields[self.dropdownselectedtype] = self.allperformancemodels[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.allperformancemodels[self.custompicker.selectedRow(inComponent: 0)].peroformance
                self.alldatainsync[self.dropdownselectedtype] = selectedval

            }
            else if self.dropdownselectedtype == "Gender" {
                          self.allchoosenfields[self.dropdownselectedtype] = self.allgenders[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.allgenders[self.custompicker.selectedRow(inComponent: 0)].gender
                self.alldatainsync[self.dropdownselectedtype] = selectedval

            }
          
        else if self.dropdownselectedtype == "Contest Winner Price Type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.contestwinnerprices[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.contestwinnerprices[self.custompicker.selectedRow(inComponent: 0)].winnerprice
            self.alldatainsync[self.dropdownselectedtype] = selectedval

        }
        else if self.dropdownselectedtype == "Contest Result Type" {
            self.allchoosenfields[self.dropdownselectedtype] = self.contestwinnertypes[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.contestwinnertypes[self.custompicker.selectedRow(inComponent: 0)].contestwintype
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            

        }
        else if self.dropdownselectedtype == "Category" {
            self.allchoosenfields[self.dropdownselectedtype] = self.allcategories[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.allcategories[self.custompicker.selectedRow(inComponent: 0)].categoryname
            
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            self.fetchthemes()

        }
        else if self.dropdownselectedtype == "Contest Theme" {
           
            if allthemes.count > 0 {
            if let th = self.allthemes[self.custompicker.selectedRow(inComponent: 0)] as? themes
            { self.allchoosenfields[self.dropdownselectedtype] = self.allthemes[self.custompicker.selectedRow(inComponent: 0)]
            selectedval = self.allthemes[self.custompicker.selectedRow(inComponent: 0)].theme
            
            self.alldatainsync[self.dropdownselectedtype] = selectedval
            }
        }

        }
        else if self.dropdownselectedtype == "Contest Start Date" || self.dropdownselectedtype == "Contest Result Date" {
            print("Selected \(self.dropdownselectedtype)")
            self.allchoosenfields[self.dropdownselectedtype] = self.datepicker.date
            selectedval = self.datepicker.date.description
            self.alldatainsync[self.dropdownselectedtype] = selectedval

        }
        print(self.allchoosenfields)
        
        for var k in 0 ..< self.createtablefields.count {
            if let cell = self.table.cellForRow(at: IndexPath(row: k, section: 0)) as? EventdatafeedsimpleTableViewCell {
                if cell.currentitem?.fieldname == self.dropdownselectedtype {
                    cell.setlabeltitle(x: selectedval)
                }
            }
        }

        
        self.popupview.isHidden = true

    }
    
    
    func fetchthemes()
    {
        if let ex = self.allchoosenfields["Category"] as? categorybrief {
            var id = ex.categoryid
            var url = Constants.K_baseUrl + Constants.getthemes
            var params : Dictionary<String,Any> = ["contestId" : id]
            var r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: params) { (response, error) in
                if let res =  response?.result.value as? Dictionary<String,Any> {
                    if let results = res["Results"] as? Dictionary<String,Any> {
                        if let themeees = results["Theme"] as? [Dictionary<String,Any>] {
                            print(themeees)
                            for each in themeees {
                                var id = 0
                                var them = ""
                                if let a = each["Id"] as? Int {
                                    id = a
                                }
                                if let t = each["Theme"] as? String {
                                    them = t
                                }
                                var xx = themes(id : id , theme : them)
                                self.allthemes.append(xx)
                                
                            }
                            self.custompicker.reloadAllComponents()
                        }
                    }
                }
            }
        }
    }
    
    func setupviews()
    {
        notificationindicator.layer.cornerRadius = 10
        createbottombutton.layer.cornerRadius = 10
    }
    
    
   
    func setupdummydata()
    {
        createtablefields.append(inputstype(fieldname: "Contest Name", fieldtype: "text", datatype: "text"))
        createtablefields.append(inputstype(fieldname: "Category", fieldtype: "dropdown", datatype: "custom"))
        createtablefields.append(inputstype(fieldname: "Organisation Allowed", fieldtype: "checkbox", datatype: ""))
        createtablefields.append(inputstype(fieldname: "Invitation type", fieldtype: "dropdown", datatype: "custom"))
        createtablefields.append(inputstype(fieldname: "Entry Type", fieldtype: "dropdown", datatype: "custom"))
        createtablefields.append(inputstype(fieldname: "Entry Fees", fieldtype: "text", datatype: "number"))
        createtablefields.append(inputstype(fieldname: "Contest Start Date", fieldtype: "dropdown", datatype: "date"))
        createtablefields.append(inputstype(fieldname: "Contest Location", fieldtype: "text", datatype: "text"))
        createtablefields.append(inputstype(fieldname: "Contest Result Date", fieldtype: "dropdown", datatype: "date"))
        createtablefields.append(inputstype(fieldname: "Contest Price", fieldtype: "text", datatype: "text"))
        createtablefields.append(inputstype(fieldname: "Contest Winner Price Type", fieldtype: "dropdown", datatype: "custom"))
        createtablefields.append(inputstype(fieldname: "Contest Result Type", fieldtype: "dropdown", datatype: "custom"))
        createtablefields.append(inputstype(fieldname: "Contest Theme", fieldtype: "dropdown", datatype: "custom"))
         createtablefields.append(inputstype(fieldname: "Performance Type", fieldtype: "dropdown", datatype: "custom"))
        createtablefields.append(inputstype(fieldname: "Gender", fieldtype: "dropdown", datatype: "custom"))
        createtablefields.append(inputstype(fieldname: "Contest Description", fieldtype: "text", datatype: "textarea"))
        
        

        let url = "\(Constants.K_baseUrl)\(Constants.geteventsbygroup)?groupId=\(self.groupid)"
        var r = BaseServiceClass()
        var params : Dictionary<String,Any> = ["Page": 0,"PageSize": 10]
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let innerdata = res["Results"] as? Dictionary<String,Any> {
                    if let data = innerdata["Data"] as? [Dictionary<String,Any>] {
                        for each in data {
                            var contestid = 0
                                    var contestname = ""
                                    var allowcategoryid = 0
                                    var allowcategory = ""
                                    var organisationallow = false
                                    var invitationtypeid = 0
                                    var invitationtype = ""
                                    var entryallowed = 0
                                    var entrytype = ""
                                    var entryfee = 0
                                    var conteststart = ""
                                    var contestlocation = ""
                                    var description = ""
                                    var resulton = ""
                                    var contestprice = ""
                                    var contestwinnerpricetypeid = 0
                                    var contestpricetype = ""
                                    var resulttypeid = 0
                                    var resulttype = ""
                                    var userid = ""
                                    var groupid = 0
                                    var createon = ""
                                    var isactive = false
                                    var status = false
                                    var runningstatusid = 0
                                    var runningstatus = ""
                                    var juries : [juryorwinner] = []
                                    var cim = ""
                            
                            if let cn = each["ContestId"] as? Int {
                                contestid = cn
                            }
                                    
                                    if let cn = each["ContestName"] as? String {
                                        contestname = cn
                                    }
                                    if let cn = each["AllowCategoryId"] as? Int {
                                        allowcategoryid = cn
                                    }
                                    if let cn = each["AllowCategory"] as? String {
                                        allowcategory = cn
                                    }
                                    if let cn = each["OrganizationAllow"] as? Bool {
                                        organisationallow = cn
                                    }
                                    if let cn = each["InvitationTypeId"] as? Int {
                                        invitationtypeid = cn
                                    }
                                    if let cn = each["InvitationType"] as? String {
                                        invitationtype = cn
                                    }
                                    if let cn = each["EntryAllowed"] as? Int {
                                        entryallowed = cn
                                    }
                                    if let cn = each["EntryType"] as? String {
                                        entrytype = cn
                                    }
                                    if let cn = each["EntryFee"] as? Int {
                                        entryfee = cn
                                    }
                                    if let cn = each["ContestStart"] as? String {
                                        conteststart = cn
                                    }
                                    if let cn = each["ContestLocation"] as? String {
                                        contestlocation = cn
                                    }
                                    if let cn = each["Description"] as? String {
                                        description = cn
                                    }
                                    if let cn = each["ResultOn"] as? String {
                                        resulton = cn
                                    }
                                    if let cn = each["ContestPrice"] as? String {
                                        contestprice = cn
                                    }
                                    if let cn = each["ContestWinnerPriceTypeId"] as? Int {
                                        contestwinnerpricetypeid = cn
                                    }
                                    if let cn = each["ContestWinnerPriceType"] as? String {
                                      contestpricetype  = cn
                                    }
                                    if let cn = each["ResultTypeId"] as? Int {
                                        resulttypeid = cn
                                    }
                                    if let cn = each["ResultType"] as? String {
                                        resulttype = cn
                                    }
                                    if let cn = each["UserId"] as? String {
                                        userid = cn
                                    }
                                    if let cn = each["GroupId"] as? Int {
                                        groupid = cn
                                    }
                                    if let cn = each["CreateOn"] as? String {
                                        createon = cn
                                    }
                            
                            var tandc = ""
                            if let cn = each["TermAndCondition"] as? String {
                                tandc = cn
                            }
                            
                             if let cn = each["Creator"] as? Dictionary<String,Any> {
                                                                       var name = ""
                                                                       var profile = ""
                                                                       var userid = ""
                                                                       if let n = cn["Name"] as? String {
                                                                           name = n
                                                                       }
                                                                       if let n = cn["Profile"] as? String {
                                                                           profile = n
                                                                       }
                                                                       if let n = cn["UserID"] as? String {
                                                                           userid = n
                                                                       }
                                                                       self.eventcreator = juryorwinner(id: 0, userid: userid, name: name, profile: profile)
                                                                   }
                                    if let cn = each["IsActive"] as? Bool {
                                        isactive = cn
                                    }
                                    if let cn = each["Status"] as? Bool {
                                        status = cn
                                    }
                                    if let cn = each["RunningStatusId"] as? Int {
                                        runningstatusid = cn
                                    }
                                    if let cn = each["RunningStatus"] as? String {
                                        runningstatus = cn
                                    }
                            if let cn = each["ContestImage"] as? String {
                                    cim = cn
                            }
                                    if let cn = each["Juries"] as? [juryorwinner] {
                                        juries = cn
                                    }
                           
                            var noofwinn = 0
                            if let cn = each["NoOfWinner"] as? Int {
                                noofwinn = cn
                            }
                            var x = strevent(contestid: contestid, contestname: contestname, allowcategoryid: allowcategoryid, allowcategory: allowcategory, organisationallow: organisationallow, invitationtypeid: invitationtypeid, invitationtype: invitationtype, entryallowed: entryallowed, entrytype: entrytype, entryfee: entryfee, conteststart: conteststart, contestlocation: contestlocation, description: description, resulton: resulton, contestprice: contestprice, contestwinnerpricetypeid: contestwinnerpricetypeid, contestpricetype: contestpricetype, resulttypeid: resulttypeid, resulttype: resulttype, userid: userid, groupid: groupid, createon: createon, isactive: isactive, status: status, runningstatusid: runningstatusid, runningstatus: runningstatus, juries: juries, contestimage: cim, termsandcondition: tandc, noofwinners: noofwinn)
                            
                            
                            
                            if let d = resulton as? String {
                                 var usefuldate = ""
                                     if d != "" || d != " " {
                                         var arr = d.components(separatedBy: "T")
                                         if arr.count == 2 {
                                             usefuldate = arr[0]
                                         }
                                         else if d.count == 10 {
                                             usefuldate = d
                                         }
                                     }
                                 
                                 var d = ""
                                 var m = ""
                                 var y = ""
                                 if usefuldate != "" {
                                     var darr = usefuldate.components(separatedBy: "-")
                                     y = darr[0]
                                     m = darr[1]
                                     d = darr[2]
                                 }
                                 let formatter = DateFormatter()
                                 formatter.dateFormat = "MM/yyyy/dd"
                                 if let cusdate = formatter.date(from: "\(m)/\(y)/\(d)") as? Date {
                                    let k = Date().compare(cusdate).rawValue
                                        print("Heyya \(k)")
                                    if k == 1 {
                                        self.pastevents.append(x)
                                    }
                                    else {
                                        self.upcomingevents.append(x)

                                    }
                                    
                                 }
                             }
                            

                        }
                        if self.upcomingevents.count == 0 {
                            self.nodatawarn.isHidden = false
                        }
                        else {
                            self.nodatawarn.isHidden = true
                        }
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.table.reloadData()
                    }
                }
            }
        }
        
        
        

        
        
    }
    
    
    
    @IBAction func createsliderpressed(_ sender: UIButton) {
        self.type = "simple"
        if type == "simple" {
             self.createbottombutton.isHidden = false
         }
         else {
             self.createbottombutton.isHidden = true
         }
        createsliderbtn.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        upcomingsliderbtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        pastsliderbtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        swipeslider(x:1)
        self.table.reloadData()
    }
    
    
    @IBAction func upcomingsliderpressed(_ sender: UIButton) {
        self.type = "complex"
        if type == "simple" {
             self.createbottombutton.isHidden = false
         }
         else {
             self.createbottombutton.isHidden = true
         }
        createsliderbtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
         upcomingsliderbtn.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
         pastsliderbtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        if self.upcomingevents.count == 0 {
            self.nodatawarn.text = "Sorry no upcoming contests found."
            self.nodatawarn.isHidden = false

        }
        else {
            self.nodatawarn.isHidden = true

        }
        swipeslider(x:2)
        self.table.reloadData()
    }
    
    
    @IBAction func pastsliderpressed(_ sender: UIButton) {
        self.type = "complexpast"
        if type == "simple" {
             self.createbottombutton.isHidden = false
         }
         else {
             self.createbottombutton.isHidden = true
         }
        createsliderbtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
         upcomingsliderbtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
         pastsliderbtn.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        if self.pastevents.count == 0 {
            self.nodatawarn.text = "Sorry no past contests found."
            self.nodatawarn.isHidden = false
            
        }
        else {
            self.nodatawarn.isHidden = true
            
        }
        swipeslider(x:3)
        self.table.reloadData()
    }
    
    
    func swipeslider(x:Int){
        if x == 1 {
            print(createsliderbtn.frame.origin.x)
            UIView.animate(withDuration: 0.5, animations: {
                self.slider.frame = CGRect(x: (self.createsliderbtn.frame.origin.x * 1 + 48), y: self.slider.frame.origin.y, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
            })
        }
        else if x == 2 {
            print(upcomingsliderbtn.frame.origin.x)
            UIView.animate(withDuration: 0.5, animations: {
                self.slider.frame = CGRect(x: (self.upcomingsliderbtn.frame.origin.x * 1 + 48), y: self.slider.frame.origin.y, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
            })
        }
        else {
            print(pastsliderbtn.frame.origin.x)
            UIView.animate(withDuration: 0.5, animations: {
                self.slider.frame = CGRect(x: (self.pastsliderbtn.frame.origin.x * 1 + 48), y: self.slider.frame.origin.y, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
            })
        }
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "simple" {
            
        }
       else if type == "complex" {
            self.tappedevent = self.upcomingevents[indexPath.row]
            
            performSegue(withIdentifier: "tojoinedevents", sender: nil)
        }
        else {
            self.tappedevent = self.pastevents[indexPath.row]
            performSegue(withIdentifier: "tojoinedevents", sender: nil)
        }
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "simple" {
            return createtablefields.count
        }
        else if(type == "complex") {
            return upcomingevents.count
        }
        else{
            return pastevents.count
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == "simple" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "eventsimple", for: indexPath) as? EventdatafeedsimpleTableViewCell {
                cell.sendtogglevalue = {a,b in

                    self.allchoosenfields[a.fieldname] = b
                    self.alldatainsync[a.fieldname] = b
                }
                cell.sendtogglevalue2 = { a in
                    self.allchoosenfields["Organisation Allowed"] = a
                }
                
                
                cell.sendfieldvalue = {a,b in
                    self.allchoosenfields[a.fieldname] = b
                     self.alldatainsync[a.fieldname] = b
                    print(self.allchoosenfields)
                    

                }
                cell.passback = {a in
                    print("passback")
                    print(a.fieldname)
                    print(a.datatype)
                    if a.datatype == "custom" {
                        self.popupview.isHidden = false

                        self.custompicker.isHidden = false
                        self.dropdownselectedtype = a.fieldname
                        print("Setting to \(self.dropdownselectedtype)")

                    self.custompicker.reloadAllComponents()
                        self.datepicker.isHidden = true
                    }
                    else {
                        self.popupview.isHidden = false
                        self.datepicker.minimumDate = Date()

                        self.dropdownselectedtype = a.fieldname
                        self.custompicker.isHidden = true
                        self.datepicker.setDate(Date(), animated: true)
                        self.datepicker.isHidden = false
                    }
                }
                if self.isineditmode == false {
                    cell.updatecell(x: self.createtablefields[indexPath.row] , y : self.alldatainsync)
                }
                else {
                    if let ev = self.eventwhole as? strevent {
                        cell.updatecell2(x: self.createtablefields[indexPath.row] , y : self.alldatainsync , z : ev)

                    }
                }
                return cell
            }
        }
        else if type == "complex" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "eventcomplex", for: indexPath) as? EventDataFeedComplexTableViewCell {
                
                cell.updatecell(x: self.upcomingevents[indexPath.row],y:"complex",z : self.eventcreator!)
                return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "eventcomplex", for: indexPath) as? EventDataFeedComplexTableViewCell {
                
                cell.updatecell(x: self.pastevents[indexPath.row],y:"complexpast",z : self.eventcreator!)
                return cell
            }
        }
        return UITableViewCell()
       }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(type == "simple") {
            if indexPath.row == self.createtablefields.count - 1 {
                return 180
            }
            return 110
        }
        else {
            return 330
        }
    }
    
    
    @IBAction func createeventtapped(_ sender: UIButton) {
        
        
        if isineditmode == true {
            print(self.allchoosenfields)
        }
        
       


        
        if (type == "simple") {
            for var k in 0 ..< self.createtablefields.count {
                if let cell =  table.cellForRow(at: IndexPath(row: k, section: 0)) as? EventdatafeedsimpleTableViewCell {
                    cell.textfieldplaceholder.resignFirstResponder()
                }
            }
        }
        
        if(self.allchoosenfields["Contest Name"] == nil) {
            self.present(customalert.showalert(x: "You need to enter contest name"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Performance Type"] == nil) {
            self.present(customalert.showalert(x: "You need to enter performance type"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Gender"] == nil) {
            self.present(customalert.showalert(x: "You need to enter gender"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Category"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Category"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Organisation Allowed"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Organisation Allowed"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Invitation type"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Invitation type"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Entry Type"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Entry Type"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Entry Fees"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Entry Fees"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Start Date"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Start Date"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Location"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Location"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Result Date"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Result Date"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Price"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Price"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Winner Price Type"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Winner Price Type"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Result Type"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Result Type"), animated: true, completion: nil)
        }
        else if(self.allchoosenfields["Contest Theme"] == nil) {
            self.present(customalert.showalert(x: "You need to enter Contest Theme"), animated: true, completion: nil)
        }
        else {
            
            if let cat = self.allchoosenfields["Category"] as? categorybrief {
                if let invt = self.allchoosenfields["Invitation type"] as? invitationtypess {
                    if let et = self.allchoosenfields["Entry Type"] as? entrytype {
                        if let cpt = self.allchoosenfields["Contest Winner Price Type"] as? contestwinnerpricess {
                            if let cwt = self.allchoosenfields["Contest Result Type"] as? contestwintypes {
                                if let cppt = self.allchoosenfields["Performance Type"] as? performancetypemodels {
                                    if let cgn = self.allchoosenfields["Gender"] as? genders {
                                        if let conth = self.allchoosenfields["Contest Theme"] as? themes {
                                
                                var contname = ""
                                var entfee = ""
                                var contloc = ""
                                var reson = ""
                                var contprice = ""
                                var conton = ""
                                var contdesc = ""
                                    
                                var eeeen = 0
                                        
                                if let c = self.allchoosenfields["Contest Name"] as? String {
                                    contname = c
                                }
                                if let c = self.allchoosenfields["Entry Fees"] as? String {
                                       entfee = c
                                   }
                                            if let d = Int(entfee) as? Int {
                                                eeeen = d
                                            }
                                            
                                if let c = self.allchoosenfields["Contest Location"] as? String {
                                       contloc = c
                                   }
                                if let c = self.allchoosenfields["Contest Result Date"] as? Date {
                                     reson =  c.string(format: "yyyy-MM-dd'T'hh:mm:ss'.303Z'")
                                }
                                if let c = self.allchoosenfields["Contest Price"] as? String {
                                       contprice = c
                                   }
                                if let c = self.allchoosenfields["Contest Start Date"] as? Date {
                                     conton =  c.string(format: "yyyy-MM-dd'T'HH:mm:ss'.303Z'")
                                }
               
                                if let c = self.allchoosenfields["Contest Description"] as? String {
                                    contdesc = c
                                }
            
                         
            
            var userid = UserDefaults.standard.value(forKey: "refid") as! String
                                            var params : Dictionary<String,Any> = ["ContestName": contname,"AllowCategoryId":cat.categoryid,"OrganizationAllow":true,"InvitationType":invt.id,"EntryAllowed":et.id,"EntryFee":eeeen,"ContestStart":conton,"ContestLocation":contloc,"Description":contdesc,"ResultOn":reson,"ContestPrice":contprice,"ContestWinnerPriceTypeId":cpt.id,"ResultTypeId":cwt.id,"UserId":userid,"GroupId":self.groupid,"IsActive":true,"Status":true,"RunningStatusId" : 2,"PerformanceTypeId":cppt.id,"Gender":cgn.id,"ThemeId" : conth.id]
                                
                                print(params)
                                
                                var url = Constants.K_baseUrl + Constants.createcontest
                                      var r = BaseServiceClass()
                                r.postApiRequest(url: url, parameters: params) { (response, err) in
                                    if let res = response?.result.value as? Dictionary<String,Any> {
                                        print(res)
                                        
                                        if let juryid = res["Results"] as? Int {
                                            self.juryid = juryid
                                        }
                                        
                                        if let resstatus = res["ResponseStatus"] as? Int {
                                            if resstatus == 0 {
                                                self.present(customalert.showalert(x: "Contest Created"), animated: true) {
                                                    self.performSegue(withIdentifier: "addjuryandparticipants", sender: nil)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                                }
                
                            }
                        }
                    }
                }
            }
            
            
      
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? NewEventViewController {
            seg.passedevent = event(eventid: self.tappedevent?.contestid ?? 0, eventname: self.tappedevent?.contestname ?? "", eventicon: self.tappedevent?.contestimage ?? "", time: self.tappedevent?.conteststart ?? "", endtime: self.tappedevent?.resulton ?? "", location: self.tappedevent?.contestlocation ?? "", createdby: self.eventcreator?.name ?? "")
        }
        if let seg = segue.destination as? GroupsandEventsContactvc {
            seg.mode = "jury"
            seg.passedjuryid = self.juryid
        }
        if let seg = segue.destination as? JoinedeventsViewController {
            seg.eventid = self.tappedevent?.contestid ?? 0
        }
    }

}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
