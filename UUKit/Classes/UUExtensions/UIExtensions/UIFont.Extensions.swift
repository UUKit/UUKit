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

/**
 创建字体：label.font = UIFont._17.bold.medium.monospaced
 */
public extension UIFont {
    
    static var _08: UIFont {
        return UIFont.systemFont(ofSize: 08)
    }
    
    static var _09: UIFont {
        return UIFont.systemFont(ofSize: 09)
    }
    
    static var _10: UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
    static var _11: UIFont {
        return UIFont.systemFont(ofSize: 11)
    }
    
    static var _12: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    static var _13: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
    static var _14: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    static var _15: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    static var _16: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static var _17: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    
    static var _18: UIFont {
        return UIFont.systemFont(ofSize: 18)
    }
    
    static var _19: UIFont {
        return UIFont.systemFont(ofSize: 19)
    }
    
    static var _20: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    
    static var _21: UIFont {
        return UIFont.systemFont(ofSize: 21)
    }
    
    static var _22: UIFont {
        return UIFont.systemFont(ofSize: 22)
    }
    
    static var _23: UIFont {
        return UIFont.systemFont(ofSize: 23)
    }
    
    static var _24: UIFont {
        return UIFont.systemFont(ofSize: 24)
    }
    
}

public extension UIFont {
    
    /// 设置等宽字体 "UIFont._16.monospaced"
    var monospaced: UIFont {
        let traits = fontDescriptor.object(forKey: .traits) as? [String: Any] ?? [:]
        let weight = traits[UIFontDescriptor.TraitKey.weight.rawValue] as? CGFloat ?? UIFont.Weight.regular.rawValue
        return UIFont.monospacedDigitSystemFont(ofSize: pointSize, weight: UIFont.Weight(weight))
    }
    
}


public extension UIFont {
    
    var ultraLight: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .ultraLight)
    }
    
    var thin: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .thin)
    }
    
    var light: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .light)
    }
    
    var regular: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .regular)
    }
    
    var medium: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .medium)
    }
    
    var semibold: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .semibold)
    }
    
    var bold: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .bold)
    }
    
    var heavy: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .heavy)
    }
    
    var black: UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: .black)
    }
    
}

protocol UUFountProtocol {
    
    var fontSize: CGFloat { get }
    
}


extension UInt8: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int8: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt16: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int16: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt32: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int32: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt64: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int64: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Float: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension CGFloat: UUFountProtocol {
    public var fontSize: CGFloat { return self }
}

extension NSNumber: UUFountProtocol {
    public var fontSize: CGFloat { return CGFloat(doubleValue) }
}

