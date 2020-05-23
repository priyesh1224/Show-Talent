//
//  OfferViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/14/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class OfferViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var searchouter: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationindicator.layer.cornerRadius = 10
        searchouter.layer.borderWidth = 1
        searchouter.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        table.delegate = self
        table.dataSource = self
        table.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "offercell", for: indexPath) as? OfferTableViewCell {
            cell.update(x: "Get 25% Cashback", y: "On book any event", z: "with Axis bank Debit card")
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    

}
