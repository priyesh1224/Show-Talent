//
//  CustomeventViewController.swift
//  ShowTalent
//
//  Created by apple on 3/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CustomeventViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    @IBOutlet weak var nodatawarning: Customlabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
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
        self.nodatawarning.isHidden = true
        self.spinner.isHidden = false
        self.spinner.startAnimating()
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
                cell.startfetching = { a in
                    if a {
                        self.spinner.isHidden = false
                        self.spinner.startAnimating()
                    }
                    else {
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    }
                }
                cell.passback = {a in
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    if a.count == 0 {
                        self.nodatawarning.isHidden = false
                    }
                    else {
                        self.nodatawarning.isHidden = true
                    }
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
