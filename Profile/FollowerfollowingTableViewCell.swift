//
//  FollowerfollowingTableViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 18/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
struct follower
{
    var username : String
    var userid : String
    var relation : String
}
struct following
{
    var username : String
    var userid : String
    var relation : String
}
struct filterednames {
    var username : String
    var userid : String
    var relation : String
}

class FollowerfollowingTableViewCell: UITableViewCell {

  @IBOutlet weak var followericon: UIImageView!
    
    @IBOutlet weak var followername: UILabel!
    
    
    @IBOutlet weak var followeruserid: UILabel!
    
    @IBOutlet weak var relation: UILabel!
    
    @IBOutlet weak var indicator: UIView!
    
    func updatecell(x : follower) {
        self.followername.text = x.username.capitalized
       
        self.followeruserid.text = x.userid
        indicator.layer.cornerRadius = 10
         self.relation.text = "Follower"
        
    }
    func updatecell2(x : following) {
        self.followername.text = x.username.capitalized
       
        self.followeruserid.text = x.userid
        indicator.layer.cornerRadius = 10
        self.relation.text = "Following"
        
    }
    
    func updatecell3(x : filterednames) {
        self.followername.text = x.username.capitalized
       
        self.followeruserid.text = x.userid
        indicator.layer.cornerRadius = 10
        self.relation.text = "\(x.relation.capitalized)"
        
    }

}
