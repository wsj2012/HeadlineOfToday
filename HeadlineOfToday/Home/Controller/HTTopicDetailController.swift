//
//  HTTopicDetailController.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import MJRefresh
import SVProgressHUD
import Kingfisher
import IBAnimatable

class HTTopicDetailController: UIViewController {
    
    fileprivate var disposeBag = DisposeBag()
    
    var comments = [NewsDetailImageComment]()
    var relateNews = [WeiTouTiao]()
    var labels = [NewsDetailLabel]()
    var userLike: UserLike?
    var appInfo: NewsDetailAPPInfo?
    
    @IBOutlet weak var tableView: UITableView!
    
    var htmlString: String?
    
    var weitoutiao: WeiTouTiao? {
        didSet {
            if let user = weitoutiao!.user {
                navView.usernameLabel.text = user.name
                navView.avatarImageView.kf.setImage(with: URL(string: user.avatar_url!))
            }else if let userInfo = weitoutiao!.user_info {
                navView.usernameLabel.text = userInfo.name
                navView.avatarImageView.kf.setImage(with: URL(string: userInfo.avatar_url!))
            }else if let mediaInfo = weitoutiao!.media_info {
                navView.usernameLabel.text = mediaInfo.name
                navView.avatarImageView.kf.setImage(with: URL(string: mediaInfo.avatar_url!))
            }
            // 设置属性
            headerView.weitoutiao = weitoutiao!
            headerView.height = 45 + 2 * kMargin + weitoutiao!.newDetailTitleHeight!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        webView.loadHTMLString(htmlString!, baseURL: Bundle.main.bundleURL)
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: [.old, .new], context: nil)
        
        // 获取相关新闻高度
        
        NetworkTool.loadNewsDetailRelateNews(fromCategory: "", weitoutiao: self.weitoutiao!) { (relateNews, labels, userLike, appInfo, filter_words) in
            let relateHeaderViewHeight: CGFloat = 30
            var relateTableHeight: CGFloat = relateHeaderViewHeight
            for relatenews in relateNews {
                relateTableHeight += relatenews.relateNewsCellHeight!
            }
            self.webView.addSubview(self.headerView)
            self.webView.addSubview(self.relateNewsTableView)
            self.relateNews = relateNews
            self.relateNewsTableView.reloadData()
            self.relateNewsTableView.frame = CGRect(x: 0, y: self.webView.frame.maxY - relateTableHeight, width: screenWidth, height: relateTableHeight)
            self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.headerView.height, 0, self.relateNewsTableView.height + 30, 0)
        }
    }
    
    /// 标签，广告 作为头部
    fileprivate lazy var relateHeaderView: HTHomeRelateNewsHeaderView  = {
        let relateHeaderView = HTHomeRelateNewsHeaderView.relateNewHeaderView()
        relateHeaderView.x = 0
        relateHeaderView.y = 0
        return relateHeaderView
    }()
    
    /// 相关新闻列表的头部，添加
    fileprivate lazy var relateBackHeaderView: UIView = {
        let relateBackHeaderView = UIView()
        return relateBackHeaderView
    }()
    
    /// 头部 标题，用户名，关注按钮,添加到 webView
    fileprivate lazy var headerView: HTNewsDetailHeaderView = {
        let headerView = HTNewsDetailHeaderView.headerView()
        headerView.x = 0
        headerView.y = 0
        return headerView
    }()
    
    /// 相关新闻的 tableView， 添加到 webView
    fileprivate lazy var relateNewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 44
        tableView.showsVerticalScrollIndicator = false
        tableView.ym_registerCell(cell: HTDetailRelateNewsCell.self)
        return tableView
    }()
    
    /// 评论的头部,作为相关新闻列表的容器
    fileprivate lazy var commentBackHeaderView: UIView = {
        let commentBackHeaderView = UIView()
        return commentBackHeaderView
    }()
    
    /// 导航条
    fileprivate lazy var navView: HTConcernNavigationView = {
        let navView = HTConcernNavigationView.loadViewFromNib()
        navView.returnButton.setImage(#imageLiteral(resourceName: "lefterbackicon_titlebar_24x24_"), for: .normal)
        navView.moreButton.setImage(#imageLiteral(resourceName: "More_24x24_"), for: .normal)
        navView.delegate = self
        navView.bottomLine.isHidden = false
        return navView
    }()
    
    fileprivate lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
        return webView
    }()

}

// MARK: - webView KVO 实时改变webView的控件高度，使其高度跟内容高度一致
extension HTTopicDetailController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {()->Void in
                var frame: CGRect = self.webView.frame
                frame.size.height = self.webView.scrollView.contentSize.height //webView loadHtml加载后的内容高度
                self.webView.frame = frame
                self.tableView.tableHeaderView = self.webView
                // 获取评论
                NetworkTool.loadNewsDetailComments(offset: 0, weitoutiao: self.weitoutiao!, completionHandler: { (comments) in
                    self.comments = comments
                    self.tableView.reloadData()
                })
                
            })
        }
    }
}

