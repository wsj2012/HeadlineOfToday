//
//  HTMyChannelReusableView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

protocol HTMyChannelReusableViewDelegate: class {
    ///点击编辑按钮点击
    func channelReusableViewEditButtonClicked(_ sender: UIButton)
}

/// 我的频道推荐
class HTMyChannelReusableView: UICollectionReusableView, RegisterCellOrNib {
    
    weak var delegate: HTMyChannelReusableViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editChannelButton.layer.borderColor = UIColor.globalRedColor().cgColor
        editChannelButton.layer.borderWidth = 1
        editChannelButton.setTitle("完成", for: .selected)
        
        NotificationCenter.default.addObserver(self, selector: #selector(longPressTarget), name: NSNotification.Name(rawValue: "longPressTarget"), object: nil)
    }
    @objc private func longPressTarget() {
        editChannelButton.isSelected = true
    }
    
    @IBOutlet weak var editChannelButton: UIButton!
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.channelReusableViewEditButtonClicked(sender)
    }
    
    /// 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
