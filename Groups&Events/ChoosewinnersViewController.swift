//
//  ChoosewinnersViewController.swift
//  ShowTalent
//
//  Created by maraekat on 27/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

struct members
{
    var name : String
    var id : String
    var profimage : String
}

class ChoosewinnersViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
    var winnerdetails : [Dictionary<String,Any>]?
    var allmembers  : [members] = []
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var titlescreen: UITextView!
    
    var totalwinners = 3
    var currentwinner = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dummydata()
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
        self.titlescreen.text = "Choose Rank 1"
//        collection.delegate = collection.dataSource as! UICollectionViewDelegate


        
    }
    
    func dummydata()
    {
        var x = members(name: "Priyesh", id: "xyz", profimage: "")
        self.allmembers.append(x)
        var y = members(name: "Xy", id: "axyz", profimage: "")
        self.allmembers.append(y)
        var z = members(name: "AB", id: "bxyz", profimage: "")
        self.allmembers.append(z)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allmembers.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winnercell", for: indexPath) as? WinnerCollectionViewCell {
            cell.updatecell(x: self.allmembers[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/3.5, height: self.view.frame.size.width/2.8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = #colorLiteral(red: 0.3537997603, green: 0.3623381257, blue: 0.8117030263, alpha: 1)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.clear

    }
    
    
    @IBAction func backbtnpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
  
    @IBAction func nextbtnpressed(_ sender: UIButton) {
        
        if currentwinner <= self.totalwinners {
            currentwinner = currentwinner + 1
            if currentwinner <= self.totalwinners
            {
                self.titlescreen.text = "Choose Rank \(currentwinner)"
            }
            for each in self.collection.indexPathsForSelectedItems! {
                if let cell = self.collection.cellForItem(at: each) as? WinnerCollectionViewCell {
                    if cell.rank.text == "" {
                        cell.rank.text = ("\(currentwinner - 1)")
                        var x : Dictionary<String,Any>  = ["ContestId" : 0 ,"WinnerUserId" : self.allmembers[each.row].id , "Position" : "\(currentwinner - 1)"]
                        self.winnerdetails?.append(x)
                        
                    }
                }
            }
 
        }
        else {
            print("Done uploading")
        }
    }
    
}
