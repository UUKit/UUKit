//
//  Dictionary.Extensions.swift
//  UUKit
//
//  Created by mac on 2020/12/22.
//

import Foundation


extension Dictionary {
    
    /// 格式化成 JSON 数据
    public var toJSON: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return nil }
        guard let JSON = String(data: data, encoding: .utf8) else { return nil }
        return JSON
    }
    
    /// 式化成 JSON 数据，根据传入的 options 格式成打印的样式，或其他格式
    public func toJSON(withWritingOptions options: JSONSerialization.WritingOptions = [.prettyPrinted]) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        guard let JSON = String(data: data, encoding: .utf8) else { return nil }
        return JSON
    }
    
}






