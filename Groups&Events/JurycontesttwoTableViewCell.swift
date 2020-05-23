//
//  JurycontesttwoTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 05/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class JurycontesttwoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var poepleinterested: UILabel!
    
    @IBOutlet weak var contestdate: UILabel!
    
    @IBOutlet weak var contestinfo: UITextView!
    
    
    @IBOutlet weak var winnerprice: UILabel!
    
    @IBOutlet weak var noofwinners: UILabel!
    
    
    func update(x : strevent , y : Int)
    {
        self.poepleinterested.text = "\(y) people interested"
        
        var usefuldate = ""
          var usefultime = ""
          var d = x.conteststart
              if d != "" && d != " " {
                  var arr = d.components(separatedBy: "T")
                  if arr.count == 2 {
                      usefuldate = arr[0]
                      usefultime = arr[1]
                  }
                  else if d.count == 10 {
                      usefuldate = d
                  }
              }
          
        
          if usefuldate != "" {
              var darr = usefultime.components(separatedBy: ".")
              usefultime = darr[0]
              
          }
          
          var usefuldate1 = ""
            var usefultime1 = ""
             d = x.resulton
                if d != "" && d != " " {
                    var arr = d.components(separatedBy: "T")
                    if arr.count == 2 {
                        usefuldate1 = arr[0]
                        usefultime1 = arr[1]
                    }
                    else if d.count == 10 {
                        usefuldate1 = d
                    }
                }
            
          
            if usefuldate1 != "" {
                var darr = usefultime1.components(separatedBy: ".")
                usefultime1 = darr[0]
                
            }
        
        
        self.contestdate.text = "\(usefuldate) \(usefultime) to \(usefuldate1) \(usefultime1)"
        self.contestinfo.text = x.description
        self.winnerprice.text = x.contestprice
        self.noofwinners.text = x.resulttype
    }
    
    
}
