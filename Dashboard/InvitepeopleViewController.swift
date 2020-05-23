//
//  InvitepeopleViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/9/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class InvitepeopleViewController: UIViewController {
    
    
    @IBOutlet weak var notifindicator: UIView!
    
    @IBOutlet weak var bannerheight: NSLayoutConstraint!
    
    @IBOutlet weak var referalcode: UILabel!
    
    @IBOutlet weak var outerreferalcodeview: UIView!
    
    
    @IBOutlet weak var bannerview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notifindicator.layer.cornerRadius = 10
        outerreferalcodeview.layer.borderColor = UIColor.white.cgColor
        outerreferalcodeview.layer.borderWidth = 1
        self.bannerheight.constant = self.view.frame.size.height/3
        let m = self.applygradient(a: #colorLiteral(red: 0.3215686275, green: 0.3058823529, blue: 0.7803921569, alpha: 1), b: #colorLiteral(red: 0.1960784314, green: 0.4784313725, blue: 0.6666666667, alpha: 1))
        self.bannerview.layer.insertSublayer(m, at: 0)

        // Do any additional setup after loading the view.
    }
    
    func applygradient(a:UIColor , b:UIColor) -> CAGradientLayer
    {
        let gl = CAGradientLayer()
        gl.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.bannerheight.constant)
        gl.colors = [a.cgColor,b.cgColor]
        return gl
    }
    
    
    @IBAction func whatsapptapped(_ sender: Any) {
        var whatsappURL:NSURL? = NSURL(string: "whatsapp://send?text=Hello%2C%20World!")
        if (UIApplication.shared.canOpenURL(whatsappURL as! URL)) {
            UIApplication.shared.openURL(whatsappURL as! URL)
        }
    }
    
    
    
    
    
    @IBAction func backtapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
