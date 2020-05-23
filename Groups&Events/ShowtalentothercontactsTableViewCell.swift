//
//  ShowtalentothercontactsTableViewCell.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class ShowtalentothercontactsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profimage: UIImageView!
    
    
    @IBOutlet weak var profname: UILabel!
    

    @IBOutlet weak var addbtn: UIButton!
    
    
    var addremove : ((_ x : othertalentcontact , _ y : Bool) -> Void)?
    
    var currentcontact : othertalentcontact?
    
    
    @IBAction func addbtnpressed(_ sender: UIButton) {
        if self.addbtn.titleLabel?.text == "Add" {
            self.addbtn.backgroundColor = UIColor.red
            self.addbtn.setTitle("Remove", for: .normal)
            addremove!(currentcontact ?? othertalentcontact(id: 0, contact: "", countrycode: "", profileimage: "", name: ""),true)
        }
        else {
            self.addbtn.backgroundColor = #colorLiteral(red: 0.3236835599, green: 0.3941466212, blue: 0.8482848406, alpha: 1)
            self.addbtn.setTitle("Add", for: .normal)
             addremove!(currentcontact ?? othertalentcontact(id: 0, contact: "", countrycode: "", profileimage: "", name: ""),false)
        }
    }
    
    
    func update(x : othertalentcontact , y :Bool)
    {
        self.addbtn.layer.cornerRadius = 10
        if y == false {
            self.addbtn.backgroundColor = UIColor.red
            self.addbtn.setTitle("Remove", for: .normal)
            
        }
        else {
            self.addbtn.backgroundColor = #colorLiteral(red: 0.3236835599, green: 0.3941466212, blue: 0.8482848406, alpha: 1)
            self.addbtn.setTitle("Add", for: .normal)
        }
        self.currentcontact = x
        self.profname.text = x.name.capitalized
        self.profimage.layer.cornerRadius = 30
        self.downloadimage(url: x.profileimage) { (im) in
            self.profimage.image = im
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
