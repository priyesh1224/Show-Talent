//
//  Customtable2TableViewCell.swift
//  ShowTalent
//
//  Created by apple on 3/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class Customtable2TableViewCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    

    @IBOutlet var colle: UICollectionView!
    var layout : UICollectionViewFlowLayout?
    var passbackevent : ((_ : languagewiseevent) -> Void)?
    
    var alldata = [languagewiseevent]()
    var currenttappedveent : languagewiseevent?
    
    
    func update()
    {
        colle.delegate = self
        colle.dataSource = self
        colle.reloadData()
        
        layout = UICollectionViewFlowLayout()
               
        CustomeventViewController.passdata = { a in
            print("Rechead here")
            print(a)
            self.alldata = a
            self.colle.reloadData()
            
        }
               
                   
                   if let l = layout {
                    l.scrollDirection = .vertical
                    l.itemSize = CGSize(width: self.frame.size.width / 3.2, height: 220)
                       colle.reloadData()
                       colle.collectionViewLayout = l
           
                   }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return self.alldata.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherce", for: indexPath) as? OtherhalfCollectionViewCell {
            cell.update(x : self.alldata[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
        
       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currenttappedveent = self.alldata[indexPath.row]
        if let c  = self.currenttappedveent {
            self.passbackevent!(c)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width / 3.2, height: 220)
    }
    
}
