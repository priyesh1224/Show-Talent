//
//  VideoFiltersViewController.swift
//  ShowTalent
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import YPImagePicker


class VideoFiltersViewController: UIViewController , YPImagePickerDelegate, UIViewControllerTransitioningDelegate {

    
    
    
    
    var picker : YPImagePicker?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var config = YPImagePickerConfiguration()
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = false
        config.usesFrontCamera = true
        config.showsPhotoFilters = true
        config.showsVideoTrimmer = true
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "ShowTalent"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .photo , .video]
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.bottomMenuItemSelectedTextColour = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        config.bottomMenuItemUnSelectedTextColour = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        config.showsCrop = .rectangle(ratio: 2)
        
        config.showsPhotoFilters = true
        
        config.showsVideoTrimmer = true
        config.maxCameraZoomFactor = 1.2
        config.library.options = nil
        config.library.onlySquare = false
        config.library.isSquareByDefault = true
        config.library.minWidthForItem = nil
        config.library.mediaType = YPlibraryMediaType.photoAndVideo
        config.library.defaultMultipleSelection = false
        config.library.maxNumberOfItems = 1
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = false
        config.library.preselectedItems = nil
        config.video.compression = AVAssetExportPresetHighestQuality
        config.video.fileType = .mp4
        config.video.recordingTimeLimit = 60.0
        config.video.libraryTimeLimit = 60.0
        config.video.minimumTimeLimit = 3.0
        config.video.trimmerMaxDuration = 60.0
        config.video.trimmerMinDuration = 3.0
        config.gallery.hidesRemoveButton = false
        YPImagePickerConfiguration.shared = config
        picker = YPImagePicker()

        picker?.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print("Image")
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            }
            if let video = items.singleVideo {
                print("Video")
                           print(video.fromCamera)
                           print(video.thumbnail)
                           print(video.url)
                
                
                var videoURL = video.url as? URL
                    self.dismiss(animated: true, completion: nil)
                    
                    // We create a VideoEditorViewController to play video as well as for editing purpose
                    let videoEditorViewController = VideoEditorViewController()
                   
                    videoEditorViewController.videoURL = videoURL
                    videoEditorViewController.videoAsset = AVURLAsset(url: videoURL!)
                    videoEditorViewController.transitioningDelegate = self
                    self.present(videoEditorViewController, animated: true, completion: nil)
                
                
                       }
            
        
          
            picker?.dismiss(animated: true, completion: nil)
        }
        
       
        
       


      
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
  

    func noPhotos() {
          print("hello")
      }
    
    
    
    
    
    @IBAction func btntapped(_ sender: Any) {
        present(picker!, animated: true, completion: nil)

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
