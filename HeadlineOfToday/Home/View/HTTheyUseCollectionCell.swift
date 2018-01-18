//
//  HTTheyUseCollectionCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/9.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import Kingfisher

class HTTheyUseCollectionCell: UICollectionViewCell {
    
    var userCard: UserCard? {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: userCard!.user!.info!.avatar_url!))
            nameLabel.text = userCard!.user!.info!.name!
            subtitleLabel.text = userCard!.recommend_reason!
        }
    }

    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var concernButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.white
        closeButton.setImage(#imageLiteral(resourceName: "icon_popup_close_24x24_"), for: .normal)
    }

}
