//
//  NSNumber.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/3/19.
//

import Foundation

private let formatter = NumberFormatter()

extension NSNumber {
    
    /// 返回一个三位添加一个分隔符的字符串
    public var toDecimalString: String? {
        //let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: self)
    }
    
    
}



