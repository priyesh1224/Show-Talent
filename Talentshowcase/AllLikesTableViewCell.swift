//
//  AllLikesTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 27/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class AllLikesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgeee: UIImageView!
    
    @IBOutlet weak var namee: UILabel!
    
    func updatecell(x:like) {
        self.namee.text = x.profilename.capitalized
        downloadprofileimage(url: x.profileimage) { (ime) in
            self.imgeee.image = ime
        }
    }
    
    
    func downloadprofileimage(url:String,completion : @escaping (UIImage?) -> Void) {
        if let cachedimage = Talentshowcase2ViewController.cachepostprofileimage.object(forKey: url as NSString) {
            completion(cachedimage)
        }
        else {
            Alamofire.request(url, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                if responseData.data != nil {
            Talentshowcase2ViewController.cachepostprofileimage.setObject(UIImage(data: responseData.data!)!, forKey: url as NSString)
                completion(UIImage(data: responseData.data!))
                }
            })
        }
    }
}
