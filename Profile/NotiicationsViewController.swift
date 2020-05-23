//
//  NotiicationsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

struct notifications
{
    var image : String
    var content : String
    var time : String
    var status : String
}

class NotiicationsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    var allnotificationsfetced : [notifications] = []
    
    @IBOutlet weak var plusbuttoncovering: UIView!
    

    @IBOutlet weak var plusbutton: UIButton!
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupallviews()
        self.table.delegate = self
        self.table.dataSource = self
        setdummydata()
    }
    
    
    @IBAction func backpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setdummydata()
    {
        var x  = notifications(image: "", content: "Biggest Sale of the year", time: "12:00PM", status: "unread")
        var y  = notifications(image: "", content: "Your order is placed.", time: "01:00PM", status: "read")
        self.allnotificationsfetced.append(x)
        self.allnotificationsfetced.append(y)
        self.allnotificationsfetced.append(x)
        self.allnotificationsfetced.append(y)
        self.allnotificationsfetced.append(x)
        self.allnotificationsfetced.append(y)
        
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allnotificationsfetced.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notificationcell", for: indexPath) as? NotificationTableViewCell {
            cell.updatecell(x: self.allnotificationsfetced[indexPath.row])
            cell.selectionStyle = .none

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.table.frame.size.height / 4.5
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
