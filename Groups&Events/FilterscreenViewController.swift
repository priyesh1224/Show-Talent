//
//  FilterscreenViewController.swift
//  ShowTalent
//
//  Created by maraekat on 04/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FilterscreenViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    
    
    var allthemes : [themes] = []
    var allperformancetypes : [performancetypemodels] = []
    var allgenders : [genders] = []
    var allentryfees : [entrytypefees] = []
    

    var categoryid = 114
    
    @IBOutlet weak var lefttable: UITableView!
    
    @IBOutlet weak var righttable: UITableView!
    
    var selectedleftcell = "theme"
    
    var allkeys : [String] = ["Theme" ,"Performance Type", "Gender" , "Entry Type"]
    
    var alldata : Dictionary<String,[String]> = ["Theme" : [] , "Performance Type" : [], "Gender" : [] , "Entry Type" : []]
    
    var takebackfilters : ((_ con : Dictionary<String,[String]> ) -> ())?
    
    var selectedrightvalues : Dictionary<String,[String]> = ["theme" : [] ,"performance type" : [], "gender" : [] , "entry type" : []]
    
    @IBOutlet weak var filtrapplybtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lefttable.delegate = self
        lefttable.dataSource = self
        righttable.delegate = self
        righttable.dataSource = self
        righttable.allowsMultipleSelection = true
        self.getprefetch()

        self.filtrapplybtn.layer.cornerRadius = 10
        if let cell = self.lefttable.cellForRow(at: IndexPath(row: 0, section: 0)) as? FilterscreenleftTableViewCell {
            cell.content.textColor = #colorLiteral(red: 0.3537997603, green: 0.3623381257, blue: 0.8117030263, alpha: 1)
            cell.contentView.backgroundColor = UIColor.white
        }
        

    }
    
    
    
    func getprefetch()
    {
        var url = Constants.K_baseUrl + Constants.getthemes
        var params : Dictionary<String,Any> = ["categoryId" : self.categoryid]
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let data = res["Results"] as? Dictionary<String,Any> {
                    if let themess = data["Theme"] as? [Dictionary<String,Any>] {
                        for each in themess {
                            var id = 0
                            var theme = ""
                            if let i = each["Id"] as? Int {
                                id = i
                            }
                            if let i = each["Theme"] as? String {
                                theme = i
                            }
                            var x = themes(id: id, theme: theme)
                            self.allthemes.append(x)
                            self.alldata["Theme"]?.append(theme)
                        }
                    }
                    if let themess = data["Genders"] as? [Dictionary<String,Any>] {
                        for each in themess {
                            var id = 0
                            var theme = ""
                            if let i = each["Id"] as? Int {
                                id = i
                            }
                            if let i = each["GenderType"] as? String {
                                theme = i
                            }
                            var x = genders(id: id, gender: theme)
                            self.allgenders.append(x)
                            self.alldata["Gender"]?.append(theme)
                        }
                    }

                    if let themess = data["PerformanceTypes"] as? [Dictionary<String,Any>] {
                        for each in themess {
                            var id = 0
                            var theme = ""
                            if let i = each["Id"] as? Int {
                                id = i
                            }
                            if let i = each["Performance"] as? String {
                                theme = i
                            }
                            var x = performancetypemodels(id: id, peroformance: theme)
                            self.allperformancetypes.append(x)
                            self.alldata["Performance Type"]?.append(theme)
                        }
                    }

                    if let themess = data["EntryType"] as? [Dictionary<String,Any>] {
                        for each in themess {
                            var id = 0
                            var theme = ""
                            if let i = each["Id"] as? Int {
                                id = i
                            }
                            if let i = each["FeeType"] as? String {
                                theme = i
                            }
                            var x = entrytypefees(id: id, fees: theme)
                            self.allentryfees.append(x)
                            self.alldata["Entry Type"]?.append(theme)
                        }
                    }
                    
                    print(self.alldata)
                    self.lefttable.reloadData()
                    self.righttable.reloadData()
                }
            }
        }
    }
    
    
    @IBAction func resetfilters(_ sender: Any) {
        self.selectedrightvalues = ["" : []]
        self.takebackfilters!(self.selectedrightvalues)
        righttable.reloadData()
    }
    
    @IBAction func filterapplypressed(_ sender: Any) {
        print(self.selectedrightvalues)
        self.takebackfilters?(self.selectedrightvalues)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return self.allkeys.count
        }
        else {
            return self.alldata[self.selectedleftcell.capitalized]!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "leftfilter", for: indexPath) as? FilterscreenleftTableViewCell {
                cell.updatecell(x: self.allkeys[indexPath.row])
                return cell
                
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "rightfilter", for: indexPath) as? FilterscreenrightTableViewCell {
                var found = false
                print("--------------------------")
                print(selectedrightvalues)
                if let a = selectedrightvalues[self.selectedleftcell] as? [String] {
                    print(self.selectedleftcell)
                    print("choosing colors")
                    print(a)
                    for var k in 0 ..< a.count {
                        print(a[k])
                        print(self.alldata[self.selectedleftcell.capitalized]![indexPath.row])
                        print("--------------")
                        if a[k] == self.alldata[self.selectedleftcell.capitalized]![indexPath.row].lowercased() {
                            found = true
                            break
                        }
                    }
                }
                if found == true {
                    cell.chkbox.backgroundColor = UIColor.black
                }
                else
                {
                    cell.chkbox.backgroundColor = UIColor.clear
                }
                cell.updatecell(x: self.alldata[self.selectedleftcell.capitalized]![indexPath.row])
                return cell
                
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            if let cell = self.lefttable.cellForRow(at: IndexPath(row: 0, section: 0)) as? FilterscreenleftTableViewCell {
                cell.content.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.contentView.backgroundColor = UIColor.clear
            }
            self.selectedleftcell = self.allkeys[indexPath.row].lowercased()
            print(self.selectedleftcell)
            selectedrightvalues[self.selectedleftcell] = selectedrightvalues[self.selectedleftcell] ?? []
            self.lefttable.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.white
            if let cell = self.lefttable.cellForRow(at: indexPath) as? FilterscreenleftTableViewCell {
                cell.content.textColor = #colorLiteral(red: 0.3537997603, green: 0.3623381257, blue: 0.8117030263, alpha: 1)
            }
            righttable.reloadData()
        }
        else {
            if let cell = righttable.cellForRow(at: indexPath) as? FilterscreenrightTableViewCell {
                
                       print(selectedrightvalues[self.selectedleftcell])
                        print(self.alldata[self.selectedleftcell.capitalized]![indexPath.row])
                selectedrightvalues[self.selectedleftcell]?.append(self.alldata[self.selectedleftcell.capitalized]![indexPath.row].lowercased())
                print(selectedrightvalues)
                cell.chkbox.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            self.lefttable.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.clear
            if let cell = self.lefttable.cellForRow(at: indexPath) as? FilterscreenleftTableViewCell {
                cell.content.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        else {
            if let cell = righttable.cellForRow(at: indexPath) as? FilterscreenrightTableViewCell {
                if var k = selectedrightvalues[self.selectedleftcell.lowercased()] as? [String] {
                    print("Check out")
                    print(k)
                    for var m in 0 ..< k.count {
                        print(k[m])
                        print(self.alldata[self.selectedleftcell.capitalized]![indexPath.row].lowercased())
                        if k[m] == self.alldata[self.selectedleftcell.capitalized]![indexPath.row].lowercased() {
                            print("Remove at \(m)")
                            if m < k.count {
                                selectedrightvalues[self.selectedleftcell.lowercased()]?.remove(at: m)
                            }
                        }
                    }
                }
                print(selectedrightvalues)
                cell.chkbox.backgroundColor = UIColor.clear
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
