//
//  HomeUserCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/9.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HomeUserCell: UITableViewCell {
    
    var weitoutiao: WeiTouTiao? {
        didSet {
            /// 发布者
            if let source = weitoutiao!.source {
                nameLabel.text = source
            }else if let user = weitoutiao!.user {
                avatarImageView.kf.setImage(with: URL(string: user.avatar_url!))
                nameLabel.text = user.screen_name!
            }else if let userInfo = weitoutiao!.user_info {
                avatarImageView.kf.setImage(with: URL(string: userInfo.avatar_url!))
                nameLabel.text = userInfo.screen_name!
            }else if let mediaInfo = weitoutiao!.media_info {
                nameLabel.text = mediaInfo.name!
                avatarImageView.kf.setImage(with: URL(string: mediaInfo.avatar_url!))
            }
            readCountLabel.text = "\(weitoutiao!.readCount!)阅读"
            verifiedContentLabel.text = weitoutiao!.verified_content!
            digButton.setTitle(weitoutiao!.diggCount!, for: .normal)
            commentButton.setTitle("\(weitoutiao!.commentCount!)", for: .normal)
            feedshareButton.setTitle(weitoutiao!.forwardCount!, for: .normal)
            contentLabel.text = weitoutiao!.content! as String
        }
    }
    

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var verifiedContentLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var concernButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var digButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var feedshareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        closeButton.setImage(#imageLiteral(resourceName: "dislikeicon_textpage_26x14_"), for: .normal)
        nameLabel.textColor = UIColor.black
        verifiedContentLabel.textColor = UIColor(r: 170, g: 170, b: 170)
        readCountLabel.textColor = UIColor(r: 170, g: 170, b: 170)
        contentView.backgroundColor = UIColor.white
        digButton.setImage(#imageLiteral(resourceName: "like_old_feed_24x24_"), for: .normal)
        digButton.setImage(#imageLiteral(resourceName: "like_old_feed_press_24x24_"), for: .selected)
        separatorView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        commentButton.setImage(#imageLiteral(resourceName: "comment_feed_24x24_"), for: .normal)
        feedshareButton.setImage(#imageLiteral(resourceName: "feed_share_24x24_"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
