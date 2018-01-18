//
//  HTTheyAlsoUseCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/9.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTTheyAlsoUseCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var theyUse: WeiTouTiao? {
        didSet {
            leftLabel.text = theyUse!.title! as String
            rightButton.setTitle(theyUse!.show_more!, for: .normal)
            userCards = theyUse!.user_cards
            collectionView.reloadData()
        }
    }
    
    
    var userCards = [UserCard]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 215)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: HTTheyUseCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: HTTheyUseCollectionCell.self))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HTTheyAlsoUseCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HTTheyUseCollectionCell.self), for: indexPath) as! HTTheyUseCollectionCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 15, 10, 10)
    }
}
