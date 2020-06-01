//
//  WinnerjuryTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 06/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class WinnerjuryTableViewCell: UITableViewCell {

    @IBOutlet weak var position: UIButton!
    
    @IBOutlet weak var name: UILabel!
    var isselected = false
    @IBOutlet weak var price: UILabel!
    var currentrank = 0
    var currentfeed : feeds?
    var takebackrankedfeed : ((_ x : Int , _ y : feeds) -> Void)?
    var a = 0
    var b = 0
    func updatecell(x : feeds , y : Int , z : String , a : Int , b : Int)
    {
        self.selectionStyle = .none
        self.a = a
        self.b = b
        currentfeed = x
        self.currentrank = y + 1
        self.position.layer.cornerRadius = 15
        
        self.name.text = x.profilename.capitalized
        self.price.text = z
        
    }
    
    func assingrank()
    {
        if b < a && isselected == false {
            self.position.setTitle("\(JurycontestViewController.currentshowingrank)", for: .normal)
            if let f = self.currentfeed as? feeds {
                self.isselected = true
                self.takebackrankedfeed!(JurycontestViewController.currentshowingrank,f)

            }
        }
    }
    
    
    @IBAction func btntapped(_ sender: Any) {

//        assingrank()
    }
    
    
}
