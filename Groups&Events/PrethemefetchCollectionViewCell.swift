//
//  PrethemefetchCollectionViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/8/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class PrethemefetchCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var outerview: UIView!
    
    @IBOutlet weak var imm: UIImageView!
    
    
    @IBOutlet weak var viewbtn: UIButton!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let i = imm as? UIImageView {
            i.image = #imageLiteral(resourceName: "cover-photo")
        }
    }
    
    
    func update(x: pretheme)
    {
        self.outerview.layer.cornerRadius = 20
        self.outerview.clipsToBounds = true
        self.downloadimage(url: x.contestimage) { (im) in
            if let i  = im as? UIImage {
                self.imm.image = i
            }
        }
    }
    
    
    @IBAction func viewtapped(_ sender: Any) {
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
