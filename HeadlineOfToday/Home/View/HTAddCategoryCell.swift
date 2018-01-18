//
//  HTAddCategoryCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

protocol HTAddCategoryCellDelegate: class {
    func deleteCategoryButtonClicked(of cell:HTAddCategoryCell)
}

class HTAddCategoryCell: UICollectionViewCell, RegisterCellOrNib {
    
    weak var delegate: HTAddCategoryCellDelegate?
    
    var isEdit = false {
        didSet {
            deleteCategoryButton.isHidden = !isEdit
        }
    }
    @IBOutlet weak var titleButton: UIButton!
    
    @IBOutlet weak var deleteCategoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func deleteCategoryButtonClicked(_ sender: UIButton) {
        delegate?.deleteCategoryButtonClicked(of: self)
    }
    
}