extension HTTopicDetailController: WKNavigationDelegate {
    /// 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.offsetHeight") { (result, error) in
            var frame: CGRect = webView.frame
            frame.size.height = result! as! CGFloat
            webView.frame = frame
            self.tableView.tableHeaderView = webView
            // 更新relateNewsTable的frame
            self.relateNewsTableView.frame = CGRect(x: 0, y: webView.frame.maxY - self.relateNewsTableView.frame.height, width: screenWidth, height: self.relateNewsTableView.frame.height)
        }
    }
    
    /// 当开始请求时，会调用此方法
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /// 响应的内容到达主页面的时候响应,刚准备开始渲染页面应用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    /// 启动时加载数据发生错误就会调用这个方法
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("网页加载发生错误-----\(error)")
    }
    
}

extension HTTopicDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == relateNewsTableView {
            let relateNew = relateNews[indexPath.row]
            return relateNew.relateNewsCellHeight!
        }else {
            let comment = comments[indexPath.row]
            return comment.cellHeight!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == relateNewsTableView ? relateNews.count : comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == relateNewsTableView {
            let cell = relateNewsTableView.ym_dequeueReusableCell(indexPath: indexPath) as HTDetailRelateNewsCell
            let relatenews = relateNews[indexPath.row]
            cell.contenLabel.text = relatenews.title! as String
            return cell
        }else {
            let comment = comments[indexPath.row]
            let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as HTNewsDetailImageCommentCell
            ///判断评论是不是作者
            if let user = weitoutiao!.user {
                if comment.user_id! == user.user_id! {
                    cell.isAuthor = true
                }
            }else if let userInfo = weitoutiao!.user_info {
                if comment.user_id! == userInfo.user_id! {
                    cell.isAuthor = true
                }
            }else if let mediaInfo = weitoutiao!.media_info {
                if comment.user_id! == mediaInfo.user_id! {
                    cell.isAuthor = true
                }
            }
            cell.comment = comments[indexPath.row]
            cellClickedEvent(cell: cell)
            return cell
        }
    }
    
    /// 设置 presnet 出来的控制器
    private func setupPresentationController(cell: HTNewsDetailImageCommentCell) {
        let followDetailVC = HTFollowDetailViewController()
        followDetailVC.userid = cell.comment!.user_id!
        followDetailVC.dismissalAnimationType = .cover(from: .right)
        followDetailVC.presentationAnimationType = .cover(from: .right)
        followDetailVC.modalSize = (width: .full, height: .full)
        self.present(followDetailVC, animated: true, completion: nil)
    }
    
    /// cell按钮点击事件
    private func cellClickedEvent(cell: HTNewsDetailImageCommentCell) {
        // 头像按钮点击
        cell.avatarButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self!.setupPresentationController(cell: cell)
            })
            .disposed(by: disposeBag)
        // 用户名点击
        cell.nameLabel.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self!.setupPresentationController(cell: cell)
            })
            .disposed(by: disposeBag)
        // 点击了 评论内容或者回复
        cell.coverReplayButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
    }
    
    // scrollview 代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0 {
            // 把 头部的用户图片的 frame 转换到 view 的坐标
            let rect = headerView.convert(headerView.avatarImageView.frame, to: view)
            if rect.origin.y <= 0 {
                navView.vipImageView.isHidden = false
                navView.avatarImageView.isHidden = false
                navView.usernameLabel.isHidden = false
                navView.concernButton.isHidden = false
                if let userVerified = weitoutiao!.user_verified {
                    navView.vipImageView.isHidden = !userVerified
                }
            }else {
                navView.vipImageView.isHidden = true
                navView.avatarImageView.isHidden = true
                navView.usernameLabel.isHidden = true
                navView.concernButton.isHidden = true
            }
        }
    }
}

extension HTTopicDetailController {
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.ym_registerCell(cell: HTNewsDetailImageCommentCell.self)
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            // 获取评论数据
            NetworkTool.loadNewsDetailComments(offset: self!.comments.count, weitoutiao: self!.weitoutiao!, completionHandler: { (comments) in
                self!.tableView.mj_footer.endRefreshing()
                if comments.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多评论啦~~")
                    return
                }
                self!.comments += comments
                self!.tableView.reloadData()
            })
        })
        view.addSubview(navView)
    }
}

// MARK: - HTConcernNavigationViewDelegate
extension HTTopicDetailController: HTConcernNavigationViewDelegate {
    /// 返回按钮点击
    func concernHeaderViewReturnButtonClicked() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    /// 更多按钮点击
    func concernHeaderViewMoreButtonClicked() {
        
    }
}
