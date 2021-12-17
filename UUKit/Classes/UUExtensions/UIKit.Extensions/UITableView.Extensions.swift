//
//  UITableViewExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/8.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

protocol UURegisterProtocol {
    
    func register<T: AnyObject>(cellsInheritOf baseCell: T.Type)
    
}


extension UITableView {
    
    public convenience init<T: UITableViewCell>(with baseCell: T.Type) {
        self.init(frame: .zero, style: .plain)
        register(cellsInheritOf: baseCell)
    }
    
    public func register<T: UITableViewCell>(cellsInheritOf baseCell: T.Type) {
        subclasses(of: baseCell).forEach {
            register($0)
        }
    }
    
    public func register<T: UITableViewCell>(_ anyCell: T.Type) {
        let cellType: AnyClass = anyCell.self
        let bundle: Bundle = .init(for: cellType)
        let cellName: String = String(describing: cellType)
        guard bundle.path(forResource: cellName, ofType: "nib") != nil else {
            register(cellType, forCellReuseIdentifier: cellName); return
        }
        let nib = UINib(nibName: cellName, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellName)
    }
    
}
