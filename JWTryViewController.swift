//
//  JWTryViewController.swift
//  ShowTalent
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class JWTryViewController: UIViewController , JWPlayerDelegate , UITableViewDelegate , UITableViewDataSource{
   
    

   
    var videoload = false
    
    @IBOutlet weak var table: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 9 {
            videoload = true
        }
        if videoload || indexPath.row < 2 {
            if let tc = tableView.cellForRow(at: indexPath) as? JWTryTableViewCell {
                if let p = tc.player {
                    p.play()
                }
            }
        }
        print("printng \(indexPath.row)")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 10
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "jwtry") as? JWTryTableViewCell {
            
                cell.update()
            
            return cell
        }
        return UITableViewCell()
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.frame.size.height/1.5
    }
    
    
    
}
