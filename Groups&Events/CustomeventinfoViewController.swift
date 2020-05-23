//
//  CustomeventinfoViewController.swift
//  ShowTalent
//
//  Created by apple on 3/18/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class CustomeventinfoViewController: UIViewController , UIScrollViewDelegate  {

    @IBOutlet var cont: UIView!
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet var scrollwidth: NSLayoutConstraint!
    
    @IBOutlet var scrollheight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var eventimage: UIImageView!
    
    @IBOutlet weak var eventname: Customlabel!
    
    
    @IBOutlet weak var eventwhen: UITextView!
    
    
    @IBOutlet weak var category: UITextView!
    
    
    @IBOutlet weak var agelimit: UITextView!
    
    
    @IBOutlet weak var eventwhere: UITextView!
    
    @IBOutlet weak var eventabout: UITextView!
    
    
    @IBOutlet weak var eventlanguages: UITextView!
    
    
    @IBOutlet weak var eventduration: UITextView!
    
    
    @IBOutlet weak var artistimage: UIImageView!
    
    
    @IBOutlet weak var artistname: UITextView!
    
    
    @IBOutlet weak var artistoccupation: UITextView!
    
    @IBOutlet weak var fee: Customlabel!
    
    
    @IBOutlet weak var tandcpopup: UIView!
    
    
    
    @IBOutlet weak var tandc: UITextView!
    
    
    
    
    
    
    func setupcontents()
    {
        self.eventname.text = self.gotevent?.heading.capitalized
        self.eventwhen.text = self.gotevent?.todate
        self.category.text = self.gotevent?.category.capitalized
        self.agelimit.text = self.gotevent?.agelimit
        
        self.tandcpopup.isHidden = true

        self.tandc.text  = self.gotevent?.termsandconditions
        
        var a  = ""
        var b = ""
        var c  = "'"
        
        if let i = self.gotevent?.address1 {
            a = i
        }
        if let i = self.gotevent?.address2 {
            b = i
        }
        if let i = self.gotevent?.city {
            c = i
        }
        self.eventwhere.text  = "\(a.capitalized) , \(b.capitalized) ,\(c.capitalized)"
        self.eventabout.text = self.gotevent?.about.capitalized
        self.eventlanguages.text = self.gotevent?.langauge
        self.eventduration.text = self.gotevent?.eventtime
        self.artistname.text = self.gotevent?.artist.capitalized
        if let f = self.gotevent?.fee {
            self.fee.text = "Rs \(f)"
        }
        
        self.downloadimage(url: self.gotevent?.imagepath ?? "") { (im) in
            if let imm = im as? UIImage {
                self.eventimage.image = im
            }
        }

    }
    
    
    
    
    typealias imgcomp = (_ x : UIImage) -> Void
    func downloadimage(url : String,p : @escaping imgcomp)
    {
        var uurl = "http://thcoreapi.maraekat.com/Upload/Category/noicon.png"
        var receivedimage : UIImage?
        if let u = url as? String {
            Alamofire.request(u, method:.get).responseData { (rdata) in
                if let d = rdata.data as? Data {
                    if let i = UIImage(data: d) as? UIImage {
                        p(i)
                        
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    var gotevent : languagewiseevent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        var scrollWidth = self.view.frame.size.width
        var scrollHeight = self.view.frame.size.height - 64
        view.addSubview(scroll)

        scroll.isScrollEnabled = true
//        scrollwidth.constant = scrollWidth
//        scrollheight.constant = scrollHeight
        scroll.contentSize = CGSize(width: scrollWidth, height: 4300)
        setupcontents()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {

           self.scroll.delegate = self
           scroll.isPagingEnabled = true
           scroll.showsHorizontalScrollIndicator = false
           scroll.showsVerticalScrollIndicator = false
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 4300)
        self.scroll.isScrollEnabled = true
        
       }
    
    
    @IBAction func termsandconditionspressed(_ sender: Any) {
        self.tandcpopup.isHidden = false
        self.scroll.isHidden = true

    }
    
    
    
    
    @IBAction func tandcclose(_ sender: Any) {
        self.tandcpopup.isHidden = true
        self.scroll.isHidden = false

    }
    
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    

}
