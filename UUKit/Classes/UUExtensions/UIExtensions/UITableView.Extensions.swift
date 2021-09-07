//
//  UITableViewExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/8.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit


extension UITableView {
    
    public convenience init<T: UITableViewCell>(with baseCellType: T.Type) {
        self.init(frame: .zero, style: .plain)
        register(cellsWith: baseCellType)
    }
    
    public func register<T: UITableViewCell>(cellsWith baseCellType: T.Type) {
        subclasses(of: baseCellType).forEach {
            let className: String = String(describing: $0), nibPath: String? = Bundle(for: $0).path(forResource: String(describing: $0), ofType: "nib")
            guard nibPath != nil else { register($0, forCellReuseIdentifier: className); return }
            let nib = UINib(nibName: className, bundle: Bundle(for: $0))
            register(nib, forCellReuseIdentifier: className)
        }
    }
    
}
