//
//  FilterImageViewController.swift
//  ShowTalent
//
//  Created by maraekat on 31/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FilterImageViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var originalimage : UIImage?
    var filteredimage : UIImage?
  
    
    var allfilters : [String] = ["Normal","CIPhotoEffectChrome",
    "CIPhotoEffectFade",
    "CIPhotoEffectInstant",
    "CIPhotoEffectNoir",
    "CIPhotoEffectProcess",
    "CIPhotoEffectTonal",
    "CIPhotoEffectTransfer",
    "CISepiaTone"]
    
    
    @IBOutlet weak var mainimage: UIImageView!
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    var filterdone : ((_ im : UIImage) -> Void)?
    
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.originalimage = #imageLiteral(resourceName: "placeholder2")
        self.mainimage.image = originalimage
        self.mainimage.layer.cornerRadius = 10
        collection.delegate = self
        collection.dataSource = self
        collection.delegate = collection.dataSource as! UICollectionViewDelegate
        collection.reloadData()

        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterImageCollectionViewCell {
            self.mainimage.image = cell.filterimage.image
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.size.width/2, height: self.collection.frame.size.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.allfilters.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let og = self.originalimage as? UIImage {
            
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filtercell", for: indexPath) as? FilterImageCollectionViewCell {
            cell.updatecell(oimg: og, x: self.allfilters[indexPath.row])
            return cell
        }
        }
        
          return UICollectionViewCell()
      }
    
    
    @IBAction func cancelpressed(_ sender: UIButton) {
        self.filterdone!(self.originalimage!)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func nextpressed(_ sender: UIButton) {
        self.filteredimage = self.mainimage.image
        self.filterdone!(self.filteredimage!)
        dismiss(animated: true, completion: nil)

    }
    

}
