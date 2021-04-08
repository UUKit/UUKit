//
//  OpenFuncs.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/8.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit


/// 获取项目名
///
/// - Returns: 项目名
public func AppName() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
}


/// 通过类名获取Swift的类（命名空间）
///
/// - Parameter aClassName: 类名
/// - Returns: 类
public func ClassFromString(_ aClassName: String) -> AnyClass? {
    let aSwiftClassName = AppName() + "." + aClassName
    if let aSwiftClass = NSClassFromString(aSwiftClassName) {
        return aSwiftClass
    }
    if let anOCClass = NSClassFromString(aClassName) {
        return anOCClass
    }
    print("错误信息:没有找到 \(aClassName) 这个类")
    return nil
}


/// 根据屏幕宽度，UI尺寸自适应屏幕尺寸，横向等比缩放标准 : 375.0
///
/// - Parameter floatValue: 传入值
/// - Returns: 等比缩放后的值
public func flexH(_ floatValue: CGFloat) -> CGFloat {
    let flexRatio = UIScreen.main.bounds.size.width / CGFloat(375.0)
    return floatValue * flexRatio
}


/// 根据屏幕高度，UI尺寸自适应屏幕尺寸，纵向等比缩放标准 : 667.0
///
/// - Parameter floatValue: 传入值
/// - Returns: 等比缩放后的值
public func flexV(_ floatValue: CGFloat) -> CGFloat {
    let flexRatio = UIScreen.main.bounds.size.height / CGFloat(667.0)
    return floatValue * flexRatio
}



