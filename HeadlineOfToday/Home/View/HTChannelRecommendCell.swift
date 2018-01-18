//
//  HTChannelRecommendCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTChannelRecommendCell: UICollectionViewCell, RegisterCellOrNib {

    @IBOutlet weak var titleButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
        titleButton.backgroundColor = UIColor.white
        titleButton.setImage(#imageLiteral(resourceName: "add_channel_titlbar_thin_new_16x16_"), for: .normal)
        layer.cornerRadius = 3
        titleButton.layer.shadowColor = UIColor(r: 240, g: 240, b: 240).cgColor
        titleButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        titleButton.layer.shadowOpacity = 1
        titleButton.layer.shadowRadius = 1
        titleButton.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

}
