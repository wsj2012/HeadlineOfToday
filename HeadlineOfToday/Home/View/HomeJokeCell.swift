//
//  HomeJokeCell.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/9.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import Kingfisher

class HomeJokeCell: UITableViewCell {
    
    var isJoke: Bool? {
        didSet {
            girlImageView.isHidden = isJoke!
        }
    }
    
    var joke: WeiTouTiao? {
        didSet {
            if let content = joke!.content {
                jokeLabel.text = content as String
            }
            if joke!.comment_count! == 0 {
                commentButton.setTitle("评论", for: .normal)
            }else {
                commentButton.setTitle(String(describing: joke!.comment_count!), for: .normal)
            }
            likeButton.setTitle(joke!.diggCount, for: .normal)
            dislikeButton.setTitle(joke!.buryCount, for: .normal)
            if let largeImage = joke!.large_image {
                
                girlImageView.kf.setImage(with: URL(string: largeImage.url!))
            }
        }
    }
    
    
    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        starButton.setImage(#imageLiteral(resourceName: "love_video_press_20x20_"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
