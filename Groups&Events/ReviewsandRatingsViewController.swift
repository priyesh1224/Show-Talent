//
//  ReviewsandRatingsViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/18/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


struct review
{
    var id : Int
    var contestid : Int
    var postid : Int
    var userid : String
    var review : String
    var rating : Int
    var reviewdate : String
    var name : String
    var profileimage : String
}

class ReviewsandRatingsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    
    
    
    
    @IBOutlet weak var notificationindicator: UIView!
    
    
    @IBOutlet weak var star1: UIButton!
    
    @IBOutlet weak var star2: UIButton!
    
    
    @IBOutlet weak var star3: UIButton!
    
    
    @IBOutlet weak var star4: UIButton!
    
    
    @IBOutlet weak var star5: UIButton!
    
    
    @IBOutlet weak var reviewfield: UITextField!
    
    
    @IBOutlet weak var reviewsubmit: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var allreviews : [review] = []
    
    var postid = 1027
    var rating = 0
    var contestid = 160
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationindicator.layer.cornerRadius = 10
        table.delegate = self
        table.dataSource = self
        self.reviewsubmit.layer.cornerRadius = 10
        self.fetchreviews(pg: 0)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func star1tapped(_ sender: Any) {
        rating = 1
        star1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star2.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        star3.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        star4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        star5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
    }
    
    
    @IBAction func star2tapped(_ sender: Any) {
        rating = 2
        star1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star3.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        star4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        star5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        
    }
    
    
    @IBAction func star3tapped(_ sender: Any) {
        rating = 3
        star1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star4.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        star5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
        
    }
    
    
    
    @IBAction func star4tapped(_ sender: Any) {
        rating = 4
        star1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star5.setImage(#imageLiteral(resourceName: "ic_star_border_24px"), for: .normal)
    }
    
    
    @IBAction func star5tapped(_ sender: Any) {
        rating = 5
        star1.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star2.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star3.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star4.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
        star5.setImage(#imageLiteral(resourceName: "ic_star_24px"), for: .normal)
    }
    
    

  
    @IBAction func backbtntapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitbtntapped(_ sender: Any) {
        
        if rating == 0 {
            self.present(customalert.showalert(x: "Please select ratings"), animated: true, completion: nil)
        }
        else
        {
            if let t = reviewfield.text as? String
            {
                var name = UserDefaults.standard.value(forKey: "name") as! String
                var pim = UserDefaults.standard.value(forKey: "profileimage") as! String
                
                var userid = UserDefaults.standard.value(forKey: "refid") as! String
                var url = Constants.K_baseUrl + Constants.postreview
                var params : Dictionary<String,Any> = ["ContestId": self.contestid,
                              "PostId": self.postid,
                              "UserId": userid,
                              "Review": t,
                              "Rating": self.rating]
                print(url)
                print(params)
                var r = BaseServiceClass()
                r.postApiRequest(url: url, parameters: params) { (response, err) in
                    if let res = response?.result.value as? Dictionary<String,Any> {
                        if let code = res["ResponseStatus"] as? Int {
                            if code == 0 {
                                var nw = review(id: 0, contestid: self.contestid, postid: self.postid, userid: userid, review: t, rating: self.rating, reviewdate: Date().description, name: name, profileimage: pim)
                                self.allreviews.insert(nw, at: 0)
                                self.table.reloadData()
                            }
                            else {
                                 self.present(customalert.showalert(x: "Could not add review. Try again !"), animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allreviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reviewcell", for: indexPath) as? ReviewandRatingsTableViewCell {
            
            cell.posting = { a in
                if a  {
                    self.spinner.isHidden = false
                    self.spinner.startAnimating()
                }
                else {
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                }
            }
            
            cell.popup = { a in
                self.present(customalert.showalert(x: a), animated: true, completion: nil)
            }
            
            cell.update(x : self.allreviews[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var tc = self.allreviews[indexPath.row].review.count
        var nl = CGFloat(tc/55)
        if nl < 1 {
            nl = 1.5
        }
        return (50.0 * nl + 120)
        
        
        
    }
    
    
    func fetchreviews(pg : Int)
    {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        var url = "\(Constants.K_baseUrl)\(Constants.fetchreviews)?postId=\(self.postid)"
        print(url)
        var params : Dictionary<String,Int> = ["Page" : pg , "PageSize" : 10]
        print(params)

        var r = BaseServiceClass()
        r.postApiRequest(url: url, parameters: params) { (response, err) in
            print("hello")
            if let res = response?.result.value as? Dictionary<String,Any> {
                print(res)
                if let rs = res["ResponseStatus"] as? Int {
                    if rs == 0 {
                        
                        if let data = res["Results"] as? Dictionary<String,Any> {
                            if let innerdata = data["Data"] as? [Dictionary<String,Any>] {
                                
                                for each in innerdata {
                                    var i = 0
                                    var c = 0
                                    var p = 0
                                    var u = ""
                                    var r = ""
                                    var ra = 0
                                    var rd = ""
                                    var nm = ""
                                    var pi = ""
                                    
                                    if let a = each["ID"] as? Int {
                                        i = a
                                    }
                                    if let a = each["ContestId"] as? Int {
                                        c = a
                                    }
                                    if let a = each["PostId"] as? Int {
                                        p = a
                                    }
                                    if let a = each["UserId"] as? String {
                                        u = a
                                    }
                                    if let a = each["Review"] as? String {
                                        r = a
                                    }
                                    if let a = each["Rating"] as? Int {
                                        ra = a
                                    }
                                    if let a = each["ReviewDate"] as? String {
                                        rd = a
                                    }
                                    if let a = each["Name"] as? String {
                                        nm = a
                                    }
                                    if let a = each["ProfileImage"] as? String {
                                        pi = a
                                    }
                                    
                                    var x = review(id: i, contestid: c, postid: p, userid: u, review: r, rating: ra, reviewdate: rd, name: nm, profileimage: pi)
                                    self.allreviews.append(x)
                                    
                                }
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.table.reloadData()
                            }
                        }
                        
                    }
                    else {
                        self.present(customalert.showalert(x: "Could not fetch reviews"), animated: true, completion: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    }
                }
            }
        }
        
    }
    
    
}
