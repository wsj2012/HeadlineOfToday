//
//  HTHomeRelateNewsHeaderView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import Kingfisher

class HTHomeRelateNewsHeaderView: UIView {

    var filter_words = [WTTFilterWord]() {
        didSet {
            if filter_words.count > 0 {
                dislikePopView.filterWords = filter_words
            }
        }
    }
    
    // 标签
    var labels = [NewsDetailLabel]() {
        didSet {
            for (index, label) in labels.enumerated() {
                let button = UIButton(type: .custom)
                button.setTitle(label.word!, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.addTarget(self, action: #selector(labelButtonClciked(sender:)), for: .touchUpInside)
                button.backgroundColor = UIColor.globalBackgroundColor()
                button.layer.cornerRadius = 5
                button.layer.masksToBounds = true
                let width: CGFloat = 65
                let height: CGFloat = 30
                button.frame = CGRect(x: CGFloat(index) * (width + 5), y: 0, width: width, height: height)
                scrollView.addSubview(button)
                if index == labels.count - 1 {
                    scrollView.contentSize = CGSize(width: button.frame.maxX, height: scrollView.height)
                }
            }
        }
    }
    
    // 喜欢 /不喜欢
    var userLike: UserLike? {
        didSet {
            if let user_like = userLike {
                likeButton.setTitle(user_like.likeNum, for: .normal)
            }
        }
    }
    
    // app 广告信息
    var appInfo: NewsDetailAPPInfo? {
        didSet {
            if let app_info = appInfo {
                if let description = app_info.description {
                    titleLabel.text = description
                    closeButton.isHidden = true
                }
                if let videoInfo = app_info.video_info {
                    playButton.kf.setBackgroundImage(with: URL(string: videoInfo.cover_url!), for: .normal)
                    playButton.setImage(#imageLiteral(resourceName: "smallvideo_all_32x32_"), for: .normal)
                    closeButton.isHidden = true
                    timeLabel.text = app_info.video_info!.videoDuration!
                    timeLabel.isHidden = false
                    adLabel.isHidden = false
                }else {
                    adLabel.isHidden = true
                    timeLabel.text = "广告"
                    timeLabelWidth.constant = 30
                    self.layoutIfNeeded()
                }
                if let appName = app_info.app_name {
                    appNameLabel.text = appName
                }else if let sourceName = appInfo!.source_name {
                    sourceNameLabel.text = sourceName
                    sourceTitleLabel.text = appInfo!.title
                }
                adLabel.text = app_info.label!
                if let appImage = appInfo!.appImage {
                    playButton.kf.setBackgroundImage(with: URL(string: appImage.url!), for: .normal)
                }else if let image = appInfo!.image {
                    playButton.kf.setBackgroundImage(with: URL(string: image), for: .normal)
                }
                downloadButton.setTitle(app_info.button_text!, for: .normal)
            }
        }
    }
    
    @IBOutlet weak var sourceNameLabel: UILabel!
    
    @IBOutlet weak var sourceTitleLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var dislikeButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var adLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timeLabelWidth: NSLayoutConstraint!
    
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var appNameView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var appNameViewHeight: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = screenWidth
        likeButton.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        likeButton.layer.borderWidth = 1
        dislikeButton.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        dislikeButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        playButton.layer.borderWidth = 1
        downloadButton.layer.borderColor = UIColor.globalBlueColor().cgColor
        downloadButton.layer.borderWidth = 1
        appNameView.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        appNameView.layer.borderWidth = 1
    }
    
    @objc func labelButtonClciked(sender: UIButton) {
        
    }
    
    class func relateNewHeaderView() -> HTHomeRelateNewsHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! HTHomeRelateNewsHeaderView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.height = self.bottomView.frame.maxY
    }
    
    @IBAction func dislikeButtonClicked(_ sender: UIButton) {
        UIApplication.shared.keyWindow?.addSubview(dislikePopView)
    }
    
    
    fileprivate lazy var dislikePopView: HTDislikePopView = {
       let dislikePopView = HTDislikePopView.popView()
        return dislikePopView
    }()
    
    
    
}
