//
//  HTDislikePopView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import SVProgressHUD

class HTDislikePopView: UIView {

    var filterWords = [WTTFilterWord]() {
        didSet {
            self.popViewHeight.constant = 81 + CGFloat(filterWords.count * 40)
            self.layoutIfNeeded()
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var popViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = screenWidth
        self.height = screenHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: HTDislikeCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HTDislikeCell.self))
        
    }
    
    class func popView() -> HTDislikePopView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! HTDislikePopView
    }
    
    func show() {
        UIView.animate(withDuration: 0.25) {
            self.bottomMargin.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomMargin.constant = -self.popViewHeight.constant
            self.layoutIfNeeded()
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @IBAction func finishButtonClicked(_ sender: UIButton) {
        dismiss()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
}

extension HTDislikePopView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HTDislikeCell.self), for: indexPath) as! HTDislikeCell
        let word = filterWords[indexPath.row]
        cell.wordLabel.text = word.name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HTDislikeCell.self), for: indexPath) as! HTDislikeCell
        SVProgressHUD.showInfo(withStatus: cell.wordLabel.text!)
        dismiss()
        
    }
}

