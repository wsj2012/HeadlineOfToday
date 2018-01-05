//
//  HTMainTabBarController.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/5.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let  tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor(r: 245, g: 90, b: 93, alpha: 1/0)
        addChildViewControllers()
        
    }
    
    func addChildViewControllers() {
        addChildViewController(HTHomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImage: "home_tabbar_press_32x32_")
        addChildViewController(HTVideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectedImage: "video_tabbar_press_32x32_")
        addChildViewController(HTWTouTiaoViewController(), title: "微头条", imageName: "weitoutiao_tabbar_32x32_", selectedImage: "weitoutiao_tabbar_press_32x32_")
        addChildViewController(HTMineViewController(), title: "未登录", imageName: "no_login_tabbar_32x32_", selectedImage: "no_login_tabbar_press_32x32_")
    }
    
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImage: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named:selectedImage)
        childController.title = title
        let navC = HTMainNavigationController(rootViewController: childController)
        navC.navigationItem.title = title
        addChildViewController(navC)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
