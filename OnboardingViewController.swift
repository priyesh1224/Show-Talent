//
//  OnboardingViewController.swift
//  ShowTalent
//
//  Created by apple on 10/29/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
   // var skipbtn : UIButton?
    
     var imgs = ["one-plus.jpg","one-plus2.jpg","one-plus3.jpg", "one-plus4.jpg"]
    
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.layoutIfNeeded()
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//          skipbtn =  UIButton()
//        skipbtn!.frame = CGRect(x: 80, y: 80, width: 100, height: 50)
//        skipbtn!.setTitle("SKIP", for: .normal)
//        skipbtn!.setTitleColor(.black, for: .normal)
 //  self.view.addSubview(skipbtn)
        
        for index in 0..<imgs.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
//            if index > 1 {
//                skipbtn.isHidden = true
//            }
            let slide = UIView(frame: frame)
            
            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:scrollview.frame.width  ,height:scrollview.frame.height)
            
            imageView.contentMode = .scaleToFill
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2)
            
//            if index == 3
//            {
            
            let view1  = UIView(frame: CGRect(x: 0, y: self.scrollview.frame.height-150, width: self.scrollview.frame.width, height: 150))
        //     var myView = UIView(frame: (
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            
                view1.addGestureRecognizer(tap)
                view1.backgroundColor = .gray
                view1.isUserInteractionEnabled = true
            
            
            let skipbtn = UIButton(frame: CGRect(x: self.scrollview.frame.size.width-120, y: self.scrollview.frame.origin.y+60, width: 80, height: 30))
            skipbtn.setTitle("Skip", for: .normal)
            skipbtn.setTitleColor(.black, for: .normal)
            
         //   skipbtn.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
            
            
            
            
            
              //  self.view.addSubview(view1)
                
                // function which is triggered when handleTap is called
//            }
           
//            var myView = UIView(frame: CGRectMake(100, 100, 100, 100))
//
//            self.view.addSubview(myView)
//
//            let gesture = UITapGestureRecognizer(target: self, action: "someAction:")
//
//            let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
//            self.myView.addGestureRecognizer(gesture)

          
//            slide.addSubview(txt1)
            
            
            
            if index == 0
            {
                slide.addSubview(skipbtn)
            }
                   if index == 3
                   {
                      //  imageView.addSubview(view1)
                      slide.addSubview(view1)
                }
           slide.addSubview(imageView)
            scrollview.addSubview(slide)
            scrollview.contentSize = CGSize(width: scrollWidth * CGFloat(imgs.count), height: scrollHeight)
            
            //disable vertical scroll/bounce
            self.scrollview.contentSize.height = 1.0
            
            
            
        }
    }
    

    
    
    
    
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollview.frame.size.width
        scrollHeight = scrollview.frame.size.height
        self.scrollview.delegate = self
        scrollview.isPagingEnabled = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Show the Navigation Barw
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
                           self.performSegue(withIdentifier: "loginSeg", sender: self)
                        }

//        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//
//        for index in 0..<imgs.count {
//            frame.origin.x = scrollWidth * CGFloat(index)
//            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
//
//            let slide = UIView(frame: frame)
//
//            //subviews
//            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
//            imageView.frame = CGRect(x:0,y:0,width:scrollview.frame.width  ,height:scrollview.frame.height)
//
//            imageView.contentMode = .scaleAspectFit
//            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
//
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
