//
//  HTNewsDetailImageCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

protocol HTNewsDetailImageCellDelegate: class {
    func imageViewLongPressGestureRecognizer()
}

class HTNewsDetailImageCell: UICollectionViewCell, RegisterCellOrNib {
    
    weak var delegate: HTNewsDetailImageCellDelegate?
    
    var index: Int?
    var count: Int?
    
    var abstract: String? {
        didSet {
            let size = CGSize(width: screenWidth - 2 * kMargin, height: CGFloat(MAXFLOAT))
            let abstractHeight = abstract?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 18)], context: nil).size.height
            abstractLabelHeight.constant = abstractHeight! + 5
            self.layoutIfNeeded()
            
            let abstractAttributeString = NSAttributedString(string: abstract!, attributes: [.font: UIFont.systemFont(ofSize: 17)])
            
            let countAttributeStriing = NSMutableAttributedString(string: "/\(count!) ", attributes: [.font: UIFont.systemFont(ofSize: 13)])
            countAttributeStriing.append(abstractAttributeString)
            
            let numberAttributeString = NSMutableAttributedString(string: String(index!), attributes: [.font: UIFont.systemFont(ofSize: 17)])
            numberAttributeString.append(countAttributeStriing)
            // 方式2 ，和图片详情控制器里在 scrollView 的的代理里设置二者择一
            abstractLabel.attributedText = numberAttributeString
        }
    }
    
    
    @IBOutlet weak var abstractLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var abstractLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longRecognizerEvent))
        imageView.addGestureRecognizer(longRecognizer)
    }
    
    @objc func longRecognizerEvent() {
        delegate?.imageViewLongPressGestureRecognizer()
    }

}