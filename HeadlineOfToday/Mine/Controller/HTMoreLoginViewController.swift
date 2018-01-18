//
//  HTMoreLoginViewController.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/10.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit
import IBAnimatable

class HTMoreLoginViewController: AnimatableModalViewController, StoryboardLoadable {
    
    @IBOutlet weak var mobileView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var verifyCodeView: UIView!
    
    @IBOutlet weak var findPasswordView: UIView!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var sendVerifyCodeButton: AnimatableButton!
    
    @IBOutlet weak var findPasswordButton: AnimatableButton!
    
    @IBOutlet weak var middleTipLabel: UILabel!
    
    @IBOutlet weak var loginModeButton: UIButton!
    
    @IBOutlet weak var inTouTiaoButton: AnimatableButton!
    
    @IBOutlet weak var readButton: UIButton!
    
    @IBOutlet weak var readLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginModeButton.setTitle("免密码登录", for: .selected)
        view.backgroundColor = UIColor.white
        topLabel.textColor = UIColor.black
        middleTipLabel.textColor = UIColor(r: 170, g: 170, b: 170)
        readLabel.textColor = UIColor.black
        inTouTiaoButton.backgroundColor = UIColor(r: 249, g: 169, b: 169)
        readButton.setImage(#imageLiteral(resourceName: "details_choose_ok_icon_15x15_"), for: .normal)
        readButton.setImage(#imageLiteral(resourceName: "details_choose_icon_15x15_"), for: .selected)
        mobileView.backgroundColor = UIColor.white
        passwordView.backgroundColor = UIColor.white
        inTouTiaoButton.setTitleColor(UIColor.white, for: .normal)
    }
    
}

/// MARK: - 点击事件
extension HTMoreLoginViewController {
    
    /// 阅读按钮点击
    @IBAction func readButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func closeLoginViewButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 进入头条按钮点击
    @IBAction func goInTouTiaoButtonClicked() {
        
    }
    
    /// 登录方式按钮点击
    @IBAction func loginModeButonClicked(_ sender: UIButton) {
        loginModeButton.isSelected = !sender.isSelected
        verifyCodeView.isHidden = sender.isSelected
        findPasswordView.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        passwordTextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "帐号密码登录" : "登录你的头条，精彩永不消失"
    }
}

extension HTMoreLoginViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
