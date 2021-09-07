//
//  Bundle.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/8/31.
//

import Foundation

extension Bundle {
    
    
    public var name: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    
}
