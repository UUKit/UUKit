//
//  StringExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/8.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    /// 字符串为 nil、" "、""、"\n" 返回true
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}


public extension String {
    
    @discardableResult
    func toDate(_ dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
    
    @discardableResult
    func toDate(_ dateFormat: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: self)
    }
    
    @discardableResult
    func format(to dateFormat: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: self)
    }
    
    @discardableResult
    func format(from dateFormat1: DateFormat, to dateFormat2: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat1.rawValue
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = dateFormat2.rawValue
        return dateFormatter.string(from: date)
    }
    
}


// MARK: - Size
extension String {
    
    public func size(with font: UIFont, drawingSize: CGSize, mode: NSLineBreakMode) -> CGSize {
        var attr = [NSAttributedString.Key:Any]()
        attr[NSAttributedString.Key.font] = font
        if mode != .byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = mode
            attr[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        let options = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue)
        return NSString(string: self).boundingRect(with: drawingSize, options: options , attributes: attr, context: nil).size
    }
    
    /// 根据文本显示的高度计算宽度
    ///
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - height: 文本要显示的高度
    ///   - options: 文本显示的格式，有没有行间距等等
    /// - Returns: 返回文本的宽度
    public func width(fontSize: CGFloat, height: CGFloat = 15, options: NSStringDrawingOptions = .usesLineFragmentOrigin) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    
    /// 根据文本显示的宽度，计算文本的高度，并使高度不大于设置最大值
    ///
    /// - Parameters:
    ///   - fontSize: 文字大小
    ///   - width: 文本显示的宽度
    ///   - limitedHeight: 文本限制高度，大于此高度则返回此高度
    ///   - options: 文本显示的格式，有没有行间距等等
    /// - Returns: 返回文本高度
    public func height(fontSize: CGFloat, width: CGFloat, limitedHeight: CGFloat = CGFloat(MAXFLOAT), options: NSStringDrawingOptions = .usesLineFragmentOrigin) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height) > limitedHeight ? limitedHeight : ceil(rect.height)
    }
    
}

extension String {
    
    /// 是否是有效的网址
    public var isValidURL: Bool {
        let pattern = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,6})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,6})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(((http[s]{0,1}|ftp)://|)((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否是有效的手机号或电话号码
    public var isValidPhone: Bool {
        let pattern = "\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[3578]+\\d{9}|[+]861+[3578]+\\d{9}|861+[3578]+\\d{9}|1+[3578]+\\d{1}-\\d{4}-\\d{4}|\\d{8}|\\d{7}|400-\\d{3}-\\d{4}|400-\\d{4}-\\d{3}"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否是有效的邮箱
    public var isValidEmail: Bool {
        let pattern = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,6}"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    public var isValidChineseIdCardNum: Bool {
        let idCardNumber = uppercased()// 如果输入字符串中有x，转成大写
        if  idCardNumber.count != 18 { return false }
        // 正则表达式判断基本 身份证号是否满足格式
        let regex = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"
        //let regex = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
        let identityStringPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        //如果通过该验证，说明身份证格式正确，但准确性还需计算
        if !identityStringPredicate.evaluate(with: idCardNumber) { return false }
        
        //** 开始进行校验 *//
        //将前17位加权因子保存在数组里
        let idCardWiArray = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"]
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        let idCardYArray = ["1", "0", "10", "9", "8", "7", "6", "5", "4", "3", "2"]
        //用来保存前17位各自乖以加权因子后的总和
        var idCardWiSum = 0
        for i in 0..<17 {
            let subStrIndex = Int((idCardNumber as NSString).substring(with: NSRange(location: i, length: 1)))!
            //let subStrIndex = [[_identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
            let idCardWiIndex = Int(idCardWiArray[i])!
            idCardWiSum += subStrIndex * idCardWiIndex
        }
        //计算出校验码所在数组的位置
        let idCardMod = idCardWiSum % 11
        //得到最后一位身份证号码
        let idCardLast = (idCardNumber as NSString).substring(with: NSRange(location: 17, length: 1))
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if idCardMod == 2 {
            if idCardLast != "X" { return false }
        } else {
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if idCardLast != idCardYArray[idCardMod] {
                return false
            }
        }
        return true
    }
    
    /// SwifterSwift: Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    public var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x1F1E6...0x1F1FF, // Regional country flags
                 0x2600...0x26FF, // Misc symbols
                 0x2700...0x27BF, // Dingbats
                 0xE0020...0xE007F, // Tags
                 0xFE00...0xFE0F, // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 127_000...127_600, // Various asian characters
                 65024...65039, // Variation selector
                 9100...9300, // Misc items
                 8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// 移除字符串中的 emoji 表情符号
    public var removeEmoji: String {
        return reduce("") { (result, character) -> String in
            if character.isEmoji {
                return result + ""
            } else {
                return result + String(character)
            }
        }
    }
    
}

public extension String {

    /// 去掉头尾的空白字符
    var trimTopBottomSpace: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// 去掉整段文字内的所有空白字符（包括换行符）
    var  trimAllSpace: String {
        return replacingOccurrences(of: "\\s", with: "", options: .regularExpression, range: range(of: self))
    }

    /// 将文字中的换行符替换为空格
    var trimLinerBreakCharacter: String {
        return replacingOccurrences(of: "\n", with: " ", options: .regularExpression, range: range(of: self))
    }

    /// 把该字符串转换为对应的 md5
    var md5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: .utf8) {
            _ = d.withUnsafeBytes { body -> String in
                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
                return ""
            }
        }
        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    /// 去掉一段文字中的HTML标签，只保留文字
    var trimHTMLTags: String {
        let regularExpretion = try? NSRegularExpression(pattern: "<[^>]*>|\n|&nbsp", options: NSRegularExpression.Options(rawValue: 0))
        let string = regularExpretion?.stringByReplacingMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.count), withTemplate: "")
        return string ?? self;
    }
    
}


