//
//  ShowoneTimeScreenViewController.swift
//  ShowTalent
//
//  Created by maraekat on 14/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire



class ShowoneTimeScreenViewController: UIViewController , UIGestureRecognizerDelegate {
    
    @IBOutlet var swipeg: UISwipeGestureRecognizer!
    
    
    
    @IBOutlet var swipeleft: UISwipeGestureRecognizer!
    
    @IBOutlet weak var swipingviewwidth: NSLayoutConstraint!
    
    @IBOutlet weak var swipingview: UIView!
    
    var noofimages = 4
       var currentdisplay = 0
       var allimages : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchdata()
//        setupview()
        
    }
    
    func fetchdata()
    {
        let url = Constants.K_baseUrl + Constants.allpromotions
        let r = BaseServiceClass()
        r.getApiRequest(url: url, parameters: [ : ]) { (response, eror) in
            if let res = response?.result.value as? Dictionary<String,Any> {
                if let data = res["Results"] as? Dictionary<String,Any> {
                    if let innerdata = data["Data"] as? [Dictionary<String,Any>] {
                        
                        for each in innerdata {
                            if let e = each["Status"] as? Int {
                                if e == 0 {
                                    if let promo = each["promoImagePath"] as? String {
                                        print("\(e) and \(promo)")
                                        self.downloadimage(url: promo) { (im) in
                                            if let i = im as? UIImage {
                                                print("Downloaded")
                                                self.allimages.append(i)
                                                self.noofimages = self.allimages.count
                                                self.setupview()
                                            }
                                            else {
                                                print("Not downloaded")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        print("Check")

                        
                    }
                }
            }
        }
    }
    
    
    func setupview()
    {
        
            var skip = UIButton()
            skip.backgroundColor = UIColor.white
            skip.setTitle("Skip", for: .normal)
            skip.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
        skip.addTarget(self, action: #selector(skipped), for: .touchUpInside)
            skip.layer.cornerRadius = 5
        skip.layer.zPosition = 3
            skip.frame = CGRect(x: self.view.frame.size.width - 122, y: 64, width: 90, height: 40)
            self.view.addSubview(skip)
        
        
        var swipeinst = UILabel()
        swipeinst.text = "Swipe for the next image"
        swipeinst.textColor = UIColor.white
        swipeinst.textAlignment = .center
        swipeinst.frame = CGRect(x: 0, y:self.view.frame.size.height - 60 , width: self.view.frame.size.width, height: 60)
//        self.view.addSubview(swipeinst)
        
        
//            var skip2 = UIButton()
//            skip2.backgroundColor = UIColor.white
//            skip2.setTitle("Skip for 10 Secs", for: .normal)
//            skip2.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1), for: .normal)
//            skip2.layer.cornerRadius = 5
//        skip2.layer.zPosition = 3
//        skip2.frame = CGRect(x: self.view.frame.size.width - 232, y: self.view.frame.size.height - 122, width: 200, height: 40)
//            self.view.addSubview(skip2)
        
      self.swipingviewwidth.constant = self.view.frame.size.width * CGFloat(Double(noofimages)) 
        
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        stackview.frame = CGRect(x: 0, y: 0, width:  self.swipingviewwidth.constant , height: self.swipingview.frame.size.height)
        self.swipingview.addSubview(stackview)
        
        
        
        
        for var k in 0 ..< noofimages {
            let imv = UIImageView()
//            imv.frame = CGRect(x: (k) , y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            imv.frame.size.width = self.view.frame.size.width
            imv.image = self.allimages[k]
            imv.contentMode = .scaleAspectFit
            stackview.addArrangedSubview(imv)
            
            
        }
        
        
        
    }
    
    @objc func skipped()
    {
        print("Adds Skipped")
        if let uid = UserDefaults.standard.value(forKey: "refid") as? String {
            
            performSegue(withIdentifier: "alreadyloggedin", sender: nil)
        }
        else {
            print("logged out")
            performSegue(withIdentifier: "gettologin", sender: nil)
        }
        
    }

    @IBAction func swippedright(_ sender: UISwipeGestureRecognizer) {
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
    
    @IBAction func swipedleft(_ sender: UISwipeGestureRecognizer) {
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
    
    
    typealias imgcomp = (_ x : UIImage) -> Void
    func downloadimage(url : String,p : @escaping imgcomp)
    {
     var uurl = "http://thcoreapi.maraekat.com/Upload/Category/noicon.png"
        var receivedimage : UIImage?
     if let u = url as? String {
        Alamofire.request(u, method:.get).responseData { (rdata) in
         if let d = rdata.data as? Data {
             if let i = UIImage(data: d) as? UIImage {
                 p(i)

             }
         }
        }
     }

    }
    
    
    }
    

