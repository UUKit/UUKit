//
//  CGFloatExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/4.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

///**************************************************************
///**************************************************************
/// 此处为UI设计模板的尺寸，如需使用等比设置界面尺寸，需要对应修改此值 //****
public let UITemplateSize = CGSize(width: 375, height: 667)//****
///**************************************************************
///**************************************************************

extension CGFloat {
    
    /// 返回一个浮点数的一半
    public var half: CGFloat { return (self / 2.0) }
    
    public var flexH: CGFloat {
        return self * UIScreen.main.bounds.size.width / CGFloat(UITemplateSize.width)
    }
    
    public var flexV: CGFloat {
        return self * UIScreen.main.bounds.size.height / CGFloat(UITemplateSize.height)
    }
    
//    ///返回包括0和1.0之间的随机浮点数
//    static var random0_1: CGFloat {
//        return CGFloat(CGFloat(arc4random()) / 0xFFFFFFFF)
//    }
    
}

extension Float {
    
    /// 返回一个浮点数的一半
    public var half: Float { return (self / 2.0) }
    
    public var flexH: Float {
        return self * Float(UIScreen.main.bounds.size.width) / Float(UITemplateSize.width)
    }
    
    public var flexV: Float {
        return self * Float(UIScreen.main.bounds.size.height) / Float(UITemplateSize.height)
    }
    
//    ///返回包括0和1.0之间的随机浮点数
//    public static var random0_1: Float {
//        return Float(CGFloat(arc4random()) / 0xFFFFFFFF)
//    }
    
}

