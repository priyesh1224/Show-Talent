//
//  ShowPromotionViewController.swift
//  ShowTalent
//
//  Created by maraekat on 14/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ShowPromotionViewController: UIViewController ,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var swippingviewwodth: NSLayoutConstraint!
    
    @IBOutlet weak var swipingview: UIView!
    
    
    @IBOutlet var swipeleft: UISwipeGestureRecognizer!
    @IBOutlet var swipeg: UISwipeGestureRecognizer!
    
    var noofimages = 4
    var currentdisplay = 0
    var allimages : [UIImage] = [#imageLiteral(resourceName: "one-plus4"),#imageLiteral(resourceName: "splash-screen-one-plus"),#imageLiteral(resourceName: "one-plus"),#imageLiteral(resourceName: "one-plus3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()

        

    }
    
    func setupview()
    {
        
            var skip = UIButton()
            skip.backgroundColor = UIColor.white
            skip.setTitle("Skip", for: .normal)
            skip.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
            skip.layer.cornerRadius = 5
        skip.layer.zPosition = 3
            skip.frame = CGRect(x: self.view.frame.size.width - 122, y: 64, width: 90, height: 40)
            self.view.addSubview(skip)
        
        
            var skip2 = UIButton()
            skip2.backgroundColor = UIColor.white
            skip2.setTitle("Skip for 10 Secs", for: .normal)
            skip2.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
            skip2.layer.cornerRadius = 5
        skip2.layer.zPosition = 3
        skip2.frame = CGRect(x: self.view.frame.size.width - 232, y: self.view.frame.size.height - 122, width: 200, height: 40)
            self.view.addSubview(skip2)
        
      self.swippingviewwodth.constant = self.view.frame.size.width * CGFloat(Double(noofimages))
        
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        stackview.frame = CGRect(x: 0, y: 0, width:  self.swippingviewwodth.constant , height: self.swipingview.frame.size.height)
        self.swipingview.addSubview(stackview)
        
        
        
        
        for var k in 0 ..< noofimages {
            let imv = UIImageView()
            imv.image = self.allimages[k]
            imv.contentMode = .scaleAspectFill
            stackview.addArrangedSubview(imv)
            
            
        }
        
        
        
    }
    

    @IBAction func didswipe(_ sender: UISwipeGestureRecognizer) {
        print("Yo")
        
        
        if currentdisplay <= 0 {
            return
        }
        currentdisplay = currentdisplay - 1
        var xgap = self.view.frame.size.width * CGFloat(Double(currentdisplay))
        var myBounds = CGRect(x: xgap, y: 0, width: self.swipingview.frame.size.width, height: self.swipingview.frame.size.height)
       
        UIView.animate(withDuration: 0.5,delay:0.0,options:UIView.AnimationOptions.layoutSubviews,
        animations:{ () -> Void in
            self.swipingview.bounds = myBounds
        }, completion: nil)
    }
    

    @IBAction func didswipedleft(_ sender: UISwipeGestureRecognizer) {
        
         
         if currentdisplay >= noofimages - 1 {
             return
         }
         currentdisplay = currentdisplay + 1
         var xgap = self.view.frame.size.width * CGFloat(Double(currentdisplay))
         var myBounds = CGRect(x: xgap, y: 0, width: self.swipingview.frame.size.width, height: self.swipingview.frame.size.height)
        
        UIView.animate(withDuration: 0.5,delay:0.0,options:UIView.AnimationOptions.layoutSubviews,
         animations:{ () -> Void in
             self.swipingview.bounds = myBounds
         }, completion: nil)
    }
}
