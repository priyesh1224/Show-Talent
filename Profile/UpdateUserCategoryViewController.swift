//
//  UpdateUserCategoryViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class UpdateUserCategoryViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    
    
    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var table1: UITableView!
    
    
    @IBOutlet weak var table2: UITableView!
    
    
    @IBOutlet weak var savebtn: CustomButton!
    
    
    @IBOutlet weak var table1height: NSLayoutConstraint!
    
    var allcategories : [categorybrief] = []
    var usercategories : [categorybrief] = []
    var deletedcategories : [categorybrief] = []
    var addedcategories : [categorybrief] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationindicator.layer.cornerRadius = 10
        savebtn.layer.cornerRadius = 25
        table1.delegate = self
        table1.dataSource = self
        table2.delegate = self
        table2.dataSource = self
        fetchcategories()
        
        // Do any additional setup after loading the view.
    }
    
    
    func fetchcategories()
    {
        
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        
        var params : Dictionary<String,Any> = [:]
        
        
        
        
        var url = Constants.K_baseUrl + Constants.getCategory
        var r = BaseServiceClass()
        
        print(url)
        r.getApiRequest(url: url, parameters: [:]) { (data, error) in
            print("-----------------")
            if let dv = data?.result.value as? Dictionary<String,Any> {
                if let inv =  dv["Results"] as? Dictionary<String,Any> {
                    if let indv =  inv["Data"] as? [Dictionary<String,Any>] {
                        print(indv)
                        for eachcat in indv {
                            if let cat = eachcat["CategoryName"] as? String , let catid = eachcat["ID"] as? Int {
                                
                                var x  = categorybrief(categoryid: catid, categoryname: cat)
                                self.allcategories.append(x)
                                
                            }
                        }
                        self.fetchowncategories()
                    }
                }
            }
        }
    }
    
    
    func fetchowncategories()
    {
        var url = Constants.K_baseUrl + Constants.getusercategories
        var r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: [:]) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let rr = res["Results"] as? [Dictionary<String,Any>] {
                    for eachcat in rr {
                        if let cat = eachcat["CategoryName"] as? String , let catid = eachcat["CategoryMasterID"] as? Int {
                            
                            var x  = categorybrief(categoryid: catid, categoryname: cat)
                            self.usercategories.append(x)
                            
                        }
                    }
                    var ht = CGFloat(self.usercategories.count * 60)
                    if ht > self.view.frame.height/2.5 {
                        ht = self.view.frame.height/2.5
                    }
                    self.table1height.constant = ht
                    self.removeduplicates()

                }
            }
        }
        
    }
    
    
    
    func removeduplicates()
    {
        for var k in 0 ..< self.usercategories.count {
            for var m in 0 ..< self.allcategories.count {
                if usercategories[k].categoryid == allcategories[m].categoryid {
                    self.allcategories.remove(at: m)
                    break
                }
            }
        }
        self.table1.reloadData()
        self.table2.reloadData()
    }
    
    
    
    
    
    @IBAction func savebtntapped(_ sender: Any) {
        print("Deleted")
        print(self.deletedcategories)
        print("Added")
        print(self.addedcategories)
        let userid = UserDefaults.standard.value(forKey: "refid") as! String
        let url = Constants.K_baseUrl + Constants.updatecategorychoice
        var catdata : [Dictionary<String,Any>] = []
        for each in self.deletedcategories {
            var x : Dictionary<String,Any> = ["CategoryMasterID" : each.categoryid , "IsDelete" : true , "CategoryName" : each.categoryname]
            catdata.append(x)
        }
        for each in self.addedcategories {
            var x : Dictionary<String,Any> = ["CategoryMasterID" : each.categoryid , "IsDelete" : false , "CategoryName" : each.categoryname]
            catdata.append(x)
        }
        
        var params : Dictionary<String,Any> = ["UserID" : userid , "CategoryIds" : catdata]
        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let code = res["ResponseStatus"] as? Int {
                    if code == 0 {
                        let alert2 = UIAlertController(title: "Categories Updated", message: "", preferredStyle: .actionSheet)
                        alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            self.dismiss(animated: true, completion: nil)
                            
                        }));
                        self.present(alert2, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func backbtntapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return self.usercategories.count
        }
        else {
            return self.allcategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "updateuc1", for: indexPath) as? UpdateUserCategoryTableViewCell {
                
                cell.passfordelete = { a,b in
                    if b {
                        self.deletedcategories.append(a)
                    }
                    else {
                        for var k in 0 ..< self.deletedcategories.count {
                            if self.deletedcategories[k].categoryid == a.categoryid {
                                self.deletedcategories.remove(at: k)
                            }
                        }
                    }
                }
                
                
                cell.update(x: self.usercategories[indexPath.row])
                return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "updateuc2", for: indexPath) as? Updateuercategory2TableViewCell {
                cell.passforadd = { a,b in
                    if b {
                        self.addedcategories.append(a)
                    }
                    else {
                        for var k in 0 ..< self.addedcategories.count {
                            if self.addedcategories[k].categoryid == a.categoryid {
                                self.addedcategories.remove(at: k)
                            }
                        }
                    }
                }
                cell.update(x: self.allcategories[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
   

}
