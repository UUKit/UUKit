//
//  UILabelExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/5/16.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

extension UILabel {
    
    public convenience init( frame: CGRect = CGRect.zero, text: String = "", textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 16), aligement: NSTextAlignment = .left, numOfLines: Int = 1) {
        self.init()
        self.font = font
        self.text = text
        self.frame = frame
        self.textColor = textColor
        self.textAlignment = aligement
        self.numberOfLines = numOfLines
    }
    
    public static func initForTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }
    
    public static func initForDescription() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }
    
}


public extension UILabel {
    
    func setLinespace(_ linespace: CGFloat) {
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
