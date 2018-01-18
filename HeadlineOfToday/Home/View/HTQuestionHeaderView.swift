//
//  HTQuestionHeaderView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTQuestionHeaderView: UIView {
    
    var question: Question? {
        didSet {
            // 设置顶部标签数据
            if question?.concern_tag_list.count == 0 {
                scrollViewHeight.constant = 0
            }else {
                scrollViewHeight.constant = 45
                for (index, concernTag) in question!.concern_tag_list.enumerated() {
                    let button = UIButton(type: .custom)
                    button.setTitle(concernTag.name, for: .normal)
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                    button.backgroundColor = UIColor.globalBackgroundColor()
                    button.layer.cornerRadius = 5
                    button.layer.masksToBounds = true
                    let width: CGFloat = 65
                    let height: CGFloat = 30
                    button.frame = CGRect(x: CGFloat(index) * (width + 5), y: 0, width: width, height: height)
                    scrollView.addSubview(button)
                    if index == question!.concern_tag_list.count - 1 {
                        scrollView.contentSize = CGSize(width: button.frame.maxX, height: scrollView.height)
                    }
                }
            }
            
            /// 设置问题的标题
            titleLabel.text = question?.title!
            /// 设置问题的内容
            if question!.content!.text! == "" {
                contentLabelHeight.constant = 0
                unfoldButtonWidth.constant = 0
            }else {
                contentLabel.text = question!.content!.text! as String
                let size = CGSize(width: CGFloat(MAXFLOAT), height: 35)
                let width = question!.content!.text!.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 16)], context: nil).size.width
                // 74 = 2X间距 + 展开按钮的宽度
                if width >= screenHeight - 74 {
                    contentLabel.width = screenWidth - 30
                    unfoldButtonWidth.constant = 0
                }
            }
            layoutIfNeeded()
            answerCountLabel.text = "\(question!.answer_count!)"
            concernCountLabel.text = "\(question!.follow_count!)"
        }
    }
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var unfoldButton: UIButton!
    
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var answerCountLabel: UILabel!
    
    @IBOutlet weak var concernCountLabel: UILabel!
    
    @IBOutlet weak var concernQuestionButton: UIButton!
    
    @IBOutlet weak var inviteAnswerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func unfoldButtonClicked(_ sender: UIButton) {
        sender.isHidden = true
        contentLabelHeight.constant = question!.content!.textH!
        unfoldButtonWidth.constant = 0
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.height = topView.height + middleView.height + 85
    }
    
    class func headerView() -> HTQuestionHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! HTQuestionHeaderView
    }
}
