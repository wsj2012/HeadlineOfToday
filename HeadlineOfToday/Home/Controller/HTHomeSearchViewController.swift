//
//  HTHomeSearchViewController.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import SnapKit

class HTHomeSearchViewController: UITableViewController {
    
    var weitoutiaos = [WeiTouTiao]()
    
    var offset: Int = 0
    
    // 导航栏
    fileprivate lazy var searchNavigationView: HTSearchNavigationView = {
        let searchNavigationView = HTSearchNavigationView()
        searchNavigationView.delegate = self
        return searchNavigationView
    }()
    
    // 搜索界面默认背景
    fileprivate lazy var searchDefaultBGView: HTSearchDefaultBackgroundView = {
        let searchDefaultBGView = HTSearchDefaultBackgroundView.defalutBackgroundView()
        searchDefaultBGView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 180)
        return searchDefaultBGView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(true)
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
    }

}

extension HTHomeSearchViewController {
    fileprivate func setupUI() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        // 隐藏返回按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        // 设置自定义导航试图
        navigationItem.titleView = searchNavigationView
        // 添加背景VIEW
        tableView.addSubview(searchDefaultBGView)
        tableView.tableFooterView = UIView()
        
        NetworkTool.loadSearchResult(keyword: "", offset: offset) { (weitoutiaos) in
            self.weitoutiaos = weitoutiaos
            self.tableView.reloadData()
        }
    }
}

// MARK: - SearchNavigationViewDelegate
extension HTHomeSearchViewController: HTSearchNavigationViewDelegate, UITextFieldDelegate {
    func cancelButtonClicked() {
        navigationController?.popViewController(animated: false)
    }
}
