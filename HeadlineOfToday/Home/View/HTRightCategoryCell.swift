//
//  HTRightCategoryCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTRightCategoryCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var concernButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var subConcern:SubConcern? {
        didSet {
            nameLabel.text = subConcern!.name!
            contentLabel.text = subConcern!.description!
            iconImageView.kf.setImage(with: URL(string: subConcern!.icon!))
            concernButton.isSelected = subConcern!.is_subscribed!
            if subConcern!.is_subscribed! {
                concernButton.layer.borderColor = UIColor.lightGray.cgColor
                concernButton.isSelected = true
                concernButton.setTitle("已关注", for: .selected)
            }else {
                concernButton.setTitle("关注", for: .normal)
                concernButton.layer.borderColor = UIColor(r: 42, g: 144, b: 215).cgColor
                concernButton.layer.borderWidth = 1
                concernButton.isSelected = false
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.globalBackgroundColor().cgColor
        concernButton.setTitleColor(UIColor.lightGray, for: .selected)
        concernButton.setTitleColor(UIColor(r: 42, g: 144, b: 215), for: .normal)
        concernButton.layer.borderColor = UIColor(r: 42, g: 144, b: 215).cgColor
        concernButton.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        if !sender.isSelected {
            // 关注
            NetworkTool.loadFollowInfo(user_id: subConcern!.user_id!, completionHandler: { (isFollowing) in
                if isFollowing {
                    self.concernButton.isSelected = true
                    self.concernButton.layer.borderWidth = 1
                    self.concernButton.layer.borderColor = UIColor.lightGray.cgColor
                }
            })
        }else {
            // 取消关注
            NetworkTool.loadUnfollowInfo(user_id: subConcern!.user_id!, completionHandler: { (isFollowing) in
                if !isFollowing {
                    self.concernButton.isSelected = false
                    self.concernButton.layer.borderWidth = 1
                    self.concernButton.layer.borderColor = UIColor(r: 42, g: 144, b: 215).cgColor
                }
            })
        }
    }
}
