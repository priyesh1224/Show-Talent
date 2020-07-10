//
//  CustomVideoEditorViewController.swift
//  ShowTalent
//
//  Created by admin on 09/07/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import Photos

class CustomVideoEditorViewController: UIViewController, UICollectionViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
    
    var videoPickerController = UIImagePickerController()
    
    @IBOutlet weak var upperview: UIView!
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    
    let editingTools = ["Merge Videos", "Rearrange", "Trim", "Speed", "Reverse","Effects", "Add Text", "Add Sticker", "Texture"]

    var layout : UICollectionViewFlowLayout?
    
    
    var videoURL: URL!
       var videoAsset: AVAsset!
       var mergeVideoURL: URL?
       var mergeVideoAsset: AVAsset?
       
       // Helper property for merging
       var willInsert = false
    var videoPlayerView: VideoPlayerView!
    
    let processingLabel: UILabel = {
        let label = UILabel()
        label.text = "PROCESSING"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.alpha = 0.7
        label.font = UIFont.systemFont(ofSize: 30)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var effectsView: EffectsView?
    var addTextView: AddTextView?
    var addStickerView: AddStickerView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        layout = UICollectionViewFlowLayout()
        videoPickerController.delegate = self
        if let l = layout {
                    l.scrollDirection = .horizontal
            l.itemSize = CGSize(width: 100, height: self.collection.frame.size.height)
                    collection.reloadData()
                    collection.collectionViewLayout = l
        
                }
        addButtons()
         addVideoPlayerView(with: self.view.frame.width)

        // Do any additional setup after loading the view.
    }
    override var prefersStatusBarHidden: Bool {
           return true
       }
    
    func pauseVideo() {
           videoPlayerView.player.pause()
           videoPlayerView.pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
           videoPlayerView.isPlaying = false
       }
    
    func addVideoPlayerView(with width: CGFloat) {
        let videoPlayerWidth = width
        let videoPlayerHeight = videoPlayerWidth*9/10
        let videoPlayerFrame = CGRect(x: 0, y: 64, width: videoPlayerWidth, height: videoPlayerHeight)
        videoURL = URL(string: "http://d26lcc3xloewa9.cloudfront.net/Equine+Walk+300fps_Generic_Hd_Mp4_Avc_Aac_16x9_Sdr_1280x720p_30Hz_5000Kbps_Qvbr_Vq9.mp4")
        videoPlayerView = VideoPlayerView(frame: videoPlayerFrame, url: videoURL)
        self.videoAsset = AVURLAsset(url: videoURL)
        self.view.addSubview(videoPlayerView)
    }
    
    // When device rotates, we modify the videoPlayerView acoordingly
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        videoPlayerView.removeFromSuperview()
        addVideoPlayerView(with: self.view.frame.height)
    }
    
    
    func addButtons() {
        let backButton = UIButton(frame: CGRect(x: 16, y: 64, width: 30, height: 30))
        backButton.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.clipsToBounds = true
        backButton.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.upperview.addSubview(backButton)
        
        
        let snapShotButton = UIButton(frame: CGRect(x: self.upperview.frame.size.width/2 - 15, y: self.upperview.frame.size.height - 46, width: 30, height: 30))
         snapShotButton.clipsToBounds = true
        snapShotButton.setImage(#imageLiteral(resourceName: "approved").withRenderingMode(.alwaysOriginal), for: .normal)
        
        snapShotButton.contentMode = .scaleAspectFit
        snapShotButton.addTarget(self, action: #selector(snapShotButtonTapped), for: .touchUpInside)
//        self.upperview.addSubview(snapShotButton)
 
        
        
        let doneButton = UIButton(frame: CGRect(x: self.upperview.frame.size.width - 46, y: 64, width: 30, height: 30))
        doneButton.clipsToBounds = true
        doneButton.setImage(#imageLiteral(resourceName: "approved"), for: .normal)
        doneButton.contentMode = .scaleAspectFit
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        self.upperview.addSubview(doneButton)

        
    }
    
    // Handle touch events on 3 buttons
    @objc func backButtonTapped() {
        pauseVideo()
        // Pop up a alert to choose if users want to discard or continue editing
        let alert = UIAlertController(title: "Discard Editing?", message: "Press Cancel to continue Editing", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            // If discard, then dismiss current view
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func snapShotButtonTapped() {
        pauseVideo()
        alertNotAvailable()
    }
    
    @objc func doneButtonTapped() {
        pauseVideo()
        // Pop up an action sheet that lets users choose to send editted videos or save all and go back to initial screen
        let doneActionSheet = UIAlertController(title: "Done Editing", message: "Please choose an option to continue", preferredStyle: .actionSheet)
        doneActionSheet.addAction(UIAlertAction(title: "Send", style: .default, handler: { (UIAlertAction) in
            self.alertNotAvailable()
        }))
        doneActionSheet.addAction(UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
            self.exportWithWatermark()
        }))
        doneActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(doneActionSheet, animated: true, completion: nil)
    }
    
    
    func alertNotAvailable() {
        // Some tools are not implemented
        let alert = UIAlertController(title: "Function Not Available", message: "Sorry... Please press OK to continue", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.editingTools.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customeditor", for: indexPath) as? CustomVideoEditorCollectionViewCell {
            cell.update(x : self.editingTools[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.collection.frame.size.height)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         pauseVideo()
               //  Handle different tool calles
               let selectedItem = indexPath.row
               if selectedItem == 0 {
                   // Merge videos
                   mergeVideosTapped()
               } else if selectedItem == 1 {
                   // Moving parts
                   rearrangePartsTapped()
               }else if selectedItem == 2 {
                   // Trim
                   trimVideoTapped()
               }else if selectedItem == 3 {
                   // Change Speed
                   changeSpeedTapped()
               } else if selectedItem == 4 {
                   // Reverse
                   alertNotAvailable()
               } else if selectedItem == 5 {
                   // Apply Effects
                   effectsTapped()
               } else if selectedItem == 6 {
                   // Overlay texts
                   addTextTapped()
               } else if selectedItem == 7 {
                   // Overlay Stickers
                   addStickerTapped()
               } else if selectedItem == 8 {
                   // Change Sound Texture
                   alertNotAvailable()
               }

    }
    
    
    
    func mergeVideosTapped() {
        // let user choose to insert into or append to the end of current video
        let doneActionSheet = UIAlertController(title: "Insert or Append", message: "Choose an option", preferredStyle: .actionSheet)
        doneActionSheet.addAction(UIAlertAction(title: "Insert At Current Time", style: .default, handler: { (UIAlertAction) in
            self.willInsert = true
            // Call getMergingVideo to get the second Video
            self.getMergingVideo()
        }))
        doneActionSheet.addAction(UIAlertAction(title: "Append To The End", style: .default, handler: { (UIAlertAction) in
            self.willInsert = false
            // Call getMergingVideo to get the second Video
            self.getMergingVideo()
        }))
        doneActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(doneActionSheet, animated: true, completion: nil)
    }
    
    // Helper function to get the second video for merging
    func getMergingVideo() {
        // Display the Video Gallery
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == false {
            return
        }
        
        videoPickerController.sourceType = .photoLibrary
        videoPickerController.mediaTypes = ["public.movie"]
        videoPickerController.mediaTypes = [kUTTypeMovie as String]
        videoPickerController.allowsEditing = true
        self.present(videoPickerController, animated: true, completion: nil)
        // After users have picked a video,
        //  the function imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo...)
        //  below get called
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // This is called when users are picking a video for merging purpose.
        // Set class property for merging viedo
        
        print("Holaaaaaaaaaaaaaaaaaaaaaa")
        self.mergeVideoURL = info["UIImagePickerControllerReferenceURL"] as? URL
        self.mergeVideoAsset = AVURLAsset(url: mergeVideoURL!)
        self.dismiss(animated: true, completion: nil)
        self.mergeVideos()
    }
    
    // Helper function to merge 2 videos
    func mergeVideos() {
        // Create an AVMutableComposition for editing Video
        let mutableComposition = AVMutableComposition()
        
        // Get video and audio tracks of all video instance we have
        let compositionVideoTrack: AVMutableCompositionTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!
        let compositionAudioTrack: AVMutableCompositionTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
        
        let videoTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let mergingVideoTrack: AVAssetTrack = mergeVideoAsset!.tracks(withMediaType: AVMediaType.video)[0]
        let audioTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.audio)[0]
        let mergingAudioTrack: AVAssetTrack = mergeVideoAsset!.tracks(withMediaType: AVMediaType.audio)[0]
        
        // Add video and audio tracks of 2 video to our MutableComposition
        if willInsert {
            //  If users had chosen to insert, we insert the second video inside the first video
            do {
                try compositionVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoPlayerView.currentPlayingTime), of: videoTrack, at: CMTime.zero)
                try compositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoPlayerView.currentPlayingTime), of: audioTrack, at: CMTime.zero)
                var currentEndTime = videoPlayerView.currentPlayingTime
                try compositionVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: (mergeVideoAsset?.duration)!), of: mergingVideoTrack, at: currentEndTime!)
                try compositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: (mergeVideoAsset?.duration)!), of: mergingAudioTrack, at: currentEndTime!)
                currentEndTime = currentEndTime! + (mergeVideoAsset?.duration)!
                try compositionVideoTrack.insertTimeRange(CMTimeRangeMake(start: videoPlayerView.currentPlayingTime, duration: videoAsset.duration), of: videoTrack, at: currentEndTime!)
                try compositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: videoPlayerView.currentPlayingTime, duration: videoAsset.duration), of: audioTrack, at: currentEndTime!)
            }
            catch{
                alertErrors()
                return
            }
        } else {
            // Users had chosen to append second video to the end of the first video
            do {
                try compositionVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: videoTrack, at: CMTime.zero)
                try compositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: audioTrack, at: CMTime.zero)
                try compositionVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: (mergeVideoAsset?.duration)!), of: mergingVideoTrack, at: videoAsset.duration)
                try compositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: (mergeVideoAsset?.duration)!), of: mergingAudioTrack, at: videoAsset.duration)
            }
            catch{
                alertErrors()
                return
            }
        }
        
        // Call helper function to export the newly created video
        export(mutableComposition)
    }
    
    
    /** selectedItem = 1
     Rearrange 2 parts of current video
     */
    func rearrangePartsTapped() {
        // Display an alert to get user input on the pivot for rearranging
        var partitionTime: Double?
        let totalSeconds = videoPlayerView.videoDuration
        
        let alert = UIAlertController(title: "Rearrange Video", message: "Please enter a number between 0s and \(Int(totalSeconds!))s", preferredStyle: .alert)
        alert.addTextField { (textField) in
            // Default displaying current playing time
            print(self.videoPlayerView.currentPlayingTime)
            print(totalSeconds)
            if let m = self.videoPlayerView.currentPlayingTime {
                textField.text = "\(Int(CMTimeGetSeconds(m)))"
            }
            else {
                textField.text = "\(Int(0))"

            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            guard let partitionTimeConvert = Double((textField?.text)!) else {
                return
            }
            partitionTime = partitionTimeConvert
            // If users prompt in valid input, use that
            if partitionTime! > 0 && partitionTime! < totalSeconds! {
                let partitionTimeCMTime = CMTime(seconds: partitionTime!, preferredTimescale: 1)
                // Call the helper function
                self.rearrangeVideo(at: partitionTimeCMTime)
            }
        }))
        // if user choose to use current time of the video, use that
        alert.addAction(UIAlertAction(title: "Partition at pausing moment", style: .default, handler: { (UIAlertAction) in
            // Call the helper function
            self.rearrangeVideo(at: self.videoPlayerView.currentPlayingTime)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Helper function to rearrange the video
    func rearrangeVideo(at partition: CMTime) {
        // Create A AVMUtableComposition for editong
        let mutableComposition = AVMutableComposition()
        // Get video tracks and audio tracks of our video and the AVMutableComposition
        let compositionVideoTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let compositionAudioTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let videoTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let audioTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        // Add 2 parts of video around the pivot in reversed order.
        do {
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: partition, duration: videoAsset.duration), of: videoTrack, at: CMTime.zero)
            try compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(start: partition, duration: videoAsset.duration), of: audioTrack, at: CMTime.zero)
            let currentEndTime = videoAsset.duration - partition
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: partition), of: videoTrack, at: currentEndTime)
            try compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: partition), of: audioTrack, at: currentEndTime)
        } catch {
            alertErrors()
            return
        }
        
        // Call helper function to export the newly edited video
        export(mutableComposition)
    }
    
    
    
    /** selectedItem = 2
     Trim a part of the video
     */
    func trimVideoTapped() {
        // Display an alert and get users input of 2 time points for triming
        var startTrim: Double?
        var endTrim: Double?
        let totalSeconds = videoPlayerView.videoDuration ?? 0
        
        let alert = UIAlertController(title: "Trim Video", message: "Please enter 2 numbers between 0s and \(Int(totalSeconds))s for triming.", preferredStyle: .alert)
        alert.addTextField { (from) in
            from.text = "From..."
            from.textColor = .lightGray
        }
        alert.addTextField { (to) in
            to.text = "To..."
            to.textColor = .lightGray
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let fromField = alert?.textFields?[0].text?.components(separatedBy: "...")[1] ?? ""
            let toField = alert?.textFields?[1].text?.components(separatedBy: "...")[1] ?? ""
            
            
            
            
            if let st =  Int(fromField) as? Int , let tt = Int(toField) as? Int {
                startTrim = Double(st)
                endTrim = Double(tt)
                
                // IF users prompt valid inputs, we do triming
                if startTrim! < endTrim! && startTrim! >= 0 && endTrim! <= totalSeconds {
                    let startTrimTime = CMTime(seconds: startTrim!, preferredTimescale: 1)
                    let endTrimTime = CMTime(seconds: endTrim!, preferredTimescale: 1)
                    // Call helper function for triming
                    self.trimVideo(from: startTrimTime, to: endTrimTime)
                }
            }
            
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Helper function to trim our video based on startTrimTime and endTrimTime
    func trimVideo(from startTrimTime: CMTime, to endTrimTime: CMTime) {
        // Create an AVMutableComposition for editing
        let mutableComposition = AVMutableComposition()
        // Get video tracks and audio tracks of our video and the AVMutableComposition
        let compositionVideoTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let compositionAudioTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let videoTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let audioTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        // Insert our video into the MutableCompositon except the triming part
        do {
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: startTrimTime), of: videoTrack, at: CMTime.zero)
            try compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: startTrimTime), of: audioTrack, at: CMTime.zero)
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: endTrimTime, duration: videoAsset.duration), of: videoTrack, at: startTrimTime)
            try compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(start: endTrimTime, duration: videoAsset.duration), of: audioTrack, at: startTrimTime)
        } catch {
            alertErrors()
            return
        }
        
        //Call helper function for exporting the newly edited video
        export(mutableComposition)
    }
    
    /** selectedItem = 3
     Change running speed of the current video
     */
    func changeSpeedTapped() {
        // Display an alert an get user input for new speed
        var speed: Int64 = 1
        
        let alert = UIAlertController(title: "New Speed", message: "Please enter a number between 10(%) and 500(%). And wait for processing after pressing OK", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "100"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            guard let speedConvert = Int64((textField?.text)!) else {
                return
            }
            speed = speedConvert
            // If users inputs match pur constaints, change the speed
            if speed >= 10 && speed <= 500 {
                // Call helper function to change speed
                self.changeSpeed(at: speed)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Helper function to change to video speed
    func changeSpeed(at speed: Int64) {
        // Create an AVMutableComposition for editing
        let mutableComposition = AVMutableComposition()
        // Get video tracks and audio tracks of our video and the AVMutableComposition
        let compositionVideoTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let compositionAudioTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let videoTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let audioTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        // Add our video tracks and audio tracks into the Mutable Composition normal order
        do {
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: videoTrack, at: CMTime.zero)
            try compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: audioTrack, at: CMTime.zero)
        } catch {
            alertErrors()
            return
        }
        
        let videoDuration = videoAsset.duration
        
        // Change video's speed
        let finalTimeScale : Int64 = videoDuration.value / speed * 100
        // Use scaleTimeTange to change video speed
        compositionVideoTrack?.scaleTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoDuration), toDuration: CMTimeMake(value: finalTimeScale, timescale: videoDuration.timescale))
        compositionAudioTrack?.scaleTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoDuration), toDuration: CMTimeMake(value: finalTimeScale, timescale: videoDuration.timescale))
        
        export(mutableComposition)
    }
    
    /** selectedItem = 5
     Apply effects to the video
     */
    func effectsTapped() {
        // Add effect to the view controller
        effectsView = EffectsView(frame: self.collection.frame)
        self.view.addSubview(effectsView!)
        // Based on what we user input, perform accordingly
        effectsView?.cancelButton.addTarget(self, action: #selector(cancelEffectsButtonHandle), for: .touchUpInside)
        effectsView?.applyButton.addTarget(self, action: #selector(applyEffectsButtonHandle), for: .touchUpInside)
    }
    
    // If users tap cancel
     @objc func cancelEffectsButtonHandle() {
        effectsView?.removeFromSuperview()
    }
    
    // If users tap apply, we check all needed information then perform applying effect
    @objc func applyEffectsButtonHandle() {
        if let effect = effectsView?.effect {
            addEffect(effect)
        } else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please choose an effect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Apply effect by create a new CALayer and add it to the video afterward.
    func addEffect(_ effect: Int) {
        effectsView?.removeFromSuperview()
        
        // Create an AVMutableComposition for editing
        let mutableComposition = getVideoComposition()
        
        // Create a new CALayer instance and configurate it
        let effectLayer = CALayer()
        effectLayer.backgroundColor = UIColor(hue: CGFloat(effect)/20, saturation: 1, brightness: 1, alpha: 1).cgColor
        effectLayer.opacity = 0.2
        
        let videoSize = videoAsset.tracks(withMediaType: AVMediaType.video)[0].naturalSize
        effectLayer.frame = CGRect(x: 0, y: 0, width: videoSize.width, height: videoSize.height)
        
        // Further export the video with the layer
        exportWithAddedLayer(mutableComposition, with: effectLayer, doneEditing: false)
    }
    
    /** selectedItem = 6
     Overlay the video with input text
     */
    func addTextTapped() {
        // Add the addTextView to current View Controller
        addTextView = AddTextView(frame: self.collection.frame)
        self.view.addSubview(addTextView!)
        // Based on what we user input, perform accordingly
        addTextView?.cancelButton.addTarget(self, action: #selector(cancelAddTextButtonHandle), for: .touchUpInside)
        addTextView?.addButton.addTarget(self, action: #selector(addAddTextButtonHandle), for: .touchUpInside)
    }
    
    // If users tap cancel
    @objc func cancelAddTextButtonHandle() {
        addTextView?.removeFromSuperview()
    }
    
    // If users tap add, we check all needed information then perform applying effect
    @objc func addAddTextButtonHandle() {
        if addTextView?.inputTextField.text != "", let position = addTextView?.position {
            addText((addTextView?.inputTextField.text)!, at: position)
        } else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please enter text and choose overlaid position", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Add text by create a CALayer instance and add it afterward
    func addText(_ text: String, at position: Int) {
        
        addTextView?.removeFromSuperview()
        
        // Create an AVMutableComposition for editing
        let mutableComposition = getVideoComposition()
        
        // Create a CALayer instance and configurate it
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.font = UIFont(name: "Helvetica-Bold", size: 50)
        textLayer.shadowOpacity = 0.5
        
        if position % 3 == 0 {
            textLayer.alignmentMode = CATextLayerAlignmentMode.left
        } else if position % 3 == 1 {
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
        } else {
            textLayer.alignmentMode = CATextLayerAlignmentMode.right
        }
        
        let videoSize = videoAsset.tracks(withMediaType: AVMediaType.video)[0].naturalSize
        let textLayerWidth = videoSize.width
        let textLayerHeight = videoSize.height * CGFloat(3 * (position / 3) + 1 ) / 7
        textLayer.frame = CGRect(x: 0, y:0, width: textLayerWidth, height: textLayerHeight)
        
        // Further export the video with the layer
        exportWithAddedLayer(mutableComposition, with: textLayer, doneEditing: false)
    }
    
    /** selectedItem = 7
     Overlay the video with sticker
     */
    func addStickerTapped() {
        // Add the addStickerView to current view controller
        addStickerView = AddStickerView(frame: self.collection.frame)
        self.view.addSubview(addStickerView!)
        // Based on what we user input, perform accordingly
        addStickerView?.cancelButton.addTarget(self, action: #selector(cancelAddStickerButtonHandle), for: .touchUpInside)
        addStickerView?.addButton.addTarget(self, action: #selector(addAddStickerButtonHandle), for: .touchUpInside)
    }
    
    // If users tap cancel
    @objc func cancelAddStickerButtonHandle() {
        addStickerView?.removeFromSuperview()
    }
    
    // If users tap add, we check all needed information then perform applying effect
    @objc func addAddStickerButtonHandle() {
        if let sticker = addStickerView?.sticker, let position = addStickerView?.position {
            addSticker(sticker, at: position)
        } else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please choose a sticker an the position", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Add sticker by create a CALayer instance and add it afterward
    func addSticker(_ sticker: Int, at position: Int) {
        addStickerView?.removeFromSuperview()
        
        // Create an AVMutableComposition for editing
        let mutableComposition = getVideoComposition()
        
        // Create a CALayer instance and configurate it
        let stickerLayer = CALayer()
        stickerLayer.contents = UIImage(named: "sticker\(sticker)")?.cgImage
        stickerLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        let videoSize = videoAsset.tracks(withMediaType: AVMediaType.video)[0].naturalSize
        let videoWidth = videoSize.width
        let videoHeight = videoSize.height
        let stickerWidth = videoWidth/6
        let stickerX = videoWidth * CGFloat(5 * (position % 3)) / 12
        let stickerY = videoHeight * CGFloat(position / 3) / 3
        stickerLayer.frame = CGRect(x: stickerX, y: stickerY, width: stickerWidth, height: stickerWidth)
        
        // Further export the video with the layer
        exportWithAddedLayer(mutableComposition, with: stickerLayer, doneEditing: false)
    }
    
    func getVideoComposition() -> AVMutableComposition {
        // Create an AVMutableComposition for editing
        let mutableComposition = AVMutableComposition()
        // Get video tracks and audio tracks of our video and the AVMutableComposition
        let compositionVideoTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let compositionAudioTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let videoTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let audioTrack: AVAssetTrack  = videoAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        // Add our video tracks and audio tracks into the Mutable Composition normal order
        do {
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: videoTrack, at: CMTime.zero)
            try compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: audioTrack, at: CMTime.zero)
        } catch {
            alertErrors()
            return AVMutableComposition()
        }
        
        return mutableComposition
    }
    
    // Helper function that generate a unique URL for saving
    func generateExportUrl() -> URL {
        
        // Create a custom URL using curernt date-time to prevent conflicted URL in the future.
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .short
        let dateString = dateFormat.string(from: Date())
        let exportPath = (documentDirectory as NSString).strings(byAppendingPaths: ["edited-video-\(dateString).mp4"])[0]
        
        return NSURL(fileURLWithPath: exportPath) as URL
    }
    
    //Export the AV Mutable Composition
    func export(_ mutableComposition: AVMutableComposition) {
        
        self.view.addSubview(processingLabel)
        processingLabel.frame = self.collection.frame

        // Set up exporter
        guard let exporter = AVAssetExportSession(asset: mutableComposition, presetName: AVAssetExportPresetHighestQuality) else { return }
        exporter.outputURL = generateExportUrl()
        exporter.outputFileType = AVFileType.mov
        exporter.exportAsynchronously() {
            DispatchQueue.main.async {
                self.exportDidComplete(exportURL: exporter.outputURL!, doneEditing: false)
            }
        }
    }
    
    // Export with watermark when user tap save
    func exportWithWatermark() {
        
        // Create an AVMutableComposition for editing
        let mutableComposition = getVideoComposition()
        
        // Create a watermark CALayer and configurate it
        let watermarkLayer = CALayer()
        watermarkLayer.contents = #imageLiteral(resourceName: "watermark").cgImage
        watermarkLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
        let videoWidth = videoAsset.tracks(withMediaType: AVMediaType.video)[0].naturalSize.width
        let watermarkWidth = videoWidth/6
        watermarkLayer.frame = CGRect(x: videoWidth - 20 - watermarkWidth, y: 20, width: watermarkWidth, height: watermarkWidth)
        watermarkLayer.opacity = 0.5

        // Further export the video with the layer
        exportWithAddedLayer(mutableComposition, with: watermarkLayer, doneEditing: true)
    }
    
    

    // Export a video and a added CALayer object
    func exportWithAddedLayer(_ mutableComposition: AVMutableComposition, with addedLayer: CALayer, doneEditing: Bool) {
        
        self.view.addSubview(processingLabel)
        processingLabel.frame = self.collection.frame

        let videoTrack: AVAssetTrack = mutableComposition.tracks(withMediaType: AVMediaType.video)[0]
        let videoSize = videoTrack.naturalSize
        
        
        let videoLayer = CALayer()
        videoLayer.frame = CGRect(x: 0, y: 0, width: videoSize.width, height: videoSize.height)
        
        let containerLayer = CALayer()
        containerLayer.frame = CGRect(x: 0, y: 0, width: videoSize.width, height: videoSize.height)
        containerLayer.addSublayer(videoLayer)
        containerLayer.addSublayer(addedLayer)
        
        let layerComposition = AVMutableVideoComposition()
        layerComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        layerComposition.renderSize = videoSize
        layerComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: containerLayer)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: mutableComposition.duration)
        let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        instruction.layerInstructions = [layerInstruction]
        layerComposition.instructions = [instruction]
        
        let exportUrl = generateExportUrl()
        // Set up exporter
        guard let exporter = AVAssetExportSession(asset: mutableComposition, presetName: AVAssetExportPresetHighestQuality) else { return }
        exporter.videoComposition = layerComposition
        exporter.outputURL = exportUrl as URL
        exporter.outputFileType = AVFileType.mov
        exporter.exportAsynchronously() {
            DispatchQueue.main.async {
                self.exportDidComplete(exportURL: exporter.outputURL!, doneEditing: doneEditing)
            }
        }
    }
    
    //Export Finish Handler
    func exportDidComplete(exportURL: URL, doneEditing: Bool) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: exportURL)
        }) { saved, error in
            if saved { }
            else {
                self.alertErrors()
            }
        }
        self.processingLabel.removeFromSuperview()
        
        // If user tap save, we dismiss current view controller, go back to main screen and play the edited video in a  AVPlayerViewController
        if doneEditing == true {
            self.dismiss(animated: true, completion: {
                let videoPlayer = AVPlayer(url: exportURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = videoPlayer
                UIApplication.shared.keyWindow?.rootViewController?.present(playerViewController, animated: false, completion: nil)
            })
        } else {
            // Other wise, we reload the videoPlayerView to play the new edited video
            self.videoPlayerView.removeFromSuperview()
            self.videoURL = exportURL
            self.videoAsset = AVURLAsset(url: exportURL)
            self.addVideoPlayerView(with: self.view.frame.width)
        }
    }
    
    /** Alert something wrong happend when errors are thrown
     */
    func alertErrors() {
        let alert = UIAlertController(title: "Oops... Something wrong has happened", message: "Don't worry, your previous editings had been saved in Gallery for you.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        //alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
