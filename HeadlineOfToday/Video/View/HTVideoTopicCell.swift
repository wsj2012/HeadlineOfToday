//
//  HTVideoTopicCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/8.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import Kingfisher

class HTVideoTopicCell: UITableViewCell, RegisterCellOrNib {

    /// 标题 label
    @IBOutlet weak var titleLabel: UILabel!
    /// 播放数量
    @IBOutlet weak var playCountLabel: UILabel!
    /// 时间 label
    @IBOutlet weak var timeLabel: UILabel!
    /// 背景图片
    @IBOutlet weak var bgImageButton: UIButton!
    /// 用户头像
    @IBOutlet weak var headButton: UIButton!
    @IBOutlet weak var headCoverButton: UIButton!
    /// 用户昵称
    @IBOutlet weak var nameLable: UILabel!
    /// 关注数量
    @IBOutlet weak var concernButton: UIButton!
    /// 评论数量
    @IBOutlet weak var commentButton: UIButton!
    /// 更多按钮
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var bottomLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headButton.layer.cornerRadius = 15
        headButton.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor.white
        nameLable.textColor = UIColor.black
        commentButton.setTitleColor(UIColor.black, for: .normal)
        concernButton.setTitleColor(UIColor.black, for: .normal)
        bottomLineView.backgroundColor = UIColor.init(r: 240, g: 240, b: 240)
        playCountLabel.textColor = UIColor.init(r: 200, g: 200, b: 200)
        concernButton.setImage(#imageLiteral(resourceName: "video_add_24x24_") , for: .normal)
        commentButton.setImage(#imageLiteral(resourceName: "comment_24x24_"), for: .normal)
        moreButton.setImage(#imageLiteral(resourceName: "More_24x24_"), for: .normal)
        bgImageButton.setImage(#imageLiteral(resourceName: "video_play_icon_44x44_"), for: .normal)
    }
    
    var videoTopic: WeiTouTiao? {
        didSet {
            bgImageButton.kf.setBackgroundImage(with: URL(string: (videoTopic!.video_detail_info?.detail_video_large_image?.url)!), for: .normal)
            titleLabel.text = String(describing: videoTopic!.title!)
            if let user_info = videoTopic!.user_info {
                headButton.kf.setImage(with: URL(string: user_info.avatar_url!)!, for: .normal)
                nameLable.text = user_info.name!
            }
            if videoTopic!.comment_count! == 0 {
                commentButton.setTitle("评论", for: .normal)
            } else {
                commentButton.setTitle(String(describing: videoTopic!.comment_count!), for: .normal)
            }
            playCountLabel.text = videoTopic!.readCount! + "次播放"
            timeLabel.text = videoTopic!.video_duration!
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// 背景按钮点击
    @IBAction func bgImageButtonClick(_ sender: UIButton) {
        /// 获取视频的真实链接
        NetworkTool.parseVideoRealURL(video_id: videoTopic!.video_id!) { (realVideo) in

        }
    }
    
}
