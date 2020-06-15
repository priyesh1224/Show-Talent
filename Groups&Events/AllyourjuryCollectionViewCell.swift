//
//  AllyourjuryCollectionViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/19/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class AllyourjuryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var juryimage: UIImageView!
    
    @IBOutlet weak var juryname: UILabel!
    
    func update(x : juryorwinner)
    {
        self.juryname.text = x.name.capitalized
        self.downloadimage(url: x.profile) { (im) in
            if let i = im as? UIImage {
                if let j = self.juryimage as? UIImageView {
                    j.image = i
                    j.layer.cornerRadius = 10
                }

            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.juryimage.image = #imageLiteral(resourceName: "cover-photo")
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
