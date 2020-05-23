//
//  FeedImageTableViewCell.swift
//  ShowTalent
//
//  Created by apple on 11/13/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class FeedImageTableViewCell: UITableViewCell {

    @IBOutlet weak var btn_favourites: UIButton!
    @IBOutlet weak var btn_comments: UIButton!
    @IBOutlet weak var btn_views: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        img_view.layer.borderWidth = 0.3
        img_view.layer.masksToBounds = false
        img_view.layer.borderColor = UIColor.white.cgColor
        img_view.layer.cornerRadius = img_view.frame.height/2
        img_view.clipsToBounds = true
        
    }
    @IBOutlet weak var img_view: UIImageView!
    
    @IBOutlet weak var btn_like: UIButton!
    
   
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var slider: ImageCarouselView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
