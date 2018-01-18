//
//  HTSearchNavigationView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

protocol HTSearchNavigationViewDelegate: class {
    func cancelButtonClicked()
}

class HTSearchNavigationView: UIView {

    weak var delegate: HTSearchNavigationViewDelegate?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchBar: HTHomeSearchBar = {
        let searchBar = HTHomeSearchBar.searchBar()
        searchBar.searchFiled.placeholder = "请输入关键字"
        searchBar.searchFiled.tintColor = UIColor.black
        searchBar.searchFiled.background = #imageLiteral(resourceName: "searchbox_search_20x28_")
        return searchBar
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor(r: 40, g: 141, b: 206), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        return cancelButton
    }()
}

extension HTSearchNavigationView {
    
    fileprivate func setupUI() {
        
        addSubview(searchBar)
        addSubview(cancelButton)
        
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin)
            make.right.equalTo(cancelButton.snp.left).offset(-kMargin)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-kMargin)
            make.height.equalTo(searchBar)
        }
        
        searchBar.becomeFirstResponder()
    }
    
    @objc fileprivate func cancelButtonClick() {
        delegate?.cancelButtonClicked()
    }
    
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
            super.frame = newFrame
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
}
