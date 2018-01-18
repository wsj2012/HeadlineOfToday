//
//  HTToutiaohaoHeaderView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import SnapKit

protocol HTToutiaohaoHeaderViewDelegate {
    func toutiaohaoHeaderViewMoreConcernButtonClicked()
}

class HTToutiaohaoHeaderView: UIView {

    var delegate: HTToutiaohaoHeaderViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(moreButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var moreButton: UIButton = {
        let moreButton = UIButton(frame: CGRect(x: 10, y: 10, width: screenWidth - 20, height: 36))
        moreButton.addTarget(self, action: #selector(moreConcernButtonClicked), for: .touchUpInside)
        moreButton.setTitle("", for: .normal)
        moreButton.setTitleColor(UIColor(r: 230, g: 7, b: 20), for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreButton.setImage(#imageLiteral(resourceName: "addpgc_subscribe_16x16_"), for: .normal)
        moreButton.layer.borderColor = UIColor(r: 235, g: 235, b: 235).cgColor
        moreButton.layer.borderWidth = 1
        moreButton.layer.cornerRadius = 5
        moreButton.layer.masksToBounds = true
        return moreButton
    }()
    
    @objc func moreConcernButtonClicked() {
        delegate?.toutiaohaoHeaderViewMoreConcernButtonClicked()
    }
}
