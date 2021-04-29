//
//  UIColorExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/4.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit


// 0xB2B2B2 // 警告框按钮分割线颜色值
// 0xDCDCDD // 警告框按钮高亮时颜色值

public extension UIColor {
    
    /// UIColor(r: 95, g: 199, b: 220)，透明度（0 ~ 1）
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// UIColor(hex: 0x5fc7dc)，透明度（0 ~ 1）
    convenience init(hexInt: UInt64, alpha: CGFloat = 1.0) {
        let r = CGFloat((hexInt & 0xff0000) >> 16)
        let g = CGFloat((hexInt & 0x00ff00) >> 8)
        let b = CGFloat( hexInt & 0x0000ff)
        self.init(r, g, b, a: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let formattedHEX = hexString
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "0X", with: "")
            .replacingOccurrences(of: "#" , with: "")
        let scanner = Scanner(string: "0x\(formattedHEX)")
        scanner.scanLocation = 0
        var hexInt: UInt64 = 0
        scanner.scanHexInt64(&hexInt)
        self.init(hexInt: hexInt, alpha: alpha)
    }
    
    /// 获取颜色对应的16进制数值
    var toHexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "0x%02X%02X%02X", Int(r * 0xff), Int(g * 0xff), Int(b * 0xff))
    }
    
    /// 随机色 UIColor.random
    static var random: UIColor {
        return UIColor(CGFloat(arc4random_uniform(256)),
                       CGFloat(arc4random_uniform(256)),
                       CGFloat(arc4random_uniform(256)))
    }
    
}

//MARK:- 增加基础属性
extension UIColor {

    func rgb() -> UInt32? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return UInt32(rgb)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }

    /**
    *  将当前色值转换为hex字符串，通道排序是AARRGGBB（与Android保持一致）
    *  @return 色值对应的 hex 字符串，以 # 开头，例如 #00ff00ff
    */
    func hexString() -> String {
        return String("#\(rgb())")
    }
    /**
    *  获取当前 UIColor 对象里的红色色值
    *
    *  @return 红色通道的色值，值范围为0.0-1.0
    */
    func redValue() -> CGFloat {
        guard let rgbInt = rgb() else {
            return CGFloat(0)
        }
        return CGFloat((rgbInt >> 16) << 8)/255.0
    }

    /**
     *  获取当前 UIColor 对象里的绿色色值
     *
     *  @return 绿色通道的色值，值范围为0.0-1.0
     */
    func greenValue() -> CGFloat {
        guard let rgbInt = rgb() else {
            return CGFloat(0)
        }
        return CGFloat((rgbInt >> 8) << 16)/255.0
    }
    /**
    *  获取当前 UIColor 对象里的蓝色色值
    *
    *  @return 蓝色通道的色值，值范围为0.0-1.0
    */
    func blueValue() -> CGFloat {
        guard let rgbInt = rgb() else {
            return CGFloat(0)
        }
        return CGFloat(rgbInt << 24)/255.0
    }

    /**
    *  获取当前 UIColor 对象里的透明色值
    *
    *  @return 透明通道的色值，值范围为0.0-1.0
    */
    func alphaValue() -> CGFloat {
        guard let rgbInt = rgb() else {
            return CGFloat(0)
        }
        return CGFloat(rgbInt >> 24)/255.0
    }

    /**
    *  将当前UIColor对象剥离掉alpha通道后得到的色值。相当于把当前颜色的半透明值强制设为1.0后返回
    *
    *  @return alpha通道为1.0，其他rgb通道与原UIColor对象一致的新UIColor对象
    */
    func colorWithoutAlpha() -> UIColor {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha: CGFloat = 1
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
             return UIColor(red: red, green:green, blue: blue, alpha: CGFloat(1))
        } else {
            // Could not extract RGBA components:
            return .white
        }
    }

    /**
     *  判断当前颜色是否为深色，可用于根据不同色调动态设置不同文字颜色的场景。
     *
     *  @link http://stackoverflow.com/questions/19456288/text-color-based-on-background-image @/link
     *
     *  @return 若为深色则返回“YES”，浅色则返回“NO”
     */
    func isDark() -> Bool {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let referenceValue:CGFloat = 0.411
            let colorDelta = (red * 0.299) + (green * 0.587) + (blue * 0.114)
            return 1.0 - colorDelta > referenceValue
        } else {
            // Could not extract RGBA components:
            return false
        }
    }



}


//MARK:- 扩展构造工厂方法
extension UIColor {

    /**
    *  使用HEX命名方式的颜色字符串生成一个UIColor对象
    *
    *  @param hexString 支持以 # 开头和不以 # 开头的 hex 字符串
    *      #RGB        例如#f0f，等同于#ffff00ff，RGBA(255, 0, 255, 1)
    *      #ARGB       例如#0f0f，等同于#00ff00ff，RGBA(255, 0, 255, 0)
    *      #RRGGBB     例如#ff00ff，等同于#ffff00ff，RGBA(255, 0, 255, 1)
    *      #AARRGGBB   例如#00ff00ff，等同于RGBA(255, 0, 255, 0)
    *
    * @return UIColor对象
    */
//    static func hexString(_ hexString: String) -> UIColor {
//        guard hexString.count > 0 else {
//            assert(false, "你敢传个色值吗")
//            return .white
//        }
//        var alpha:Float = 1, red:Float = 1, blue:Float = 1, green:Float = 1
//
//        let colorString = hexString.replacingOccurrences(of: "#", with: "").uppercased()
//        switch colorString.count {
//        case 3:// #RGB
//            red   = component(from: colorString, start: 0, lenght: 1)
//            green = component(from: colorString, start: 1, lenght: 1)
//            blue  = component(from: colorString, start: 2, lenght: 1)
//        case 4:// #ARGB
//            alpha = component(from: colorString, start: 0, lenght: 1)
//            red   = component(from: colorString, start: 1, lenght: 1)
//            green = component(from: colorString, start: 2, lenght: 1)
//            blue  = component(from: colorString, start: 3, lenght: 1)
//        case 6:
//            red   = component(from: colorString, start: 0, lenght: 2)
//            green = component(from: colorString, start: 2, lenght: 2)
//            blue  = component(from: colorString, start: 4, lenght: 2)
//        case 8:
//            alpha = component(from: colorString, start: 0, lenght: 2)
//            red   = component(from: colorString, start: 2, lenght: 2)
//            green = component(from: colorString, start: 4, lenght: 2)
//            blue  = component(from: colorString, start: 6, lenght: 2)
//        default:
//            assert(false, "\(hexString)这玩意是啥？")
//        }
//        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
//    }

}


////MARK:- 私有方法不暴露
//fileprivate extension UIColor {
//
//    static func component(from hexString: String, start: Int, lenght: Int) -> Float {
//        guard let subString = hexString.subString(location: start, length: lenght) else {
//            return 1
//        }
//        let fullHex = (lenght == 2) ? subString : subString+subString
//        var hexComponent: UInt64 = 0xff
//        Scanner(string: fullHex).scanHexInt64(&hexComponent)
//        return Float(hexComponent) / 255.0
//    }
//}

extension UIColor {
    
    /// 颜色生成图片
    public func image(_ size: CGSize = .init(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
