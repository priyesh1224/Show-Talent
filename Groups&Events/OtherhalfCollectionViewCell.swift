//
//  OtherhalfCollectionViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class OtherhalfCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var im: UIImageView!
    
    @IBOutlet var lb: UILabel!
    
    
    func update( x : languagewiseevent)
    {
        self.im.image = #imageLiteral(resourceName: "music")
        self.downloadimage(url: x.imagepath) { (imm) in
            if let ime = imm as? UIImage {
                self.im.image = ime
            }
        }
        self.lb.text = "\(x.heading)"
        self.im.layer.cornerRadius = 5
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
