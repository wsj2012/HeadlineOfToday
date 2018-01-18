//
//  HTLeftCategoryCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTLeftCategoryCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var selectedIndicater: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var concern: HTHomeConcernToutiaohao? {
        didSet {
            nameLabel.text = concern!.name!
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.globalBackgroundColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectedIndicater.backgroundColor = selected ? UIColor.globalRedColor() : UIColor.clear
        selectedIndicater.isHidden = !selected
        contentView.backgroundColor = selected ? UIColor.white : UIColor.globalBackgroundColor()
        nameLabel.textColor = selected ? UIColor.globalRedColor() : UIColor.black
    }
    
}
