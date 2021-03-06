//
//  HTHomeTopicViewController.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/5.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BMPlayer
import SnapKit
import MJRefresh
import SVProgressHUD

class HTHomeTopicViewController: UIViewController {
    
    var lastSelectedIndex = 0
    // 播放器
    fileprivate lazy var player = BMPlayer()
    fileprivate let disposeBag = DisposeBag()
    // 记录点击的顶部标题
    var topicTitle: HTHomeTopicTitle?
    // 存放新闻主题的数组
    var newsTopics = [WeiTouTiao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        if self.topicTitle!.category == "subscription" {
            tableView.tableHeaderView = toutiaohaoHeaderView
        }
        
        // 设置上下拉刷新
        setRefresh()
        
        /// 设置通知监听tabbar点击
        NotificationCenter.default.addObserver(self, selector: #selector(tabBarSelected), name: NSNotification.Name(rawValue: TabBarDidSelectedNotification), object: nil)
        
    }
    
    fileprivate lazy var toutiaohaoHeaderView: HTToutiaohaoHeaderView = {
        let toutiaohaoHeaderView = HTToutiaohaoHeaderView()
        toutiaohaoHeaderView.height = 56
        toutiaohaoHeaderView.delegate = self
        return toutiaohaoHeaderView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 232
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0)
        tableView.backgroundColor = UIColor(r: 246, g: 246, b: 246)
        return tableView
    }()

}

// MARK: - 头条号的代理
extension HTHomeTopicViewController: HTToutiaohaoHeaderViewDelegate {
    func toutiaohaoHeaderViewMoreConcernButtonClicked() {
        navigationController?.pushViewController(HTConcernToutiaohaoController(), animated: true)
    }
}

extension HTHomeTopicViewController {
    
    //设置UI
    fileprivate func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view)
        }
    }
    
    // 设置上拉合下拉
    @objc fileprivate func setRefresh() {
        let header = RefreshHeader {[weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.topicTitle!.category!, completionHandler: { (nowTime, newsTopics) in
                self!.tableView.mj_header.endRefreshing()
                self!.newsTopics = newsTopics
                self!.tableView.reloadData()
            })
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer =  MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.topicTitle!.category!, completionHandler: { (nowTime, newsTopics) in
                self!.tableView.mj_footer.endRefreshing()
                if newsTopics.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多新闻啦~~")
                    return
                }
                self!.newsTopics += newsTopics
                self!.tableView.reloadData()
            })
        })
    }
    
    // 监听tabBar 点击
    @objc fileprivate func tabBarSelected() {
        if lastSelectedIndex != tabBarController!.selectedIndex {
            tableView.mj_header.beginRefreshing()
        }
        lastSelectedIndex = tabBarController!.selectedIndex
    }
}

