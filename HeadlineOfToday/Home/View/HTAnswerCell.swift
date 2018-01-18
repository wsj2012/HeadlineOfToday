//
//  HTAnswerCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import Kingfisher

class HTAnswerCell: UITableViewCell, RegisterCellOrNib {
    
    var answer: Answer? {
        didSet {
            avatarButton.kf.setImage(with: URL(string: answer!.user!.avatar_url!), for: .normal)
            nameButton.setTitle(answer!.user!.uname!, for: .normal)
            digButton.setTitle("\(answer!.digg_count!)", for: .normal)
        }
    }
    // 头像
    @IBOutlet weak var avatarButton: UIButton!
    // 用户名
    @IBOutlet weak var nameButton: UIButton!
    // 点赞
    @IBOutlet weak var digButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
