//
//  InternetViewController.swift
//  ShowTalent
//
//  Created by apple on 12/2/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Reachability
class InternetViewController: UIViewController {
 
    
   
    let reachability =  try! Reachability()
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if reachability.isReachable()  {
            DispatchQueue.main.async {
                self.view.backgroundColor = UIColor.green
            }
        }
        
        if !reachability.isReachable()  {
            DispatchQueue.main.async {
                self.view.backgroundColor = UIColor.red
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged , object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            print("Could not strat notifier")
        }
    }
    
   
    @objc  func internetChanged(note:Notification)  {
        let reachability  =  note.object as! Reachability
        if reachability.isReachable() {
            DispatchQueue.main.async {
                //   self.view.backgroundColor = UIColor.orange
           
            self.dismiss(animated: true, completion: nil)
            }
            
            
            if reachability.isReachableViaWiFi() {
               // self.view.backgroundColor = UIColor.green
            }
            else{
                DispatchQueue.main.async {
                 //   self.view.backgroundColor = UIColor.orange
                }
            }
        } else{
            DispatchQueue.main.async {
                self.view.backgroundColor = UIColor.red
            }
        }
    }
    
//    func reachabilityChanged(_ isReachable: Bool) {
//        if isReachable {
//            print(" internet connection")
//           self.dismiss(animated: true, completion: nil)
//           // self.navigationController?.dismiss(animated: true, completion: nil)
//        }
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
