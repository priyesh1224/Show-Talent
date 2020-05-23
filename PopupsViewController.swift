//
//  PopupsViewController.swift
//  ShowTalent
//
//  Created by apple on 9/20/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import BottomPopup
import AVFoundation
import MobileCoreServices
import Photos
import OpalImagePicker

class PopupsViewController: BottomPopupViewController {
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var videoURL = NSURL()
    var shouldDismissInteractivelty: Bool?
    var imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var btn_audio: UIButton!
    @IBOutlet weak var btn_file: UIButton!
    @IBOutlet weak var btn_video: UIButton!
    @IBOutlet weak var btn_photo: UIButton!
    
    @IBOutlet weak var btn_cancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dismis_tap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func file_taped(_ sender: Any) {
    }
    @IBAction func audio_tapped(_ sender: Any) {
    }
    @IBAction func video_tapped(_ sender: UIButton) {
        openImgPicker()
    }
   
    @IBAction func photo_taped(_ sender: Any) {
        openimg()
    }
    // Bottom popup attribute methods
    // You can override the desired method to change appearance
    
    
    private func openImgPicker() {
        
        
        
        // let picker = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.videoQuality = .typeLow
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    override func getPopupHeight() -> CGFloat {
        return height ?? CGFloat(200)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(30)
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration ?? 0.5
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration ?? 0.1
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }


    
    func openimg() {
        
        let imagePicker = OpalImagePickerController()
        imagePicker.selectionTintColor = UIColor.white.withAlphaComponent(0.7)
        //Change color of image tint to black
        imagePicker.selectionImageTintColor = UIColor.black
        
        //Change image to X rather than checkmark
        imagePicker.selectionImage = UIImage(named: "cancel")
        
        //Change status bar style
        imagePicker.statusBarPreference = UIStatusBarStyle.lightContent
        
        //Limit maximum allowed selections to 5
        imagePicker.maximumSelectionsAllowed = 10
        
        //Only allow image media type assets
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        
        //Change default localized strings displayed to the user
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
        imagePicker.imagePickerDelegate = self
       
     //   dismiss(animated: true, completion: nil)
    
        present(imagePicker, animated: true, completion: nil)
       
    
}

}
extension PopupsViewController : OpalImagePickerControllerDelegate
{
    
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
   dismiss(animated: true, completion: nil)
 dismiss(animated: true, completion: nil)
      //  let vc = storyboard?.instantiateViewController(withIdentifier: "uploadVc")
       let vc = self.storyboard!.instantiateViewController(withIdentifier: "uploadVc") as! UploadFIleViewController
        vc.asses = assets
        vc.type = "image"
// self.present(vc!, animated: true, completion: nil)
//self.navigationController?.pushViewController(vc!, animated: true)
        
      //  let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "MyViewController") as! MyViewController
        
      
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
    
    }
    
    
}



extension PopupsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        
        guard let image = info[.mediaURL] as? NSURL else {
            print("videoURL:\(String(describing: videoURL))")
            //
            return //self.imagePickerController(picker, didSelect: nil)
            
        }
        videoURL = image
        print(image.path as Any)
        
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "uploadVc") as! UploadFIleViewController
     vc.videopath = image
        
        vc.type = "video"
    
        
    //    vc.asses = assets
        // self.present(vc!, animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc!, animated: true)
        
        //  let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "MyViewController") as! MyViewController
          self.dismiss(animated: true, completion: nil)
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
}
}


//extension PopupsViewController :


