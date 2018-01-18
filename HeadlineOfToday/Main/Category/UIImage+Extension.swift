//
//  UIImage+Extension.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/8.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

extension UIImage {
    /// 颜色转图片
    class func getImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
