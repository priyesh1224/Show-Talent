//
//  JuryprofileViewController.swift
//  ShowTalent
//
//  Created by maraekat on 05/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class JuryprofileViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
 
    
    var currentjury : juryorwinner?
    
    @IBOutlet weak var upperview: UIView!
    
    @IBOutlet weak var upperviewheight: NSLayoutConstraint!
    
    @IBOutlet weak var juryimage: UIImageView!
    
    @IBOutlet weak var juryname: UILabel!
    
    @IBOutlet weak var followmebtn: UIButton!
    

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var jurynametwo: UILabel!
    
    @IBOutlet weak var juryexperience: UILabel!
    
    @IBOutlet weak var juryabout: UITextView!
    
    @IBOutlet weak var editprofilebtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.upperviewheight.constant = self.view.frame.size.height/3
        self.followmebtn.layer.cornerRadius = 5
        self.editprofilebtn.layer.cornerRadius = self.editprofilebtn.frame.size.height/2
        self.currentjury = juryorwinner(id: 1, userid: "df8524d3-0e65-47fa-acee-4e37d88208c3", name: "Dharmesh Sharma", profile: "http://thcoreapi.maraekat.comUpload/Profile/df8524d3-0e65-47fa-acee-4e37d88208c3/df8524d3-0e65-47fa-acee-4e37d88208c3.jpg")
        
        self.juryname.text = self.currentjury?.name.capitalized
        self.jurynametwo.text = self.currentjury?.name.capitalized
        self.downloadimage(url: self.currentjury!.profile) { (im) in
            self.juryimage.image = im
        }
        
        var m = self.applygradient(a: #colorLiteral(red: 0.2274509804, green: 0.6235294118, blue: 0.7294117647, alpha: 1), b: #colorLiteral(red: 0.2156862745, green: 0.2823529412, blue: 0.4980392157, alpha: 1))
        self.upperview.layer.insertSublayer(m, at: 0)
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 5
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jurycontest", for: indexPath) as? JuryprofileCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 120)
    }
    
    func applygradient(a:UIColor , b:UIColor) -> CAGradientLayer
          {
              let gl = CAGradientLayer()
            gl.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.upperviewheight.constant)
              gl.colors = [a.cgColor,b.cgColor]
              return gl
          }
    
    @IBAction func editprofilebtnpressed(_ sender: Any) {
    }
    
   
    @IBAction func followmepressed(_ sender: Any) {
    }
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
