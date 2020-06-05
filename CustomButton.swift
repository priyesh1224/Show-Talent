//
//  CustomButton.swift
//  ShowTalent
//
//  Created by maraekat on 06/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable public var size : CGFloat = 28  {
        didSet {
            self.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: size)
        }
    }

   override func awakeFromNib() {
    self.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 22)
      }


}


class MinorButton: UIButton {
    
    @IBInspectable public var size : CGFloat = 28  {
        didSet {
            self.titleLabel?.font = UIFont(name: "NeusaNextStd-Light", size: size)
        }
    }

   override func awakeFromNib() {
    self.titleLabel?.font = UIFont(name: "NeusaNextStd-Light", size: 12)
      }


}


class UltraMinorButton: UIButton {
    
    @IBInspectable public var size : CGFloat = 7  {
        didSet {
            self.titleLabel?.font = UIFont(name: "NeusaNextStd-Light", size: size)
        }
    }

   override func awakeFromNib() {
    self.titleLabel?.font = UIFont(name: "NeusaNextStd-Light", size: 6)
      }


}


