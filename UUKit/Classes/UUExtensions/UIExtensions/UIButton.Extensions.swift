//
//  UIButtonExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/5/16.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit


extension UIButton {
    
    public struct StateBackgroundColor {
        public var normal: UIColor? = nil
        public var selected: UIColor? = nil
        public var highlighted: UIColor? = nil
        public var disabled: UIColor? = nil
        public init(normal: UIColor? = nil, selected: UIColor? = nil, highlighted: UIColor? = nil, disabled: UIColor? = nil) {
            self.normal = normal
            self.selected = selected
            self.highlighted = highlighted
            self.disabled = disabled
        }
    }
    
    public struct StateFont {
        public var normal: UIFont? = nil
        public var selected: UIFont? = nil
        public var highlighted: UIFont? = nil
        public var disabled: UIFont? = nil
    }
    
    public convenience init(title: String, titleColor: UIColor, selectedTitle: String? = nil, selectedTitleColor: UIColor? = nil, font: StateFont? = nil, backgroundColor: StateBackgroundColor? = nil, target: Any? = nil, action: Selector? = nil) {
        self.init()
        set(title: title, titleColor: titleColor, selectedTitle: selectedTitle, selectedTitleColor: selectedTitleColor, backgroundColor: backgroundColor?.normal, selectedBackgroundColor: backgroundColor?.selected, highlightedBackgroundColor: backgroundColor?.highlighted, disabledBackgroundColor: backgroundColor?.disabled, target: target, action: action)
        
    }
    
    
    public convenience init(title: String, titleColor: UIColor, selectedTitle: String? = nil, selectedTitleColor: UIColor? = nil, font: UIFont? = .systemFont(ofSize: 14), backgroundColor: UIColor? = nil, selectedBackgroundColor: UIColor? = nil, highlightedBackgroundColor: UIColor? = .init(hex: 0xDCDCDD), disabledBackgroundColor: UIColor? = nil, isUserInteractionEnabled: Bool = true,  target: Any? = nil, action: Selector? = nil) {
        self.init()
        set(title: title, titleColor: titleColor, selectedTitle: selectedTitle, selectedTitleColor: selectedTitleColor, font: font, backgroundColor: backgroundColor, selectedBackgroundColor: selectedBackgroundColor, highlightedBackgroundColor: highlightedBackgroundColor, disabledBackgroundColor: disabledBackgroundColor, isUserInteractionEnabled: isUserInteractionEnabled, target: target, action: action)
    }
    
    public func set(title: String, titleColor: UIColor, selectedTitle: String? = nil, selectedTitleColor: UIColor? = nil, font: UIFont? = .systemFont(ofSize: 14), backgroundColor: UIColor? = nil, selectedBackgroundColor: UIColor? = nil, highlightedBackgroundColor: UIColor? = .init(hex: 0xDCDCDD), disabledBackgroundColor: UIColor? = nil, isUserInteractionEnabled: Bool = true,  target: Any? = nil, action: Selector? = nil) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        if let selectedTitle = selectedTitle {
            setTitle(selectedTitle, for: .selected)
        }
        if let selectedTitleColor = selectedTitleColor {
            setTitleColor(selectedTitleColor, for: .selected)
        }
        self.titleLabel?.font = font
        setBackgroundColor(normal: backgroundColor, highlighted: highlightedBackgroundColor, disabled: disabledBackgroundColor, selected: selectedBackgroundColor)
        self.isUserInteractionEnabled = isUserInteractionEnabled
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }
    
    public convenience init(image: UIImage, tintColor: UIColor? = nil, target: Any? = nil, action: Selector? = nil) {
        self.init()
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
        }
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }
    
    public convenience init(image: UIImage, selectedImage: UIImage? = nil, target: Any? = nil, action: Selector? = nil) {
        self.init()
        setImage(image, for: .normal)
        setImage(selectedImage, for: .selected)
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }
    
    
    /// 通过设置纯色背景图片的方式设置背景颜色
    public func setBackgroundColor(normal color: UIColor? = nil, highlighted highlightedColor: UIColor? = nil, disabled disabledColor: UIColor? = nil, selected selectedColor: UIColor? = nil) {
        setBackgroundColor(color, for: .normal)
        setBackgroundColor(disabledColor, for: .disabled)
        setBackgroundColor(selectedColor, for: .selected)
        setBackgroundColor(highlightedColor, for: .highlighted)
    }
    
    public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        setBackgroundImage(color?.image(), for: state)
        // 保证圆角等情况下背景颜色图片也被切成圆角
        clipsToBounds = true
    }
    
    
    /// 根据按钮的状态设置显示的字体
    /// ⚠️注意：需要在设置过按钮标题之后调用才有效果
    public func setTitleFontForState(normal font1: UIFont? = nil, highlighted font2: UIFont? = nil, disabled font3: UIFont? = nil, selected font4:UIFont? = nil) {
        if let font = font1, let title = title(for: .normal) {
            setTitleFont(font, for: .normal, in: NSMakeRange(0, title.count))
        }
        if let font = font2, let title = title(for: .highlighted) {
            setTitleFont(font, for: .highlighted, in: NSMakeRange(0, title.count))
        }
        if let font = font3, let title = title(for: .disabled) {
            setTitleFont(font, for: .disabled, in: NSMakeRange(0, title.count))
        }
        if let font = font4, let title = title(for: .selected) {
            setTitleFont(font, for: .selected, in: NSMakeRange(0, title.count))
        }
    }
    
    /// 根据按钮的状态设置显示的字体
    /// ⚠️注意：需要在设置过按钮标题之后调用才有效果
    public func setTitleFont(_ font: UIFont, for state: UIControl.State, in range: NSRange) {
        let text = title(for: state) ?? ""
        let attributedTitle = NSMutableAttributedString(string: text)
        attributedTitle.addAttributes([NSAttributedString.Key.font: font], range: range)
        setAttributedTitle(attributedTitle, for: state)
    }
    
}


