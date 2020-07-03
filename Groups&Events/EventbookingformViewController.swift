//
//  EventbookingformViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 5/28/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EventbookingformViewController: UIViewController {
    
    
    @IBOutlet weak var tandccheckbox: UIButton!
    
    @IBOutlet weak var proceedbtn: CustomButton!
    
    @IBOutlet weak var notifindicator: UIView!
    
    @IBOutlet weak var stp: UIStepper!
    @IBOutlet weak var scroll: UIScrollView!
    
    
    @IBOutlet weak var tv1: UITextView!
    
    @IBOutlet weak var firstname: UITextField!
    
    
    @IBOutlet weak var tv2: UITextView!
    
    
    @IBOutlet weak var lastname: UITextField!
    
    
    @IBOutlet weak var tv3: UITextView!
    
    
    @IBOutlet weak var personcount: UILabel!
    
    
    @IBOutlet weak var tv4: UITextView!
    
    
    @IBOutlet weak var country: UITextField!
    
    
    @IBOutlet weak var tv5: UITextView!
    
    @IBOutlet weak var phone: UITextField!
    
    
    @IBOutlet weak var tv6: UITextView!
    
    @IBOutlet weak var email: UITextField!
    
    var currentpeoplecount = 0
    var eventid = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proceedbtn.layer.cornerRadius = 25
        tandccheckbox.layer.borderWidth = 1
        tandccheckbox.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2941176471, blue: 0.8117647059, alpha: 1)
        notifindicator.layer.cornerRadius = 10
        stp.isEnabled = true
        stp.stepValue = 1
        stp.isUserInteractionEnabled = true
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1250)
        self.scroll.isScrollEnabled = true
        stp.minimumValue = 1
        stp.maximumValue = 50
        stp.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func stepperChanged()
    {
        print("Hey")
    }
    @IBAction func tandccheckboxpressed(_ sender: Any) {
        if tandccheckbox.image(for: .normal) == nil {
            tandccheckbox.setImage(#imageLiteral(resourceName: "check-solid"), for: .normal)
        }
        else {
            tandccheckbox.setImage(nil, for: .normal)
        }
    }
    
    
    @IBAction func backbtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stepperpressed(_ sender: Any) {
        print(stp.value)
        self.personcount.text = "\(Int(stp.value))"
        currentpeoplecount = Int(stp.value)
    }
    
    
    @IBAction func proceedbtn(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.303Z'"
        let bookdate = dateFormatter.string(from: Date())
        print(bookdate)
        if let fn = firstname.text as? String , let ln = lastname.text as? String , let cnt = country.text as? String , let phn = phone.text as? String , let emil = email.text as? String {
            if fn == "" || fn == " " || ln == "" || ln == " " || cnt == "" || cnt == " " || phn == "" || phn == " " || emil == "" || emil == " "  {
                self.present(customalert.showalert(x: "All field are mandatory"), animated: true, completion: nil)
            }
            else if currentpeoplecount == 0 {
                self.present(customalert.showalert(x: "No of person should be greater than 0"), animated: true, completion: nil)
            }
            else if tandccheckbox.image(for: .normal) == nil {
                self.present(customalert.showalert(x: "Please accept terms and condition before booking the event."), animated: true, completion: nil)
            }
            else {
                var url = Constants.K_baseUrl + Constants.bookevent
                var r  = BaseServiceClass()
                var uid = UserDefaults.standard.value(forKey: "refid") as! String
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.303Z'"
                let bookdate = dateFormatter.string(from: Date())
                var params : Dictionary<String,Any> = ["EventId": self.eventid,
                                                       "UserId": uid,
                                                       "FirstName": fn,
                                                       "Lastname": ln,
                                                       "Email": emil,
                                                       "Mobile": phn,
                                                       "CountryCode": "+91",
                                                       "BookOn": "\(bookdate)",
                                                       "Location": "",
                                                       "NoOfPeople": currentpeoplecount]
                print(params)
                r.postApiRequest(url: url, parameters: params) { (response, err) in
                    if let res = response?.result.value as? Dictionary<String,Any> {
                        print(res)
                        if let code = res["ResponseStatus"] as? Int {
                            if code == 0 {
                                let alert2 = UIAlertController(title: "Event Booked", message: "Booking details will be sent to you.", preferredStyle: .actionSheet)
                                alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                    self.performSegue(withIdentifier: "backtozero", sender: nil)
                                    
                                }));
                                self.present(alert2, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}
