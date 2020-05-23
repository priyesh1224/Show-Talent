//
//  TalentshowcaseViewController.swift
//  ShowTalent
//
//  Created by maraekat on 20/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TalentshowcaseViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
  
    

    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    @IBOutlet weak var screentitle: UILabel!
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var collectionheight: NSLayoutConstraint!
    
    @IBOutlet weak var plusbuttoncover: UIView!
    
    @IBOutlet weak var plusbutton: UIButton!
    
    
    @IBOutlet weak var collectionlayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()

//        self.collectionheight.constant = self.view.frame.size.height/4.5
        self.collection.delegate = self
        self.collection.dataSource = self
       
        self.collection.reloadData()
        self.table.delegate = self
        self.table.dataSource = self
        self.table.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.table.layoutSubviews()
        self.table.reloadData()
    }
    
    func setupview()
    {
        
        
        self.notificationindicator.layer.cornerRadius = 10
        self.plusbuttoncover.layer.cornerRadius = 55
        self.plusbutton.layer.cornerRadius = 37
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "talentcollection", for: indexPath) as? TalentshowcaseCollectionViewCell {
            cell.updatecell()
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2, height: self.view.frame.size.height / 2)
    }

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 5
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "talenttable", for: indexPath) as? TalentshowcaseTableViewCell {
            var x = videopost(activityid: 0, activitypath: "", category: "", descrip: "", id: "", images: [], like: 0, likebyme:[], profileimg: "", profilename: "", publichon: "", title: "", type: "", userid: "", views: 0, comments: [], thumbnail: "",status: false)
            cell.update(x:x)
            return cell
        }
        return UITableViewCell()
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var ht = UIImage(named: "music")?.size.height ?? self.view.frame.size.height/3
        return ht * 0.7
    }


}
