//
//  DashboardCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 16/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import FLAnimatedImage

class DashboardCollectionViewCell: UICollectionViewCell {
    
    
    var dummytrendingimages = ["contest-ad","contest2","contest3","event-ad","event-ad2","event-ad3"]
    
    var dummyeventimages = ["ev5","ev6"]
    
    @IBOutlet weak var outerview: UIView!
    @IBOutlet weak var bannerimage: UIImageView!
    func updatebanner(c : String, x : strcategory , y : strtrending ,z : strevent, a : UIColor ,b :UIColor , number : Int ) {
        print("The category is \(c)")
        var customov = UIView(frame: CGRect(x: 0, y: 0, width: (self.frame.size.width), height: (self.frame.size.height)))
        customov.layer.cornerRadius = 10
        self.addSubview(customov)
        var newimage : UIImageView?
        self.layer.cornerRadius = 10
        if(c == "categories") {
            
            let last4 = String(x.categoryicon.suffix(3))
            print(last4)
            
            if last4 == "gif"
            {
            
           
                downloadimagegif(url: x.categoryicon) { (status) in
                    var newimageg : FLAnimatedImageView?
    //                customov.backgroundColor = status.getComplementaryForColor(color: (status.areaAverage()))
                    var gapx = (customov.frame.size.width - (status.size.width))/2
                    var gapy = (customov.frame.size.height - (status.size.height))/2
                    var m = self.applygradient(a: a, b: b)
                    customov.layer.addSublayer(m)
                    customov.layer.cornerRadius = 10
                    newimageg = FLAnimatedImageView(frame: CGRect(x: 25, y: 40, width: self.frame.size.width - 50, height: 65 ))
                    newimageg?.contentMode = .scaleAspectFit
                     customov.addSubview(newimageg!)
                    newimageg?.animatedImage = status
                    var profilename = UITextView(frame: CGRect(x: 10, y: customov.frame.size.height - 60, width:  (customov.frame.size.width  ?? 150) - 20, height: 40))
                    //             profilename.numberOfLines = 2
                    profilename.text = x.categoryName.capitalized
                                profilename.backgroundColor = UIColor.clear
                    profilename.textAlignment = .center
                    profilename.isEditable = false
                                profilename.font = UIFont.boldSystemFont(ofSize: 14)
                                profilename.textColor = UIColor.white
                    customov.addSubview(profilename)

                }
            }
            else {
                
                
                
                if let im = DashboardViewController.categoryimageslist[x.id] as? UIImage {
                    var m = self.applygradient(a: a, b: b)
                                                   customov.layer.addSublayer(m)
                                                   customov.layer.cornerRadius = 10
                                                   newimage = FLAnimatedImageView(frame: CGRect(x: 25, y: 40, width: self.frame.size.width - 50, height: 65 ))
                                                   newimage?.contentMode = .scaleAspectFit
                                                    customov.addSubview(newimage!)
                                                   newimage?.image = im
                                                   var profilename = UITextView(frame: CGRect(x: 10, y: customov.frame.size.height - 60, width:  (customov.frame.size.width  ?? 150) - 20, height: 40))
                                                   //             profilename.numberOfLines = 2
                                                   profilename.text = x.categoryName.capitalized
                                                               profilename.backgroundColor = UIColor.clear
                                                   profilename.textAlignment = .center
                                                   profilename.isEditable = false
                                                               profilename.font = UIFont.boldSystemFont(ofSize: 14)
                                                               profilename.textColor = UIColor.white
                                                   customov.addSubview(profilename)


                }
                else {
                       
                            downloadimage(url: x.categoryicon) { (status) in
                                var newimageg : FLAnimatedImageView?
                //                customov.backgroundColor = status.getComplementaryForColor(color: (status.areaAverage()))
                                var gapx = (customov.frame.size.width - (status.size.width))/2
                                var gapy = (customov.frame.size.height - (status.size.height))/2
                                var m = self.applygradient(a: a, b: b)
                                customov.layer.addSublayer(m)
                                customov.layer.cornerRadius = 10
                                newimage = FLAnimatedImageView(frame: CGRect(x: 25, y: 40, width: self.frame.size.width - 50, height: 65 ))
                                newimage?.contentMode = .scaleAspectFit
                                 customov.addSubview(newimage!)
                                newimage?.image = status
                                DashboardViewController.categoryimageslist[x.id] = status
                                var profilename = UITextView(frame: CGRect(x: 10, y: customov.frame.size.height - 60, width:  (customov.frame.size.width  ?? 150) - 20, height: 40))
                                //             profilename.numberOfLines = 2
                                profilename.text = x.categoryName.capitalized
                                            profilename.backgroundColor = UIColor.clear
                                profilename.textAlignment = .center
                                profilename.isEditable = false
                                            profilename.font = UIFont.boldSystemFont(ofSize: 14)
                                            profilename.textColor = UIColor.white
                                customov.addSubview(profilename)

                            }
                }
            }
                      
            
        }
        else if c == "events" {
            
            newimage = UIImageView(frame: CGRect(x: 0, y: 0, width: customov.frame.size.width, height: customov.frame.size.height * 0.8 ))
            var m = self.applygradient(a: a, b: b)
            customov.layer.insertSublayer(m, at: 0)

            newimage?.contentMode = .scaleAspectFit
             customov.addSubview(newimage!)
            if number < self.dummyeventimages.count {
                newimage?.image = UIImage(named: self.dummyeventimages[number])
            }
            else {
            newimage?.image = #imageLiteral(resourceName: "music")
            }
            newimage?.layer.cornerRadius = 10
            newimage?.clipsToBounds = true
            
     
            
            
            
            var profilename = UITextView(frame: CGRect(x: 10, y: customov.frame.size.height * 0.9, width:  (newimage?.frame.size.width ?? 150) - 10, height: 50))
//             profilename.numberOfLines = 2
            profilename.text = z.contestname.capitalized
            profilename.backgroundColor = UIColor.clear
            
            profilename.font = UIFont.boldSystemFont(ofSize: 16)
            profilename.textColor = UIColor.black
            customov.addSubview(profilename)
            
            var hobby = UITextView(frame: CGRect(x: 10, y: 115, width: (newimage?.frame.size.width ?? 150) - 10, height: 20))
//             hobby.numberOfLines = 4
            hobby.backgroundColor = UIColor.clear
            hobby.text = z.description.capitalized
            hobby.font = UIFont(name: "NeusaNextStd-Light", size: 14)
            hobby.textColor = UIColor.white
            newimage?.addSubview(hobby)
            
            var join = MinorButton(frame: CGRect(x: 10, y: 150, width: 70, height: 30))
            join.backgroundColor = UIColor.clear
            join.setTitle("Join", for: .normal)
            join.setTitleColor(UIColor.white, for: .normal)
            join.layer.cornerRadius = 10
            join.layer.borderWidth = 2
            join.layer.borderColor = UIColor.white.cgColor
            newimage?.addSubview(join)
        }
        else
        {
            
            
            if let im =  DashboardViewController.trendingimageslist[y.thumbnail] as? UIImage{
                                newimage = UIImageView(frame: CGRect(x: 0, y: 0, width: customov.frame.size.width, height: customov.frame.size.height * 0.85 ))
                                 customov.addSubview(newimage!)
                                if number < self.dummytrendingimages.count {
                                    newimage?.image = UIImage(named: self.dummytrendingimages[number])
                                }
                                else {
                                    newimage?.image = im
                                }
                                
                                newimage?.layer.cornerRadius = 10
                                newimage?.clipsToBounds = true
                                
                                var profilepicture = UIImageView(frame: CGRect(x: 10, y:95, width: 50, height: 50))
                                profilepicture.layer.cornerRadius = 25
                                profilepicture.layer.borderColor = UIColor.white.cgColor
                                profilepicture.layer.borderWidth = 2
                                profilepicture.clipsToBounds = true
                                newimage?.addSubview(profilepicture)
                                self.downloadimage(url: y.profileimage) { (done) in
                                    profilepicture.image = done
                                }
                                
                                
                                var profilename = UITextView(frame: CGRect(x: 70, y: 90, width:  (newimage?.frame.size.width ?? 150) - 70, height: 80))
                //                 profilename.numberOfLines = 2
                                profilename.backgroundColor = UIColor.clear
                                profilename.text = y.profilename.capitalized
                                profilename.font = UIFont.boldSystemFont(ofSize: 18)

                                profilename.textColor = UIColor.white
                                newimage?.addSubview(profilename)
                                
                                var hobby = UITextView(frame: CGRect(x: 70, y: 113, width:  (newimage?.frame.size.width ?? 150) - 70, height: 80))
                //                hobby.numberOfLines = 4
                                hobby.font = UIFont.boldSystemFont(ofSize: 16)
                                hobby.backgroundColor = UIColor.clear

                                hobby.text = y.title.capitalized
                                
                                hobby.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                                newimage?.addSubview(hobby)
            }
            else {
                
            

            downloadimage(url: y.thumbnail) { (st) in
                DashboardViewController.trendingimageslist[y.thumbnail] = st

//                customov.backgroundColor = st.getComplementaryForColor(color: (st.areaAverage()))
                newimage = UIImageView(frame: CGRect(x: 0, y: 0, width: customov.frame.size.width, height: customov.frame.size.height * 0.85 ))
                 customov.addSubview(newimage!)
                if number < self.dummytrendingimages.count {
                    newimage?.image = UIImage(named: self.dummytrendingimages[number])
                }
                else {
                    newimage?.image = st
                }
                
                newimage?.layer.cornerRadius = 10
                newimage?.clipsToBounds = true
                
                var profilepicture = UIImageView(frame: CGRect(x: 10, y:95, width: 50, height: 50))
                profilepicture.layer.cornerRadius = 25
                profilepicture.layer.borderColor = UIColor.white.cgColor
                profilepicture.layer.borderWidth = 2
                profilepicture.clipsToBounds = true
                newimage?.addSubview(profilepicture)
                self.downloadimage(url: y.profileimage) { (done) in
                    profilepicture.image = done
                }
                
                
                var profilename = UITextView(frame: CGRect(x: 70, y: 90, width:  (newimage?.frame.size.width ?? 150) - 70, height: 80))
//                 profilename.numberOfLines = 2
                profilename.backgroundColor = UIColor.clear
                profilename.text = y.profilename.capitalized
                profilename.font = UIFont.boldSystemFont(ofSize: 18)

                profilename.textColor = UIColor.white
                newimage?.addSubview(profilename)
                
                var hobby = UITextView(frame: CGRect(x: 70, y: 113, width:  (newimage?.frame.size.width ?? 150) - 70, height: 80))
//                hobby.numberOfLines = 4
                hobby.font = UIFont.boldSystemFont(ofSize: 16)
                hobby.backgroundColor = UIColor.clear

                hobby.text = y.title.capitalized
                
                hobby.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                newimage?.addSubview(hobby)
                
            }
        }
            
        }
        
       
        self.bannerimage.isHidden = true
        self.outerview.isHidden = true
        self.outerview.layer.cornerRadius = 10
        
      
        
     
 
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
        gl.frame = self.bounds
        gl.colors = [a.cgColor,b.cgColor]
        return gl
    }
    
    typealias imgcomp = (_ x : UIImage) -> Void
    func downloadimage(url : String,p : @escaping imgcomp)
    {
        print("I am downloading")
        var receivedimage : UIImage?
        Alamofire.request(url, method:.get).responseData { (rdata) in
            if let d = rdata.data {
                if let im = UIImage(data: d) as? UIImage {
                    p(im)
                }
                
            }
            
        }

    }
  
}

