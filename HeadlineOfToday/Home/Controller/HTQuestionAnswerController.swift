//
//  HTQuestionAnswerController.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class HTQuestionAnswerController: UIViewController {
    
    fileprivate var disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var moreAnswerButton: UIButton!
    
    @IBOutlet weak var moreImageView: UIImageView!
    
    var topicTitle: HTHomeTopicTitle?
    
    var weitoutiao: WeiTouTiao?
    
    var answers = [Answer]()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /// 设置UI
        setupUI()
        
        /// 获取悟空回答数据
        NetworkTool.loadQuestionAnswerList(topicTitle: topicTitle!, weitoutiao: weitoutiao!) { (questionAnswer) in
            let module = questionAnswer.module_list.first
            self.moreImageView.kf.setImage(with: URL(string: module!.day_icon_url!))
            self.moreAnswerButton.setTitle(module!.text!, for: .normal)
            self.headerView.question = questionAnswer.question
            self.answers = questionAnswer.ans_list
            self.tableView.reloadData()
        }
    }

    lazy var headerView: HTQuestionHeaderView = {
        let headerView = HTQuestionHeaderView.headerView()
        return headerView
    }()
    
}

extension HTQuestionAnswerController {
    fileprivate func setupUI() {
        // 悟空回答图标
        let navImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 20))
        navImageView.image = #imageLiteral(resourceName: "wukonglogo_ask_bar_90x20_")
        navigationItem.titleView = navImageView
        // 右上角更多按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "More_24x24_"), style: .plain, target: self, action: #selector(moreBarButtonItemClicked))
        /// 设置导航栏样式
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor.white
        // 设置tableView
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.ym_registerCell(cell: HTAnswerCell.self)
        
        headerView.concernQuestionButton.rx.controlEvent(.touchUpInside)
                                        .subscribe(onNext: {[weak self] in
                                            let storyboard = UIStoryboard(name: "HTLoginPopViewController", bundle: nil)
                                            let moreLoginVC = storyboard.instantiateViewController(withIdentifier: "HTLoginPopViewController") as!  HTLoginPopViewController
                                            moreLoginVC.modalSize = (width: .custom(size: Float(screenWidth - 76)), height: .custom(size: Float(screenHeight - 262)))
                                            self!.present(moreLoginVC, animated: true, completion: nil)
                                        })
                                        .disposed(by: disposeBag)
    }
}

extension HTQuestionAnswerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.ym_dequeueReusableCell(indexPath: indexPath) as HTAnswerCell
        cell.answer = answers[indexPath.row]
        return cell
    }
}

/// MARK: - 按钮点击事件
extension HTQuestionAnswerController {
    
    /// 更多按钮点击
    @objc fileprivate func moreBarButtonItemClicked() {
        
    }
    
    /// 左侧按钮点击
    @IBAction func moreAnswerButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 底部回答按钮点击
    @IBAction func answerButtonClicked(_ sender: Any) {
        
    }
    
}