// MARK: - Table view data source
extension HTHomeTopicViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if topicTitle!.category == "video" {
            return screenHeight * 0.4
        } else if topicTitle!.category == "subscription" { // 头条号
            return 68
        } else if topicTitle!.category == "essay_joke" { // 段子
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.jokeCellHeight!
        } else if topicTitle!.category == "组图" { // 组图
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.imageCellHeight!
        } else if topicTitle!.category == "image_ppmm" { // 组图
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.girlCellHeight!
        } else {
            let weitoutiao = newsTopics[indexPath.row]
            if weitoutiao.cell_type! == 32 { // 用户
                let weitoutiao = newsTopics[indexPath.row]
                return weitoutiao.contentHeight!
            } else if weitoutiao.cell_type! == 50 { // 他们也在用头条
                return 290
            }
            return weitoutiao.homeCellHeight!
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicTitle!.category == "subscription" {
            return 10
        } else {
            return newsTopics.count
        }
    }
    
    /// 说明是视频，显示视频 cell
    private func showVideoCell(indexPath: IndexPath) -> HTVideoTopicCell {
        let cell = Bundle.main.loadNibNamed(String(describing: HTVideoTopicCell.self), owner: nil, options: nil)?.last as! HTVideoTopicCell
        cell.videoTopic = newsTopics[indexPath.row]
        cell.headCoverButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                let userVC = HTFollowDetailViewController()
                userVC.userid = cell.videoTopic!.media_info!.user_id!
                self!.navigationController!.pushViewController(userVC, animated: true)
            })
            .disposed(by: disposeBag)
        // 评论按钮点击
        cell.commentButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                let videoDetailVC = HTVideoDetailController()
                videoDetailVC.videoTopic = cell.videoTopic
                self!.navigationController!.pushViewController(videoDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
        // 播放按钮点击
        cell.bgImageButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                cell.bgImageButton.addSubview(self!.player)
                self!.player.snp.makeConstraints { (make) in
                    make.edges.equalTo(cell.bgImageButton)
                }
                /// 获取视频的真实链接
                NetworkTool.parseVideoRealURL(video_id: cell.videoTopic!.video_id!) { (realVideo) in
                    self!.player.backBlock = { (isFullScreen) in
                        if isFullScreen == true {
                            return
                        }
                    }
                    let asset = BMPlayerResource(url: URL(string: realVideo.video_1!.main_url!)!, name: cell.titleLabel.text!)
                    self!.player.setVideo(resource: asset)
                }
            })
            .disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if topicTitle!.category == "video" { // 视频
            return showVideoCell(indexPath: indexPath)
        } else if topicTitle!.category == "subscription" { // 头条号
            let cell = Bundle.main.loadNibNamed(String(describing: HTToutiaohaoCell.self), owner: nil, options: nil)?.last as! HTToutiaohaoCell
            // cell.myConcern = myConcerns[indexPath.row]
            return cell
        } else if topicTitle!.category == "essay_joke" { // 段子
            let cell = Bundle.main.loadNibNamed(String(describing: HomeJokeCell.self), owner: nil, options: nil)?.last as! HomeJokeCell
            cell.isJoke = true
            cell.joke = newsTopics[indexPath.row]
            return cell
        } else if topicTitle!.category == "组图" { // 组图
            let cell = Bundle.main.loadNibNamed(String(describing:  HomeImageTableCell.self), owner: nil, options: nil)?.last as! HomeImageTableCell
            cell.homeImage = newsTopics[indexPath.row]
            return cell
        } else if topicTitle!.category == "image_ppmm" { // 组图
            let cell = Bundle.main.loadNibNamed(String(describing:  HomeJokeCell.self), owner: nil, options: nil)?.last as! HomeJokeCell
            cell.isJoke = false
            cell.joke = newsTopics[indexPath.row]
            return cell
        } else {
            let weitoutiao = newsTopics[indexPath.row]
            if weitoutiao.cell_type! == 32 { // 用户
                let cell = Bundle.main.loadNibNamed(String(describing:  HomeUserCell.self), owner: nil, options: nil)?.last as! HomeUserCell
                cell.weitoutiao = newsTopics[indexPath.row]
                return cell
            } else if weitoutiao.cell_type! == 50 { // 相关关注
                let cell = Bundle.main.loadNibNamed(String(describing: HTTheyAlsoUseCell.self), owner: nil, options: nil)?.last as!  HTTheyAlsoUseCell
                cell.theyUse = newsTopics[indexPath.row]
                return cell
            }
            let cell = Bundle.main.loadNibNamed(String(describing: HTHomeTopicCell.self), owner: nil, options: nil)?.last as! HTHomeTopicCell
            cell.weitoutiao = weitoutiao
            if weitoutiao.has_video! { // 说明是视频
                cell.videoView.imageButton.rx.controlEvent(.touchUpInside)
                    .subscribe(onNext: { [weak self] in
                        /// 获取视频真实链接跳转到视频详情控制器
                        self!.getRealVideoURL(weitoutiao: weitoutiao)
                    })
//                    .addDisposableTo(disposeBag)
                    .disposed(by: disposeBag)
            }
            return cell
        }
    }
    
    /// 获取视频的真实链接跳转到视频详情控制器
    private func getRealVideoURL(weitoutiao: WeiTouTiao) {
        NetworkTool.parseVideoRealURL(video_id: weitoutiao.video_id!) { (realVideo) in
            let videoDetailVC = HTVideoDetailController()
            videoDetailVC.videoTopic = weitoutiao
            videoDetailVC.realVideo = realVideo
            self.navigationController?.pushViewController(videoDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weitoutiao = newsTopics[indexPath.row]
        if indexPath.row == 0 && topicTitle!.category == "" { // 默认设置点击第一个 cell 跳转到图片详情界面
            let newsDetailImageVC = HTNewsDetailImageController.loadStoryboard()
            newsDetailImageVC.isSelectedFirstCell = true
            weitoutiao.item_id = 6450240420034118157
            weitoutiao.group_id = 6450237670911852814
            newsDetailImageVC.weitoutiao = weitoutiao
            present(newsDetailImageVC, animated: false, completion: nil)
        } else {
            if topicTitle!.category == "video" || weitoutiao.has_video! {
                /// 获取视频的真实链接
                getRealVideoURL(weitoutiao: weitoutiao)
            } else if topicTitle!.category == "subscription" {
                
            } else if topicTitle!.category == "组图" {
                
            } else if topicTitle!.category == "essay_joke" {
                
            } else if topicTitle!.category == "image_ppmm" {
                
            } else if (weitoutiao.source != nil && weitoutiao.source == "悟空问答") { // 悟空问答
                let questionAnswerVC = HTQuestionAnswerController()
                questionAnswerVC.weitoutiao = weitoutiao
                questionAnswerVC.topicTitle = topicTitle
                navigationController?.pushViewController(questionAnswerVC, animated: true)
            } else if (weitoutiao.has_image != nil && weitoutiao.has_image!) { // 说明有图片
                loadNewsDetail(weitoutiao: weitoutiao)
            } else { // 一般的新闻
                loadNewsDetail(weitoutiao:  weitoutiao)
            }
        }
    }
    /// 获取新闻详情
    private func loadNewsDetail(weitoutiao: WeiTouTiao) {
        if let articleURL = weitoutiao.article_url {
            NetworkTool.loadCommenNewsDetail(articleURL: articleURL, completionHandler: { (htmlString, images, abstracts) in
                if images.count > 0 { // 说明是图文详情
                    let newsDetailImageVC = HTNewsDetailImageController.loadStoryboard()
                    newsDetailImageVC.weitoutiao = weitoutiao
                    newsDetailImageVC.images = images
                    newsDetailImageVC.abstracts = abstracts
                    self.present(newsDetailImageVC, animated: false, completion: nil)
                } else { // 说明是一般的新闻
                    let topicDetailVC = HTTopicDetailController()
                    topicDetailVC.weitoutiao = weitoutiao
                    topicDetailVC.htmlString = htmlString
                    self.navigationController?.pushViewController(topicDetailVC, animated: true)
                }
            })
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if player.isPlaying { // 说明有正在播放的视频
            let imageButton = player.superview
            let contentView = imageButton?.superview
            let cell = contentView?.superview as! HTVideoTopicCell
            let rect = tableView.convert(cell.frame, to: view)
            if (rect.origin.y <= -cell.height) || (rect.origin.y >= screenHeight - kTabBarHeight) {
                player.pause()
                player.removeFromSuperview()
            }
        }
    }
}
