//
//  CustomeventViewController.swift
//  ShowTalent
//
//  Created by apple on 3/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CustomeventViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    
    
    
    @IBOutlet var notificationindicator: UIView!
    var currenttappedevent : languagewiseevent?
    
    @IBOutlet var table: UITableView!
    
    static var passdata : ((_ : [languagewiseevent] ) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        table.allowsSelection = true
        notificationindicator.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cecell", for: indexPath) as? CustomeventTableViewCell {
                cell.passback = {a in
                    CustomeventViewController.passdata!(a)
                }
                cell.update()
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ce2", for: indexPath) as? Customtable2TableViewCell {
                cell.passbackevent = {a in
                    self.currenttappedevent = a
                    self.performSegue(withIdentifier: "tellmemore", sender: nil)
                }
                cell.update()
                return cell
            }
        }
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 400
        }
        return self.view.frame.size.height/2
    }
    

    @IBAction func backpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? CustomeventinfoViewController {
            seg.gotevent = self.currenttappedevent
        }
    }
    
    
    
    
    
}
