//
//  FilterImageCollectionViewCell.swift
//  ShowTalent
//
//  Created by maraekat on 31/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FilterImageCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var filterimage: UIImageView!
    
    @IBOutlet weak var filtername: UILabel!
    
    func updatecell(oimg : UIImage,x:String)
    {
//        self.filtername.text = x
        self.filterimage.layer.cornerRadius = 10
        if x == "Normal" {
            self.filterimage.image = oimg
        }
        else {
            
            let cicontxt = CIContext(options: nil)
            let ci = CIImage(image: oimg)
            let filter = CIFilter(name: x)
            filter?.setDefaults()
            filter?.setValue(ci, forKey: kCIInputImageKey)
            let filteredimagedata = filter?.value(forKey: kCIOutputImageKey) as? CIImage
            let filteredImageRef = cicontxt.createCGImage(filteredimagedata!, from: filteredimagedata!.extent)
            self.filterimage.image = UIImage(cgImage: filteredImageRef!)
        }
        

        

    }
    
    
}
