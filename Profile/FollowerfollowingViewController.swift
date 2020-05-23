//
//  FollowerfollowingViewController.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit



class FollowerfollowingViewController: UIViewController , UITableViewDelegate , UITableViewDataSource ,UISearchBarDelegate{

    var currentshowing = "follower"
    var allfollowers : [follower] = []
    var allfollowing : [following] = []
    var filteredsearches : [filterednames] = []
    
    
    
    
    
    @IBOutlet weak var plusbuttoncovering: UIView!
    

    @IBOutlet weak var plusbutton: UIButton!
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    var button1 : UIButton!
    var button2 : UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupallviews()
        self.table.delegate = self
        self.table.dataSource = self
        self.searchbar.delegate = self
        setdummydata()
        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           self.filteredsearches = []
        if let s = searchBar.text?.lowercased() as? String {
            print("\(s)")
            if s.isEmpty {
                filteredsearches = []
                print("Empty")
            }
            else {
                print("Not Empty")
                for follow in self.allfollowers {
                    if(follow.username.lowercased().contains(s) || follow.userid.lowercased().contains(s)) {
                        var x = filterednames(username: follow.username, userid: follow.userid, relation: follow.relation)
                        self.filteredsearches.append(x)
                    }
                }
                
                for follow in self.allfollowing {
                    if(follow.username.lowercased().contains(s) || follow.userid.lowercased().contains(s)) {
                        var x = filterednames(username: follow.username, userid: follow.userid, relation: follow.relation)
                        self.filteredsearches.append(x)
                    }
                }
                
            }
            self.table.reloadData()

               
           }
         }
    
    func setdummydata()
       {
           
           var x  = follower(username: "Priyesh", userid: "priyesh_123", relation: "follower")
            var y  = follower(username: "John", userid: "jone05", relation: "follower")
        var z  = following(username: "Rohan", userid: "Rh12", relation: "following")
         var w  = following(username: "Amit", userid: "as45", relation: "following")
           
        self.allfollowers.append(x)
        self.allfollowers.append(y)
        self.allfollowing.append(z)
        self.allfollowing.append(w)
        
           self.table.reloadData()
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(filteredsearches.count > 0) {
            return filteredsearches.count
        }
        
        if(self.currentshowing == "follower") {
            return self.allfollowers.count
        }
        else{
            return self.allfollowing.count
        }
        return 0
    }
    
    
    @IBAction func backpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "followercell", for: indexPath) as? FollowerfollowingTableViewCell {
            if self.filteredsearches.count > 0 {
                cell.updatecell3(x: self.filteredsearches[indexPath.row])
            }
            else if self.currentshowing == "follower" {
                cell.updatecell(x: self.allfollowers[indexPath.row])
            }
            else {
                cell.updatecell2(x: self.allfollowing[indexPath.row])
            }
            cell.selectionStyle = .none

            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.table.frame.size.height / 4.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var frame = table.frame
        var framewidth = frame.size.width
         button1 = UIButton(frame: CGRect(x: 0, y: 10, width: framewidth * 0.5, height: 50))
        button1.setTitle("Follower", for: .normal)
        button1.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        button1.addTarget(self, action: #selector(followpressed), for: .touchUpInside)
        button1.titleLabel?.textAlignment = .right
         button2 = UIButton(frame: CGRect(x: framewidth * 0.5, y: 10, width: framewidth * 0.5, height: 50))
          button2.setTitle("Following", for: .normal)
          button2.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        button2.titleLabel?.textAlignment = .left
        button2.addTarget(self, action: #selector(followingpressed), for: .touchUpInside)
        var overview  = UIView(frame: CGRect(x: 0, y: 0, width: framewidth, height: 80))
        overview.addSubview(button1)
        overview.addSubview(button2)
        return overview
    }
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return self.table.frame.size.height / 6
    }
    @objc func followpressed()
    {
        print("follow")
        button1.tintColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        button2.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.currentshowing = "follower"
        self.table.reloadData()
    }
    @objc func followingpressed()
    {
        print("following")

        button1.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button2.tintColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        self.currentshowing = "following"
        self.table.reloadData()
    }
    func setupallviews()
          {
           self.searchbar.layer.cornerRadius = 35
           self.notificationindicator.layer.cornerRadius = 10
              self.plusbuttoncovering.layer.cornerRadius = 55
                  self.plusbutton.layer.cornerRadius = 37
          }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
