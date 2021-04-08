//
//  NSAtt.swift
//  UUKit
//
//  Created by mac on 2021/1/3.
//

import Foundation

public extension NSMutableAttributedString {
    /// 修改段落样式
    ///
    /// - Parameter lineSpacing: 行间距
    /// - Returns: NSMutableAttributedString
    func setParagraphStyle(lineSpacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = NSLineBreakMode.byCharWrapping
        addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, length))
        return self
    }
    
    /// 修改字号
    ///
    /// - Parameters:
    ///   - font: 字号
    ///   - range: 修改范围
    /// - Returns: NSMutableAttributedString
    func setFont(font: UIFont, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttribute(NSAttributedString.Key.font, value: font, range: range ?? NSMakeRange(0, length))
        return self
    }
    
    /// 修改字体颜色
    ///
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - range: 修改范围
    /// - Returns: NSMutableAttributedString
    func setFontColor(color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range ?? NSMakeRange(0, length))
        return self
    }
    
    /// 插入图片
    ///
    /// - Parameters:
    ///   - image: 要插入的图片
    ///   - index: 插入位置（可选：默认为0）
    ///   - imageSize: 图片尺寸（可选：默认为图片大小）
    ///   - imageOffSet: 图片偏移量（可选：默认为zero）
    /// - Returns: NSMutableAttributedString
    func setImage(image: UIImage?, index: Int = 0, imageSize: CGSize? = nil, imageOffSet: CGPoint = CGPoint.zero) -> NSMutableAttributedString {
        guard let insertImage = image else {
            return self
        }
        
        let imageMent = NSTextAttachment()
        imageMent.image = insertImage
        imageMent.bounds = CGRect(x: imageOffSet.x, y: imageOffSet.y, width: imageSize?.width ?? insertImage.size.width, height: imageSize?.height ?? insertImage.size.height)
        let imageAttribute = NSAttributedString(attachment: imageMent)
        insert(imageAttribute, at: index)
        return self
    }
    
    /// 修改（文字、图片）基线位置
    ///
    /// - Parameters:
    ///   - baselineOffset: 基线位置
    ///   - range: 修改范围
    /// - Returns: NSMutableAttributedString
    func setBaselineOffset(baselineOffset: NSNumber, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttribute(NSAttributedString.Key.baselineOffset, value: baselineOffset, range: range ?? NSMakeRange(0, length))
        return self
    }
}


