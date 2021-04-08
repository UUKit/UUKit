//
//  UIButtonExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/5/16.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

protocol UUButtonProtocol {
    
    var isHighlighted: Bool { get set }
    
}

extension UIButton {
    
    public convenience init( frame: CGRect = CGRect.zero, titleNormal: String? = "", titleSelected: String? = "", titleColorNormal: UIColor? = .black, titleColorSelected: UIColor? = .black, font: UIFont? = .systemFont(ofSize: 16), titleLines: Int = 1, titleAligement: NSTextAlignment = .center, target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) {
        self.init(frame: frame)
        self.titleLabel?.font = font
        self.setTitle(titleNormal, for: .normal)
        self.setTitle(titleSelected, for: .selected)
        self.titleLabel?.numberOfLines = titleLines
        self.titleLabel?.textAlignment = titleAligement
        self.setTitleColor(titleColorNormal, for: .normal)
        self.setTitleColor(titleColorSelected, for: .selected)
        self.addTarget(target, action: action, for: controlEvents)
    }
    
    
    
}

extension UIButton: UUButtonProtocol {
    
    
}


