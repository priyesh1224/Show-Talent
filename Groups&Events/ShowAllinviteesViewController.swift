//
//  ShowAllinviteesViewController.swift
//  ShowTalent
//
//  Created by maraekat on 14/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

struct fetchedmember
{
    var id : Int
    var name : String
    var profileimage : String
    var userid : String
    var countrycode : String
    var mobile : String
}
class ShowAllinviteesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
   
    
    var members : [fetchedmember] = []
    var groupid = 15
    var groupcreator = ""
    
    var deleteallowed = false
    
    @IBOutlet weak var table: UITableView!
    var passbackupdatedcount : ((_ x : Int) -> Void)?
    @IBOutlet weak var groupname: Customlabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        var userid = UserDefaults.standard.value(forKey: "refid") as! String
        if userid == groupcreator {
            deleteallowed = true
        }
        self.fetchdata(page : 0)

    }
    
    func fetchdata(page : Int)
    {
        var r = BaseServiceClass()
        var url = Constants.K_baseUrl + Constants.getallmembers + "?groupId=\(self.groupid)"
        var params : Dictionary<String,Int> = ["Page": page,"PageSize": 9]
        print(url)
        print(params)
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            if err != nil {
                print(err)
            }
            if let dv = response?.result.value as? Dictionary<String,AnyObject> {
                print(dv)
                           if let inv =  dv["Results"] as? [Dictionary<String,AnyObject>] {
                            
                            for each in inv {
                                var id = 0
                                var name  = ""
                                var profimg = ""
                                var countrycode = ""
                                var mobile = ""
                                var uid = ""
                                if let i = each["ID"] as? Int {
                                    id = i
                                }
                                if let i = each["Name"] as? String {
                                     name = i
                                 }
                                if let i = each["ProfileImage"] as? String {
                                     profimg = i
                                 }
                                if let i = each["UserId"] as? String {
                                     uid = i
                                 }
                                if let i = each["CountryCode"] as? String {
                                     countrycode = i
                                 }
                                if let i = each["Mobile"] as? String {
                                     mobile = i
                                 }
                                
                                var x = fetchedmember(id: id, name: name, profileimage: profimg, userid: uid, countrycode: countrycode, mobile: mobile)
                                
                                self.members.append(x)
                                
                                
                            }
                            self.table.reloadData()

                            
                            
                            
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.members.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "membercell", for: indexPath) as? ShowallinviteesTableViewCell {
            
            
            
            cell.removeuser = { a in
                let alert2 = UIAlertController(title: "Remove user", message: "Are you sure you want to remove \(a.name.capitalized)", preferredStyle: .actionSheet)
                alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    var r  = BaseServiceClass()
                    
                        var uid = UserDefaults.standard.value(forKey: "refid")!
                        var params : Dictionary<String,Any> = ["GroupId" : self.groupid , "UserId" : a.userid]
                        var url = Constants.K_baseUrl + Constants.leavegroup
                        r.postApiRequest(url: url, parameters: params) { (response, err) in
                            if let res = response?.result.value as? Dictionary<String,Any> {
                                print(res)
                                if let code = res["ResponseStatus"] as? Int {
                                    if code == 0 {
                                        for var k in 0 ..< self.members.count {
                                            if self.members[k].userid == a.userid {
                                                self.members.remove(at: k)
                                                self.table.reloadData()
                                                self.passbackupdatedcount!(self.members.count)
                                                break
                                            }
                                        }
                                        
                                        let alert3 = UIAlertController(title: "Group Member Deleted", message: "", preferredStyle: .actionSheet)
                                        alert3.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                           
                                            
                                        }));
                                        self.present(alert3, animated: true, completion: nil)
                                        
                                    }
                                    else {
                                        if let err = res["Error"] as? Dictionary<String,Any> {
                                            if let inner = err["ErrorMessage"] as? String {
                                                self.present(customalert.showalert(x: inner), animated: true, completion: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    
                    
                }));
                alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert2, animated: true, completion: nil)
            }
            
            cell.update(x: self.members[indexPath.row] , y : deleteallowed)
            return cell
        }
        return UITableViewCell()
       }
    

    @IBAction func backbtntapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
