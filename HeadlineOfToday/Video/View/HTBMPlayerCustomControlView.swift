//
//  HTBMPlayerCustomControlView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/9.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import BMPlayer

class HTBMPlayerCustomControlView: BMPlayerControlView {

    var playTimeUIProgressView = UIProgressView()
    
    
    override func customizeUIComponents() {
        
        // If needs to change position remake the constraint
        progressView.snp.remakeConstraints { (make) in
            make.bottom.left.right.equalTo(bottomMaskView)
            make.height.equalTo(2)
        }
        
        // Add new items and constraint
        bottomMaskView.addSubview(playTimeUIProgressView)
        playTimeUIProgressView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(bottomMaskView)
            make.height.equalTo(2)
        }
        
        playTimeUIProgressView.tintColor = UIColor.red
        playTimeUIProgressView.trackTintColor = UIColor.clear
        
    }
    
    override func updateUI(_ isForFullScreen: Bool) {
        topMaskView.isHidden = true
        chooseDefitionView.isHidden = true
    }
    
    override func playTimeDidChange(currentTime: TimeInterval, totalTime: TimeInterval) {
        currentTimeLabel.text = HTBMPlayerCustomControlView.formatSecondsToString(currentTime)
        totalTimeLabel.text = HTBMPlayerCustomControlView.formatSecondsToString(totalTime)
        timeSlider.value = Float(currentTime/totalTime)
        playTimeUIProgressView.setProgress(Float(currentTime/totalTime), animated: true)
    }
    
    override func onTapGestureTapped(_ gesture: UITapGestureRecognizer) {
        delegate?.controlView(controlView: self, didPressButton: playButton)
    }
    
    override func playStateDidChange(isPlaying: Bool) {
        super.playStateDidChange(isPlaying: isPlaying)
    }
    
    override func controlViewAnimation(isShow: Bool) {
        
    }
    

}

extension HTBMPlayerCustomControlView {
    static func formatSecondsToString(_ seconds: TimeInterval) -> String {
        let Min = Int(seconds / 60)
        let Sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", Min, Sec)
    }
}
