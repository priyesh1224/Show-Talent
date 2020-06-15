//
//  PreviewContestViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

struct arrayparamss
{
    var k : String
    var v : String
}

class PreviewContestViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    
    
    
    
    @IBOutlet weak var contestname: Customlabel!
    
    
    @IBOutlet weak var navigationindicator: UIView!
    
    
    @IBOutlet weak var bannerimage: UIImageView!
    
    
    @IBOutlet weak var bannerimageheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var createbtnpressed: CustomButton!
    
    
    @IBOutlet weak var publishbtnpressed: CustomButton!
    var params : Dictionary<String,Any> = [:]
     var tempparams : Dictionary<String,Any> = [:]
    var juryid = 0
    var contestid = 0
    var arrayparams  : [arrayparamss] = []
    
    var primarycolor = UIColor(red: 85/255, green: 190/255, blue: 216/255, alpha: 1)
    var secondarycolor = UIColor(red: 91/255, green: 180/255, blue: 99/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationindicator.layer.cornerRadius = 10
        bannerimageheight.constant = self.view.frame.size.height/4
        createbtnpressed.layer.cornerRadius = 25
        publishbtnpressed.layer.cornerRadius = 25
        table.delegate = self
        table.dataSource = self
        for each in self.tempparams {
            var x = arrayparamss(k: each.key, v: "\(each.value)")
            self.arrayparams.append(x)
        }
        print("Heyyyyyyyyyy")
        self.contestname.text =  self.tempparams["contest name"] as? String
        print(self.arrayparams)
        self.setTableViewBackgroundGradient(sender: self.table, primarycolor, secondarycolor)
        
        table.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    
    func setTableViewBackgroundGradient(sender: UITableView, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 2, height: self.table.frame.size.height)
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width * 2, height: self.table.frame.size.height))
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.layer.insertSublayer(gradientLayer, at: 0)
//        sender.backgroundView = backgroundView
    }
    
    @IBAction func createbtntapped(_ sender: Any) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayparams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "previewcell", for: indexPath) as? PreviewcontestTableViewCell {
            cell.update(x : self.arrayparams[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    @IBAction func publichbtntapped(_ sender: Any) {
        var url = Constants.K_baseUrl + Constants.createcontest
        var r = BaseServiceClass()
        print(params)
        r.postApiRequest(url: url, parameters: self.params) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                print(res)
                
                if let juryid = res["Results"] as? Int {
                    self.juryid = juryid
                }
                
                if let resstatus = res["ResponseStatus"] as? Int {
                    if resstatus == 0 {
                        self.present(customalert.showalert(x: "Contest Created"), animated: true) {
                             if let resstatus = res["Results"] as? Int {
                                self.contestid = resstatus
                             }
                            self.performSegue(withIdentifier: "addjury2", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seg = segue.destination as? GroupsandEventsContactvc {
            seg.mode = "jury"
            seg.passedjuryid = self.juryid
            seg.groupid =  self.contestid
        }
        
    }
    
    
    
}
