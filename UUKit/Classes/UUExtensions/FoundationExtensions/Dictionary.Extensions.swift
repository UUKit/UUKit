//
//  Dictionary.Extensions.swift
//  UUKit
//
//  Created by mac on 2020/12/22.
//

import Foundation


public extension Dictionary {
    
    var toJSON: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self) else { return nil }
        guard let JSON = String(data: data, encoding: .utf8) else { return nil }
        return JSON
    }
    
}






