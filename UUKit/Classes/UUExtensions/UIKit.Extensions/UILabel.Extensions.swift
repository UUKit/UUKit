//
//  UILabelExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/5/16.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

extension UILabel {
    
    public convenience init(text: String? = nil, textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 14), backgroundColor: UIColor = .clear, aligement: NSTextAlignment = .left, numOfLines: Int = 1) {
        self.init()
        self.set(text: text, textColor: textColor, font: font, backgroundColor: backgroundColor, aligement: aligement, numOfLines: numOfLines)
    }
    
    public func set(text: String? = nil, textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 14), backgroundColor: UIColor = .clear, aligement: NSTextAlignment = .left, numOfLines: Int = 1) {
        self.font = font
        self.text = text
        self.frame = frame
        self.textColor = textColor
        self.textAlignment = aligement
        self.numberOfLines = numOfLines
        self.backgroundColor = backgroundColor
    }
    
}


extension UILabel {
    
    @discardableResult
    public func set(text: String, withAttributes attributes: [NSAttributedString.Key: Any]) -> UILabel {
        var attributedText: NSMutableAttributedString!
        if let _attributedText = self.attributedText {
            attributedText = NSMutableAttributedString(attributedString: _attributedText)
        } else {
            guard let labelText = self.text else { return self }
            attributedText = NSMutableAttributedString(string: labelText)
        }
        let range = (attributedText.string as NSString).range(of: text)
        attributedText.addAttributes(attributes, range: range)
        self.attributedText = attributedText
        return self
    }
    
    public func setLinespace(_ linespace: CGFloat) {
        let _text = text ?? ""
        let attributedString = NSMutableAttributedString(string: _text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = linespace
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: _text.count))
        attributedText = attributedString
        sizeToFit()
    }
    
}


extension UILabel {
    
    public enum RequiedMarkPosition {
        case leading,trailing
    }
    
    /// 给表单中必须的项 label 添加必须标记
    public func addRequiedMark(_ requiredMark: String = "*", _ requiedMarkPosition: RequiedMarkPosition = .trailing) {
        let attrStrm = NSMutableAttributedString(string: "")
        let attrText = NSAttributedString(string: text ?? "")
        let requiedMarkAttrStr = NSAttributedString(string: requiredMark, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        
        switch requiedMarkPosition {
        case .leading:
            if let attributedText = attributedText {
                let first = attributedText.string.first
                guard first != Character(requiredMark) else { return }
                attrStrm.append(requiedMarkAttrStr)
                attrStrm.append(attributedText)
            } else {
                let first = attrText.string.first
                guard first != Character(requiredMark) else { return }
                attrStrm.append(requiedMarkAttrStr)
                attrStrm.append(attrText)
            }
        case .trailing:
            if let attributedText = attributedText {
                let last = attributedText.string.last
                guard last != Character(requiredMark) else { return }
                attrStrm.append(attributedText)
                attrStrm.append(requiedMarkAttrStr)
            } else {
                let last = attrText.string.last
                guard last != Character(requiredMark) else { return }
                attrStrm.append(attrText)
                attrStrm.append(requiedMarkAttrStr)
            }
        }
        attributedText = attrStrm
    }
    
    
}

extension UILabel {
    
    /// 判断文本标签的内容是否被截断
    public var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        
        //计算理论上显示所有文字需要的尺寸
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelTextSize = (labelText as NSString)
            .boundingRect(with: rect, options: .usesLineFragmentOrigin,
                          attributes: [NSAttributedString.Key.font: self.font], context: nil)
        
        //计算理论上需要的行数
        let labelTextLines = Int(ceil(CGFloat(labelTextSize.height) / self.font.lineHeight))
        
        //实际可显示的行数
        var labelShowLines = Int(floor(CGFloat(bounds.size.height) / self.font.lineHeight))
        if self.numberOfLines != 0 {
            labelShowLines = min(labelShowLines, self.numberOfLines)
        }
        
        //比较两个行数来判断是否需要截断
        return labelTextLines > labelShowLines
    }
    
}
