//
//  HTNewsDetailHeaderView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import Kingfisher

class HTNewsDetailHeaderView: UIView {

    var weitoutiao: WeiTouTiao? {
        didSet {
            titleLabel.text = weitoutiao!.title! as String
            timeLabel.text = weitoutiao!.createTime
            if let user = weitoutiao!.user {
                avatarImageView.kf.setImage(with: URL(string: user.avatar_url!))
                nameLabel.text = user.screen_name
                if let islFollowing = user.is_following {
                    concernButton.isSelected = islFollowing
                }
            }else if let user_info = weitoutiao!.user_info {
                avatarImageView.kf.setImage(with: URL(string: user_info.avatar_url!))
                nameLabel.text = user_info.name
                if let isFollowing = user_info.is_following {
                    concernButton.isSelected = isFollowing
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        concernButton.setTitle("已关注", for: .selected)
        concernButton.setTitleColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.6), for: .selected)
        self.width = screenWidth
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var concernButton: UIButton!
    
    class func headerView() -> HTNewsDetailHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! HTNewsDetailHeaderView
    }
    
}
