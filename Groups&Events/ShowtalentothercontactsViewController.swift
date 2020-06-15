//
//  ShowtalentothercontactsViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


struct othertalentcontact
{
    var id : Int
    var contact : String
    var countrycode : String
    var profileimage : String
    var name : String
}

class ShowtalentothercontactsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var warningmessage: UILabel!
    
    @IBOutlet weak var search: UISearchBar!
    
    
    @IBOutlet weak var tabel: UITableView!
    
    
    @IBOutlet weak var searchbtn: UIButton!
    
    var passallselectedcontacts : ((_ x : [othertalentcontact] ) -> Void)?
    
    
    var allobtainedcontacts : [othertalentcontact] = []
    var allselectedcontacts : [othertalentcontact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchbtn.layer.cornerRadius = 10
        self.tabel.delegate = self
        self.tabel.dataSource = self
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        self.warningmessage.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func searchbtnpressed(_ sender: Any) {
        
        allobtainedcontacts = []
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        self.warningmessage.isHidden = true
        
        if let s = search.text {
            let url = "\(Constants.K_baseUrl)\(Constants.searchmembers)?searchTeam=\(s)"
            let params : Dictionary<String,Any> = ["Page" : 0 , "PageSize" : 10]
            let r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: params) { (response, err) in
                if let res = response?.result.value as? Dictionary<String,Any> {
                    if let rr = res["Results"] as? Dictionary<String,Any> {
                        if let dt = rr["Data"] as? [Dictionary<String,Any>] {
                            for each in dt {
                                print(each)
                                var i = 0
                                var c = ""
                                var cc = ""
                                var pi = ""
                                var nm = ""
                                
                                if let a = each["Id"] as? Int {
                                    i = a
                                }
                                if let a = each["Contact"] as? String {
                                    c = a
                                }
                                if let a = each["CountryCode"] as? String {
                                    cc = a
                                }
                                if let a = each["ProfileImg"] as? String {
                                    pi = a
                                }
                                if let a = each["Name"] as? String {
                                    nm = a
                                }
                                
                                var found = false
                                for each in self.allselectedcontacts {
                                    if each.id == i {
                                        found = true
                                        break
                                    }
                                }
                                if found == false {
                                    var x = othertalentcontact(id: i, contact: c, countrycode: cc, profileimage: pi, name: nm)
                                    self.allobtainedcontacts.append(x)
                                }
                            }
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                            if self.allobtainedcontacts.count == 0{
                                self.present(customalert.showalert(x: "No new contacts found for name \(s.capitalized)"), animated: true, completion: nil)
                            }
                            self.tabel.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.allselectedcontacts.count + self.allobtainedcontacts.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "showtalentcontact", for: indexPath) as? ShowtalentothercontactsTableViewCell {
            
            cell.addremove = { a,b in
                if b {
                self.allselectedcontacts.append(a)
                    for var k in 0 ..< self.allobtainedcontacts.count {
                        if a.id == self.allobtainedcontacts[k].id {
                            self.allobtainedcontacts.remove(at: k)
                        }
                    }
                    self.tabel.reloadData()
                }
                else {
                    for var k in 0 ..< self.allselectedcontacts.count {
                        if self.allselectedcontacts[k].id == a.id {
                            self.allselectedcontacts.remove(at: k)
                            self.allobtainedcontacts.append(a)
                            self.tabel.reloadData()
                            break
                        }
                    }
                }
                print("Now")
                print(self.allselectedcontacts)
            }
            
            
            if indexPath.row < self.allselectedcontacts.count {
                cell.update(x : self.allselectedcontacts[indexPath.row] , y : false)
            }
            else {
                var i = indexPath.row - self.allselectedcontacts.count
                cell.update(x: self.allobtainedcontacts[i] , y : true)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    @IBAction func donebtnpressed(_ sender: Any) {
        self.passallselectedcontacts!(self.allselectedcontacts)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
