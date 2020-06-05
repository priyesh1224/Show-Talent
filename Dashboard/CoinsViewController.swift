//
//  CoinsViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/11/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit



struct coinearning {
    var id : Int
    var eventname : String
    var eventdescription : String
    var coin : Int
    var coincounter : Int
}

class CoinsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    
    @IBOutlet weak var bannerview: UIView!
    
    
    @IBOutlet weak var notifindicator: UIView!
    
    @IBOutlet weak var bannerheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var earnbtn: UIButton!
    
    
    @IBOutlet weak var redeembtn: UIButton!
    
    
    @IBOutlet weak var table: UITableView!
    
    var allcoinsearning : [coinearning] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notifindicator.layer.cornerRadius = 10
        self.bannerheight.constant = self.view.frame.size.height/4
        table.delegate = self
        table.dataSource = self
        fetchdata()
        
        let m = self.applygradient(a: #colorLiteral(red: 0.3215686275, green: 0.3058823529, blue: 0.7803921569, alpha: 1), b: #colorLiteral(red: 0.1960784314, green: 0.4784313725, blue: 0.6666666667, alpha: 1))
        self.bannerview.layer.insertSublayer(m, at: 0)
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func fetchdata()
    {
        var url = "\(Constants.K_baseUrl)\(Constants.coinsledger)"
       
        var r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: [:]) { (response, err) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let rr = res["Results"] as? Dictionary<String,Any> {
                    if let dt = rr["Data"] as? [Dictionary<String,Any>] {
                        for each in dt {
                            var id : Int = 0
                            var eventname : String = ""
                            var eventdescription = ""
                            var coin = 0
                            var coincounter = 0
                           
                            if let e = each["Id"] as? Int {
                                id = e
                            }
                            if let e = each["EventName"] as? String {
                                eventname = e
                            }
                            if let e = each["EventDescription"] as? String {
                                eventdescription = e
                            }
                            if let e = each["Coin"] as? Int {
                                coin = e
                            }
                            if let e = each["CoinCounter"] as? Int {
                                coincounter = e
                            }
                          
                            
                          let x  = coinearning(id: id, eventname: eventname, eventdescription: eventdescription
                            , coin: coin, coincounter: coincounter)
                            self.allcoinsearning.append(x)
                        }
                        print(self.allcoinsearning)
                        self.table.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    func applygradient(a:UIColor , b:UIColor) -> CAGradientLayer
    {
        let gl = CAGradientLayer()
        gl.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.bannerheight.constant)
        gl.colors = [a.cgColor,b.cgColor]
        return gl
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allcoinsearning.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "coincell", for: indexPath) as? CoinsTableViewCell {
            cell.updatecell(x : self.allcoinsearning[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    
    @IBAction func earnbtnpressed(_ sender: Any) {
        self.earnbtn.setTitleColor(#colorLiteral(red: 0.3236835599, green: 0.3941466212, blue: 0.8482848406, alpha: 1), for: .normal)
        self.redeembtn.setTitleColor(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), for: .normal)
    }
    
    
    @IBAction func redeembtnpressed(_ sender: Any) {
        self.earnbtn.setTitleColor(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), for: .normal)
        self.redeembtn.setTitleColor(#colorLiteral(red: 0.3236835599, green: 0.3941466212, blue: 0.8482848406, alpha: 1), for: .normal)
    }
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

   

}
