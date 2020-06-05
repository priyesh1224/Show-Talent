//
//  BuyProVersionViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 6/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class BuyProVersionViewController: UIViewController {
    
    
    @IBOutlet weak var notifindicator: UIView!
    
    
    @IBOutlet weak var basicbtn: UIButton!
    
    @IBOutlet weak var probtn: UIButton!
    
    @IBOutlet weak var ultimate: UIButton!
    
    
    @IBOutlet weak var basicunderbar: UIView!
    
    
    @IBOutlet weak var prounderbar: UIView!
    
    
    @IBOutlet weak var ultimateunderbar: UIView!
    

    @IBOutlet weak var highlighter: UIView!
    
    
    @IBOutlet weak var offercard: UIView!
    
    
    @IBOutlet weak var amount: UITextView!
    
    @IBOutlet weak var daystrial: UITextView!
    
    @IBOutlet weak var planinfo: UITextView!
    
    var plansamount = ["Rs 500","Rs 1500","Rs 2000"]
    var planinform = ["","",""]
    var plandays = ["30 Days Trial","50 Days Trial","100 Days Trial"]
    
    var selected = "basic"
    
    @IBOutlet weak var upgardebtn: UIButton!
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notifindicator.layer.cornerRadius = 10
        self.upgardebtn.layer.cornerRadius = 16
        self.offercard.layer.cornerRadius = 10
        amount.text = plansamount[0]
        planinfo.text = planinform[0]
        daystrial.text = plandays[0]
        basicbtn.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        basicunderbar.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        probtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        prounderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ultimate.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        ultimateunderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setTableViewBackgroundGradient(UIColor(hexString: "#64F0C6"), UIColor(hexString: "#1E6BF4"))
        // Do any additional setup after loading the view.
    }
    

    @IBAction func upgardebtnpressed(_ sender: Any) {
    }
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setTableViewBackgroundGradient( _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.offercard.frame.size.width, height: self.offercard.frame.size.height)
        
        self.offercard.layer.insertSublayer(gradientLayer, at: 0)
        //        sender.backgroundView = backgroundView
    }
    
    
    @IBAction func basictapped(_ sender: Any) {
        selected = "basic"
        setTableViewBackgroundGradient(UIColor(hexString: "#64F0C6"), UIColor(hexString: "#1E6BF4"))
        amount.text = plansamount[0]
        planinfo.text = planinform[0]
        daystrial.text = plandays[0]
        basicbtn.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        basicunderbar.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        probtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        prounderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ultimate.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        ultimateunderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @IBAction func protapped(_ sender: Any) {
        selected = "pro"
        setTableViewBackgroundGradient(UIColor(hexString: "#B9B9B9"), UIColor(hexString: "#333333"))
        amount.text = plansamount[1]
        planinfo.text = planinform[1]
        daystrial.text = plandays[1]
        probtn.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        prounderbar.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        basicbtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        basicunderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ultimate.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        ultimateunderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    
    @IBAction func ultimatetapped(_ sender: Any) {
        selected = "ultimate"
        setTableViewBackgroundGradient(UIColor(hexString: "#FFC130"), UIColor(hexString: "#6D4800"))
        amount.text = plansamount[2]
        planinfo.text = planinform[2]
        daystrial.text = plandays[2]
        ultimate.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        ultimateunderbar.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        probtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        prounderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        basicbtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        basicunderbar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    
}
