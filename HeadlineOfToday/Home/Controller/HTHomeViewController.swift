//
//  HTHomeViewController.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/5.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.globalBackgroundColor()
        // 设置状态属性
        navigationController?.navigationBar.barStyle = .black
        // 自定义导航栏
        navigationItem.titleView = homeNavigationBar
        
        navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        
        automaticallyAdjustsScrollViewInsets = false
        // 获取标题数据
        NetworkTool.loadHomeTitlesData(fromViewController: String(describing: HTHomeViewController.self)) { (topTitles, homeTopicVCs) in
            // 将所有字控制器添加到父控制器中
            for childVc in homeTopicVCs {
                self.addChildViewController(childVc)
            }
            self.setupUI()
            
            self.pageView.titles = topTitles
            self.pageView.childVcs = self.childViewControllers as? [HTHomeTopicViewController]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(r: 210, g: 63, b: 66)
    }
    
    
    fileprivate lazy var pageView: HTHomePageView = {
        let pageView = HTHomePageView()
        return pageView
    }()
    // 自定义导航栏
    fileprivate lazy var homeNavigationBar: HTHomeNavigationBar = {
        let homeNavigationBar = HTHomeNavigationBar()
        homeNavigationBar.searchBar.searchFiled.delegate = self
        return homeNavigationBar
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension HTHomeViewController {
    fileprivate func setupUI() {
        view.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(view).offset(kNavBarHeight)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeTitleAddButtonClicked(_:)), name: NSNotification.Name(rawValue: "homeTitleAddButtonClicked"), object: nil)
    }
    
    @objc func homeTitleAddButtonClicked(_ notification: Notification) {
        let titles = notification.object as! [HTHomeTopicTitle]
        let homeAddCategoryVC = HTHomeAddCategoryController.loadStoryboard()
        homeAddCategoryVC.homeTitles = titles
        homeAddCategoryVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - 20)))
        present(homeAddCategoryVC, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension HTHomeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationController?.pushViewController(HTHomeSearchViewController(), animated: false)
        return true
    }
}
