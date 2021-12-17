//
//  UINibExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/16.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

@objc extension UINib {
    
    
    /// 判断xib文件是否存在
    ///
    /// - Parameter nibName: xib的文件名（类名）
    /// - Returns: 返回bool值，存在返回 true 不存在返回 false
    public static func isExist(_ nibName: String) -> Bool {
        guard Bundle.main.path(forResource: nibName, ofType: "nib") != nil else {
            return false
        }
        return true
    }
    
//    convenience init(_ anyClass: AnyClass) {
//        let className = type(of: anyClass)
//        let bundle = Bundle(for: className)
//        let name = NSStringFromClass(className).components(separatedBy: ".").last
//        UINib(nibName: name!, bundle: bundle)
//    }
        
}
