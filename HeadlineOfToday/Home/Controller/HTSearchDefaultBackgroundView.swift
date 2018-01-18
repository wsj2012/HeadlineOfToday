//
//  HTSearchDefaultBackgroundView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/12.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTSearchDefaultBackgroundView: UIView {
    
    fileprivate var mainTitleLabel: UILabel = {
        let mainTitlelbel = UILabel()
        mainTitlelbel.font = UIFont.systemFont(ofSize: 21)
        mainTitlelbel.textAlignment = .center
        mainTitlelbel.textColor = UIColor.black
        mainTitlelbel.text = "搜索感兴趣的内容"
        return mainTitlelbel
    }()
    
    fileprivate var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 223, g: 223, b: 223)
        return line
    }()
    
    fileprivate var images: [UIImage] = [#imageLiteral(resourceName: "essay_discover_28x28_"), #imageLiteral(resourceName: "channel_discover_28x28_"), #imageLiteral(resourceName: "pgc_discover_28x28_"), #imageLiteral(resourceName: "video_discover_28x28_"), #imageLiteral(resourceName: "topic_discover_28x28_")]
    fileprivate var titles: [String] = ["文章", "频道", "头条号", "视频", "话题"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        
        addSubview(mainTitleLabel)
        addSubview(line)
        
        mainTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(48)
            make.left.right.equalTo(self)
            make.height.equalTo(46)
        }
        
        line.snp.makeConstraints { (make) in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(18)
            make.left.equalTo(self).offset(40)
            make.right.equalTo(self).offset(-40)
            make.height.equalTo(1)
        }
        
        let spaceX: CGFloat = (screenWidth - 250) / 2.0
        
        for (index, item) in images.enumerated() {
            let itemView = HTSearchItemView(frame: CGRect.zero, image: item, title: titles[index])
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(itemViewDidTaped(_:)))
            itemView.addGestureRecognizer(tapGes)
            addSubview(itemView)
            itemView.snp.makeConstraints({ (make) in
                make.top.equalTo(line.snp.bottom).offset(20)
                make.left.equalTo(self).offset(spaceX + CGFloat(50 * index))
                make.size.equalTo(CGSize(width: 50, height: 55))
            })
            
        }
    }
    
    @objc func itemViewDidTaped(_ tap: UITapGestureRecognizer) {
        print("\(String(describing: tap.view?.description))")
    }
    
    class func defalutBackgroundView() -> HTSearchDefaultBackgroundView{
        return HTSearchDefaultBackgroundView()
    }
}

class HTSearchItemView: UIView {
    
    private var iconImage: UIImageView = {
        let iconImage = UIImageView()
        return iconImage
        
    }()
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.gray
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private var image: UIImage?
    private var title: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, image: UIImage, title: String) {
        self.init(frame: frame)
        self.image = image
        self.title = title
        //width:50 height:55
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        
        addSubview(iconImage)
        addSubview(titleLabel)
        
        iconImage.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.size.equalTo(image!.size)
        }
        iconImage.image = image
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(17)
        }
        titleLabel.text = title
    }

}
