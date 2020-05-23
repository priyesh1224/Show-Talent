//
//  SearchcategoryCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 17/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import FLAnimatedImage


class SearchcategoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var iconimm: FLAnimatedImageView!
    
    @IBOutlet var iconlbb: UILabel!
    
    
    @IBOutlet weak var view: UIView!
//    lazy var newimageview = UIImageView()
//    lazy var catname = UILabel()
    
    func updateview(x:searchcategory , a : String , b : String) {
        
        self.view.backgroundColor = UIColor.clear
        self.view.layer.insertSublayer(applygradient(a: hexStringToUIColor(hex: a), b: hexStringToUIColor(hex: b)), at: 0)
        self.view.layer.cornerRadius = 10
        
//        print("Cell received with name \(x.categoryname)")
//        newimageview.image = nil
//        catname.text = ""
//        var xgap = self.view.frame.size.width/2 - 40
//        var ygap = self.view.frame.size.height/2 - 50
//        newimageview = UIImageView(frame: CGRect(x: xgap, y: ygap, width: 80, height: 80))
//        newimageview.removeFromSuperview()
//        self.view.addSubview(newimageview)
        
        
        
        
        
        let last4 = String(x.categoryicon.suffix(3))
                print(last4)
        print(x.categoryicon)
                
                if last4 == "gif"
                {
                
               
                    downloadimagegif(url: x.categoryicon) { (status) in
//                        var newimageg : FLAnimatedImageView?
        //                customov.backgroundColor = status.getComplementaryForColor(color: (status.areaAverage()))
                        var gapx = (self.view.frame.size.width - (status.size.width))/2
                        var gapy = (self.view.frame.size.height - (status.size.height))/2
//                        var m = self.applygradient(a: a, b: b)
//                        self.view.layer.addSublayer(m)
                        self.view.layer.cornerRadius = 10
                        
                        self.iconimm.contentMode = .scaleAspectFit
//                         self.view.addSubview(newimageg!)
                        self.iconimm.animatedImage = status
                    
                        self.iconlbb.text = x.categoryname.capitalized
                       
                    }
                }
                else {
                    
                    if let im = DashboardViewController.categoryimageslist[x.id] as? UIImage {
                        self.iconimm.image = im
                        self.iconlbb.text = x.categoryname.capitalized

                    }
                    else {
                                           downloadimage(url: x.categoryicon) { (status) in
                                                            var newimageg : FLAnimatedImageView?
                                            //                customov.backgroundColor = status.getComplementaryForColor(color: (status.areaAverage()))
                                                            var gapx = (self.view.frame.size.width - (status.size.width))/2
                                                            var gapy = (self.view.frame.size.height - (status.size.height))/2
                        //                                    var m = self.applygradient(a: a, b: b)
                        //                                    self.view.layer.addSublayer(m)
                                                            self.view.layer.cornerRadius = 10
                                                      
                                                            self.iconimm.contentMode = .scaleAspectFit
                        //                                    self.view.addSubview(self.newimageview)
                                                            self.iconimm.image = status
                                                            DashboardViewController.categoryimageslist[x.id] = status
                                                            self.iconlbb.text = x.categoryname.capitalized


                                                        }
                    }
                           
             
        
        }
        
        
        
        
        
//        downloadimage(url: "http://thcoreapi.maraekat.com/Upload/Category/noicon.png") { (done) in
//
//            self.newimageview.image = done
////            self.view.backgroundColor = done.getComplementaryForColor(color: (done.areaAverage()))
//        }
        
       
        
    }
    
        
        typealias imgcompgif = (_ x : FLAnimatedImage) -> Void
          func downloadimagegif(url : String,p : @escaping imgcompgif)
             {
                 let url = URL(string: url)!
                 let imageData = try? Data(contentsOf: url)
                if let imageData3 = FLAnimatedImage(animatedGIFData: imageData) {
                    p(imageData3)
                }
                
              
             }
    
    func applygradient(a:UIColor , b:UIColor) -> CAGradientLayer
       {
           let gl = CAGradientLayer()
        gl.cornerRadius = 10
        gl.frame = self.bounds
        
        gl.masksToBounds = true
           gl.colors = [a.cgColor,b.cgColor]
           return gl
       }
    
    func hexStringToUIColor (hex:String) -> UIColor {
           var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

           if (cString.hasPrefix("#")) {
               cString.remove(at: cString.startIndex)
           }

           if ((cString.count) != 6) {
               return UIColor.gray
           }

           var rgbValue:UInt64 = 0
           Scanner(string: cString).scanHexInt64(&rgbValue)

           return UIColor(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: CGFloat(1.0)
           )
       }
    
    typealias imgcomp = (_ x : UIImage) -> Void
       func downloadimage(url : String,p : @escaping imgcomp)
       {
        print("I am downloading")
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
