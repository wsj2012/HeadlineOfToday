//
//  HTThumbCollectionView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/9.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTThumbCollectionView: UICollectionView, RegisterCellOrNib {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func collectionViewWithFrame(frame: CGRect) -> HTThumbCollectionView {
        let layout = CollectionViewFlowLayout()
        return HTThumbCollectionView(frame: frame, collectionViewLayout: layout)
    }
    
}

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        //定义每个UICollectionView 的大小
//        let itemWidth = (screenWidth - kMargin * 2 - 12) / 3
//        itemSize = CGSize(width: itemWidth, height: itemWidth)
//定义每个UICollectionView 横向的间距
        minimumLineSpacing = 0
        //定义每个UICollectionView 纵向的间距
        minimumInteritemSpacing = 0
        //定义每个UICollectionView 的边距距
        self.sectionInset = UIEdgeInsetsMake(0, 3, 3, 3)
    }
}
