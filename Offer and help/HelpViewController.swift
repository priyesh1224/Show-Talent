//
//  HelpViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/14/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var table: UITableView!
    
    var allstrings = ["FAQ's" , "Account Settings" , "Manage All your Bookings" , "Event Booking issues", "Need help with other issues"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationindicator.layer.cornerRadius = 10
        self.table.delegate = self
        self.table.dataSource = self
        self.table.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allstrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "helpcell", for: indexPath) as? HelpTableViewCell {
            cell.update(x : self.allstrings[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    
    

    @IBAction func backbtntapped(_ sender: UIButton) {
    }
    

}
