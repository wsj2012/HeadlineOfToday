//
//  HTHomeSearchBar.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/11.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

class HTHomeSearchBar: UIView {
    
    var searchFiled: UITextField = {
        let textField = UITextField()
        let searchIcon = UIImageView()
        searchIcon.image = #imageLiteral(resourceName: "searchicon_search_20x20_")
        searchIcon.width = 30
        searchIcon.height = 30
        searchIcon.contentMode = .center
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchFiled)
        searchFiled.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func searchBar() -> HTHomeSearchBar {
        return HTHomeSearchBar()
    }
    
}
