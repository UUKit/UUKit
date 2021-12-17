//
//  UIFontExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/16.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// 设置等宽字体 " 16.regular.monospaced "
    public var monospaced: UIFont {
        let traits = fontDescriptor.object(forKey: .traits) as? [String: Any] ?? [:]
        let weight = traits[UIFontDescriptor.TraitKey.weight.rawValue] as? CGFloat ?? UIFont.Weight.regular.rawValue
        return UIFont.monospacedDigitSystemFont(ofSize: pointSize, weight: UIFont.Weight(weight))
    }
    
}

