//
//  InvitepeopleViewController.swift
//  ShowTalent
//
//  Created by PRIYESH  on 4/9/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import MessageUI

class InvitepeopleViewController: UIViewController , MFMessageComposeViewControllerDelegate , UIDocumentInteractionControllerDelegate  {
    
    
    @IBOutlet weak var notifindicator: UIView!
    
    @IBOutlet weak var bannerheight: NSLayoutConstraint!
    
    @IBOutlet weak var referalcode: UILabel!
    
    @IBOutlet weak var outerreferalcodeview: UIView!
    
    @IBOutlet weak var stackwidth: NSLayoutConstraint!
    
    @IBOutlet weak var bannerview: UIView!
    var rfc = ""
    
    @IBOutlet weak var bottomview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackwidth.constant = self.view.frame.size.width - 48
        notifindicator.layer.cornerRadius = 10
        outerreferalcodeview.layer.borderColor = UIColor.white.cgColor
        outerreferalcodeview.layer.borderWidth = 1
        outerreferalcodeview.layer.cornerRadius = 5
         if self.view.frame.size.width > 330 {
        self.bannerheight.constant = self.view.frame.size.height/2.7
        }
         else {
            self.bannerheight.constant = self.view.frame.size.height/2.3
        }
        let m = self.applygradient(a: #colorLiteral(red: 0.3215686275, green: 0.3058823529, blue: 0.7803921569, alpha: 1), b: #colorLiteral(red: 0.1960784314, green: 0.4784313725, blue: 0.6666666667, alpha: 1))
        self.bannerview.layer.insertSublayer(m, at: 0)
        self.bottomview.layer.insertSublayer(m, at: 0)
        self.referalcode.text = rfc
        fetchprofile()
        // Do any additional setup after loading the view.
    }
    
    func applygradient(a:UIColor , b:UIColor) -> CAGradientLayer
    {
        let gl = CAGradientLayer()
        gl.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.bannerheight.constant)
        gl.colors = [a.cgColor,b.cgColor]
        return gl
    }
    
    
    
    @IBAction func instagramtapped(_ sender: Any) {
        shareToInstagram()
    }
    
    var documentController: UIDocumentInteractionController!
    
    func shareToInstagram() {

      let instagramURL = NSURL(string: "instagram://app")
        
        var yourImage = #imageLiteral(resourceName: "logo-s")

        if (UIApplication.shared.canOpenURL(instagramURL! as URL)) {

            let imageData = yourImage.jpegData(compressionQuality: 100)

                 let captionString = "Download ShowTalent app"

            let writePath = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.igo")

            do {
                try imageData?.write(to: URL(fileURLWithPath: writePath), options: .atomic)
            } catch {
                print(error)
            }

    let fileURL = NSURL(fileURLWithPath: writePath)

                self.documentController = UIDocumentInteractionController(url: fileURL as URL)

                     self.documentController.delegate = self

                self.documentController.uti = "com.instagram.exlusivegram"

                self.documentController.annotation = NSDictionary(object: captionString, forKey: "InstagramCaption" as NSCopying)
                self.documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)

                 

             } else {
                 print(" Instagram isn't installed ")
             }
         }
    

  
    
    @IBAction func whatsapptapped(_ sender: Any) {
        let date = Date()
        let msg = "Download ShowTalent App \(date)"
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    print("please install watsapp")
                }
            }
        }
    }
    
    
    
    @IBAction func smstapped(_ sender: Any) {
        if(MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = []
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        print("SMS sent")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    func fetchprofile()
    {
        if let u = UserDefaults.standard.value(forKey: "referalcode") as? String {
            print("Found")
            self.referalcode.text = u
        }
        else {
            print("Not found")
            var uid = UserDefaults.standard.value(forKey: "refid") as! String
            var url = "\(Constants.K_baseUrl)\(Constants.profile)\(uid),All"
            var r = BaseServiceClass()
            r.postApiRequest(url: url, parameters: [:]) { (response, err) in
                if let res = response?.result.value as? Dictionary<String,Any> {
                    if let rv = res["Results"] as? Dictionary<String,Any> {
                        if let refcode = rv["ReferralCode"] as? String {
                            self.rfc = refcode
                            self.referalcode.text = self.rfc
                            UserDefaults.standard.set(refcode, forKey: "referalcode")
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    @IBAction func backtapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    

}
