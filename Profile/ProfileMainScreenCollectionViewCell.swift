//
//  ProfileMainScreenCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 07/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class ProfileMainScreenCollectionViewCell: UICollectionViewCell {
    
    
    
    
    @IBOutlet weak var playbtn: UIButton!
    
    @IBOutlet weak var im: UIImageView!
    
    func update(x:videopost) {
        if x.type == "Image" {
            self.playbtn.isHidden = true
            self.downloadimage(url: x.activitypath) { (img) in
                self.im.image = img
            }
        }
        else if x.type  == "Video" {
            self.playbtn.isHidden = false

            self.downloadimage(url: x.thumbnail) { (img) in
                self.im.image = img
            }
        }
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
