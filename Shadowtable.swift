//
//  Shadowtable.swift
//  ShowTalent
//
//  Created by apple on 3/19/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable
class Shadowtable: UITableView {

@IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
        layer.cornerRadius = cornerRadius
    }
}

@IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
        layer.borderWidth = borderWidth
    }
}

@IBInspectable var borderColor: UIColor = UIColor.gray {
    didSet {
        layer.borderColor = borderColor.cgColor
    }
}

@IBInspectable var shadowColor: UIColor = UIColor.gray {
    didSet {
        layer.shadowColor = shadowColor.cgColor
    }
}
@IBInspectable var shadowOpacity: Float = 1.0 {
    didSet {
        layer.shadowOpacity = shadowOpacity
    }
}

@IBInspectable var shadowRadius: CGFloat = 1.0 {
    didSet {
        layer.shadowRadius = shadowRadius
    }
}

@IBInspectable var masksToBounds: Bool = true {
    didSet {
        layer.masksToBounds = masksToBounds
    }
}

@IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
    didSet {
        layer.shadowOffset = shadowOffset
    }
}


 }





@IBDesignable
class Shadowedbuttonview: UIView {

@IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
        layer.cornerRadius = cornerRadius
    }
}

@IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
        layer.borderWidth = borderWidth
    }
}

@IBInspectable var borderColor: UIColor = UIColor.gray {
    didSet {
        layer.borderColor = borderColor.cgColor
    }
}

@IBInspectable var shadowColor: UIColor = UIColor.gray {
    didSet {
        layer.shadowColor = shadowColor.cgColor
    }
}
@IBInspectable var shadowOpacity: Float = 1.0 {
    didSet {
        layer.shadowOpacity = shadowOpacity
    }
}

@IBInspectable var shadowRadius: CGFloat = 1.0 {
    didSet {
        layer.shadowRadius = shadowRadius
    }
}

@IBInspectable var masksToBounds: Bool = true {
    didSet {
        layer.masksToBounds = masksToBounds
    }
}

@IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
    didSet {
        layer.shadowOffset = shadowOffset
    }
}


 }


@IBDesignable
class Shadowedbutton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.gray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 1.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 1.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var masksToBounds: Bool = true {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    
}



@IBDesignable
class Shadowedtabbar: UITabBar {

@IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
        layer.cornerRadius = cornerRadius
    }
}

@IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
        layer.borderWidth = borderWidth
    }
}

@IBInspectable var borderColor: UIColor = UIColor.gray {
    didSet {
        layer.borderColor = borderColor.cgColor
    }
}

@IBInspectable var shadowColor: UIColor = UIColor.gray {
    didSet {
        layer.shadowColor = shadowColor.cgColor
    }
}
@IBInspectable var shadowOpacity: Float = 1.0 {
    didSet {
        layer.shadowOpacity = shadowOpacity
    }
}

@IBInspectable var shadowRadius: CGFloat = 1.0 {
    didSet {
        layer.shadowRadius = shadowRadius
    }
}

@IBInspectable var masksToBounds: Bool = true {
    didSet {
        layer.masksToBounds = masksToBounds
    }
}

@IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
    didSet {
        layer.shadowOffset = shadowOffset
    }
}


 }
