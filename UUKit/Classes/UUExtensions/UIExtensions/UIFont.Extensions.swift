//
//  UIFontExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/16.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

extension UIFont {
    
    
    /// 屏幕宽度等比适配字体大小
    ///
    /// - Parameters:
    /// - ofSize: 375宽度下的字体大小
    /// - isFlexH: 是否水平等比缩放，默认false
    /// - Returns: 缩放后的字体大小
    public static func flex(ofSize: CGFloat, isFlexH: Bool = false) -> UIFont {
        if isFlexH {
            return UIFont.systemFont(ofSize:flexH(ofSize))
        } else {
            let screenWith = UIScreen.main.bounds.width
            if screenWith < 375.0 {
                return UIFont.systemFont(ofSize:ofSize - 2)
            } else if screenWith < 414.0 {
                return UIFont.systemFont(ofSize:ofSize)
            } else {
                return UIFont.systemFont(ofSize:ofSize + 1)
            }
        }
    }
    
    public static func flexBold(ofSize: CGFloat, isFlexH: Bool = false) -> UIFont {
        if isFlexH {
            return UIFont.boldSystemFont(ofSize:flexH(ofSize))
        } else {
            let screenWith = UIScreen.main.bounds.width
            if screenWith < 375.0 {
                return UIFont.boldSystemFont(ofSize:ofSize - 2)
            } else if screenWith < 414.0 {
                return UIFont.boldSystemFont(ofSize:ofSize)
            } else {
                return UIFont.boldSystemFont(ofSize:ofSize + 1)
            }
        }
    }
    
    
}

public extension UIFont {
    
    /// 设置等宽字体 " 16.regular.monospaced "
    var monospaced: UIFont {
        let traits = fontDescriptor.object(forKey: .traits) as? [String: Any] ?? [:]
        let weight = traits[UIFontDescriptor.TraitKey.weight.rawValue] as? CGFloat ?? UIFont.Weight.regular.rawValue
        return UIFont.monospacedDigitSystemFont(ofSize: pointSize, weight: UIFont.Weight(weight))
    }
    
}