//MARK:- SubString
extension String {

    /// 获取字符串 到index终止（包括Index）
    /// - Parameter index: 终止
    /// - Returns: 截取到的字符串
    public func subString(to index: Int) -> String? {
        return subString(from: 0, to: index)
    }

    /// 获取字符串 从index到结束
    /// - Parameter index: 起始
    /// - Returns: 截取到的字符串
    public func subString(from index: Int) -> String? {
        return subString(from: index, to: self.count-1)
    }

    /// 根据起始终止位置截取一个子字符串 [startIndex, endIndex] 包括起始和结束
    /// - Parameters:
    ///   - startIndex: 起始Index
    ///   - endIndex: 结束Index
    /// - Returns: 截取到的字符串
    public func subString(from startIndex: Int, to endIndex: Int) -> String? {
        //assert(endIndex >= startIndex, "endIndex不能小于StartIndex")
        //assert(self.count > endIndex, "endIndex超过了字符串长度")
        //assert(startIndex >= 0, "startIndex不能为负数")
        
        guard endIndex >= startIndex else { print("endIndex小于StartIndex，这是错误的"); return nil }
        guard self.count > endIndex else { print("endIndex超过了字符串长度，这是错误的"); return nil }
        guard startIndex >= 0 else { print("startIndex为负数，这是错误的"); return nil }
        
        let startIndex = self.index(self.startIndex, offsetBy: startIndex)
        let endIndex = self.index(self.startIndex, offsetBy: endIndex)
        return String(self[startIndex...endIndex])
    }
    
    /// 根据Range截取子字符串
    /// - Parameters:
    ///   - location: location description
    ///   - length: length description
    /// - Returns: 截取到的字符串
    public func subString(location:Int, length: Int) -> String? {
        //assert(location >= 0, "起始位置不能为负数")
        //assert(length > 0, "长度必须大于0")
        guard location >= 0 else { print("起始位置为负数，这是错误的"); return nil }
        guard length > 0 else { print("长度等于0，这是错误的"); return nil }
        return subString(from: location, to: location+length-1)
    }
    
    /// 根据NSRange截取子字符串
    /// - Parameter range: range description
    /// - Returns: 截取到的字符串
    public func subString(with range: NSRange) -> String? {
        return subString(location: range.location, length: range.length)
    }
}
