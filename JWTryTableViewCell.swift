//
//  JWTryTableViewCell.swift
//  ShowTalent
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class JWTryTableViewCell: UITableViewCell, JWPlayerDelegate {
    
     var player: JWPlayerController?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let p = player {
            p.pause()
            p.volume = 0
            self.player = nil
        }
    }

    func update()
    {
        let config = JWConfig()
        config.offlinePoster = #imageLiteral(resourceName: "Group_-2")
        config.offlineMessage = "my offline message"
        config.file = "http://thcoreapi.maraekat.com/Upload/Video/1140/be1178c2-37eb-48ac-894d-877fdb17c40f.mp4"
        config.playbackRateControls = true
        
        config.playbackRates = [0.5, 1, 2]
        config.autostart = true
        config.size = CGSize(width: self.frame.size.width, height: 300)
        player?.delegate = self
        player?.view?.frame = CGRect(x: 0, y: 30, width: self.frame.size.width, height: 300)
        player?.view?.backgroundColor = UIColor.black
        player?.loadFeed("http://thcoreapi.maraekat.com/Upload/Video/1140/be1178c2-37eb-48ac-894d-877fdb17c40f.mp4")
        player = JWPlayerController(config: config)
        player?.volume = 1
        
        self.addSubview(player!.view!)
        setupPlaybackButton()
        print(player?.state.rawValue)
    }
    
    func onReady(_ event: JWEvent & JWReadyEvent) {
            print("Ready to play")
            player?.play()
        }
        
        func onError(_ event: JWEvent & JWErrorEvent) {
            print("Error coming up")
        }
        
        
        func setupPlaybackButton() {
            let origin = CGPoint(x: self.frame.origin.x + 22, y: self.frame.origin.y + 22)
               let playbackButton = UIButton(frame: CGRect(origin: origin, size: CGSize(width: 44, height: 44)))
               
    //           playbackButton.setImage(#imageLiteral(resourceName: "006-cup"), for: .normal)
               playbackButton.backgroundColor = UIColor.white
               playbackButton.addTarget(self, action: #selector(self.togglePlayback(_:)), for: .touchUpInside)
               
               if let playerView = player?.view {
                    self.insertSubview(playbackButton, aboveSubview: playerView)
                   
               }
           }
           
           @objc func togglePlayback(_ button: UIButton) {
               if player?.state == JWPlayerState.playing {
                   player?.pause()
    //               button.setImage(#imageLiteral(resourceName: "006-cup"), for: .normal)
               } else {
                   player?.play()
    //               button.setImage(#imageLiteral(resourceName: "006-cup"), for: .normal)
               }
           }

}
